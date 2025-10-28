# Conversation Generator Module

This module deploys a 2nd Generation Cloud Function that simulates user conversations with a Dialogflow CX agent using Gemini. It is triggered by a Pub/Sub message and can generate a customizable number of synthetic conversations.

## Architecture

- **Pub/Sub Topic**: Receives trigger messages to start simulations.
- **Cloud Function (2nd Gen) (`dfcx-simulator`)**: A Pub/Sub trigger invokes this function. It orchestrates multi-turn conversations between Gemini and a Dialogflow CX agent, logging transcripts to Cloud Logging.
- **Cloud Scheduler**: A Cloud Scheduler job is created to trigger the Pub/Sub topic on a regular schedule.

## Features

- **Customizable Conversations**: Specify the number of conversations to generate per trigger.
- **Randomized Scenarios**: Each simulation uses randomly selected user personas, contexts, and issues.
- **Multi-turn Simulation**: Gemini generates user utterances based on conversation history and agent responses.
- **Detailed Logging**: Full conversation transcripts are logged to Cloud Logging for analysis.
- **Automated Scheduling**: A Cloud Scheduler job is created to trigger the conversation generation every 4 minutes.

## Deployment

This module is designed to be deployed as part of a larger Terraform environment (e.g., `conversational-analytics-dev`). The Cloud Function's source code is automatically packaged and deployed by Terraform to a GCS bucket, eliminating the need for a separate Cloud Build configuration for the image.

### Prerequisites

1.  A Google Cloud Project.
2.  `gcloud` CLI installed and authenticated.
3.  A Dialogflow CX Agent already created.
4.  The following APIs enabled in your GCP project:
    -   Cloud Functions API
    -   Cloud Run API
    -   Cloud Build API (for source code packaging by Cloud Functions)
    -   Dialogflow API
    -   Vertex AI API
    -   Pub/Sub API
    -   Cloud Storage API
    -   Cloud Scheduler API

### Module Variables

The following variables can be configured for this module:

| Name                | Description                                                                   | Type   | Default                     |
| :------------------ | :---------------------------------------------------------------------------- | :----- | :-------------------------- |
| `project_id`        | The GCP project ID.                                                           | `string` | `n/a`                       |
| `region`            | The GCP region for Cloud Function deployment.                                 | `string` | `"us-central1"`             |
| `dfcx_location`     | The Dialogflow CX agent location (e.g., `us-central1`, `global`).             | `string` | `"global"`                  |
| `dfcx_agent_id`     | The Dialogflow CX Agent ID (UUID).                                            | `string` | `n/a`                       |
| `gemini_model_name` | The Gemini model name to use for conversation generation.                     | `string` | `"gemini-1.5-flash-001"`    |
| `max_turns`         | Maximum number of turns for each simulated conversation.                      | `number` | `10`                        |
| `num_conversations` | Default number of conversations to generate per Pub/Sub trigger.              | `number` | `1`                         |
| `pubsub_topic_name` | The name of the Pub/Sub topic to trigger the Cloud Function.                  | `string` | `"dfcx-simulation-trigger"` |

### Example Usage in `main.tf` (within an environment)

```terraform
module "conversation_generator" {
  source = "../../modules/conversation-generator"

  project_id        = var.project_id
  region            = var.region
  dfcx_location     = var.dfcx_location
  dfcx_agent_id     = var.conversation_generator_dfcx_agent_id
  gemini_model_name = var.conversation_generator_gemini_model_name
  max_turns         = var.conversation_generator_max_turns
  num_conversations = var.conversation_generator_num_conversations
  pubsub_topic_name = var.conversation_generator_pubsub_topic_name
}
```

## Scheduling

This module automatically creates a Cloud Scheduler job that triggers the conversation generation every 4 minutes. The scheduler sends a Pub/Sub message to the `dfcx-simulation-trigger` topic with a payload of `{"num_conversations":1}`.

## Manual Triggering

For testing purposes, you can also manually trigger a simulation by publishing a message to the `dfcx-simulation-trigger` Pub/Sub topic. You can optionally specify the number of conversations to generate in the message data.

### Example Pub/Sub Message (JSON payload)

To generate 5 conversations:

```json
{
  "num_conversations": 5
}
```

If `num_conversations` is not provided in the message, the `NUM_CONVERSATIONS` environment variable (defaulting to 1) configured in the Cloud Function will be used.

### Using `gcloud` to publish a message

```bash
# To trigger a single conversation (using default num_conversations)
gcloud pubsub topics publish dfcx-simulation-trigger --message "{}"

# To trigger multiple conversations
gcloud pubsub topics publish dfcx-simulation-trigger --message '{"num_conversations": 5}'
```

## Viewing Results

Conversation transcripts are logged to Cloud Logging. Go to the GCP Console -> Cloud Logging -> Log Explorer and query for your Cloud Function (`dfcx-simulator`).