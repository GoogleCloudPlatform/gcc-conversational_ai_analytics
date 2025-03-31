# the GCS default Service Account needs to have permissions to publish Eventarc events
resource "google_project_iam_member" "gcs_pubsub_publisher" { 
  project = var.project_id
  role    = "roles/pubsub.publisher"
  member  = "serviceAccount:service-${data.google_project.project.number}@gs-project-accounts.iam.gserviceaccount.com"
}

# Default compute service permissions for Cloud function. To avoid giving permissions to it, use Foundation Fabric v.34.1.0
## Needed to register the cloud function artifact to build
resource "google_project_iam_member" "gcp_artifact_registry_create" { 
  project = var.project_id
  role    = "roles/artifactregistry.createOnPushWriter"
  member  = "serviceAccount:${data.google_project.project.number}-compute@developer.gserviceaccount.com"
}

## Needed to give more details during build job. In case it fails if this is not enabled it will not show error log.
resource "google_project_iam_member" "gcp_log_writer" { 
  project = var.project_id
  role    = "roles/logging.logWriter"
  member  = "serviceAccount:${data.google_project.project.number}-compute@developer.gserviceaccount.com"
}

## Needed for Cloud Build backend 
resource "google_project_iam_member" "gcs_object_admin" { 
  project = var.project_id
  role    = "roles/storage.objectAdmin"
  member  = "serviceAccount:${data.google_project.project.number}-compute@developer.gserviceaccount.com"
}

resource "google_project_iam_member" "gcs_cloud_builder" { 
  project = var.project_id
  role    = "roles/cloudbuild.builds.builder"
  member  = "serviceAccount:${data.google_project.project.number}-compute@developer.gserviceaccount.com"
}

# CCAI Insights Service Account permissions for Cloud Run
resource "google_project_iam_member" "gcp_speech_service" { 
  project = var.project_id
  role    = "roles/speech.serviceAgent"
  member  = "serviceAccount:service-${data.google_project.project.number}@gcp-sa-contactcenterinsights.iam.gserviceaccount.com"
  depends_on = [resource.google_project_service.gcp_services]
}

resource "google_project_iam_member" "gcp_ccai_service" { 
  project = var.project_id
  role    = "roles/contactcenterinsights.serviceAgent"
  member  = "serviceAccount:service-${data.google_project.project.number}@gcp-sa-contactcenterinsights.iam.gserviceaccount.com"
  depends_on = [resource.google_project_service.gcp_services]
}

# Terraform SA
# Service account for project with PII information
module "ccai_insights_sa" {
  source     = "github.com/GoogleCloudPlatform/cloud-foundation-fabric//modules/iam-service-account?ref=v38.1.0&depth=1"
  project_id = var.project_id
  name       = "asset-ccai-cm-sa"

  # non-authoritative roles granted *to* the service accounts on other resources
  iam_project_roles = {
    "${var.project_id}" = [
      "roles/contactcenterinsights.editor",
      "roles/logging.logWriter",
      "roles/storage.admin",
      "roles/storage.objectAdmin",
      "roles/iam.serviceAccountTokenCreator",
      "roles/iam.serviceAccountUser",
      "roles/cloudfunctions.developer",
      "roles/pubsub.publisher",
      "roles/run.invoker",
      "roles/eventarc.eventReceiver",
      "roles/bigquery.jobUser",
      "roles/bigquery.dataViewer",
      "roles/bigquery.dataEditor",
      "roles/artifactregistry.reader",
      "roles/workflows.invoker",
      "roles/speech.editor",
      "roles/aiplatform.admin",
      "roles/secretmanager.secretAccessor",
      "roles/serviceusage.serviceUsageAdmin"
    ]
  }
}