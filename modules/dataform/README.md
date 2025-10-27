# Dataform Terraform Module

This module provisions a Dataform repository and connects it to a remote Git repository. It also configures release schedules and compilation overrides, allowing you to manage your data transformation workflows as code.

## Prerequisites

- A Google Cloud project with the Dataform and Secret Manager APIs enabled.
- A service account with the `roles/dataform.editor` role.
- A Git repository containing your Dataform project.
- A personal access token for your Git repository, stored in Secret Manager.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `repository_name` | The name of the Dataform repository. | `string` | n/a | yes |
| `project_id` | The ID of the project in which to provision resources. | `string` | n/a | yes |
| `region` | The region in which to provision resources. | `string` | n/a | yes |
| `remote_repository_settings` | The settings for the remote Git repository. | `object` | `null` | no |
| `workspace_compilation_overrides` | Overrides for the default compilation settings. | `object` | `null` | no |
| `repository_release_configs` | A list of release configurations. | `list(object)` | `[]` | no |
| `service_account` | The email address of the service account to use for the Dataform repository. | `string` | `""` | no |

## Outputs

This module does not have any outputs.
