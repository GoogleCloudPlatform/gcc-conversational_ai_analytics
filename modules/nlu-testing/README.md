# NLU Testing Terraform Module

This module provisions a Cloud Function that performs NLU testing on a Dialogflow CX agent. The function is triggered by a Cloud Scheduler job and uses a test configuration file from a GCS bucket. The results of the NLU tests are written to a BigQuery table.

## Prerequisites

- A Google Cloud project with the Cloud Functions, Cloud Build, Cloud Storage, Cloud Scheduler, and BigQuery APIs enabled.
- A service account with the following roles:
    - `roles/cloudfunctions.invoker`
    - `roles/dialogflow.admin`
    - `roles/bigquery.dataEditor`
- A GCS bucket to store the Cloud Function source code.
- A GCS bucket containing a test configuration file.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `project_id` | The ID of the project in which to provision resources. | `string` | n/a | yes |
| `region` | The region in which to provision resources. | `string` | n/a | yes |
| `bq_project_id` | The ID of the project that contains the BigQuery dataset. | `string` | n/a | yes |
| `bq_table_id` | The ID of the BigQuery table to write to, in the format `{dataset}.{table}`. | `string` | n/a | yes |
| `service_account_email` | The email address of the service account to use for the Cloud Function. | `string` | n/a | yes |
| `cf_bucket_name` | The name of the GCS bucket to use for storing the Cloud Function source code. | `string` | n/a | yes |
| `scheduled_test_instances` | A list of tests to be scheduled. | `list(object)` | `[]` | yes |

## Outputs

This module does not have any outputs.
