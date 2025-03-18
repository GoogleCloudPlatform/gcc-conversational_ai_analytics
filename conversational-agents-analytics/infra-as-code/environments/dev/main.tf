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

resource "random_string" "random" {
  length  = 6
  special = false
  lower   = true
}
## Service Account used by Cloud Functions
# module "dialogflow_analytics_sa" {
#   source     = "github.com/GoogleCloudPlatform/cloud-foundation-fabric//modules/iam-service-account?ref=v34.1.0&depth=1"
#   project_id = var.project_id
#   name       = "dialogflow-analytics"
#   # non-authoritative roles granted *to* the service accounts on other resources
#   iam_project_roles = {
#     "${var.project_id}" = [
#       "roles/logging.logWriter",
#       "roles/bigquery.dataEditor",
#       "roles/run.invoker",
#       "roles/dialogflow.serviceAgent",
#       "roles/dialogflow.testCaseAdmin" 
#     ]
#   }
# }
# This bucket will be used for storing the Cloud Functions bundle (.zip file with source code)
module "cf_bundle_bucket" {
  source     = "github.com/GoogleCloudPlatform/cloud-foundation-fabric//modules/gcs?ref=v34.1.0&depth=1"
  project_id = var.project_id
  name       = "cloud-function-bucket-${random_string.random.result}"
  location   = "US"
}

module "nlu_testing" {
  source = "../../modules/nlu-testing"
  
  project_id = var.project_id
  region = var.region

  cf_bucket_name = module.cf_bundle_bucket.name
  
  bq_project_id = var.bq_project_id
  bq_table_id = "${var.bq_dataset_name}.nlu_testing"

  service_account_email = var.service_account_email

  scheduled_test_instances = var.nlu_testing_execution_instances
}

module "cx_test_cases" {
  source = "../../modules/cx-test-cases"
  
  project_id = var.project_id
  region = var.region

  cf_bucket_name = module.cf_bundle_bucket.name
  
  bq_project_id = var.bq_project_id
  bq_table_id = "${var.bq_dataset_name}.cx_test_cases" 
  
  service_account_email = var.service_account_email

  scheduled_test_instances = var.cx_test_cases_execution_instances

}

module "agent_structure" {
  source = "../../modules/agent-structure"
  
  project_id = var.project_id
  region = var.region

  cf_bucket_name = module.cf_bundle_bucket.name
  
  bq_project_id = var.bq_project_id
  bq_dataset_name = var.bq_dataset_name
  service_account_email = var.service_account_email

  scheduled_test_instances = var.agent_structure_execution_instances
}
