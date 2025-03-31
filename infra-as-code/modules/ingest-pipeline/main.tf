# Copyright 2024 Google LLC
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

locals {
  timeout_seconds = 3600
  scheduler_timeout = 1800
}

data "local_file" "orchestration" {
  filename = "${path.module}/workflow/orchestration.yaml"
}

data "google_service_account" "ccai_insights_sa" {
  account_id = var.service_account_id
}

resource "google_eventarc_trigger" "primary" {
    name = var.pipeline_name
    location = var.region

    service_account = var.service_account_email

    matching_criteria {
        attribute = "type"
        value = "google.cloud.storage.object.v1.finalized"
    }

    matching_criteria {
        attribute = "bucket"
        value = module.formatted_bucket.name
    }

    destination {
        workflow = google_workflows_workflow.orchestration.id
    }
}

resource "google_workflows_workflow" "orchestration" {
    project = var.project_id
    name            = var.pipeline_name
    region          = var.region
    service_account = data.google_service_account.ccai_insights_sa.id

    source_contents = data.local_file.orchestration.content

    user_env_vars = {
        cf_ccai_conversation_upload_url = module.cf_conversation_upload.uri
        cf_genai_url = module.cf_genai_transcript_fix.uri
        cf_stt_url = module.cf_stt_transcript.uri
        cf_feedback_generator_url = module.cf_feedback_generator.uri
        cf_audio_redaction_url = module.cf_audio_redaction.uri
        insights_endpoint = var.insights_endpoint
    }

    depends_on = [ module.cf_conversation_upload ]
}

resource "random_string" "random" {
    length  = 5
    special = false
    lower   = true
}

module "cf_bundle_bucket" {
  source     = "github.com/GoogleCloudPlatform/cloud-foundation-fabric//modules/gcs?ref=v38.1.0&depth=1"
  project_id = var.project_id
  name       = "cf-ccai-conversation-upload-bucket-${random_string.random.result}"
  location   = "US"
  versioning = true
}

module "cf_conversation_upload" {
  source      = "github.com/GoogleCloudPlatform/cloud-foundation-fabric//modules/cloud-function-v2?ref=v38.1.0&depth=1"
  project_id  = var.project_id
  region      = var.region
  name        = var.pipeline_name
  bucket_name = module.cf_bundle_bucket.name
  bundle_config = {
    source_dir  = "${path.module}/cf-ccai-conversation-upload"
    output_path = "${path.module}/cf-ccai-conversation-upload/bundle.zip"
  }
  service_account = data.google_service_account.ccai_insights_sa.email

  function_config = {
    timeout_seconds = local.timeout_seconds
    instance_count  = 250
    memory_mb = 2048
    cpu = "1"
  }

  environment_variables = {
    PROJECT_ID = var.project_id
    INSIGHTS_ENDPOINT = var.insights_endpoint
    INSIGHTS_API_VERSION = var.insights_api_version
    CCAI_INSIGHTS_PROJECT_ID = var.ccai_insights_project_id
    CCAI_INSIGHTS_LOCATION_ID = var.ccai_insights_location_id
    INGEST_RECORD_BUCKET_ID = module.ingest_record_bucket.name
    REDACTED_AUDIOS_BUCKET_NAME = module.redacted_audio_bucket.name
  }
}

resource "google_data_loss_prevention_inspect_template" "custom" {
    parent = "projects/${var.project_id}/locations/${var.region}"
    description = "DLP inspection template"
    display_name = "inspect_template"

    inspect_config {

        info_types {
            name = "AGE"
        }
        info_types {
            name = "BLOOD_TYPE"
        }
        info_types {
            name = "CREDIT_CARD_NUMBER"
        }
        info_types {
            name = "DATE_OF_BIRTH"
        }
        info_types {
            name = "EMAIL_ADDRESS"
        }
        info_types {
            name = "FEMALE_NAME"
        }
        info_types {
            name = "FINANCIAL_ACCOUNT_NUMBER"
        }
        info_types {
            name = "FIRST_NAME"
        }
        info_types {
            name = "GENDER"
        }
        info_types {
            name = "LAST_NAME"
        }
        info_types {
            name = "LOCATION_COORDINATES"
        }
        info_types {
            name = "MALE_NAME"
        }
        info_types {
            name = "MARITAL_STATUS"
        }
        info_types {
            name = "MEDICAL_RECORD_NUMBER"
        }
        info_types {
            name = "PERSON_NAME"
        }
        info_types {
            name = "PHONE_NUMBER"
        }
        info_types {
            name = "STREET_ADDRESS"
        }
        info_types {
            name = "US_HEALTHCARE_NPI"
        }
        info_types {
            name = "US_MEDICARE_BENEFICIARY_ID_NUMBER"
        }
        info_types {
            name = "US_SOCIAL_SECURITY_NUMBER"
        }
        info_types {
            name = "US_STATE"
        }
        info_types {
            name = "US_TOLLFREE_PHONE_NUMBER"
        }

        rule_set {
            info_types {
                name = "PERSON_NAME"
            }
            info_types {
                name = "FIRST_NAME"
            }
            info_types {
                name = "LAST_NAME"
            }
            rules {
                exclusion_rule {
                    dictionary {
                        word_list {
                            words = [""]
                        }
                    }
                    matching_type = "MATCHING_TYPE_FULL_MATCH"
                }
            }
        }

        custom_info_types {
            info_type {
                name = "SPELLED_NAME"
            }

            regex {
                pattern = "[A-Z][A-Z-]+"
            }
        }

        custom_info_types {
            info_type {
                name = "EMAIL_AT"
            }

            regex {
                pattern = "[\\w.-]+ ?(at) ?[\\w.-]+\\.[a-z]+"
            }
        }

        custom_info_types {
            info_type {
                name = "NUMBERS_SEPARATED_BY_SLASH"
            }

            regex {
                pattern = "\\d+(?:/\\d+)+"
            }
        }

        include_quote = true
        
    }
}

resource "google_data_loss_prevention_deidentify_template" "basic" {
    parent = "projects/${var.project_id}/locations/${var.region}"
    description = "DLP de-identification template"
    display_name = "deidentification_template"

    deidentify_config {
        info_type_transformations {
            transformations {
                info_types {
                    name = "AGE"
                }
                info_types {
                    name = "BLOOD_TYPE"
                }
                info_types {
                    name = "CREDIT_CARD_NUMBER"
                }
                info_types {
                    name = "DATE_OF_BIRTH"
                }
                info_types {
                    name = "EMAIL_ADDRESS"
                }
                info_types {
                    name = "FEMALE_NAME"
                }
                info_types {
                    name = "FINANCIAL_ACCOUNT_NUMBER"
                }
                info_types {
                    name = "FIRST_NAME"
                }
                info_types {
                    name = "GENDER"
                }
                info_types {
                    name = "LAST_NAME"
                }
                info_types {
                    name = "LOCATION_COORDINATES"
                }
                info_types {
                    name = "MALE_NAME"
                }
                info_types {
                    name = "MARITAL_STATUS"
                }
                info_types {
                    name = "MEDICAL_RECORD_NUMBER"
                }
                info_types {
                    name = "PERSON_NAME"
                }
                info_types {
                    name = "PHONE_NUMBER"
                }
                info_types {
                    name = "STREET_ADDRESS"
                }
                info_types {
                    name = "US_HEALTHCARE_NPI"
                }
                info_types {
                    name = "US_MEDICARE_BENEFICIARY_ID_NUMBER"
                }
                info_types {
                    name = "US_SOCIAL_SECURITY_NUMBER"
                }
                info_types {
                    name = "US_STATE"
                }
                info_types {
                    name = "US_TOLLFREE_PHONE_NUMBER"
                }
                info_types {
                    name = "SPELLED_NAME"
                }
                info_types {
                    name = "EMAIL_AT"
                }
                info_types {
                    name = "NUMBERS_SEPARATED_BY_SLASH"
                }


                primitive_transformation {
                    replace_with_info_type_config = true
                }
            }

        }
    }
}

# STT Transcript Cloud Function
resource "random_id" "bucket_ext" {
  byte_length = 4
}

module "cf_stt_bundle_bucket" {
  source     = "github.com/GoogleCloudPlatform/cloud-foundation-fabric//modules/gcs?ref=v38.1.0&depth=1"
  project_id = var.project_id
  name       = "cf-stt-bucket-${random_id.bucket_ext.id}"
  location   = "US"
  versioning = true
}

module "cf_stt_transcript" {
  source      = "github.com/GoogleCloudPlatform/cloud-foundation-fabric//modules/cloud-function-v2?ref=v38.1.0&depth=1"
  project_id  = var.project_id
  region      = var.region
  name        = var.stt_function_name
  bucket_name = module.cf_stt_bundle_bucket.name
  bundle_config = {
    source_dir  = "${path.module}/cf-stt-transcript"
    output_path = "${path.module}/cf-stt-transcript/bundle.zip"
  }
  service_account = data.google_service_account.ccai_insights_sa.email

  function_config = {
    timeout_seconds = local.timeout_seconds
    instance_count  = 250
    runtime = "python312"
    memory_mb = 2048
    cpu = "1"
  }

  environment_variables = {
    PROJECT_ID = var.project_id
    TRANSCRIPT_BUCKET_ID = module.transcript_bucket.name
    RECOGNIZER_PATH = var.recognizer_path
    INGEST_RECORD_BUCKET_ID = module.ingest_record_bucket.name
  }
}

# GenAI Cloud function business key word fix
resource "random_id" "genai_bucket_ext" {
  byte_length = 4
}

module "cf_genai_bundle_bucket" {
  source     = "github.com/GoogleCloudPlatform/cloud-foundation-fabric//modules/gcs?ref=v38.1.0&depth=1"
  project_id = var.project_id
  name       = "cf-genai-bucket-${random_id.genai_bucket_ext.id}"
  location   = "US"
  versioning = true
}

module "cf_genai_transcript_fix" {
  source      = "github.com/GoogleCloudPlatform/cloud-foundation-fabric//modules/cloud-function-v2?ref=v38.1.0&depth=1"
  project_id  = var.project_id
  region      = var.region
  name        = var.genai_function_name
  bucket_name = module.cf_genai_bundle_bucket.name
  bundle_config = {
    source_dir  = "${path.module}/cf-transcript-correction"
    output_path = "${path.module}/cf-transcript-correction/bundle.zip"
  }
  service_account = data.google_service_account.ccai_insights_sa.email

  function_config = {
    timeout_seconds = local.timeout_seconds
    entry_point = "main"
    runtime = "python312"
    memory_mb = 2048
    cpu = "1"
    instance_count  = 250
  }

  environment_variables = {
    PROJECT_ID = var.project_id
    LOCATION_ID = var.region
    MODEL_NAME = var.model_name
    INGEST_RECORD_BUCKET_ID = module.ingest_record_bucket.name
    CLIENT_SPECIFIC_CONSTRAINTS = var.client_specific_constraints
    CLIENT_SPECIFIC_CONTEXT = var.client_specific_context
    FEW_SHOT_EXAMPLES = var.few_shot_examples
  }
}

module "cf_feedback_generator_bundle_bucket" {
  source     = "github.com/GoogleCloudPlatform/cloud-foundation-fabric//modules/gcs?ref=v38.1.0&depth=1"
  project_id = var.project_id
  name       = "cf-feedback-generator-bucket-${random_id.bucket_ext.id}"
  location   = "US"
  versioning = true
}

module "cf_feedback_generator" {
  source      = "github.com/GoogleCloudPlatform/cloud-foundation-fabric//modules/cloud-function-v2?ref=v38.1.0&depth=1"
  project_id  = var.project_id
  region      = var.region
  name        = var.feedback_generator_function_name
  bucket_name = module.cf_feedback_generator_bundle_bucket.name
  bundle_config = {
    source_dir  = "${path.module}/cf-feedback-generator"
    output_path = "${path.module}/cf-feedback-generator/bundle.zip"
  }
  service_account = data.google_service_account.ccai_insights_sa.email

  function_config = {
    timeout_seconds = local.timeout_seconds
    instance_count  = 250
    memory_mb = 8192
    cpu = "2"
  }

  environment_variables = {
    PROJECT_ID = var.project_id,
    INSIGHTS_ENDPOINT = var.insights_endpoint,
    INSIGHTS_API_VERSION = var.insights_api_version,
    CCAI_INSIGHTS_LOCATION_ID = var.ccai_insights_location_id,
    LOCATION_ID = var.region,
    MODEL_NAME = var.model_name,
    DATASET_NAME = var.dataset_name,
    FEEDBACK_TABLE_NAME = var.feedback_table_name,
    SCORECARD_ID = var.scorecard_id
    INGEST_RECORD_BUCKET_ID = module.ingest_record_bucket.name
    TARGET_TAGS = var.target_tags
    TARGET_VALUES = var.target_values
  }
}

resource "google_project_iam_member" "ccai_insights_editor" {
  project = var.ccai_insights_project_id
  role    = "roles/contactcenterinsights.editor"
  member  = "serviceAccount:${data.google_service_account.ccai_insights_sa.email}"
}


# Audio Redaction Cloud Function
resource "random_id" "audio_redaction_bucket_ext" {
  byte_length = 4
}

module "cf_audio_redaction_bundle_bucket" {
  source     = "github.com/GoogleCloudPlatform/cloud-foundation-fabric//modules/gcs?ref=v38.1.0&depth=1"
  project_id = var.project_id
  name       = "cf-audio-redaction-bucket-${random_id.audio_redaction_bucket_ext.id}"
  location   = "US"
  versioning = true
}

module "cf_audio_redaction" {
  source      = "github.com/GoogleCloudPlatform/cloud-foundation-fabric//modules/cloud-function-v2?ref=v38.1.0&depth=1"
  project_id  = var.project_id
  region      = var.region
  name        = var.audio_redaction_function_name
  bucket_name = module.cf_audio_redaction_bundle_bucket.name
  bundle_config = {
    source_dir  = "${path.module}/cf-audio-redaction"
    output_path = "${path.module}/cf-audio-redaction/bundle.zip"
  }
  service_account = data.google_service_account.ccai_insights_sa.email

  function_config = {
    timeout_seconds = local.timeout_seconds
    instance_count  = 250
    runtime = "python312"
    memory_mb = 2048
    cpu = "1"
  }

  environment_variables = {
    PROJECT_ID = var.project_id
    TRANSCRIPT_BUCKET_ID = module.transcript_bucket.name
    REDACTED_AUDIOS_BUCKET_NAME = module.redacted_audio_bucket.name
  }
}

#Bucket for the output of the STT Transcript in json format
module "transcript_bucket" {
  source     = "github.com/GoogleCloudPlatform/cloud-foundation-fabric//modules/gcs?ref=v38.1.0&depth=1"
  project_id = var.project_id
  name     = "stt-transcript-${random_id.bucket_ext.id}-${var.env}"
  location = "US"
  versioning = true
}

# Buckets for the audio formatting cloud function
module "trigger_bucket" {
  source     = "github.com/GoogleCloudPlatform/cloud-foundation-fabric//modules/gcs?ref=v38.1.0&depth=1"
  project_id = var.project_id
  name     = "original-audio-files-${random_id.bucket_ext.id}-${var.env}"
  location = var.region # The trigger must be in the same location as the bucket
  storage_class = "REGIONAL"
  versioning = true
}

module "formatted_bucket" {
  source     = "github.com/GoogleCloudPlatform/cloud-foundation-fabric//modules/gcs?ref=v38.1.0&depth=1"
  project_id = var.project_id
  name     = "formatted-audio-files-${random_id.bucket_ext.id}-${var.env}"
  location = var.region 
  storage_class = "REGIONAL"
  versioning = true
}

module "meta_bucket" {
  source     = "github.com/GoogleCloudPlatform/cloud-foundation-fabric//modules/gcs?ref=v38.1.0&depth=1"
  project_id = var.project_id
  name     = "formatted-audio-metadata-${random_id.bucket_ext.id}-${var.env}"
  location = var.region 
  storage_class = "REGIONAL"
  versioning = true
}

module "redacted_audio_bucket" {
  source     = "github.com/GoogleCloudPlatform/cloud-foundation-fabric//modules/gcs?ref=v38.1.0&depth=1"
  project_id = var.project_id
  name     = "redacted-audio-files"
  location = var.region 
  storage_class = "REGIONAL"
  versioning = true
}

# Secret manager
module "secret_manager_hash_key" {
  source  = "github.com/GoogleCloudPlatform/cloud-foundation-fabric//modules/secret-manager?ref=v38.1.0&depth=1"
  project_id = var.project_id 

  secrets = {
    (var.hash_secret_name) = {
      locations = null
      keys      = null
    }
  }

  versions = {
    (var.hash_secret_name) = {
      "latest" = {
        enabled = true
        data    = var.hash_key
      }
    }
  }

}

module "audio_data_format_change" {
  source = "../../modules/audio-data-format-change"
  project_id = var.project_id
  region = var.region
  env = var.env
  service_account_email = data.google_service_account.ccai_insights_sa.email

  function_name = "audio-format-change"

  formatted_audio_bucket_id = module.formatted_bucket.name
  metadata_bucket_id = module.meta_bucket.name
  ingest_record_bucket_id = module.ingest_record_bucket.name
  number_of_channels = 2
  hash_key = var.hash_secret_name

  trigger_bucket_name = module.trigger_bucket.name
}

module "ingest_record_bucket" {
  source     = "github.com/GoogleCloudPlatform/cloud-foundation-fabric//modules/gcs?ref=v38.1.0&depth=1"
  project_id = var.project_id
  name     = "ingest-record-bucket-${random_id.bucket_ext.id}-${var.env}"
  location = var.region 
  storage_class = "REGIONAL"
  versioning = true
}