# AI Operating Manual for the GCC Conversational AI Analytics Repository

## 1. Project Overview

This repository contains the Infrastructure as Code (IaC) and application code for the Google Cloud Conversational AI Analytics project. It uses Terraform to provision and manage a suite of tools and services for analyzing and evaluating conversational AI agents built on Dialogflow CX.

The primary goal of this repository is to provide a set of reusable modules for:
- Extracting and storing Dialogflow CX agent structure.
- Running and managing CX test cases.
- Performing NLU testing.
- Incrementally exporting conversation data to BigQuery.
- Managing Dataform repositories for data transformation.

## 2. Core Technologies

* **Cloud:** Google Cloud Platform (GCP)
* **IaC:** Terraform
* **Data Warehousing:** BigQuery
* **Data Processing:** Cloud Functions (Python)
* **Data Transformation:** Dataform
* **Scheduling:** Cloud Scheduler
* **Messaging:** Pub/Sub

## 3. Repository Structure Overview

* `/modules/`: Contains reusable Terraform modules for provisioning various components of the analytics solution.
* `/environments/`: Contains environment-specific configurations and variable definitions for deploying the Terraform modules.
* `/utils/`: Contains utility scripts for various tasks, such as fixing audio encoding and evaluating topic models.
* `/looker/`: Contains Looker blocks for exploring visualizing the data.
* `/dataform/`: Contains Dataorm blocks for transforming the data.

## 4. Terraform Modules Overview

### 4.1. `agent-structure`

This module provisions a Cloud Function that is triggered by a Cloud Logging sink. The sink is configured to detect when a Dialogflow CX agent is restored. When triggered, the Cloud Function extracts the agent's structure and saves it to a set of BigQuery tables.

**Key Components:**
- Gen2 Cloud Function (`agent-structure`)
- Pub/Sub topic (`trigger_agent_structure`)
- Cloud Logging sink
- BigQuery dataset and tables

### 4.2. `cx-test-cases`

This module provisions a Cloud Function that runs Dialogflow CX test cases on a schedule. The schedule is defined by a Cloud Scheduler job, which triggers the Cloud Function via an HTTP request. The results of the test cases are written to a BigQuery table.

**Key Components:**
- Gen2 Cloud Function (`cx-test-cases`)
- Cloud Scheduler jobs
- BigQuery table

### 4.3. `dataform`

This module provisions a Dataform repository and connects it to a remote Git repository. It also configures release schedules and compilation overrides, allowing you to manage your data transformation workflows as code.

**Key Components:**
- Dataform repository
- Secret Manager secret for Git authentication
- Dataform release configurations

### 4.4. `export-to-bq-incremental`

This module provisions a Cloud Function that incrementally exports conversation data from CCAI Insights to BigQuery. The function is triggered by a Cloud Scheduler job and uses a staging table to merge new and updated conversations into a final BigQuery table.

**Key Components:**
- Gen2 Cloud Function
- Cloud Scheduler job
- BigQuery tables (staging and final)

### 4.5. `nlu-testing`

This module provisions a Cloud Function that performs NLU testing on a Dialogflow CX agent. The function is triggered by a Cloud Scheduler job and uses a test configuration file from a GCS bucket. The results of the NLU tests are written to a BigQuery table.

**Key Components:**
- Gen2 Cloud Function (`nlu-testing`)
- Cloud Scheduler jobs
- BigQuery table

## 5. Key Commands

### Terraform Workflow

When performing any Terraform-related tasks, you MUST follow this exact sequence of commands from within an environment directory (e.g., `/environments/conversational-analytics-dev`).

1.  **Initialize the Backend:**
    This command configures Terraform to use the correct remote state file for the environment. You must check the backend.tf to ensure a bucket is specified. If not, ask the user to provide the bucket and add to terraform init (e.g., -backend-config="bucket=specified-bucket-name")
    ```bash
    terraform init
    ```

2.  **Validate Terraform:**
    This command checks for configuration syntax errors and internal consistency.
    ```bash
    terraform validate
    ```

3.  **Format Terraform:**
    This command ensure Terraform is consistently formatted.
    ```bash
    terraform fmt -recursive
    ```

4.  **Generate an Execution Plan:**
    This command shows you what changes will be made without applying them.
    ```bash
    terraform plan
    ```

5.  **Apply Changes:**
    After the plan is reviewed and approved, apply the changes.
    ```bash
    terraform apply
    ```

## 6. Python Standards & Testing

### Environment Setup

All Python development for Cloud Functions MUST be done within a virtual environment to ensure dependency isolation. Each function directory (e.g., `/modules/agent-structure/cf-source-code/`) should be treated as a separate project.

You MUST use the following workflow:

1.  **Navigate to Function Directory**: `cd modules/<module-name>/<cf-source-code-dir>`
2.  **Create Virtual Environment**: `python3 -m venv .venv`
3.  **Activate Environment**: `source .venv/bin/activate`
4.  **Install Dependencies**: `pip install -r requirements.txt`

### Running Tests

This project uses `pytest` for unit testing. Tests are located in `test_main.py` files within each function's directory.

To run the tests for a specific function, you MUST first activate its virtual environment and then run pytest:

```bash
# Navigate to the function's directory
cd modules/agent-structure/cf-source-code

# Activate the virtual environment
source .venv/bin/activate

# Run the tests
pytest
```

You MUST run these tests for any function you modify before submitting changes.
