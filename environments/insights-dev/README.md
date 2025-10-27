# Insights Dev Environment

This directory contains the Terraform configuration for the Insights development environment.

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
