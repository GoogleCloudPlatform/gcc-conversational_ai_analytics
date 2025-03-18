import logging
import os
import json

import functions_framework

from lib import CxTestCasesHelper

logging.basicConfig(
		level=logging.INFO,
		format="%(asctime)s %(levelname)-8s %(message)s",
		datefmt="%Y-%m-%d %H:%M:%S",
)

@functions_framework.http
def main(request) -> None:
	request_json = request.get_json(silent=True)
    
	agent_id = request_json['agent_id']
	bq_project_id = os.environ.get("BQ_PROJECT_ID")
	bq_table_id = os.environ.get("BQ_TABLE_ID")

	cx_testcase_helper = CxTestCasesHelper(
		agent_id=agent_id,
		bq_project_id=bq_project_id,
		bq_table_id=bq_table_id
	)

	test_guid = cx_testcase_helper.execute()

	return {
		'test_run_guid':test_guid
	}
