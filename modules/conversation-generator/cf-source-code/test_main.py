
import unittest
from unittest.mock import patch, MagicMock
import base64
import json

from main import handle_pubsub_trigger

class TestConversationGenerator(unittest.TestCase):

    @patch('main.run_conversation_simulation')
    @patch('main.vertexai')
    @patch('main.cx.SessionsClient')
    def test_handle_pubsub_trigger_default(self, mock_sessions_client, mock_vertexai, mock_run_simulation):
        """Test with default number of conversations."""
        # Mock the Pub/Sub event
        event = {
            "data": {
                "message": {
                    "data": base64.b64encode(b'{}').decode('utf-8')
                }
            }
        }
        cloud_event = MagicMock()
        cloud_event.data = event['data']

        handle_pubsub_trigger(cloud_event)

        # Check if run_conversation_simulation was called once
        self.assertEqual(mock_run_simulation.call_count, 1)

    @patch('main.run_conversation_simulation')
    @patch('main.vertexai')
    @patch('main.cx.SessionsClient')
    def test_handle_pubsub_trigger_custom(self, mock_sessions_client, mock_vertexai, mock_run_simulation):
        """Test with a custom number of conversations."""
        # Mock the Pub/Sub event with custom data
        data = {"num_conversations": 3}
        event = {
            "data": {
                "message": {
                    "data": base64.b64encode(json.dumps(data).encode('utf-8')).decode('utf-8')
                }
            }
        }
        cloud_event = MagicMock()
        cloud_event.data = event['data']

        handle_pubsub_trigger(cloud_event)

        # Check if run_conversation_simulation was called three times
        self.assertEqual(mock_run_simulation.call_count, 3)

if __name__ == '__main__':
    unittest.main()
