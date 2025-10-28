data "google_project" "project" {}

resource "google_service_account" "dfcx_simulator_sa" {
  project      = var.project_id
  account_id   = "dfcx-simulator-sa"
  display_name = "DFCX Simulator Service Account"
}

resource "google_project_iam_member" "dfcx_simulator_sa_roles" {
  project = var.project_id
  for_each = toset([
    "roles/dialogflow.client",
    "roles/aiplatform.user",
    "roles/logging.logWriter",
    "roles/run.invoker"
  ])
  role   = each.key
  member = "serviceAccount:${google_service_account.dfcx_simulator_sa.email}"
}

resource "google_pubsub_topic" "dfcx_simulation_trigger" {
  project = var.project_id
  name    = var.pubsub_topic_name
}

module "cf_dfcx_simulator" {
  source      = "github.com/GoogleCloudPlatform/cloud-foundation-fabric//modules/cloud-function-v2?ref=v34.1.0&depth=1"
  project_id  = var.project_id
  region      = var.region
  name        = "dfcx-simulator"
  bucket_name = var.cf_bucket_name
  bundle_config = {
    runtime = "python313"
    path    = "${path.module}/cf-source-code"
    folder_options = {
      excludes     = ["__pycache__", "env", ".venv", ".pytest_cache","test_main.py"]
    }
  }
  service_account = google_service_account.dfcx_simulator_sa.email

  function_config = {
    memory_mb = 512
    cpu       = 1
  }

  environment_variables = {
    PROJECT_ID        = var.project_id
    DFCX_LOCATION     = var.dfcx_location
    DFCX_AGENT_ID     = var.dfcx_agent_id
    GEMINI_MODEL_NAME = var.gemini_model_name
    MAX_TURNS         = var.max_turns
    NUM_CONVERSATIONS = var.num_conversations
  }

  trigger_config = {
    event_type   = "google.cloud.pubsub.topic.v1.messagePublished"
    pubsub_topic = google_pubsub_topic.dfcx_simulation_trigger.id
    service_account_email = google_service_account.dfcx_simulator_sa.email
  }

  depends_on = [
    google_project_iam_member.dfcx_simulator_sa_roles
  ]
}

resource "google_pubsub_topic_iam_member" "scheduler_pubsub_publisher" {
  project = google_pubsub_topic.dfcx_simulation_trigger.project
  topic   = google_pubsub_topic.dfcx_simulation_trigger.name
  role    = "roles/pubsub.publisher"
  member  = "serviceAccount:service-${data.google_project.project.number}@gcp-sa-cloudscheduler.iam.gserviceaccount.com"
}

resource "google_cloud_scheduler_job" "conversation_generator_scheduler" {
  project  = var.project_id
  region   = var.region
  name     = "conversation-generator-scheduler"
  schedule = "*/4 * * * *"
  time_zone = "Etc/UTC"

  pubsub_target {
    topic_name = google_pubsub_topic.dfcx_simulation_trigger.id
    data       = base64encode("{\"num_conversations\":1}")
  }

  depends_on = [
    google_pubsub_topic_iam_member.scheduler_pubsub_publisher
  ]
}
