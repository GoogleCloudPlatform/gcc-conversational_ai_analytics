variable "project_id" {
  type        = string
  description = "Project ID in which resources will be deployed"
}

variable "region" {
  type        = string
  description = "Region in which GCP resources will be deployed"
}

variable "bq_project_id" {
  type        = string
  description = "BigQuery Project ID for output data"
}

variable "bq_dataset_name" {
  type        = string
  description = "BigQuery dataset name for output data"
}

variable "service_account_email" {
  type        = string
  description = "Service Account used as identity by the Cloud Function"
}

variable "cf_bucket_name" {
  type        = string
  description = "Bucket name to use for storing the Cloud Function bundle"
}

variable "scheduled_test_instances" {
  type = list(object({
    schedule_name = string
    agent_id      = string
    cron_schedule = string
    timezone      = string
  }))
  description = "List of tests to be scheduled"
}

variable "pub_sub_publishers_agent_structure" {
  type        = list(string)
  default     = []
  description = "List of service accounts to be granted permissions to publish to the agent structure topic"
}