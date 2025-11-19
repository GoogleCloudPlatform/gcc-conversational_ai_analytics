# Agent Structure Terraform Module

This module provisions a Cloud Function that is triggered by a Cloud Logging sink. The sink is configured to detect when a Dialogflow CX agent is restored. When triggered, the Cloud Function extracts the agent's structure and saves it to a set of BigQuery tables.

## Prerequisites

- A Google Cloud project with the Cloud Functions, Cloud Build, Cloud Storage, Pub/Sub, and BigQuery APIs enabled.
- A service account with the following roles:
    - `roles/cloudfunctions.invoker`
    - `roles/pubsub.publisher`
    - `roles/bigquery.dataEditor`
- A GCS bucket to store the Cloud Function source code.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `project_id` | The ID of the project in which to provision resources. | `string` | n/a | yes |
| `region` | The region in which to provision resources. | `string` | n/a | yes |
| `bq_project_id` | The ID of the project that contains the BigQuery dataset. | `string` | n/a | yes |
| `bq_dataset_name` | The name of the BigQuery dataset to write to. | `string` | n/a | yes |
| `service_account_email` | The email address of the service account to use for the Cloud Function. | `string` | n/a | yes |
| `cf_bucket_name` | The name of the GCS bucket to use for storing the Cloud Function source code. | `string` | n/a | yes |
| `scheduled_test_instances` | A list of tests to be scheduled. | `list(object)` | `[]` | no |
| `pub_sub_publishers_agent_structure` | A list of service accounts to be granted permissions to publish to the agent structure topic. | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| `function_name` | The name of the provisioned Cloud Function. |
| `function_uri` | The URI of the provisioned Cloud Function. |

## Local Development

To run tests locally, you need to install the test dependencies. It is recommended to use a virtual environment:

```bash
python3 -m venv .venv
source .venv/bin/activate
pip install -r cf-source-code/requirements.txt
pip install -r cf-source-code/requirements-test.txt
pytest cf-source-code/
```
