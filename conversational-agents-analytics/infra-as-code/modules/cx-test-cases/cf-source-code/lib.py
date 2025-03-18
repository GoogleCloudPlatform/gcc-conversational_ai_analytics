import random
import threading
import logging
import requests
import time
import uuid
from datetime import datetime

from dfcx_scrapi.core.intents import Intents
from dfcx_scrapi.core.flows import Flows
from dfcx_scrapi.core.pages import Pages
from dfcx_scrapi.core.agents import Agents
from dfcx_scrapi.core.test_cases import TestCases
from google.cloud import storage, bigquery
from google.auth.transport.requests import Request

import pandas as pd
import pandas_gbq

from ratelimit import limits, sleep_and_retry
from google.api_core.exceptions import ResourceExhausted



logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s %(levelname)-8s %(message)s",
    datefmt="%Y-%m-%d %H:%M:%S",
)

# 60 calls per minute
CALLS = 60
RATE_LIMIT = 60
MAX_RETRIES = 5
RETRY_DELAY = 30

@sleep_and_retry
@limits(calls=CALLS, period=RATE_LIMIT)
def check_limit():
    ''' Empty function just to check for calls to API '''
    return

class CxTestCasesHelper:

    def __init__(self, agent_id, bq_project_id, bq_table_id):
        self.agent_project_id = agent_id.split("/")[1]
        self.agent_location_id = agent_id.split("/")[3]
        self.agent_id_full = agent_id
        self.agent_id = agent_id.split("/")[5]
        self.bq_project_id = bq_project_id
        self.bq_table_id = bq_table_id
        self.dfcx_a = Agents()
        self.dfcx_i = Intents()
        self.dfcx_f = Flows()
        self.dfcx_p = Pages()

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
                "name": "agent_display_name",
                "type": "STRING",
                "mode": "NULLABLE"
            },
            {
                "name": "test_case_id",
                "type": "STRING",
                "mode": "NULLABLE"
            },
            {
                "name": "test_case_display_name",
                "type": "STRING",
                "mode": "NULLABLE"
            },
            {
                "name": "tags",
                "type": "STRING",
                "mode": "REPEATED"
            },
            {
                "name": "notes",
                "type": "STRING",
                "mode": "NULLABLE"
            },
            {
                "name": "start_flow",
                "type": "STRING",
                "mode": "NULLABLE"
            },
            {
                "name": "passed",
                "type": "BOOL",
                "mode": "NULLABLE"
            },
            {
                "name": "not_runnable",
                "type": "BOOL",
                "mode": "NULLABLE"
            },
            {
                "name": "test_time",
                "type": "DATETIME",
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

    def convert_flow(self, flow_id, flows_map):
        if flow_id.split('/')[-1] == '-':
            return ''
        #flow_id_converted = str(agent_id) + '/flows/' + str(flow_id)
        if flow_id in flows_map.keys():
            return flows_map[flow_id]
        return 'Default Start Flow'

    def handle_dfcx_quota(func):
        def wrapped_func(*args, **kwargs):
            for i in range(MAX_RETRIES):
                try:
                    check_limit()
                    return func(*args, **kwargs)
                except ResourceExhausted:
                    exponential_delay = RETRY_DELAY * (2**i + random.random())
                    print(f'API returned rate limit error. Waiting {exponential_delay} seconds and trying again...')
                    time.sleep(exponential_delay)
                raise Exception("ERROR: Request failed too many times.")
        return wrapped_func
        
    @handle_dfcx_quota
    def get_agent(self, agent_id):
        return self.dfcx_a.get_agent(agent_id=agent_id)
        
    @handle_dfcx_quota
    def get_intents_map(self, dfcx_i, agent_id):
        return self.dfcx_i.get_intents_map(agent_id)

    @handle_dfcx_quota
    def get_flows_map(self, dfcx_f, agent_id):
        return self.dfcx_f.get_flows_map(agent_id)

    @handle_dfcx_quota
    def get_pages_map(self, dfcx_p, flow_id):
        return self.dfcx_p.get_pages_map(flow_id)

    @handle_dfcx_quota
    def list_flows(self, dfcx_f, agent_id):
        return self.dfcx_f.list_flows(agent_id)

    @handle_dfcx_quota
    def get_page(self, dfcx_p, page_id):
        return self.dfcx_p.get_page(page_id=page_id)
        
    @handle_dfcx_quota
    def get_test_case_results(self, retest_all=False):
        '''
        tcc = TestCasesClient.from_service_account_file(creds_path)
        request = ListTestCasesRequest(
            parent=agent_id,
        )
        test_cases = tcc.list_test_cases(request=request)
        '''

        agent = self.get_agent(agent_id=self.agent_id_full)
        flows_map = self.dfcx_f.get_flows_map(self.agent_id_full)
        dfcx_tc = TestCases()
        test_cases = dfcx_tc.list_test_cases(self.agent_id_full)
        retest = []
        retest_names = []
        results = {}
        results_by_id = {}

        display_names = []
        ids = []
        short_ids = []
        tags = []
        creation_times = []
        flows = []
        test_results = []
        test_times = []
        passed = []
        not_runnable = []

        for response in test_cases:
            #print(response)
            results[response.display_name] = str(response.last_test_result.test_result)
            # Collect untested cases to be retested (or all if retest_all is True)
            if retest_all or str(response.last_test_result.test_result) == 'TestResult.TEST_RESULT_UNSPECIFIED':
                retest.append(response.name)
                retest_names.append(response.display_name)
                # Collect additional information for dataframe
            display_names.append(response.display_name)
            ids.append(response.name)
            short_ids.append(response.name.split('/')[-1])
            tags.append(response.tags)
            creation_times.append(response.creation_time)
            flows.append(self.convert_flow(response.test_config.flow, flows_map))
            test_results.append(str(response.last_test_result.test_result))
            test_times.append(response.last_test_result.test_time)
            passed.append(str(response.last_test_result.test_result) == 'TestResult.PASSED')
            not_runnable.append(str(response.last_test_result.test_result) == 'TestResult.TEST_RESULT_UNSPECIFIED')

        # Create dataframe
        test_case_df = pd.DataFrame({
            'agent_project_id': self.agent_project_id,
            'agent_location_id': self.agent_location_id,
            'agent_id': self.agent_id,
            'agent_display_name': agent.display_name,
            'test_case_display_name': display_names, 
            'id': ids, 
            'short_id': short_ids, 
            'tags': tags, 
            'creation_time': creation_times, 
            'start_flow': flows, 
            'test_result': test_results, 
            'passed': passed, 
            'not_runnable': not_runnable, 
            'test_time': test_times
        })

        # Retest any that haven't been run yet
        logging.info(f'To retest:{len(retest)}')
        if len(retest) > 0:
            '''
            request = BatchRunTestCasesRequest(
            parent=agent_id,
            test_cases=retest
            )
            operation = tcc.batch_run_test_cases(request=request)
            print("Waiting for operation to complete...")
            response = operation.result()
            '''
            response = dfcx_tc.batch_run_test_cases(retest, self.agent_id_full)
            for result in response.results:
                # Results may not be in the same order as they went in (oh well)
                # Process the name a bit to remove the /results/id part at the end.
                testCaseId_full = '/'.join(result.name.split('/')[:-2])
                index = retest.index(testCaseId_full)
                testCaseId = testCaseId_full.split('/')[-1]
                results_by_id[testCaseId] = str(result.test_result)
                results[retest_names[index]] = str(result.test_result)

                # Update dataframe where id = testcaseId_full
                #row = test_case_df.loc[test_case_df['id'] == testCaseId_full]
                test_case_df.loc[test_case_df['id'] == testCaseId_full, 'short_id'] = testCaseId
                test_case_df.loc[test_case_df['id'] == testCaseId_full, 'test_result'] = str(result.test_result)
                test_case_df.loc[test_case_df['id'] == testCaseId_full, 'test_time'] = result.test_time
                test_case_df.loc[test_case_df['id'] == testCaseId_full, 'passed'] = str(result.test_result) == 'TestResult.PASSED'
                test_case_df.loc[test_case_df['id'] == testCaseId_full, 'not_runnable'] = str(result.test_result) == 'TestResult.TEST_RESULT_UNSPECIFIED'

        # This column is redundant, since we have passed (bool)
        test_case_df = test_case_df.drop(columns=['test_result'])
        return test_case_df

        
    def execute(self):
        test_guid = uuid.uuid4()
        test_start_time = datetime.now()

        logging.info(f"AgentId: {self.agent_id}, Test GUID:{test_guid}, Start time: {test_start_time}")

        intents_map =self.get_intents_map(self.dfcx_i, self.agent_id_full)
        flows_map = self.get_flows_map(self.dfcx_f, self.agent_id_full)
        pages_map = {}

        for flow_id in flows_map.keys():
            pages_map[flow_id] = self.get_pages_map(self.dfcx_p, flow_id)
        
        flow_data_list = self.list_flows(self.dfcx_f,self.agent_id_full)

        logging.info('Pre-processing complete')

        test_case_results_df = self.get_test_case_results(retest_all=True)

        test_case_results_df["test_run_guid"] = str(test_guid)
        test_case_results_df["test_run_timestamp"] = test_start_time
        test_case_results_df["test_time"] = test_case_results_df["test_time"]
        test_case_results_df.rename(columns = {'id':'test_case_id'}, inplace = True) #rename 'id' to 'test_case_id'

        # only select the columns
        test_case_results_df = test_case_results_df[
            [
                'test_run_guid',
                'test_run_timestamp',
                'agent_id',
                'agent_display_name',
                'test_case_id',
                'test_case_display_name',
                'start_flow',
                'passed',
                'not_runnable',
                'test_time',
                'tags'
            ]
        ]

        # test_case_results_df.to_csv('file1.csv')
        logging.info("Starting to write to BigQuery")
        self.write_to_bigquery(test_case_results_df)
        logging.info("Finished writing to BigQuery")

        return test_guid