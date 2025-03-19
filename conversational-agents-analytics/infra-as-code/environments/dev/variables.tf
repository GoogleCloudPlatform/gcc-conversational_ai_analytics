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

variable "project_id" {
  type = string
  description = "Project ID in which resources will be deployed"
}

variable "region" {
  type = string
  description = "Region in which GCP resources will be deployed"
}

variable "service_account_email" {
  type = string
  description = "Service Account ID to be used as identity"
}

variable "dataform_repository_name" {
  description = "Name for the Dataform repository"
  type        = string
}

variable "dataform_github_token_secret_id" {
  description = "ID of the secret in Secret Manager that contains the Private Key used for connecting to Github"
  type        = string
}

variable "dataform_git_repo_url" {
  description = "Git repo url for Dataform code"
  type        = string
}

variable "dataform_git_repo_default_branch" {
  description = "Git repo default branch"
  type        = string
}

variable "dfcx_export_table" {
  description = "BigQuert table to which DialogFlow exports the raw DFCX logs"
  type        = string
}

variable "bq_project_id" {
  type = string
  description = "BigQuery Project"
}

variable "bq_dataset_name" {
  type = string
  description = "BigQuery Dataset"
}

variable "nlu_testing_execution_instances" {
  type = list(object({
    schedule_name = string
    agent_id = string
    test_config_gcs_uri = string
    cron_schedule = string
    timezone = string
  }))
}

variable "cx_test_cases_execution_instances" {
  type = list(object({
    schedule_name = string
    agent_id = string
    cron_schedule = string
    timezone = string
  }))
}

variable "agent_structure_execution_instances" {
  type = list(object({
    schedule_name = string
    agent_id = string
    cron_schedule = string
    timezone = string
  }))
}

