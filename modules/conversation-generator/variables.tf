variable "project_id" {
  description = "The GCP project ID."
  type        = string
}

variable "region" {
  description = "The GCP region for Cloud Run deployment."
  type        = string
  default     = "us-central1"
}

variable "dfcx_location" {
  description = "The Dialogflow CX agent location (e.g., us-central1, global)."
  type        = string
  default     = "global"
}

variable "dfcx_agent_id" {
  description = "The Dialogflow CX Agent ID (UUID)."
  type        = string
}

variable "gemini_model_name" {
  description = "The Gemini model name to use for conversation generation."
  type        = string
  default     = "gemini-1.5-flash-001"
}

variable "max_turns" {
  description = "Maximum number of turns for each simulated conversation."
  type        = number
  default     = 10
}

variable "num_conversations" {
  description = "Default number of conversations to generate per Pub/Sub trigger if not specified in the message."
  type        = number
  default     = 1
}

variable "pubsub_topic_name" {
  description = "The name of the Pub/Sub topic to trigger the Cloud Run service."
  type        = string
  default     = "dfcx-simulation-trigger"
}

variable "cf_bucket_name" {
  description = "The name of the Cloud Functions source bucket."
  type        = string
}
