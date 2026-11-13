import os
import tempfile
import unittest
from unittest.mock import MagicMock, patch

from lib import AudioFormatterRunner


class TestAudioFormatterSecurity(unittest.TestCase):

  def _make_runner(self, raw_audio_file_name='folder/call.wav', channels=None):
    with (
        patch.object(AudioFormatterRunner, 'get_credentials', return_value=MagicMock()),
        patch('lib.storage.Client') as mock_storage_cls,
        patch('lib.secretmanager.SecretManagerServiceClient') as mock_sm_cls,
    ):
      mock_secret_resp = MagicMock()
      mock_secret_resp.payload.data = b'00112233445566778899aabbccddeeff'
      mock_sm_cls.return_value.access_secret_version.return_value = mock_secret_resp
      runner = AudioFormatterRunner(
          project_id='test-proj',
          raw_audio_bucket_id='raw-bucket',
          raw_audio_file_name=raw_audio_file_name,
          formatted_audio_bucket_id='formatted-bucket',
          metadata_bucket_id='meta-bucket',
          hash_key='test-secret',
          ingest_record_bucket_id='record-bucket',
          number_of_channels=channels,
      )
      runner.storage_client = mock_storage_cls.return_value
      return runner

  @patch('lib.subprocess.run')
  def test_poc_command_injection_extension_rejected(self, mock_subproc):
    """VulnHunt PoC payload b/585249428 must fail closed before download or ffmpeg."""
    runner = self._make_runner('call.wav;id>PWNED;true ')
    with self.assertRaises(ValueError):
      runner.download_from_gcs()
    mock_subproc.assert_not_called()
    runner.storage_client.bucket.assert_not_called()

  @patch('lib.subprocess.run')
  def test_traversal_and_missing_extension_rejected(self, mock_subproc):
    for bad_name in ['../../etc/passwd', 'folder/no_extension', 'evil.sh', 'call.wav`whoami`']:
      runner = self._make_runner(bad_name)
      with self.assertRaises(ValueError):
        runner.download_from_gcs()
    mock_subproc.assert_not_called()

  def test_invalid_channel_counts_rejected(self):
    for bad_ch in ['0', '9', '-1', '2;id']:
      with self.assertRaises(ValueError):
        self._make_runner('folder/call.wav', channels=bad_ch)

  @patch.object(AudioFormatterRunner, 'delete_tmp_files')
  @patch.object(AudioFormatterRunner, 'log_error')
  @patch('lib.RecordKeeper')
  @patch('lib.subprocess.run')
  def test_run_format_logs_and_records_malicious_object_name(
      self, mock_subproc, mock_rk_cls, mock_log_error, mock_delete_tmp
  ):
    runner = self._make_runner('call.wav;id>PWNED;true ')
    runner.run_format()
    mock_subproc.assert_not_called()
    mock_rk_cls.return_value.create_error_record.assert_called_once()
    mock_log_error.assert_called_once()
    mock_delete_tmp.assert_called_once()

  @patch('lib.subprocess.run')
  def test_aac_extension_preserves_uuid_and_uses_shell_false(self, mock_subproc):
    """UUIDs containing 'aac' must not be corrupted and shell=False must be used."""
    runner = self._make_runner('calls/recording.AAC', channels='1')
    runner.raw_audio_file_extension = 'aac'
    stem = '1111aac2-3333-4444-5555-666677778888'
    input_name = f'{stem}.aac'
    flac_path = f'/tmp/{stem}.flac'
    json_path = f'/tmp/{stem}.json'
    meta_txt = '/tmp/format-meta.txt'
    audio_txt = '/tmp/audio-meta.txt'
    log_txt = '/tmp/ffmpeg-log-data.txt'

    def fake_subproc(cmd, **kwargs):
      self.assertFalse(kwargs.get('shell', True))
      if cmd[0] == 'ffmpeg':
        with open(flac_path, 'wb') as f:
          f.write(b'fLaC-test-bytes')
        with open(meta_txt, 'w', encoding='utf-8') as f:
          f.write('encoder=Lavf60.3.100\n')
      elif cmd[0] == 'ffprobe':
        stdout_handle = kwargs['stdout']
        stdout_handle.write('codec_name=flac\nsample_rate=8000\nchannels=1\n')
      return MagicMock(returncode=0)

    mock_subproc.side_effect = fake_subproc
    try:
      ok = runner.format_audio(input_name, 'calls/recording.AAC')
      self.assertTrue(ok)
      self.assertEqual(runner.formatted_audio_file_name, f'{stem}.flac')
      self.assertTrue(os.path.isfile(json_path))
      self.assertEqual(mock_subproc.call_count, 2)
      ffmpeg_args = mock_subproc.call_args_list[0].args[0]
      self.assertEqual(ffmpeg_args[0], 'ffmpeg')
      self.assertIn('-ac', ffmpeg_args)
      self.assertIn('1', ffmpeg_args)
    finally:
      for p in (flac_path, json_path, meta_txt, audio_txt, log_txt):
        if os.path.exists(p):
          os.remove(p)


if __name__ == '__main__':
  unittest.main()
