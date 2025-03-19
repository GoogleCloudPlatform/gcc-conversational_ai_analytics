variable "repository_name" {
  description = "The name of the Dataform repository"
  type        = string
}

variable "project_id" {
  description = "Id of the project where resources will be created."
  type        = string
}

variable "region" {
  description = "The repository's region."
  type        = string
}

variable "remote_repository_settings" {
  description = "Remote settings required to attach the repository to a remote repository."
  type = object({
    url            = optional(string)
    branch         = optional(string, "main")
    secret_version = optional(string)
  })
  default = null
}

variable "workspace_compilation_overrides" {
  description = "Override the default compilation settings that are specified in dataform.json"
  type = object({
    default_database = optional(string)
    schema_suffix    = optional(string)
    table_prefix     = optional(string)
  })
  default = null
}

variable "repository_release_configs" {
  description = "List of Release Configurations."
  type = list(object({
    name                    = string
    git_commitish           = string
    cron_schedule           = string
    time_zone               = string
    code_compilation_config = any
  }))
  default = []
}

variable "service_account" {
  description = "Service account used to execute the dataform workflow."
  type        = string
  default     = ""
}