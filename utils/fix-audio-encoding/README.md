# Process audio files to fix encoding

## Instructions
Install [FFmpeg](https://ffmpeg.org/ffmpeg.html). FFmpeg is a free, open-source software project consisting of a suite of libraries and programs for handling video, audio, and other multimedia files and streams. At its core is the command-line FFmpeg tool itself, designed for processing video and audio files.

```sh
sudo apt-get install -y ffmpeg
```

Use the following commands to install the FFmpeg package if working with G.723.1 encoding, as there is a bug in Linux FFmpeg for handling this particular encoding.

```sh
git clone https://github.com/FFmpeg/FFmpeg
cd FFmpeg/ && ./configure --disable-x86asm && make
```

Set up your Python environment.
```sh
sudo apt-get install python3
sudo apt-get -y install python3-pip
python3 -m pip install --user --upgrade pip
```

Create and activate the virtual environment.
```sh
python3 -m venv env
source env/bin/activate
```

Run the following commands from the directory where you have saved the downloaded tooling; this directory contains the requirements.txt required:

```sh
pip3 install -r requirements.txt --force-reinstall --no-deps
```

You will need two directories with enough file system space to hold all the audio files, if files are present locally. Create these two directories, and run the following commands in the terminal. Replace the first folder name with the name holding the audio files and the second where you need to store the converted files:

```sh
mkdir /path/to/audio-input
mkdir /path/to/audio-output
```

You will need two storage buckets to hold all the audio files, if audio files are present in Cloud Storage. Assuming files are present in one Cloud Storage bucket (source), you will need to create one destination Cloud Storage bucket to hold the converted files. Run the following command in the terminal: Replace ‘<some-unique-bucket-name>’ with a globally unique name for the destination bucket:

```sh
gsutil mb gs://<unique-bucket-name>
```

## [Applicable only if audio files are present locally] 
Execute the `convert.sh` script to convert the WAV files to FLAC (Note: Both FLAC and WAV are the same in terms of audio quality, meaning they are lossless. If using WAV, you must inspect each recording to identify the encoding. To make the STT call easier and align the encoding for all files, they are converted to FLAC).

Change the `INPUT_AUDIO_PATH` and `OUTPUT_AUDIO_PATH` parameters in the script with the local folder names created in the earlier step.

Run chmod to change the access permission with the convert script and run the script:

```sh
chmod +x convert.sh
./convert.sh
```

## [Applicable only if audio files are present in Cloud Storage] 
Execute the `convert_from_gcs.py` script to convert `.wav` objects in Cloud Storage to `.flac` objects safely (non-`.wav` blobs are skipped, relative object paths are validated against directory traversal, and conversion runs inside isolated `/tmp` directories via `subprocess.run(..., shell=False)`).

- Change the `src_gcs_bucket` and `dest_gcs_bucket` parameters in the script with the source bucket name containing WAV audio files and the bucket name created in the earlier step to hold the converted FLAC audio files.

- Add `project_id`

- Update `impersonated_service_account` with the service account you want to use; otherwise, it will take the default service account.

- Run chmod to change the access permission with the convert script and run the script:

```sh
chmod +x convert_from_gcs.sh
./convert_from_gcs.sh
```

Some methods return a long-running operation. Long-running methods are asynchronous, and the operation might not be completed when the method returns a response. You can poll the operation to check on its status.

Please find additional guidance [here](https://cloud.google.com/contact-center/insights/docs/long-running-operations) 

