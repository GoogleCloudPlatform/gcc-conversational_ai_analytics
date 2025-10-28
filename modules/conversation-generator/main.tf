data "archive_file" "source" {
  type        = "zip"
  source_dir  = "${path.module}/cf-source-code"
  output_path = "/tmp/conversation-generator-source.zip"
  excludes = [
    ".venv",
    "__pycache__",
    ".pytest_cache"
  ]
}

data "google_project" "project" {}

resource "google_storage_bucket" "source_bucket" {
  project                     = var.project_id
  name                        = "${var.project_id}-conv-gen-source"
  location                    = var.region
  uniform_bucket_level_access = true
}

resource "google_storage_bucket_object" "source_archive" {
  name   = "conversation-generator-source-${data.archive_file.source.output_base64sha256}.zip"
  bucket = google_storage_bucket.source_bucket.name
  source = data.archive_file.source.output_path
}

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

resource "google_cloudfunctions2_function" "dfcx_simulator" {
  project  = var.project_id
  name     = "dfcx-simulator"
  location = var.region

  build_config {
    runtime     = "python313"
    entry_point = "handle_pubsub_trigger"
    source {
      storage_source {
        bucket = google_storage_bucket.source_bucket.name
        object = google_storage_bucket_object.source_archive.name
      }
    }
  }

  service_config {
    max_instance_count = 10
    min_instance_count = 0
    available_memory      = "512Mi"
    service_account_email = google_service_account.dfcx_simulator_sa.email
    environment_variables = {
      PROJECT_ID        = var.project_id
      DFCX_LOCATION     = var.dfcx_location
      DFCX_AGENT_ID     = var.dfcx_agent_id
      GEMINI_MODEL_NAME = var.gemini_model_name
      MAX_TURNS         = var.max_turns
      NUM_CONVERSATIONS = var.num_conversations
    }
  }

  event_trigger {
    trigger_region = var.region
    event_type     = "google.cloud.pubsub.topic.v1.messagePublished"
    pubsub_topic   = google_pubsub_topic.dfcx_simulation_trigger.id
    retry_policy   = "RETRY_POLICY_RETRY"
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
