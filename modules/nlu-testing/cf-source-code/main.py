import base64
import logging
import os
import json

import functions_framework

from lib import NluTestingHelper

logging.basicConfig(
	level=logging.INFO,
	format="%(asctime)s %(levelname)-8s %(message)s",
	datefmt="%Y-%m-%d %H:%M:%S",
)

@functions_framework.http
def main(request) -> None:
	request_json = request.get_json(silent=True)

	bq_project_id = os.environ.get("BQ_PROJECT_ID")
	bq_table_id = os.environ.get("BQ_TABLE_ID")
	
	agent_id = request_json["agent_id"]
	test_config_gcs_uri = request_json["test_config_gcs_uri"]

	helper = NluTestingHelper(
		agent_id=agent_id,
		bq_project_id=bq_project_id,
		bq_table_id=bq_table_id,
		test_config_gcs_uri=test_config_gcs_uri
	)

	test_guid = helper.execute()

	return {
		'test_run_guid':test_guid
	}
