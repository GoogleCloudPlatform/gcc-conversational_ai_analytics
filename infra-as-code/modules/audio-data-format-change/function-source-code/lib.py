import os
import subprocess
import uuid
import json
import google.auth
import google.cloud.logging
import hashlib
import hmac
from google.cloud import storage
from datetime import datetime
from google.cloud import secretmanager
from record import RecordKeeper


ALLOWED_AUDIO_EXTENSIONS = frozenset({
    'wav',
    'mp3',
    'flac',
    'ogg',
    'm4a',
    'aac',
    'amr',
    'webm',
    'mp4',
    'wma',
    'mulaw',
    'alaw',
    'pcm',
    'opus',
    'aiff',
    '3gp',
})


class AudioFormatterRunner:
  project_id: str
  raw_audio_bucket_id: str
  raw_audio_file_name: str
  raw_audio_file_extension: str
  formatted_audio_bucket_id: str
  formatted_audio_file_name: str
  metadata_bucket_id: str
  number_of_channels: int
  hash_key: bytes
  create_date: str
  ingest_record_bucket_id: str

  storage_client = None

  def __init__(
    self,
    project_id,
    raw_audio_bucket_id,
    raw_audio_file_name,
    formatted_audio_bucket_id,
    metadata_bucket_id,
    hash_key,
    ingest_record_bucket_id,
    number_of_channels = None
    ):

    self.project_id = project_id
    self.raw_audio_bucket_id = raw_audio_bucket_id
    self.raw_audio_file_name = raw_audio_file_name
    self.formatted_audio_bucket_id = formatted_audio_bucket_id
    self.metadata_bucket_id = metadata_bucket_id
    self.metadata = {}
    self.number_of_channels = self._validate_channels(number_of_channels)
    self.ingest_record_bucket_id = ingest_record_bucket_id

    creds = self.get_credentials()
    self.storage_client = storage.Client(project = self.project_id, credentials = creds)
    secretmanager_client = secretmanager.SecretManagerServiceClient(credentials = creds)

    secret_path = f"projects/{project_id}/secrets/{hash_key}/versions/latest"
    secret_key = secretmanager_client.access_secret_version(name = secret_path).payload.data.decode("UTF-8")
    self.hash_key = bytes.fromhex(secret_key)

  @staticmethod
  def _validate_channels(number_of_channels) -> int:
    if number_of_channels is None or str(number_of_channels).strip() == '':
      return 2
    channels = int(number_of_channels)
    if channels < 1 or channels > 8:
      raise ValueError(f'Unsupported channel count: {channels}')
    return channels

  @staticmethod
  def _extract_validated_extension(blob_name: str) -> str:
    if not isinstance(blob_name, str) or not blob_name or '\x00' in blob_name:
      raise ValueError('Audio object name must be a non-empty string.')
    basename = os.path.basename(blob_name)
    _, dot_ext = os.path.splitext(basename)
    ext = dot_ext.lstrip('.').lower()
    if not ext or ext not in ALLOWED_AUDIO_EXTENSIONS:
      raise ValueError(
          f'Unsupported or missing audio file extension: {ext!r}'
      )
    return ext

  @staticmethod
  def _resolve_tmp_path(filename: str) -> str:
    if (
        not isinstance(filename, str)
        or not filename
        or '/' in filename
        or '\\' in filename
        or '\x00' in filename
    ):
      raise ValueError(f'Unsafe temporary filename: {filename!r}')
    tmp_root = os.path.realpath('/tmp')
    resolved = os.path.realpath(os.path.join(tmp_root, filename))
    if not resolved.startswith(tmp_root + os.sep):
      raise ValueError(f'Temporary path escapes /tmp: {filename!r}')
    return resolved

  def get_credentials(self):
    creds, _ = google.auth.default(
        scopes=['https://www.googleapis.com/auth/cloud-platform'])

    print('Getting credentials')
    return creds

  def get_folder_and_filename(self, blob):
    parts = blob.split("/")

    if (len(parts) != 1):
      filename = parts[-1]
      folder = parts[-2]
    else:
      filename = self.raw_audio_file_name
      folder = ''
    print(f'Got folder name: {folder}, filename: {filename}')
    return f"{folder}/{filename}"

  def download_from_gcs(self):
    """Downloads the triggering blob from the trigger bucket in GCS
        and stores it in a temporary file renamed with a UUID.

    Returns:
        tuple[str, str]: New filename assigned to the downloaded blob and trigger_file
    """
    print('Starting download')

    encoding = hashlib.sha256

    trigger_file = self.get_folder_and_filename(self.raw_audio_file_name)
    self.metadata['original_file_name'] = hmac.new(
        self.hash_key, trigger_file.encode(), encoding
    ).hexdigest()

    self.raw_audio_file_extension = self._extract_validated_extension(
        self.raw_audio_file_name
    )

    new_uuid = str(uuid.uuid4())
    new_filename = f'{new_uuid}.{self.raw_audio_file_extension}'
    self.metadata['conversation_id'] = new_uuid

    filename = self._resolve_tmp_path(new_filename)
    print(f'Filename: {self.raw_audio_file_name}. File extension: {self.raw_audio_file_extension}')

    bucket = self.storage_client.bucket(self.raw_audio_bucket_id)
    blob = bucket.blob(self.raw_audio_file_name)
    blob.download_to_filename(filename)

    print(f'Blob {self.raw_audio_file_name} downloaded to {filename}')

    return new_filename, trigger_file

  def upload_to_gcs(self, bucket_name, filename):
    """Uploads a resource to GCS

    Args:
        bucket_name (string): Bucket ID where the filename needs to be uploaded
        filename (string): The name of the local file to upload
    """
    bucket = self.storage_client.bucket(bucket_name)
    blob_name = f'{self.get_file_creation_date()}/{filename}'
    blob = bucket.blob(blob_name)

    path_to_file = self._resolve_tmp_path(filename)
    if os.path.isfile(path_to_file):
      blob.upload_from_filename(path_to_file)

    print('Uploaded file into gcs')

  def format_audio(self, filename, trigger_file):
    """Changes the format of the given file to a FLAC file through an ffmpeg command.

    Args:
        filename (string): Name of the downloaded file to encode as flac
        trigger_file (string): Original folder/filename identifier
    """
    stem, _ = os.path.splitext(os.path.basename(filename))
    self.formatted_audio_file_name = f'{stem}.flac'
    raw_audio_path = self._resolve_tmp_path(filename)
    formatted_audio_path = self._resolve_tmp_path(self.formatted_audio_file_name)
    format_meta_path = self._resolve_tmp_path('format-meta.txt')
    ffmpeg_log_path = self._resolve_tmp_path('ffmpeg-log-data.txt')

    if self.raw_audio_file_extension != 'flac':
      with open(ffmpeg_log_path, 'w', encoding='utf-8') as err_log:
        subprocess.run(
            [
                'ffmpeg',
                '-y',
                '-hide_banner',
                '-i',
                raw_audio_path,
                '-ac',
                str(self.number_of_channels),
                formatted_audio_path,
                '-f',
                'ffmetadata',
                format_meta_path,
            ],
            shell=False,
            check=False,
            stdin=subprocess.DEVNULL,
            stdout=subprocess.DEVNULL,
            stderr=err_log,
            timeout=300,
        )

    if os.path.isfile(formatted_audio_path) and os.path.getsize(formatted_audio_path) > 0:
      print(f'Formatted {filename} into {self.formatted_audio_file_name}')

      self.get_audio_metadata(formatted_audio_path)
      self.extract_metadata(filename, trigger_file)
      return True

    return False

  def extract_metadata_from_file(self):
    """Extracts metadata from the ffmpeg encoding log and audio metadata."""
    stream = dict()
    audio_meta_path = self._resolve_tmp_path('audio-meta.txt')
    with open(audio_meta_path, 'r', encoding='utf-8') as f:
      content = f.read()
      for line in content.splitlines():
        if 'codec_name' in line:
          stream['codec_name'] = line.split('=')[1].strip()
        elif 'sample_rate' in line:
          stream['sample_rate'] = line.split('=')[1].strip()
        elif 'channels' in line:
          stream['channels'] = line.split('=')[1].strip()
        elif 'channel_layout' in line:
          stream['channel_layout'] = line.split('=')[1].strip()
        elif 'start_time' in line:
          stream['start_time'] = line.split('=')[1].strip()
        elif 'duration' in line:
          stream['duration'] = line.split('=')[1].strip()
        elif 'bits_per_raw_sample' in line:
          stream['bits_per_raw_sample'] = line.split('=')[1].strip()

    self.metadata['stream'] = stream

    file_path = self._resolve_tmp_path('format-meta.txt')
    if os.path.exists(file_path):
      with open(file_path, 'r', encoding='utf-8') as f:
        for line in f:
          if 'encoder' in line:
            self.metadata['encoder'] = line.split('=')[1].strip()

  def get_audio_metadata(self, audio_path):
    """Calls ffprobe without a shell to extract audio stream metadata.

    Args:
        audio_path (string): Path to the audio file to extract metadata from
    """
    tmp_root = os.path.realpath('/tmp')
    resolved_audio_path = os.path.realpath(audio_path)
    if not resolved_audio_path.startswith(tmp_root + os.sep):
      raise ValueError(f'Audio path must reside within /tmp: {audio_path!r}')

    audio_meta_path = self._resolve_tmp_path('audio-meta.txt')
    with open(audio_meta_path, 'w', encoding='utf-8') as meta_out:
      subprocess.run(
          [
              'ffprobe',
              '-loglevel',
              'quiet',
              '-hide_banner',
              '-i',
              resolved_audio_path,
              '-show_streams',
          ],
          shell=False,
          check=True,
          stdin=subprocess.DEVNULL,
          stdout=meta_out,
          stderr=subprocess.DEVNULL,
          timeout=60,
      )

    print('Extracted stream metadata')

  def get_file_creation_date(self):
    today = datetime.today().date()
    return today.strftime("%m_%d_%y")

  def extract_metadata(self, filename, trigger_filename):
    """Extracts metadata from file conversation and original filename

    Args:
        filename (string): Name of the file where metadata will be stored
        trigger_filename (string): Original folder/filename identifier
    """
    self.extract_metadata_from_file()

    stem, _ = os.path.splitext(os.path.basename(filename))
    json_filename = f'{stem}.json'
    json_path = self._resolve_tmp_path(json_filename)

    with open(json_path, 'w', encoding='utf-8') as jd:
      json.dump(self.metadata, jd, indent = 2)

    print('Created metadata file')

  def delete_tmp_files(self):
    """Deletes all tmp files created to free allocated memory."""
    for filename in os.listdir('/tmp'):
      file_path = os.path.join('/tmp', filename)
      if os.path.isfile(file_path) and filename != 'run':
        os.remove(file_path)
    print('Deleted tmp files')

  def upload_resources(self, filename):
    """Uploads encoded .flac file and its metadata to their respective buckets

    Args:
        filename (string): Name of the downloaded file to encode as flac
    """
    #Upload .flac
    self.upload_to_gcs(self.formatted_audio_bucket_id, self.formatted_audio_file_name)

    #Upload metadata
    stem, _ = os.path.splitext(os.path.basename(filename))
    json_filename = f'{stem}.json'
    self.upload_to_gcs(self.metadata_bucket_id, json_filename)
    self.set_blob_metadata()

  def get_ffmpeg_error(self):
    """Retrieves an error from ffmpeg log data if exists."""
    ffmpeg_log_path = self._resolve_tmp_path('ffmpeg-log-data.txt')
    if not os.path.exists(ffmpeg_log_path):
      return None
    with open(ffmpeg_log_path, "r", encoding='utf-8') as f:
      error_message = f.read()
      if error_message:
        return error_message
    return None

  def get_log_entry(self, error_message):
    entry = dict()
    entry['message'] = 'Audio format change failure'
    entry['error'] = error_message
    entry['raw_file_gcs_path'] = 'gs://{}/{}'.format(self.raw_audio_bucket_id, self.raw_audio_file_name)
    entry['hashed_filename'] = self.metadata.get('original_file_name', '')

    return entry

  def log_error(self, error_entry = None, severity = "ERROR"):
    """Logs an error or warning in Cloud Logging if error happens in the cloud function."""
    creds = self.get_credentials()
    client = google.cloud.logging.Client(project = self.project_id, credentials = creds)
    logger = client.logger(name="cf_audio_format_change_logger")

    if error_entry:
      entry = self.get_log_entry(error_entry)
      logger.log_struct(entry,severity=severity,)

      print('Error logged')
    else:
      error_message = self.get_ffmpeg_error()
      entry = self.get_log_entry(error_message)
      logger.log_struct(entry,severity="ERROR",)

      print('Error logged, file format change failed')

  def set_blob_metadata(self):
    """Set a blob's metadata."""
    bucket = self.storage_client.bucket(self.formatted_audio_bucket_id)
    blob_name = self.get_file_creation_date() + '/' + self.formatted_audio_file_name
    blob = bucket.get_blob(blob_name)

    blob.metadata = self.metadata
    blob.patch()

    print("Updated formatted file metadata")

  def run_format(self):
    """Runs the format change and sends the output payload to GCS."""
    trigger_file = self.get_folder_and_filename(self.raw_audio_file_name)
    self.metadata['original_file_name'] = hmac.new(
        self.hash_key, trigger_file.encode(), hashlib.sha256
    ).hexdigest()
    self.record_keeper = RecordKeeper(
        self.ingest_record_bucket_id,
        self.metadata['original_file_name'],
        self.storage_client,
    )

    try:
      self.record_keeper.verify_file()
      filename, trigger_file = self.download_from_gcs()
      print(f'New assigned filename: {filename}')
      if self.format_audio(filename, trigger_file):
        #Successfully changed format
        print('Changed format')
        self.upload_resources(filename)
      else:
        #Unsuccessful format change, write on error and delete from processed
        print('Unsucessful')
        self.record_keeper.replace_row(
          self.record_keeper.create_error_record(
            f'An error ocurred while changing audio format: {self.get_ffmpeg_error()}'))
        self.log_error()
    except Exception as e:
      self.record_keeper.replace_row(
        self.record_keeper.create_error_record(
          f'An error ocurred while changing audio format: {str(e)}'))
      self.log_error(str(e))
    finally:
      self.delete_tmp_files()
      print("Finished")
