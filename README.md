# Conversational AI Analytics

The purpose of this repository is to make available reusable code that can be implemented in Conversational AI Analytics projects.

## Considerations
This is not an officially supported Google product. This project is not eligible for the [Google Open Source Software Vulnerability Rewards Program](https://bughunters.google.com/open-source-security).

# Overview

This repository contains a collection of Terraform modules and utility scripts designed to help you build a comprehensive analytics solution for your Dialogflow CX agents. The modules are designed to be reusable and configurable, allowing you to pick and choose the components you need for your specific use case.

The repository is organized into the following directories:

- `/modules`: Contains reusable Terraform modules for provisioning various components of the analytics solution.
- `/environments`: Contains environment-specific configurations and variable definitions for deploying the Terraform modules.
- `/utils`: Contains utility scripts for various tasks, such as fixing audio encoding and evaluating topic models.
- `/looker`: Contains Looker blocks for visualizing the data.

# Architecture

The modules in this repository can be combined to create a powerful and flexible analytics pipeline. Here's a high-level overview of how the different components work together:

1.  **Data Ingestion**: The `agent-structure` module captures Dialogflow CX agent structures, while the `export-to-bq-incremental` module exports conversation data to BigQuery.
2.  **Testing and Evaluation**: The `cx-test-cases` and `nlu-testing` modules provide a framework for running automated tests against your agents and storing the results in BigQuery.
3.  **Data Transformation**: The `dataform` module allows you to manage your data transformation workflows as code, making it easy to build and maintain your analytics data models.
4.  **Visualization**: The Looker blocks in the `/looker` directory provide a starting point for visualizing your data and gaining insights into your agent's performance.

# Getting Started

To get started with this repository, you'll need to have Terraform installed and configured to work with your Google Cloud project. You can then browse the modules in the `/modules` directory and choose the ones you want to use.

Each module has its own `README.md` file with detailed instructions on how to use it. You can also find example configurations in the `/environments` directory.