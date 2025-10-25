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

  count = length(var.repository_release_configs)

  project    = google_dataform_repository.repo.project
  region     = google_dataform_repository.repo.region
  repository = google_dataform_repository.repo.name

  name          = var.repository_release_configs[count.index].name
  git_commitish = var.repository_release_configs[count.index].git_commitish
  cron_schedule = var.repository_release_configs[count.index].cron_schedule
  time_zone     = var.repository_release_configs[count.index].time_zone

  code_compilation_config {
    default_database = try(
      lookup(
        var.repository_release_configs[count.index].code_compilation_config,
        "default_database",
        var.repository_release_configs[count.index].code_compilation_config.default_database
      ),
      null #"map_does_not_exist"
    )

    default_schema = try(
      lookup(
        var.repository_release_configs[count.index].code_compilation_config,
        "default_schema",
        var.repository_release_configs[count.index].code_compilation_config.default_schema
      ),
      null #"map_does_not_exist"
    )

    database_suffix = try(
      lookup(
        var.repository_release_configs[count.index].code_compilation_config,
        "database_suffix",
        var.repository_release_configs[count.index].code_compilation_config.default_schema
      ),
      null #"map_does_not_exist"
    )

    schema_suffix = try(
      lookup(
        var.repository_release_configs[count.index].code_compilation_config,
        "schema_suffix",
        var.repository_release_configs[count.index].code_compilation_config.default_schema
      ),
      null #"map_does_not_exist"
    )

    table_prefix = try(
      lookup(
        var.repository_release_configs[count.index].code_compilation_config,
        "table_prefix",
        var.repository_release_configs[count.index].code_compilation_config.default_schema
      ),
      null #"map_does_not_exist"
    )

    vars = try(
      lookup(
        var.repository_release_configs[count.index].code_compilation_config,
        "vars",
        var.repository_release_configs[count.index].code_compilation_config.vars
      ),
      null #"map_does_not_exist"
    )
  }
}

resource "google_secret_manager_secret" "dataform_git_repo_secret" {
  secret_id = "${var.repository_name}-repo-pat"

  replication {
    auto {}
  }
}

# resource "google_secret_manager_secret_iam_member" "member" {
#   project   = var.project_id
#   secret_id = google_secret_manager_secret.dataform_git_repo_secret.secret_id
#   role      = "roles/secretmanager.secretAccessor"
#   member    = "test@google.com"
# }
