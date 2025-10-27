# Conversational Analytics Dev Environment

This directory contains the Terraform configuration for the Conversational Analytics development environment.

## Prerequisites

## Create Git Repo
**Dataform** needs its own Git repository for storing the code. Once the repo gets created, we need to manually copy the files that can be found in `dataform/conversational_agents_block` and push the changes to the default main branch of the repo.

## Create Git Secret
Depending on the Git service being used (Github, Gitlab, etc) we need to create credentials for Dataform to pull/push code into the repo.
For this example code, we utilized PAT, but consultant the Dataform documentation for the latest information.
- [Dataform - Connect to a third-party Git repository](https://docs.cloud.google.com/dataform/docs/connect-repository)

## Create Secret in Secret Manager
We need to create a **Secret** (regional) in **Secret Manager** for storing the credentials that will be used by Dataform for connecting to Git. Terraform will create the secret placeholder, you will have to add the secret to it.

## Service Account
The service account is created with **Terraform**, but your organizations may have their own internal process for provisioning them. The roles required are documented in main.tf.

## How to Use

To deploy this environment, you'll need to have Terraform installed and configured to work with your Google Cloud project. You'll also need to create a `terraform.tfvars` file in this directory with the following variables:

```
project_id = "your-gcp-project-id"
region     = "your-gcp-region"
```

You can then run the following commands to deploy the environment:

```
terraform init
terraform plan
terraform apply
```

## Update Terraform variables
We need to update the `infra-as-code/environments/<name of the environment>/terraform.tfvars` file with the required

| Variable    | Description | Example | 
| -------- | ------- | ------- |
| `dataform_repository_name` | Name for the Dataform repository | `dfcx_analytics` |
| `dataform_git_token_secret_id` | ID of the secret in Secret Manager that contains the Private Key used for connecting to Github | `projects/7863122225/secrets/dataform_github_token/versions/latest` |
| `dataform_git_repo_default_branch` | Git repo default branch | `main` |
| `dfcx_export_table` | Name of BigQuery table that contains the raw Dialogflow exports | `dialogflow.dialogflow_conversation_data` |

## Update the Release Configuration in Terraform
We need to update the `infra-as-code/environments/<name of the environment>/main.tf` file with the required settings for the Release Configuration of the desired environment (dev/qa/prod)

```
#Each environment will have it's own Release Configuration
repository_release_configs = [
    {
        name          = "dev"
        git_commitish = "dev" #git branch with the Dataform code for 'dev'
        cron_schedule = null
        time_zone     = null
        code_compilation_config = {
            default_database = var.project_id # BigQuery Project ID
            vars = {
                dialogflowExport = var.dfcx_export_table
                backfillDate     = "DATE_TRUNC(DATE_SUB(CURRENT_DATE(), INTERVAL 12 MONTH), MONTH)"
            }
        }
    }
]
```

## Dataform Development Workspace
In order to make changes to the **Dataform** code, we need to create a **Development Workspace** in the `dev` environment. [Documentation](https://cloud.google.com/dataform/docs/create-workspace)

The name of the **Development Workspace** will be used as a branch name when commiting the changes to the Git repo.

## Create Scheduled Workflows
**Scheduled Workflows** may or may not be handled with Terraform. Our preference is to manually create this kind of resource because usually there are some previous steps you need to perform in each environment before a **Scheduled Workflow** gets created/triggered.
