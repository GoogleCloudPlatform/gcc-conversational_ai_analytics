# conversational-agents-analytics

## Prerequisites

## Create Git Repo
**Dataform** needs its own Git repository for storing the code. Once the repo gets created, we need to manually copy the files that can be found in `dataform/code` and push the changes to the default main branch of the repo.

## Create Git Secret
Depending on the Git service being used (Github, Gitlab, etc) we need to create credentials for Dataform to pull/push code into the repo.
For Github, one of the most common ways of authenticating is via Tokens. For simplicity, we will be using PATs:
- [PAT](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens)

The PAT needs to have the repo scope.

## Create Secret in Secret Manager
We need to create a **Secret** (regional) in **Secret Manager** for storing the credentials that will be used by Dataform for connecting to Git.

## Service Account
The reason why the Service Account is not created with **Terraform** is that many organizations have their own internal process for provisioning them.
These are the required roles and sample code that can be used for provisioning it.

```sh
PROJECT_ID="gsd-ccai-insights-offering"
SERVICE_ACCOUNT_NAME="dfcx-analytics"

gcloud config set project ${PROJECT_ID}

gcloud iam service-accounts create ${SERVICE_ACCOUNT_NAME} \
    --display-name="${SERVICE_ACCOUNT_NAME}"

#Grab the email of the newly created Service Account
SERVICE_ACCOUNT_EMAIL=$(gcloud iam service-accounts list --filter="displayName:${SERVICE_ACCOUNT_NAME}" --format="value(email)")

#Execute BigQuery jobs
gcloud projects add-iam-policy-binding ${PROJECT_ID} --member="serviceAccount:${SERVICE_ACCOUNT_EMAIL}" --role="roles/bigquery.jobUser"

#BigQuery Data Viewer
gcloud projects add-iam-policy-binding ${PROJECT_ID} --member="serviceAccount:${SERVICE_ACCOUNT_EMAIL}" --role="roles/bigquery.dataViewer"

# Write data to BigQuery
gcloud projects add-iam-policy-binding ${PROJECT_ID} --member="serviceAccount:${SERVICE_ACCOUNT_EMAIL}" --role="roles/bigquery.dataEditor"

#Invoke Cloud Run Functions
gcloud projects add-iam-policy-binding ${PROJECT_ID} --member="serviceAccount:${SERVICE_ACCOUNT_EMAIL}" --role="roles/run.invoker"

# DFCX APIs
gcloud projects add-iam-policy-binding ${PROJECT_ID} --member="serviceAccount:${SERVICE_ACCOUNT_EMAIL}" --role="roles/dialogflow.serviceAgent"

# Execute DFCX test
gcloud projects add-iam-policy-binding ${PROJECT_ID} --member="serviceAccount:${SERVICE_ACCOUNT_EMAIL}" --role="roles/dialogflow.testCaseAdmin"

# Execute DFCX test
gcloud projects add-iam-policy-binding ${PROJECT_ID} --member="serviceAccount:${SERVICE_ACCOUNT_EMAIL}" --role="roles/logging.logWriter"
```

## Additional permissions
The **Dataform Default Service Account** needs to have permissions to *impersonate* the Service Account we previously created and also access the Git Secret we previously defined.

```sh
PROJECT_NUMBER=$(gcloud projects describe ${PROJECT_ID} --format='value(projectNumber)')
DATAFORM_DEFAULT_SERVICE_ACCOUNT=service-${PROJECT_NUMBER}@gcp-sa-dataform.iam.gserviceaccount.com
DATAFORM_GIT_SECRET_ID="projects/322256122112/secrets/dataform-git-token"

# Secret Accesor
gcloud secrets add-iam-policy-binding ${DATAFORM_GIT_SECRET_ID} \
    --member="serviceAccount:${DATAFORM_DEFAULT_SERVICE_ACCOUNT}" \
    --role="roles/secretmanager.secretAccessor"

# Impersonate the Service Account
gcloud projects add-iam-policy-binding ${PROJECT_ID} \
    --member="serviceAccount:${DATAFORM_DEFAULT_SERVICE_ACCOUNT}" \
    --role="roles/iam.serviceAccountTokenCreator"

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

## Terraform deployment
For deploying the solution in each environment, we need to execute:
```sh
cd infra-as-code/environments/dev
terraform init
terraform plan
terraform apply
```

## Dataform Development Workspace
In order to make changes to the **Dataform** code, we need to create a **Development Workspace** in the `dev` environment. [Documentation](https://cloud.google.com/dataform/docs/create-workspace)



The name of the **Development Workspace** will be used as a branch name when commiting the changes to the Git repo.

## Create Scheduled Workflows
**Scheduled Workflows** may or may not be handled with Terraform. Our preference is to manually create this kind of resource because usually there are some previous steps you need to perform in each environment before a **Scheduled Workflow** gets created/triggered.

