# Copyright 2025 Google LLC
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

resource "google_project_service" "secret_manager_api" {
  project = var.project_id
  service = "secretmanager.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "cloud_functions_api" {
  project = var.project_id
  service = "cloudfunctions.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "cloud_scheduler_api" {
  project = var.project_id
  service = "cloudscheduler.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "run_api" {
  project = var.project_id
  service = "run.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "dataform_api" {
  project = var.project_id
  service = "dataform.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "storage_api" {
  project = var.project_id
  service = "storage.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "dialogflow_api" {
  project = var.project_id
  service = "dialogflow.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "bigquery_api" {
  project = var.project_id
  service = "bigquery.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "cloud_build_api" {
  project = var.project_id
  service = "cloudbuild.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "artifact_registry_api" {
  project = var.project_id
  service = "artifactregistry.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "eventarc_api" {
  project = var.project_id
  service = "eventarc.googleapis.com"
  disable_on_destroy = false
}

resource "google_service_account" "conversational_analytics_sa" {
  project      = var.project_id
  account_id   = "convo-analytics-sa"
  display_name = "Conversational Analytics Service Account"
}

resource "google_project_iam_member" "conversational_analytics_sa_permissions" {
  project = var.project_id
  for_each = toset([
    "roles/run.invoker",
    "roles/logging.logWriter",
    "roles/storage.objectViewer",
    "roles/bigquery.dataEditor",
    "roles/bigquery.jobUser",
    "roles/dialogflow.serviceAgent",
    "roles/dialogflow.testCaseAdmin",
    "roles/secretmanager.secretAccessor"
  ])
  role   = each.key
  member = "serviceAccount:${google_service_account.conversational_analytics_sa.email}"
}

resource "google_project_iam_member" "cloudbuild_sa_permissions" {
  project = var.project_id
  for_each = toset([
    "roles/iam.serviceAccountUser"
  ])
  role   = each.key
  member = "serviceAccount:${data.google_project.project.number}@cloudbuild.gserviceaccount.com"
}

resource "google_project_iam_member" "compute_sa_permissions" {
  project = var.project_id
  for_each = toset([
    "roles/logging.logWriter",
    "roles/storage.objectViewer",
    "roles/artifactregistry.reader",
    "roles/artifactregistry.writer"
  ])
  role   = each.key
  member = "serviceAccount:${data.google_project.project.number}-compute@developer.gserviceaccount.com"
}

resource "google_project_iam_member" "build_sa_permissions" {
  project = var.project_id
  for_each = toset([
    "roles/logging.logWriter"
  ])
  role   = each.key
  member  = "serviceAccount:${data.google_project.project.number}-compute@developer.gserviceaccount.com"
}

resource "google_project_iam_member" "dataform_sa_permissions" {
  project = var.project_id
  for_each = toset([
    "roles/secretmanager.secretAccessor",
    "roles/iam.serviceAccountTokenCreator",
    "roles/iam.serviceAccountUser"
  ])
  role   = each.key
  member  = "serviceAccount:service-${data.google_project.project.number}@gcp-sa-dataform.iam.gserviceaccount.com"
}

resource "random_string" "random" {
  length  = 6
  special = false
  lower   = true
}

# This bucket will be used for storing the Cloud Functions bundle (.zip file with source code)
module "cf_bundle_bucket" {
  source     = "github.com/GoogleCloudPlatform/cloud-foundation-fabric//modules/gcs?ref=v34.1.0&depth=1"
  project_id = var.project_id
  name       = "cloud-function-bucket-${random_string.random.result}"
  location   = "US"
  depends_on = [google_project_service.storage_api]
}

module "nlu_testing" {
  source = "../../modules/nlu-testing"
  
  project_id = var.project_id
  region = var.region

  cf_bucket_name = module.cf_bundle_bucket.name
  
  bq_project_id = var.project_id
  bq_table_id = "${var.bq_dataset_name}.nlu_testing"

  service_account_email = google_service_account.conversational_analytics_sa.email

  scheduled_test_instances = var.nlu_testing_execution_instances
  depends_on = [
    google_project_service.cloud_functions_api,
    google_project_service.run_api,
    google_project_service.cloud_build_api,
    google_project_service.cloud_scheduler_api,
    google_project_service.dialogflow_api,
    google_project_service.bigquery_api
  ]
}

module "cx_test_cases" {
  source = "../../modules/cx-test-cases"
  
  project_id = var.project_id
  region = var.region

  cf_bucket_name = module.cf_bundle_bucket.name
  
  bq_project_id = var.project_id
  bq_table_id = "${var.bq_dataset_name}.cx_test_cases" 
  
  service_account_email = google_service_account.conversational_analytics_sa.email

  scheduled_test_instances = var.cx_test_cases_execution_instances
  depends_on = [
    google_project_service.cloud_functions_api,
    google_project_service.run_api,
    google_project_service.cloud_build_api,
    google_project_service.cloud_scheduler_api,
    google_project_service.dialogflow_api,
    google_project_service.bigquery_api
  ]
}

module "agent_structure" {
  source = "../../modules/agent-structure"
  
  project_id = var.project_id
  region = var.region

  cf_bucket_name = module.cf_bundle_bucket.name
  
  bq_project_id = var.project_id
  bq_dataset_name = var.bq_dataset_name
  service_account_email = google_service_account.conversational_analytics_sa.email

  depends_on = [
    google_project_service.cloud_functions_api,
    google_project_service.run_api,
    google_project_service.cloud_build_api,
    google_project_service.cloud_scheduler_api,
    google_project_service.dialogflow_api,
    google_project_service.bigquery_api,
    google_project_service.eventarc_api
  ]
}

module "dataform" {
  source  = "../../modules/dataform"

  repository_name = var.dataform_repository_name
  project_id      = var.project_id
  region          = var.region
  service_account = google_service_account.conversational_analytics_sa.email

  remote_repository_settings = {
    url            = var.dataform_git_repo_url
    branch         = var.dataform_git_repo_default_branch
  }

  workspace_compilation_overrides = {
    default_database = var.project_id
  }

  repository_release_configs = [
    {
      name          = "dev"
      git_commitish = "dev"
      cron_schedule = null
      time_zone     = null
      code_compilation_config = {
        default_database = var.project_id
        vars = {
          dialogflowExport = var.dfcx_export_table
          backfillDate     = "DATE_TRUNC(DATE_SUB(CURRENT_DATE(), INTERVAL 12 MONTH), MONTH)"
        }
      }
    }
  ]
    depends_on = [
      google_project_service.dataform_api,
      google_project_service.secret_manager_api
    ]
  }
  
  module "conversation_generator" {
    source = "../../modules/conversation-generator"
  
    project_id        = var.project_id
    region            = var.region
    dfcx_location     = var.region
    dfcx_agent_id     = var.conversation_generator_dfcx_agent_id
    gemini_model_name = var.conversation_generator_gemini_model_name
    max_turns         = var.conversation_generator_max_turns
    num_conversations = var.conversation_generator_num_conversations
    pubsub_topic_name = var.conversation_generator_pubsub_topic_name
    cf_bucket_name    = module.cf_bundle_bucket.name
  
    depends_on = [
      google_project_service.run_api,
      google_project_service.cloud_build_api,
      google_project_service.dialogflow_api,
      google_project_service.artifact_registry_api,
      google_project_service.eventarc_api
    ]
  }
  