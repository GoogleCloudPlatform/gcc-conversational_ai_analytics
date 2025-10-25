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

variable "project_id" {
  type = string
  description = "Project ID in which the resources will be provisioned"
}

variable "region" {
  type = string
  description = "Region in which the resources will be provisioned"
}

variable "ccai_insights_project_id" {
  type = string
  description = "Project ID of CCAI Insights"
}

variable "ccai_insights_location_id" {
  type = string
  description = "Location ID of CCAI Insights"
}

variable "bigquery_project_id" {
  type = string
  description = "Project ID to which we will be sending the CCAI Insights data to BigQuery"
}

variable "bigquery_staging_dataset" {
  type = string
  description = "BigQuery dataset in which we will be writing the Staging data"
}

variable "bigquery_final_dataset" {
  type = string
  description = "BigQuery dataset in which we will be writing the data"
}

variable "bigquery_staging_table" {
  type = string
  description = "BigQuery table in which we will be writing the Staging data"
}

variable "bigquery_final_table" {
  type = string
  description = "BigQuery table in which we will be writing the data"
}

variable "export_to_bq_cron" {
  type = string
  description = "CRON expression that defines how often the CCAI Insights data will be exported"
}

variable "service_account_email" {
  type = string
  description = "Service Account used as identity by the Cloud Function"
}

variable "cf_bucket_name" {
  type = string
  description = "Bucket name to use for storing the Cloud Function bundle"
}

variable "function_name" {
  type = string
  description = "Cloud Function name"
}