#    Copyright 2024 Google LLC

#    Licensed under the Apache License, Version 2.0 (the "License");
#    you may not use this file except in compliance with the License.
#    You may obtain a copy of the License at

#        http://www.apache.org/licenses/LICENSE-2.0

#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS,
#    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#    See the License for the specific language governing permissions and
#    limitations under the License.

locals {
  timeout_seconds = 540
}

resource "random_id" "bucket_ext" {
  byte_length = 4
}

module "cf_audio_bundle_bucket" {
  source     = "github.com/GoogleCloudPlatform/cloud-foundation-fabric//modules/gcs?ref=v38.1.0&depth=1"
  project_id = var.project_id
  name       = "cf-bucket-${random_id.bucket_ext.id}"
  location   = "US"
}

#Cloud function
module "cf_audio_format_flac" {

  source      = "github.com/GoogleCloudPlatform/cloud-foundation-fabric//modules/cloud-function-v2?ref=v38.1.0&depth=1"
  project_id  = var.project_id
  region      = var.region
  name        = var.function_name
  bucket_name = module.cf_audio_bundle_bucket.name
  bundle_config = {

    source_dir = "${path.module}/function-source-code"
    output_path = "${path.module}/function-source-code/bundle.zip"
    excludes     = ["__pycache__"]
  }
  service_account = var.service_account_email

  function_config = {
    timeout_seconds = local.timeout_seconds
    entry_point = "main"
    runtime = "python312"
    instance_count  = 1
    memory_mb = 2048
    cpu = "1"
  }

  environment_variables = {
    PROJECT_ID = var.project_id
    FORMATTED_AUDIO_BUCKET_ID = var.formatted_audio_bucket_id
    METADATA_BUCKET_ID = var.metadata_bucket_id
    NUMBER_OF_CHANNELS = var.number_of_channels
    HASH_KEY = var.hash_key
    INGEST_RECORD_BUCKET_ID = var.ingest_record_bucket_id
  }

  trigger_config = {
    region = var.region
    event_type = "google.cloud.storage.object.v1.finalized"
    service_account_email = var.service_account_email
    event_filters = [{
      attribute = "bucket"
      value = var.trigger_bucket_name 
    }]
  }
}
