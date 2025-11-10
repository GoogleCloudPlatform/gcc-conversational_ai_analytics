#!/bin/bash

set -e -o pipefail

if [ "$#" -ne 5 ]; then
  echo "Usage: $0 <release> <project_id> <region> <git_commitish> <repo_name>"
  echo "Example: $0 dev my-project us-central1 abc123 my-repo"
  exit 1
fi

RELEASE=$1
PROJECT_ID=$2
REGION=$3
GIT_COMMITISH=$4
DATAFORM_REPO=$5

# Create a secure temporary file to store information about disabled workflows
DISABLED_WORKFLOWS_FILE=$(mktemp)

# Cleanup function to re-enable workflows and remove the temp file on exit
function cleanup {
  set +e # Do not exit on error inside the cleanup function
  echo "--- Performing cleanup ---"
  if [ -f "${DISABLED_WORKFLOWS_FILE}" ] && [ -s "${DISABLED_WORKFLOWS_FILE}" ]; then
    echo "Re-enabling any paused Dataform workflows from ${DISABLED_WORKFLOWS_FILE}..."
    local access_token
    access_token=$(gcloud auth print-access-token)
    if [ -z "${access_token}" ]; then
      echo "Error: Failed to get access token during cleanup. Workflows might not be re-enabled."
    else
      while IFS='|' read -r name releaseConfig; do
        echo "Re-enabling workflow: ${name}..."
        local update_mask="disabled"
        local patch_json_body

        if [ -n "${releaseConfig}" ] && [ "${releaseConfig}" != "null" ]; then
          update_mask="disabled,releaseConfig"
          patch_json_body=$(printf '{"disabled": false, "releaseConfig": "%s"}' "${releaseConfig}")
        else
          patch_json_body='{"disabled": false}'
        fi
        
        local patch_api_url="https://dataform.googleapis.com/v1/${name}?updateMask=${update_mask}"
        response=$(curl -s -w '\n%{http_code}' --request PATCH "${patch_api_url}" \
          --header "Authorization: Bearer ${access_token}" \
          --header "Accept: application/json" \
          --header "Content-Type: application/json" \
          --data "${patch_json_body}" \
          --compressed)
        http_code=$(tail -n1 <<< "$response")
        body=$(sed '$ d' <<< "$response")
        if [ "$http_code" -ne 200 ]; then
            echo "Error re-enabling workflow ${name}. HTTP ${http_code}: ${body}"
        fi
      done < "${DISABLED_WORKFLOWS_FILE}"
      echo "Finished attempting to restore workflows."
    fi
  else
    echo "No workflows were paused or disabled workflows file is empty/missing."
  fi
  rm -f "${DISABLED_WORKFLOWS_FILE}"
  echo "--- Cleanup finished ---"
}

# Trap EXIT, INT, TERM signals to run the cleanup function
trap cleanup EXIT INT TERM

echo "Starting Dataform release update for release: ${RELEASE}"
echo "Project: ${PROJECT_ID}"
echo "Region: ${REGION}"
echo "Repository: ${DATAFORM_REPO}"
echo "Git Commitish: ${GIT_COMMITISH}"

# Step 1: Get Access Token
echo "Fetching GCP access token..."
ACCESS_TOKEN=$(gcloud auth print-access-token)

# Step 2: Pause all active workflow configurations
echo "--- Pausing active Dataform workflows ---"
WORKFLOW_CONFIGS_API_URL="https://dataform.googleapis.com/v1/projects/${PROJECT_ID}/locations/${REGION}/repositories/${DATAFORM_REPO}/workflowConfigs"
WORKFLOW_CONFIGS=$(curl -s -X GET "${WORKFLOW_CONFIGS_API_URL}" \
  -H "Authorization: Bearer ${ACCESS_TOKEN}" \
  -H "Content-Type: application/json")

# Filter for workflows that are not disabled, save their info, and then disable them
echo "${WORKFLOW_CONFIGS}" | jq -c '.workflowConfigs[]? | select(.disabled != true)' | while read -r config; do
  name=$(echo "${config}" | jq -r '.name')
  releaseConfig=$(echo "${config}" | jq -r '.releaseConfig // ""')
  
  echo "Pausing workflow: ${name}"
  echo "${name}|${releaseConfig}" >> "${DISABLED_WORKFLOWS_FILE}"
  
  update_mask="disabled"
  json_body=""

  if [ -n "${releaseConfig}" ] && [ "${releaseConfig}" != "null" ]; then
    update_mask="disabled,releaseConfig"
    json_body=$(printf '{"disabled": true, "releaseConfig": "%s"}' "${releaseConfig}")
  else
    json_body='{"disabled": true}'
  fi

  PATCH_API_URL="https://dataform.googleapis.com/v1/${name}?updateMask=${update_mask}"

  curl -s --request PATCH "${PATCH_API_URL}" \
    --header "Authorization: Bearer ${ACCESS_TOKEN}" \
    --header "Accept: application/json" \
    --header "Content-Type: application/json" \
    --data "${json_body}" \
    --compressed > /dev/null
done
echo "All active workflows paused."

# Step 3: Poll for any currently running workflow invocations to complete
echo "--- Checking for running workflow invocations ---"
SECONDS=0
TIMEOUT=900 # 15 minutes
RETRY_INTERVAL=30 # seconds

while true; do
  RUNNING_WORKFLOWS=$(curl -s -X GET "https://dataform.googleapis.com/v1/projects/${PROJECT_ID}/locations/${REGION}/repositories/${DATAFORM_REPO}/workflowInvocations?filter=state:RUNNING&orderBy=create_time%20desc" \
    -H "Authorization: Bearer ${ACCESS_TOKEN}" \
    -H "Content-Type: application/json" | jq -c '[.workflowInvocations[]?]')

  if [ "$(echo "${RUNNING_WORKFLOWS}" | jq 'length')" -eq 0 ]; then
    echo "No running workflows found. Proceeding with compilation."
    break
  fi

  if [ "${SECONDS}" -ge "${TIMEOUT}" ]; then
    echo "Timeout reached. The following workflows are still running:"
    echo "${RUNNING_WORKFLOWS}" | jq .
    exit 1
  fi

  echo "Found running workflows. Waiting for completion... (${SECONDS}s / ${TIMEOUT}s)"
  sleep ${RETRY_INTERVAL}
  SECONDS=$((SECONDS + RETRY_INTERVAL))
done

# Step 4: Create a new compilation result
echo "--- Creating new compilation result ---"
PROJECT_NUMBER=$(gcloud projects describe "${PROJECT_ID}" --format="value(projectNumber)")
COMPILATION_API_URL="https://dataform.googleapis.com/v1/projects/${PROJECT_ID}/locations/${REGION}/repositories/${DATAFORM_REPO}/compilationResults"
RELEASE_CONFIG_FULL_NAME="projects/${PROJECT_NUMBER}/locations/${REGION}/repositories/${DATAFORM_REPO}/releaseConfigs/${RELEASE}"
COMPILATION_JSON_BODY="{ \"releaseConfig\": \"${RELEASE_CONFIG_FULL_NAME}\" }"

echo "Creating new compilation result from release config: ${RELEASE}..."
COMPILATION_RESPONSE=$(curl -s -X POST "${COMPILATION_API_URL}" \
  -H "Authorization: Bearer ${ACCESS_TOKEN}" \
  -H "Content-Type: application/json" \
  --data "${COMPILATION_JSON_BODY}")

COMPILATION_RESULT_NAME=$(echo "${COMPILATION_RESPONSE}" | jq -r '.name')

if [ -z "${COMPILATION_RESULT_NAME}" ] || [ "${COMPILATION_RESULT_NAME}" == "null" ]; then
  echo "Error: Failed to create compilation result."
  echo "Response: ${COMPILATION_RESPONSE}"
  exit 1
fi
echo "Successfully created compilation result: ${COMPILATION_RESULT_NAME}"

# Step 5: Patch the release configuration to use the new compilation result
echo "--- Activating new compilation result ---"
RELEASE_CONFIG_API_URL="https://dataform.googleapis.com/v1/${RELEASE_CONFIG_FULL_NAME}?updateMask=releaseCompilationResult"
RELEASE_JSON_BODY="{ \"git_commitish\": \"${GIT_COMMITISH}\", \"releaseCompilationResult\": \"${COMPILATION_RESULT_NAME}\" }"

echo "Patching release configuration '${RELEASE}' to use ${COMPILATION_RESULT_NAME}..."
PATCH_RESPONSE=$(curl -s -X PATCH "${RELEASE_CONFIG_API_URL}" \
  -H "Authorization: Bearer ${ACCESS_TOKEN}" \
  -H "Content-Type: application/json" \
  --data "${RELEASE_JSON_BODY}")

UPDATED_RESULT=$(echo "${PATCH_RESPONSE}" | jq -r '.releaseCompilationResult')
if [ "${UPDATED_RESULT}" != "${COMPILATION_RESULT_NAME}" ]; then
    echo "Warning: Patch response did not match expected compilation result."
    echo "Response: ${PATCH_RESPONSE}"
fi
echo "Successfully patched release configuration."

# The cleanup function will run automatically on exit
echo "--- Dataform release update process completed successfully ---"