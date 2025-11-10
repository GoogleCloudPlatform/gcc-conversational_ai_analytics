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
  release_configs_map = { for config in var.repository_release_configs : config.name => config }
}

resource "google_dataform_repository" "repo" {
  provider        = google-beta
  name            = var.repository_name
  project         = var.project_id
  display_name    = var.repository_name
  region          = var.region
  service_account = var.service_account

  dynamic "git_remote_settings" {
    for_each = var.remote_repository_settings != null ? [1] : []
    content {
      url                                 = var.remote_repository_settings.url
      default_branch                      = var.remote_repository_settings.branch
      authentication_token_secret_version = "${google_secret_manager_secret.dataform_git_repo_secret.id}/versions/latest"
    }
  }

  dynamic "workspace_compilation_overrides" {
    for_each = var.workspace_compilation_overrides != null ? [1] : []
    content {
      default_database = var.workspace_compilation_overrides.default_database
      schema_suffix    = var.workspace_compilation_overrides.schema_suffix
      table_prefix     = var.workspace_compilation_overrides.table_prefix
    }
  }
}

resource "google_dataform_repository_release_config" "releases" {
  provider = google-beta

  for_each = local.release_configs_map

  project    = google_dataform_repository.repo.project
  region     = google_dataform_repository.repo.region
  repository = google_dataform_repository.repo.name

  name          = each.key
  git_commitish = each.value.git_commitish

  code_compilation_config {
    default_database = try(each.value.code_compilation_config.default_database, null)
    default_schema   = try(each.value.code_compilation_config.default_schema, null)
    database_suffix  = try(each.value.code_compilation_config.database_suffix, null)
    schema_suffix    = try(each.value.code_compilation_config.schema_suffix, null)
    table_prefix     = try(each.value.code_compilation_config.table_prefix, null)
    vars             = try(each.value.code_compilation_config.vars, null)
  }

  depends_on = [google_secret_manager_secret.dataform_git_repo_secret]
}

resource "google_dataform_repository_workflow_config" "workflows" {
  provider = google-beta
  for_each = { for k, v in local.release_configs_map : k => v if v.cron_schedule != null }

  project    = google_dataform_repository.repo.project
  region     = google_dataform_repository.repo.region
  repository = google_dataform_repository.repo.name

  name = "${each.key}-workflow"
  release_config = google_dataform_repository_release_config.releases[each.key].id

  cron_schedule = each.value.cron_schedule
  time_zone     = each.value.time_zone

  invocation_config {
    included_tags                            = ["high-frequency"]
    transitive_dependencies_included         = false
    transitive_dependents_included           = false
    fully_refresh_incremental_tables_enabled = false
  }
}

resource "google_secret_manager_secret" "dataform_git_repo_secret" {
  secret_id = "${var.repository_name}-repo-pat"

  replication {
    auto {}
  }
}

module "bigquery-dataset" {
  source     = "github.com/GoogleCloudPlatform/cloud-foundation-fabric//modules/bigquery-dataset?ref=v34.1.0&depth=1"
  project_id = var.bq_project_id
  id         = var.bq_dataform_dataset_name
  location   = var.bq_dataset_region
  tables = {
    for name, config in local.tables :
    name => {
      schema                   = jsonencode(config.schema)
      description              = config.description
      partitioning             = try(config.partitioning,null)
      require_partition_filter = try(config.require_partition_filter,null) 
    }
  }
}

resource "null_resource" "trigger_dataform_compilation" {
  for_each = local.release_configs_map
  triggers = {
    config_hash = md5(jsonencode(each.value))
    repo_name   = google_dataform_repository.repo.name
  }
  provisioner "local-exec" {
    command     = "/bin/bash ./trigger_compilation.sh ${each.key} ${var.project_id} ${var.region} ${each.value.git_commitish} ${google_dataform_repository.repo.name}"
    working_dir = path.module
  }
  depends_on = [google_dataform_repository_release_config.releases]
}