import os
import tempfile
import unittest
from unittest.mock import MagicMock, patch

import convert_from_gcs


class TestConvertFromGcsSecurity(unittest.TestCase):

  @patch('convert_from_gcs._DownloadFileFromGcs')
  @patch('convert_from_gcs.subprocess.run')
  def test_path_traversal_blob_names_rejected(self, mock_subproc, mock_download):
    """b/585249407: traversal sequences and leading slashes must fail before GCS download."""
    traversal_names = [
        '../../etc/cron.d/evil.wav',
        '/etc/passwd.wav',
        'calls/../../../tmp/outside.wav',
        'calls\\evil.wav',
        'calls//double.wav',
        './dot.wav',
        'not_a_wav.txt',
    ]
    for bad_blob in traversal_names:
      with self.assertRaises(ValueError, msg=f'Expected rejection for {bad_blob!r}'):
        convert_from_gcs._ConvertWavToFlacRunner(
            bad_blob, 'src-bkt', 'dst-bkt', 'proj-1', None, 8000
        )
    mock_download.assert_not_called()
    mock_subproc.assert_not_called()

  @patch('convert_from_gcs.storage.Client')
  @patch('convert_from_gcs._GetClientCredentials', return_value=MagicMock())
  @patch('convert_from_gcs.subprocess.run')
  def test_single_quote_injection_poc_neutralized(
      self, mock_subproc, _mock_creds, mock_storage_cls
  ):
    """b/585249407 PoC: single quote in blob name never spawns shell or creates sentinel."""
    sentinel = '/tmp/PWNED_c3d5fa14'
    if os.path.exists(sentinel):
      os.remove(sentinel)

    poc_blob_name = "a';touch /tmp/PWNED_c3d5fa14;echo 'x.wav"
    expected_dest_blob = "a';touch /tmp/PWNED_c3d5fa14;echo 'x.flac"

    mock_bucket = mock_storage_cls.return_value.bucket.return_value
    mock_blob = mock_bucket.blob.return_value

    def fake_download(local_dest):
      # Local path must be isolated and contain no attacker quote characters.
      self.assertNotIn("'", local_dest)
      with open(local_dest, 'wb') as f:
        f.write(b'RIFF-wav-bytes')

    mock_blob.download_to_filename.side_effect = fake_download

    def fake_ffmpeg(cmd, **kwargs):
      self.assertFalse(kwargs.get('shell', True))
      self.assertEqual(cmd[0], 'ffmpeg')
      out_path = cmd[-1]
      with open(out_path, 'wb') as f:
        f.write(b'fLaC-bytes')
      return MagicMock(returncode=0)

    mock_subproc.side_effect = fake_ffmpeg

    convert_from_gcs._ConvertWavToFlacRunner(
        poc_blob_name, 'src-bkt', 'dst-bkt', 'proj-1', None, 8000
    )

    self.assertFalse(os.path.exists(sentinel))
    mock_subproc.assert_called_once()
    mock_bucket.blob.assert_any_call(expected_dest_blob)

  @patch('convert_from_gcs.subprocess.run')
  def test_direct_convert_wav_to_flac_rejects_outside_tmp_and_quotes_safe(
      self, mock_subproc
  ):
    with self.assertRaises(ValueError):
      convert_from_gcs._ConvertWavToFlac('/etc/passwd.wav')

    with tempfile.TemporaryDirectory(dir='/tmp') as tmp_dir:
      quoted_wav = os.path.join(tmp_dir, "caller's_audio.WAV")
      expected_flac = os.path.join(tmp_dir, "caller's_audio.flac")
      with open(quoted_wav, 'wb') as f:
        f.write(b'RIFF')

      def fake_ffmpeg(cmd, **kwargs):
        self.assertFalse(kwargs.get('shell', True))
        with open(cmd[-1], 'wb') as out:
          out.write(b'fLaC')
        return MagicMock(returncode=0)

      mock_subproc.side_effect = fake_ffmpeg
      out = convert_from_gcs._ConvertWavToFlac(quoted_wav)
      self.assertEqual(out, expected_flac)
      self.assertFalse(os.path.exists(quoted_wav))
      self.assertTrue(os.path.exists(expected_flac))

  @patch('convert_from_gcs._ConvertWavToFlacRunner')
  @patch('convert_from_gcs._GetGcsUris')
  def test_batch_pipeline_skips_non_wav_objects(self, mock_uris, mock_runner):
    mock_uris.return_value = (
        ['gs://b/readme.md', 'gs://b/2026/11/call1.wav'],
        ['readme.md', '2026/11/call1.wav'],
    )
    convert_from_gcs._BatchConvertWavToFlacPipeline(
        'src-bkt', 'dst-bkt', 'proj-1', None, 8000
    )
    mock_runner.assert_called_once_with(
        '2026/11/call1.wav', 'src-bkt', 'dst-bkt', 'proj-1', None, 8000
    )


if __name__ == '__main__':
  unittest.main()
