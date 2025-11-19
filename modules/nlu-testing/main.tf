#    Copyright 2024 Google LLC
#    Licensed under the Apache License, Version 2.0 (the "License");
#    you may not use this file except in compliance with the License.
#    You may obtain a copy of the License at
#        http://www.apache.org/licenses/LICENSE-2.0
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS,
#    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#    See the License for the specific language governing permissions and
#    limitations under the License.
locals {
  timeout_seconds = 540
}

module "cf_nlu_testing" {
  source      = "github.com/GoogleCloudPlatform/cloud-foundation-fabric//modules/cloud-function-v2?ref=v34.1.0&depth=1"
  project_id  = var.project_id
  region      = var.region
  name        = "nlu-testing"
  bucket_name = var.cf_bucket_name
  bundle_config = {
    path = "${path.module}/cf-source-code"
    folder_options = {
      archive_path = "${path.module}/cf-source-code/bundle.zip"
      excludes     = ["__pycache__", "env"]
    }
  }
  service_account = var.service_account_email

  function_config = {
    memory_mb       = 512
    timeout_seconds = local.timeout_seconds
  }

  environment_variables = {
    BQ_PROJECT_ID = var.bq_project_id
    BQ_TABLE_ID   = var.bq_table_id
  }
}


resource "google_cloud_scheduler_job" "test_instances" {
  count = length(var.scheduled_test_instances)

  region = var.region

  name             = var.scheduled_test_instances[count.index].schedule_name
  description      = var.scheduled_test_instances[count.index].schedule_name
  schedule         = var.scheduled_test_instances[count.index].cron_schedule
  time_zone        = var.scheduled_test_instances[count.index].timezone
  attempt_deadline = "${local.timeout_seconds}s"

  retry_config {
    retry_count = 3
  }

  http_target {
    http_method = "POST"
    uri         = module.cf_nlu_testing.uri
    body = base64encode(
      jsonencode({
        agent_id            = var.scheduled_test_instances[count.index].agent_id
        test_config_gcs_uri = var.scheduled_test_instances[count.index].test_config_gcs_uri
      })
    )
    oidc_token {
      audience              = "${module.cf_nlu_testing.uri}/"
      service_account_email = var.service_account_email
    }
    headers = {
      "Content-Type" = "application/json"
    }
  }
}
