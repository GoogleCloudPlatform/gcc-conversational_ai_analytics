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
}

module "nlu_testing" {
  source = "../../modules/nlu-testing"
  
  project_id = var.project_id
  region = var.region

  cf_bucket_name = module.cf_bundle_bucket.name
  
  bq_project_id = var.project_id
  bq_table_id = "${var.bq_dataset_name}.nlu_testing"

  service_account_email = var.service_account_email

  scheduled_test_instances = var.nlu_testing_execution_instances
}

module "cx_test_cases" {
  source = "../../modules/cx-test-cases"
  
  project_id = var.project_id
  region = var.region

  cf_bucket_name = module.cf_bundle_bucket.name
  
  bq_project_id = var.project_id
  bq_table_id = "${var.bq_dataset_name}.cx_test_cases" 
  
  service_account_email = var.service_account_email

  scheduled_test_instances = var.cx_test_cases_execution_instances

}

module "agent_structure" {
  source = "../../modules/agent-structure"
  
  project_id = var.project_id
  region = var.region

  cf_bucket_name = module.cf_bundle_bucket.name
  
  bq_project_id = var.project_id
  bq_dataset_name = var.bq_dataset_name
  service_account_email = var.service_account_email

  scheduled_test_instances = var.agent_structure_execution_instances
}

module "dataform" {
  source  = "../../modules/dataform"

  repository_name = var.dataform_repository_name
  project_id      = var.project_id
  region          = var.region

  remote_repository_settings = {
    url            = var.dataform_git_repo_url
    branch         = var.dataform_git_repo_default_branch
    secret_version = var.dataform_git_secret_id
  }

  #Override the BQ Project ID in which Dataform will execute
  workspace_compilation_overrides = {
    default_database = var.project_id
  }

  #Each environment will have it's own Release Configuration
  repository_release_configs = [
    {
      name          = "dev"
      git_commitish = "dev" #git branch with the Dataform code for 'dev'
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

  service_account = var.service_account_email
}