# Insights Looker Block

## Overview

This CCAI Insights Looker Block uses the BQ export to provide a more holistic view of the business's call center and agent performance via the following dashboards:

* Call Center Performance: Executive dashboard displaying high-level metrics intended for call center management. 
* Agent Performance: Performance metrics for an individual agent, linked from the Agent ID dimension.
* Agent Operations: Performance metrics for agents in aggregate.
* Conversation Lookup Dashboard: Detailed transcript and sentiment analysis for an individual conversation, linked from the Conversation Name dimension.

## Instructions

1. Copy each of files from the dashboards, models and views folders into a new LookML Project
2. Copy the manifest.lkml file into the LookML project
3. Update the db_connection_name constant in the manifest file with your db connection name
4. Update the insights_table constant in the manifest file with your Insight export's dataset.table name

## Documentation
[BQ Schema](https://cloud.google.com/contact-center/insights/docs/bigquery-all-schemas)
*Note: This Looker block is compatible with BQ Schema v4 and higher

## Troubleshooting
Common LookML Error: "Ensure the database connection is working and the modeled syntax is appropriate to the connections SQL dialect. Query execution failed: - Name agents not found insight insights_data at [13:32]"
The Insights BQ export schema is still on v3 whereas the field "agents" is a nested field in v4+ schemas. You may need to request to allowlist your instance to a later version and recreate the BQ export.

## Dashboards

- **Conversation Overview**: Provides a high-level overview of your conversations, including the number of conversations, average conversation length, and sentiment analysis.
- **Topic Analysis**: Allows you to analyze the topics that are being discussed in your conversations.
- **Agent Performance**: Provides insights into the performance of your agents, including their handling of different topics and their impact on customer satisfaction.

## How to Use

To use this block, you'll need to have a Looker instance with a connection to your BigQuery data. You can then install this block from the Looker Marketplace or by copying the files into your Looker project.
