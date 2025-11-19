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
  timeout_seconds = 1800
}

data "google_project" "project" {
  project_id = var.project_id
}

resource "google_pubsub_topic" "trigger_topic" {
  name    = "${var.function_name}-trigger"
  project = var.project_id
}

module "cf_export_to_bq" {
  source      = "github.com/GoogleCloudPlatform/cloud-foundation-fabric//modules/cloud-function-v2?ref=v31.1.0&depth=1"
  project_id  = var.project_id
  region      = var.region
  name        = var.function_name
  bucket_name = var.cf_bucket_name
  bundle_config = {
    source_dir  = "${path.module}/function-source-code"
    output_path = "${path.module}/function-source-code/bundle.zip"
  }
  service_account = var.service_account_email

  function_config = {
    max_instance_count = 1 #Only one export at the time should be running
  }

  environment_variables = {
    CCAI_INSIGHTS_PROJECT_ID  = var.ccai_insights_project_id
    CCAI_INSIGHTS_LOCATION_ID = var.ccai_insights_location_id
    BIGQUERY_PROJECT_ID       = var.bigquery_project_id
    BIGQUERY_STAGING_DATASET  = var.bigquery_staging_dataset
    BIGQUERY_STAGING_TABLE    = var.bigquery_staging_table
    BIGQUERY_FINAL_DATASET    = var.bigquery_final_dataset
    BIGQUERY_FINAL_TABLE      = var.bigquery_final_table
    BQ_EXPORT_SCHEMA_VERSION  = var.bq_export_schema_version
  }

  trigger_config = {
    event_type            = "google.cloud.pubsub.topic.v1.messagePublished"
    pubsub_topic          = google_pubsub_topic.trigger_topic.id
    service_account_email = var.service_account_email
  }
}

resource "google_cloud_scheduler_job" "ccai_to_bq_scheduler" {
  name             = "${var.function_name}-scheduler"
  region           = var.region
  schedule         = var.export_to_bq_cron
  description      = "Schedule to export CCAI Insights conversations to BigQuery"
  attempt_deadline = "${local.timeout_seconds}s" #30 minutes
  retry_config {
    retry_count = 3
  }
  
  pubsub_target {
    topic_name = google_pubsub_topic.trigger_topic.id
    data       = base64encode("{\"trigger\": true}")
  }
}

resource "google_pubsub_topic_iam_member" "scheduler_pubsub_publisher" {
  project = google_pubsub_topic.trigger_topic.project
  topic   = google_pubsub_topic.trigger_topic.name
  role    = "roles/pubsub.publisher"
  member  = "serviceAccount:service-${data.google_project.project.number}@gcp-sa-cloudscheduler.iam.gserviceaccount.com"
}



locals {
  is_same_dataset = var.bigquery_staging_dataset == var.bigquery_final_dataset
}

module "unified_dataset" {
  count      = local.is_same_dataset ? 1 : 0
  source     = "github.com/GoogleCloudPlatform/cloud-foundation-fabric//modules/bigquery-dataset?ref=v34.1.0&depth=1"
  project_id = var.bigquery_project_id
  id         = var.bigquery_staging_dataset
  tables = {
    (var.bigquery_staging_table) = {
      schema              = file("${path.module}/schemas/ccai_insights_export_schema.json")
      deletion_protection = false
    },
    (var.bigquery_final_table) = {
      schema              = file("${path.module}/schemas/ccai_insights_export_schema.json")
      deletion_protection = false
      partitioning = {
        type  = "DAY"
        field = "startTimestamp"
      }
    }
  }
}

module "staging_dataset" {
  count      = local.is_same_dataset ? 0 : 1
  source     = "github.com/GoogleCloudPlatform/cloud-foundation-fabric//modules/bigquery-dataset?ref=v34.1.0&depth=1"
  project_id = var.bigquery_project_id
  id         = var.bigquery_staging_dataset
  tables = {
    (var.bigquery_staging_table) = {
      schema              = file("${path.module}/schemas/ccai_insights_export_schema.json")
      deletion_protection = false
    }
  }
}

module "final_dataset" {
  count      = local.is_same_dataset ? 0 : 1
  source     = "github.com/GoogleCloudPlatform/cloud-foundation-fabric//modules/bigquery-dataset?ref=v34.1.0&depth=1"
  project_id = var.bigquery_project_id
  id         = var.bigquery_final_dataset
  tables = {
    (var.bigquery_final_table) = {
      schema              = file("${path.module}/schemas/ccai_insights_export_schema.json")
      deletion_protection = false
      partitioning = {
        type  = "DAY"
        field = "startTimestamp"
      }
    }
  }
}
