import logging
import os
import json
import traceback


import functions_framework

from agent_structure_helper import *

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s %(levelname)-8s %(message)s",
    datefmt="%Y-%m-%d %H:%M:%S",
)

# useful for local testing
# @functions_framework.http 
# def main(request) -> None:
#     request_json = request.get_json(silent=True)
#     try:
#         agent_id = request_json["agent_id"]

@functions_framework.cloud_event
def main(cloud_event) -> None:
    try:
        agent_id = get_agent_id_from_encoded_log(cloud_event.data['message']['data'])

        bq_output_project_id = os.environ.get("BQ_PROJECT")
        bq_output_dataset_name = os.environ.get("BQ_DATASET_NAME")

        agent_structure_helper = AgentStructureHelper(
            agent_id=agent_id,
            bq_project_id=bq_output_project_id,
            bq_dataset_name=bq_output_dataset_name,
        )

        agent_structure_helper.fetch_agent_data()
        bigquery_data = agent_structure_helper.parse_agent_data()
        agent_structure_helper.write_to_bigquery(bigquery_data=bigquery_data)

        test_guid = agent_structure_helper.get_test_guid()

        return {"test_run_guid": test_guid}

    except Exception as e:
        print(f"Error: {e}")
        print(traceback.format_exc())
        return "Error", 500


# if __name__ == "__main__":
#     main(None)
