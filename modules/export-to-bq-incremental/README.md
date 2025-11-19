# Incremental Export to BigQuery Terraform Module

This module provisions a Cloud Function that incrementally exports conversation data from CCAI Insights to BigQuery. The function is triggered by a Pub/Sub message published by a Cloud Scheduler job and uses a staging table to merge new and updated conversations into a final BigQuery table.

## Prerequisites

- A Google Cloud project with the Cloud Functions, Cloud Build, Cloud Storage, Cloud Scheduler, and BigQuery APIs enabled.
- A service account with the following roles:
    - `roles/cloudfunctions.invoker`
    - `roles/dialogflow.admin`
    - `roles/bigquery.dataEditor`
- A GCS bucket to store the Cloud Function source code.

## BigQuery Tables

This module automatically provisions the required BigQuery tables (`staging` and `final`) using the schema defined in `schemas/ccai_insights_export_schema.json`.

- **Staging Table**: Used for temporary storage of incremental exports.
- **Final Table**: Stores the historical conversation data, partitioned by day on `startTimestamp`.

The incremental load process uses the `conversationUpdateTimestampUtc` field to merge updates into the final table.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `project_id` | The ID of the project in which to provision resources. | `string` | n/a | yes |
| `region` | The region in which to provision resources. | `string` | n/a | yes |
| `ccai_insights_project_id` | The ID of the project that contains the CCAI Insights data. | `string` | n/a | yes |
| `ccai_insights_location_id` | The location of the CCAI Insights data. | `string` | n/a | yes |
| `bigquery_project_id` | The ID of the project that contains the BigQuery dataset. | `string` | n/a | yes |
| `bigquery_staging_dataset` | The name of the BigQuery dataset for the staging table. | `string` | n/a | yes |
| `bigquery_final_dataset` | The name of the BigQuery dataset for the final table. | `string` | n/a | yes |
| `bigquery_staging_table` | The name of the BigQuery staging table. | `string` | n/a | yes |
| `bigquery_final_table` | The name of the BigQuery final table. | `string` | n/a | yes |
| `export_to_bq_cron` | A cron expression that defines how often the export should run. | `string` | n/a | yes |
| `service_account_email` | The email address of the service account to use for the Cloud Function. | `string` | n/a | yes |
| `cf_bucket_name` | The name of the GCS bucket to use for storing the Cloud Function source code. | `string` | n/a | yes |
| `function_name` | The name of the Cloud Function. | `string` | n/a | yes |
| `bq_export_schema_version` | The version of the BigQuery export schema. | `string` | `"V10"` | no |

## Outputs

This module does not have any outputs.
