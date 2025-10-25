import os
os.environ['BQ_PROJECT_ID'] = 'test-project'
os.environ['BQ_DATASET_NAME'] = 'test-dataset'

import base64
import json
from unittest.mock import MagicMock, patch

# Workaround for ImportError: cannot import name 'T' from 're'
import re
if not hasattr(re, 'T'):
    re.T = None

from cloudevents.http import CloudEvent
import pandas as pd
from pandas.testing import assert_frame_equal

from main import main
from agent_structure_helper import get_agent_id_from_encoded_log


def create_cloud_event(data):
    """Creates a mock CloudEvent for testing."""
    encoded_data = base64.b64encode(json.dumps(data).encode('utf-8')).decode('utf-8')
    attributes = {
        "type": "google.cloud.pubsub.topic.v1.messagePublished",
        "source": "my-test-source",
    }
    return CloudEvent(attributes, {"message": {"data": encoded_data}})


@patch('main.AgentStructureHelper')
@patch('main.get_agent_id_from_encoded_log')
def test_main(mock_get_agent_id, mock_agent_structure_helper):
    """Tests the main function orchestrates the helper correctly."""
    # --- Mock ---
    mock_get_agent_id.return_value = 'projects/test-project/locations/us-central1/agents/test-agent-id'
    mock_helper_instance = mock_agent_structure_helper.return_value
    expected_df = pd.DataFrame({'col1': [1]})
    mock_helper_instance.parse_agent_data.return_value = {'agents': expected_df}
    mock_helper_instance.get_test_guid.return_value = 'test-guid'
    
    # --- Execute ---
    cloud_event_data = {
        "protoPayload": {
            "resourceName": "projects/test-project/locations/us-central1/agents/test-agent-id"
        }
    }
    cloud_event = create_cloud_event(cloud_event_data)
    result = main(cloud_event)

    # --- Assert ---
    mock_get_agent_id.assert_called_once_with(cloud_event.data['message']['data'])
    mock_agent_structure_helper.assert_called_once_with(
        agent_id='projects/test-project/locations/us-central1/agents/test-agent-id',
        bq_project_id='test-project',
        bq_dataset_name='test-dataset'
    )
    mock_helper_instance.fetch_agent_data.assert_called_once()
    mock_helper_instance.parse_agent_data.assert_called_once()
    
    # Assert call to write_to_bigquery
    mock_helper_instance.write_to_bigquery.assert_called_once()
    called_args, called_kwargs = mock_helper_instance.write_to_bigquery.call_args
    assert 'bigquery_data' in called_kwargs
    assert 'agents' in called_kwargs['bigquery_data']
    assert_frame_equal(called_kwargs['bigquery_data']['agents'], expected_df)

    assert result['test_run_guid'] == 'test-guid'


def test_get_agent_id_from_encoded_log():
    """Tests that the agent ID is correctly extracted from a log entry."""
    log_entry = {
        "protoPayload": {
            "resourceName": "projects/my-project/locations/us-central1/agents/my-agent"
        }
    }
    encoded_data = base64.b64encode(json.dumps(log_entry).encode('utf-8')).decode('utf-8')
    agent_id = get_agent_id_from_encoded_log(encoded_data)
    assert agent_id == "projects/my-project/locations/us-central1/agents/my-agent"
