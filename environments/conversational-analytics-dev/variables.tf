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

variable "bq_dataset_region" {
  type = string
  description = "BigQuery dataset region"
}

variable "bq_testing_dataset_name" {
  type        = string
  description = "BigQuery dataset name for testing data"
}

variable "bq_agent_dataset_name" {
  type        = string
  description = "BigQuery dataset name for agent data"
}

variable "bq_dataform_dataset_name" {
  type        = string
  description = "BigQuery dataset name for dataform data"
}
variable "dataform_repository_name" {
  description = "Name for the Dataform repository"
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

variable "conversation_generator_dfcx_agent_id" {
  description = "The Dialogflow CX Agent ID (UUID) for the conversation generator."
  type        = string
}

variable "conversation_generator_gemini_model_name" {
  description = "The Gemini model name to use for conversation generation."
  type        = string
}

variable "conversation_generator_max_turns" {
  description = "Maximum number of turns for each simulated conversation in the conversation generator."
  type        = number
}

variable "conversation_generator_num_conversations" {
  description = "Default number of conversations to generate per Pub/Sub trigger if not specified in the message."
  type        = number
}

variable "conversation_generator_pubsub_topic_name" {
  description = "The name of the Pub/Sub topic to trigger the Cloud Run service for conversation generation."
  type        = string
  default     = "dfcx-simulation-trigger"
}
