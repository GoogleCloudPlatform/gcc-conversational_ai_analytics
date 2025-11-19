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
  project = var.project_id
}

data "google_project" "project" {
  project_id = var.project_id
}

resource "google_project_service" "contact_center_insights_api" {
  project            = var.project_id
  service            = "contactcenterinsights.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "bigquery_api" {
  project            = var.project_id
  service            = "bigquery.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "run_api" {
  project            = var.project_id
  service            = "run.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "cloud_build_api" {
  project            = var.project_id
  service            = "cloudbuild.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "artifact_registry_api" {
  project            = var.project_id
  service            = "artifactregistry.googleapis.com"
  disable_on_destroy = false
}

## CCAI Insights Service Account BigQuery access
resource "google_project_iam_binding" "project" {
  project = var.project_id
  role    = "roles/bigquery.dataEditor"

  members = [
    "serviceAccount:service-${data.google_project.project.number}@gcp-sa-contactcenterinsights.iam.gserviceaccount.com",
  ]
}

## Service Account used by Cloud Functions
module "ccai_insights_sa" {
  source     = "github.com/GoogleCloudPlatform/cloud-foundation-fabric//modules/iam-service-account?ref=v31.1.0&depth=1"
  project_id = var.project_id
  name       = "ccai-insights-demo1"

  # non-authoritative roles granted *to* the service accounts on other resources
  iam_project_roles = {
    "${var.project_id}" = [
      "roles/contactcenterinsights.editor",
      "roles/logging.logWriter",
      "roles/workflows.invoker",

      # only required if GCS/PubSub trigger will be used by Cloud Function v2
      "roles/pubsub.publisher",
      "roles/run.invoker",
      "roles/eventarc.eventReceiver",
      "roles/bigquery.dataEditor",
      "roles/bigquery.jobUser"
    ]
  }
}

# the GCS default Service Account needs to have permissions to publish Eventarc events
resource "google_project_iam_member" "gcs_pubsub_publisher" {
  project = var.project_id
  role    = "roles/pubsub.publisher"
  member  = "serviceAccount:service-${data.google_project.project.number}@gs-project-accounts.iam.gserviceaccount.com"
}

resource "random_string" "random" {
  length  = 6
  special = false
  lower   = true
}

# This bucket will be used for storing the Cloud Functions bundle (.zip file with source code)
module "cf_bundle_bucket" {
  source     = "github.com/GoogleCloudPlatform/cloud-foundation-fabric//modules/gcs?ref=v31.1.0&depth=1"
  project_id = var.project_id
  name       = "cloud-function-bucket-${random_string.random.result}"
  location   = "US"
}

# Implement the Terraform module that schedules the BQ export using incremental loads
module "ccai_insights_to_bq_incremental" {
  source     = "../../modules/export-to-bq-incremental"
  project_id = var.project_id
  region     = var.region

  function_name  = "export-to-bq-incremental"
  cf_bucket_name = module.cf_bundle_bucket.name

  ccai_insights_location_id = var.region
  ccai_insights_project_id  = var.project_id
  bigquery_project_id       = var.project_id
  bigquery_staging_dataset  = "ccai_insights_export"
  bigquery_staging_table    = "export_staging"
  bigquery_final_dataset    = "ccai_insights_export"
  bigquery_final_table      = "export"
  export_to_bq_cron         = "0 * * * *"
  service_account_email     = module.ccai_insights_sa.email

  depends_on = [module.ccai_insights_sa]
}