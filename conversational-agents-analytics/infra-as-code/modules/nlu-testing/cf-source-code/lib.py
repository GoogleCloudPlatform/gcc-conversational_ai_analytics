import logging
from datetime import datetime

import uuid
import pandas as pd
from google.cloud import storage, bigquery

import pandas_gbq

import google.auth

from custom_nlu_evals import CustomNluEvals

logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s %(levelname)-8s %(message)s',
    datefmt='%Y-%m-%d %H:%M:%S',
)

class NluTestingHelper:
    def __init__(self, agent_id, test_config_gcs_uri, bq_project_id, bq_table_id):
        self.agent_project_id = agent_id.split("/")[1]
        self.agent_location_id = agent_id.split("/")[3]
        self.agent_id_full = agent_id
        self.agent_id = agent_id.split("/")[5]
        self.test_config_gcs_uri = test_config_gcs_uri
        self.bq_project_id = bq_project_id
        self.bq_table_id = bq_table_id

    def write_to_bigquery(self, df):
        table_schema = [
            {
                "name": "test_run_guid",
                "type": "STRING",
                "mode": "NULLABLE"
            },
            {
                "name": "test_run_timestamp",
                "type": "TIMESTAMP",
                "mode": "NULLABLE"
            },
            {
                "name": "agent_project_id",
                "type": "STRING",
                "mode": "NULLABLE"
            },
            {
                "name": "agent_location_id",
                "type": "STRING",
                "mode": "NULLABLE"
            },
            {
                "name": "agent_id",
                "type": "STRING",
                "mode": "NULLABLE"
            },
            {
                "name": "agent_name",
                "type": "STRING",
                "mode": "NULLABLE"
            },
            {
                "name": "flow_display_name",
                "type": "STRING",
                "mode": "NULLABLE"
            },
            {
                "name": "page_display_name",
                "type": "STRING",
                "mode": "NULLABLE"
            },
            {
                "name": "utterance",
                "type": "STRING",
                "mode": "NULLABLE"
            },
            {
                "name": "expected_intent",
                "type": "STRING",
                "mode": "NULLABLE"
            },
            {
                "name": "expected_parameters",
                "type": "STRING",
                "mode": "NULLABLE"
            },
            {
                "name": "expected_match_type",
                "type": "STRING",
                "mode": "NULLABLE"
            },
            {
                "name": "target_page",
                "type": "STRING",
                "mode": "NULLABLE"
            },
            {
                "name": "detected_match_type",
                "type": "STRING",
                "mode": "NULLABLE"
            },
            {
                "name": "confidence",
                "type": "FLOAT",
                "mode": "NULLABLE"
            },
            {
                "name": "detected_parameters",
                "type": "STRING",
                "mode": "NULLABLE"
            },
            {
                "name": "detected_intent",
                "type": "STRING",
                "mode": "NULLABLE"
            },
            {
                "name": "passed",
                "type": "BOOL",
                "mode": "NULLABLE"
            },
            {
                "name": "description",
                "type": "STRING",
                "mode": "NULLABLE"
            },
            {
                "name": "input_source",
                "type": "STRING",
                "mode": "NULLABLE"
            }
        ]

        pandas_gbq.to_gbq(
            df,
            self.bq_table_id, 
            project_id=self.bq_project_id,
            if_exists='append', 
            table_schema=table_schema,
            progress_bar=True
        )

    def download_blob_from_gcs(self, gcs_uri, destination_file_name):
        storage_client = storage.Client()
        
        bucket_name = gcs_uri.split("/")[2] 
        blob_name = "/".join(gcs_uri.split("/")[3:]) 

        bucket = storage_client.bucket(bucket_name)
        blob = bucket.blob(blob_name)

        blob.download_to_filename(destination_file_name)

        print(f"Blob {gcs_uri} downloaded to {destination_file_name}.")

    
        
    def execute(self):
        test_guid = uuid.uuid4()
        test_start_time = datetime.now()

        logging.info(f'Agent Id: {self.agent_id}, Test GUID:{test_guid}, start time {test_start_time}')

        # get the credentials
        credentials, project_id = google.auth.default()
        
        # run the evals
        nlu = CustomNluEvals(
            agent_id=self.agent_id_full,
            creds=credentials
        )

        # get the tests config
        destination_file_name = "/tmp/nlu_testing_config.csv"
        self.download_blob_from_gcs(
            gcs_uri = self.test_config_gcs_uri,
            destination_file_name=destination_file_name
        )
        config_df = nlu.process_input_csv(destination_file_name)

        # run the evals
        evals_df = nlu.run_evals(config_df)

        # add custom fields to the dataframe
        evals_df['test_run_guid'] = str(test_guid)
        evals_df['test_run_timestamp'] = test_start_time

        # rename some of the columns
        evals_df.rename(columns = {'parameters_set':'detected_parameters'}, inplace = True)
        evals_df.rename(columns = {'match_type':'detected_match_type'}, inplace = True)

        # calculate the tests that have passed based on business criteria
        def calculate_passed(row):
            match_type_passed = row['expected_match_type'] == row['detected_match_type']
            intent_passed = row['expected_intent'] == row['detected_intent']
            parameters_passed = row['expected_parameters'] == row['detected_parameters']

            return match_type_passed and intent_passed and parameters_passed

            
        evals_df['passed'] = evals_df.apply(lambda row: calculate_passed(row), axis=1)
        evals_df['input_source'] = self.test_config_gcs_uri
        evals_df['agent_project_id'] = self.agent_project_id
        evals_df['agent_location_id'] = self.agent_location_id
        evals_df['agent_id'] = self.agent_id

        # only select these columns
        evals_df = evals_df[
            [
                'test_run_guid',
                'test_run_timestamp',
                'agent_name',
                'flow_display_name',
                'page_display_name',
                'utterance',
                'expected_intent',
                'expected_parameters',
                'expected_match_type',
                'target_page',
                'detected_match_type',
                'confidence',
                'detected_parameters',
                'detected_intent',
                'passed',
                'description',
                'input_source'
            ]
        ]

        # write test results to BigQuery
        self.write_to_bigquery(
            df=evals_df
        )

        return test_guid