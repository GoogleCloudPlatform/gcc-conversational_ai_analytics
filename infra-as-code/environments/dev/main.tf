# Copyright 2024 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

provider "google" {
  project = "${var.project_id}"
}

data "google_project" "project" {
  project_id = var.project_id
}

# Optional module: Ingesting data into CCAI Insights
# This pipeline automates the ingestion of audio data into Google Cloud Contact Center AI (CCAI) Insights. 
# It uses Cloud Functions orchestrated by Cloud Workflows to transcribe audio using Cloud Speech-to-Text, 
# correct key terms in the transcripts using Vertex AI's Gemini model, redact sensitive information from audio using FFmpeg 
# and from text using DLP, upload the corrected transcripts into CCAI for analysis
# and generate agent feedback using Gemini based on CCAI analysis
# The pipeline includes error handling and provides status updates at each step.

module "custom_ccai_insights_ingest_pipeline" {
  source = "../../modules/ingest-pipeline"
  project_id = var.project_id
  env = var.env
  ccai_insights_project_id = var.ccai_insights_project_id
  region = var.region
  service_account_email = module.ccai_insights_sa.email
  insights_endpoint = var.insights_endpoint
  insights_api_version = var.insights_api_version
  ccai_insights_location_id = var.ccai_insights_location_id
  pipeline_name = var.pipeline_name
  service_account_id = module.ccai_insights_sa.id
  recognizer_path = var.recognizer_path
  stt_function_name = var.stt_function_name
  model_name = var.model_name
  genai_function_name = var.genai_function_name
  feedback_generator_function_name = var.feedback_generator_function_name
  dataset_name = var.dataset_name
  feedback_table_name = var.feedback_table_name
  scorecard_id = var.scorecard_id
  target_tags = var.target_tags
  target_values = var.target_values

  hash_secret_name = var.hash_secret_name
  hash_key = var.hash_key

  client_specific_constraints = var.client_specific_constraints
  client_specific_context = var.client_specific_context
  few_shot_examples = var.few_shot_examples

  depends_on = [ module.ccai_insights_sa, 
                resource.google_project_iam_member.gcp_artifact_registry_create,
                resource.google_project_iam_member.gcs_object_admin,
                google_project_service.gcp_services ]
}

resource "random_id" "export_to_bq_bundle_ext" {
  byte_length = 4
}

# This bucket will be used for storing the Cloud Functions bundle (.zip file with source code)
module "cf_bundle_bucket" {
  source     = "github.com/GoogleCloudPlatform/cloud-foundation-fabric//modules/gcs?ref=v38.1.0&depth=1"
  project_id = var.project_id
  name       = "cf-bucket-${random_id.export_to_bq_bundle_ext.id}"
  location   = "US"
}

# Implement the Terraform module that schedules the BQ export using incremental loads
module "ccai_insights_to_bq_incremental" {
  source  = "../../modules/export-to-bq-incremental"
  project_id = var.project_id
  region = var.region

  function_name = "export-to-bq-incremental"
  cf_bucket_name = module.cf_bundle_bucket.name
  
  ccai_insights_location_id = var.region
  ccai_insights_project_id = var.project_id
  bigquery_project_id = var.project_id
  bigquery_staging_dataset = "ccai_insights_export"
  bigquery_staging_table = "export_staging"
  bigquery_final_dataset = "ccai_insights_export"
  bigquery_final_table = "export"
  export_to_bq_cron   = "0 * * * *"
  service_account_email = module.ccai_insights_sa.email
  insights_endpoint = "contactcenterinsights.googleapis.com"
  insights_api_version = "v1"

  depends_on = [ module.ccai_insights_sa ]
}