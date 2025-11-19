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
  schema_files = fileset("${path.module}/schemas", "*.json")
  tables = {
    for f in local.schema_files :
    replace(f, ".json", "") => jsondecode(file("${path.module}/schemas/${f}"))
  }
}

data "google_project" "project" {
  project_id = var.project_id
}

module "cf_agent_structure" {
  source      = "github.com/GoogleCloudPlatform/cloud-foundation-fabric//modules/cloud-function-v2?ref=v34.1.0&depth=1"
  project_id  = var.project_id
  region      = var.region
  name        = "agent-structure"
  bucket_name = var.cf_bucket_name
  bundle_config = {
    runtime = "python313"
    path    = "${path.module}/cf-source-code"
    folder_options = {
      archive_path = "${path.module}/cf-source-code/bundle.zip"
      excludes     = ["__pycache__", "env", ".venv", ".pytest_cache", "test_main.py"]
    }
  }
  service_account = var.service_account_email

  function_config = {
    memory_mb = 2048
    cpu       = 1
  }

  environment_variables = {
    BQ_PROJECT_ID   = var.bq_project_id
    BQ_DATASET_NAME = var.bq_agent_dataset_name
  }

  trigger_config = {
    event_type            = "google.cloud.pubsub.topic.v1.messagePublished"
    pubsub_topic          = google_pubsub_topic.trigger_agent_structure.id
    service_account_email = var.service_account_email
  }

}

resource "google_pubsub_topic" "trigger_agent_structure" {
  name = "trigger_agent_structure"
}

resource "google_logging_project_sink" "agent_structure_restore_sink" {
  name                   = "agent-structure-restore-sink"
  project                = var.project_id
  destination            = "pubsub.googleapis.com/projects/${var.project_id}/topics/${google_pubsub_topic.trigger_agent_structure.name}"
  filter                 = "protoPayload.methodName=~\"google.cloud.dialogflow.*.Agents.RestoreAgent\""
  unique_writer_identity = true
}

resource "google_pubsub_topic_iam_member" "agent_structure_sink_publisher" {
  project = var.project_id
  topic   = google_pubsub_topic.trigger_agent_structure.name
  role    = "roles/pubsub.publisher"
  member  = google_logging_project_sink.agent_structure_restore_sink.writer_identity
}

module "bigquery-dataset" {
  source     = "github.com/GoogleCloudPlatform/cloud-foundation-fabric//modules/bigquery-dataset?ref=v34.1.0&depth=1"
  project_id = var.bq_project_id
  id         = var.bq_agent_dataset_name
  location   = var.bq_dataset_region
  tables = {
    for name, config in local.tables :
    name => {
      schema                   = jsonencode(config.schema)
      description              = config.description
      time_partitioning        = config.time_partitioning
      require_partition_filter = config.require_partition_filter
    }
  }
}

