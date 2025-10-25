
import logging
import base64
import json
import pandas as pd
import pandas_gbq
import uuid

from datetime import datetime

from dfcx_scrapi.core.agents import Agents
from dfcx_scrapi.core.playbooks import Playbooks
from dfcx_scrapi.core.tools import Tools
from dfcx_scrapi.core.intents import Intents
from dfcx_scrapi.core.flows import Flows
from dfcx_scrapi.core.pages import Pages
from dfcx_scrapi.core.webhooks import Webhooks


from proto.marshal.collections.maps import MapComposite
from proto.marshal.collections.repeated import RepeatedComposite

import google.cloud.dialogflowcx_v3beta1.types as dfcx_types

DFCXCase = dfcx_types.Fulfillment.ConditionalCases.Case
DFCXFlow = dfcx_types.flow.Flow
DFCXPage = dfcx_types.page.Page
DFCXRoute = dfcx_types.page.TransitionRoute

from bq_schemas import *

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s %(levelname)-8s %(message)s",
    datefmt="%Y-%m-%d %H:%M:%S",
)

class AgentStructureHelper:

    def __init__(self, agent_id, bq_project_id, bq_dataset_name):
        self.agent_id_full = agent_id
        self.test_guid = str(uuid.uuid4())
        self.test_start_time = datetime.now()
        self.bq_project_id = bq_project_id
        self.bq_dataset_name = bq_dataset_name
        self.agent_data = self.fetch_agent_data()

        self.agent_project_id = self.agent_data['agent'].name.split("/")[1]
        self.agent_location_id = self.agent_data['agent'].name.split("/")[3]
        self.agent_id = self.agent_data['agent'].name.split("/")[5]
        self.agent_name = self.agent_data['agent'].display_name
        
        self.webhooks_map = Webhooks(agent_id=self.agent_id_full).get_webhooks_map(agent_id=self.agent_id_full)


    def get_test_guid(self):
        return self.test_guid

    def fetch_agent_data(self):
        """
            Fetches agent data using scrapi-dfcx
        """
        agent = Agents().get_agent(agent_id=self.agent_id_full)
        intents = Intents(agent_id=self.agent_id_full).list_intents(agent_id=self.agent_id_full)
        # entity_types = EntityTypes(agent_id=self.agent_id).list_entity_types(agent_id=self.agent_id)
        playbooks = Playbooks(agent_id=self.agent_id_full).list_playbooks(agent_id=self.agent_id_full)
        tools = Tools(agent_id=self.agent_id_full).list_tools(agent_id=self.agent_id_full)
        flows = Flows(agent_id=self.agent_id_full).list_flows(agent_id=self.agent_id_full)

        agent_data = {
            'agent': agent,
            'intents': intents,
            # 'entity_types': entity_types,
            'playbooks': playbooks,
            'tools': tools,
            'flows': flows,
            # 'pages':pages
        }

        return agent_data

    def get_training_phrases_from_intent(self, intent):
        training_phrases = []
        for training_phrase in intent.training_phrases:
            training_phrase_text = ''
            training_phrase_annotated = ''
            traninig_phrase_entity_types = []
            
            for part in training_phrase.parts:
                training_phrase_text += part.text

                if part.parameter_id == '':
                    training_phrase_annotated += part.text
                elif part.parameter_id != '':
                    entity_type = next((x for x in intent.parameters if x.id == part.parameter_id), None)
                    training_phrase_annotated += f'[{part.text}]{{@{part.parameter_id}}}'
                    # traninig_phrase_entity_types.append(part.parameter_id)

                    if(entity_type is None):
                        logging.warning(f'Could not find entity_type for parameter_id: {part.parameter_id}')
                    else:
                        entity_type_id_parts = entity_type.entity_type.split('/')

                        traninig_phrase_entity_types.append({
                            'id': entity_type_id_parts[len(entity_type_id_parts)-1],
                            'display_name': entity_type.id
                        })
            
            training_phrases.append({
                'phrase_text': training_phrase_text,
                'phrase_annotated': training_phrase_annotated,
                'entity_types': traninig_phrase_entity_types
            })
        
        return training_phrases
    
    def get_agent_df(self):
        # Agent parse
        agent_info_data = [{
            'test_run_guid': self.test_guid,
            'test_run_timestamp': self.test_start_time,
            'agent_project_id': self.agent_project_id,
            'agent_location_id': self.agent_location_id,
            'agent_id': self.agent_id,
            'agent_name': self.agent_name
        }]

        result = pd.DataFrame(agent_info_data)

        logging.info(f'Agent: {result.shape}')

        return result

    def get_intent_df(self):
        # Intent parse
        intent_data = [{
            'test_run_guid': self.test_guid,
            'test_run_timestamp': self.test_start_time,
            'agent_project_id': self.agent_project_id,
            'agent_location_id': self.agent_location_id,
            'agent_id': self.agent_id,
            'agent_name': self.agent_name,
            'intent_id': data.name.split("/")[7],
            'intent_name': data.display_name,
            'description': data.description,
            'labels': list(data.labels.keys()),
            'training_phrases': self.get_training_phrases_from_intent(intent=data)
        } for data in self.agent_data['intents']]

        intent_df = pd.DataFrame(intent_data)

        logging.info(f'Intents: {intent_df.shape}')

        return intent_df

    def get_playbooks_df(self):
        # Playbook parse
        playbook_data = [{
            'test_run_guid': self.test_guid,
            'test_run_timestamp': self.test_start_time,
            'agent_project_id': self.agent_project_id,
            'agent_location_id': self.agent_location_id,
            'agent_id': self.agent_id,
            'agent_name': self.agent_name,
            'playbook_id': data.name.split("/")[7],
            'playbook_name': data.display_name,
            'goal': data.goal
        } for data in self.agent_data['playbooks']]

        playbook_df = pd.DataFrame(playbook_data)

        logging.info(f'Playbooks:{playbook_df.shape}')

        return playbook_df

    def get_tools_df(self):
        # Tool parse
        tool_data = [{
            'test_run_guid': self.test_guid,
            'test_run_timestamp': self.test_start_time,
            'agent_project_id': self.agent_project_id,
            'agent_location_id': self.agent_location_id,
            'agent_id': self.agent_id,
            'agent_name': self.agent_name,
            'tool_id': data.name.split("/")[7],
            'tool_name': data.display_name,
            'description': data.description
        } for data in self.agent_data['tools']]

        tool_df = pd.DataFrame(tool_data)

        logging.info(f'Tools: {tool_df.shape}')

        return tool_df
    
    def get_flows_df(self):
        # Flows parse
        flows_data = [{
            'test_run_guid': self.test_guid,
            'test_run_timestamp': self.test_start_time,
            'agent_project_id': self.agent_project_id,
            'agent_location_id': self.agent_location_id,
            'agent_id': self.agent_id,
            'agent_name': self.agent_name,
            'flow_id': data.name.split("/")[7],
            'flow_name': data.display_name,
            'description': data.description
        } for data in self.agent_data['flows']]

        flows_df = pd.DataFrame(flows_data)

        return flows_df
    
    def get_pages_df(self):
        # Pages
        pages_data = []
        for flow in self.agent_data['flows']:
            pages_data += self.get_pages_from_flow(flow=flow)

        pages_df = pd.DataFrame(pages_data)

        return pages_df

    def parse_agent_data(self):
        """
            Prepares data for loading into BigQuery
        """

        bigquery_data = {
            'agent': self.get_agent_df(),
            'intents': self.get_intent_df(),
            'playbooks': self.get_playbooks_df(),
            'tools': self.get_tools_df(),
            'flows': self.get_flows_df(),
            'pages': self.get_pages_df()
        }

        return bigquery_data

    def write_to_bigquery(self, bigquery_data):
        """
            Writes data into BigQuery
        """
        agents_table_id = f"{self.bq_project_id}.{self.bq_dataset_name}.dfcx_agents"

        logging.info(f"Writing data to Bigquery table {agents_table_id}")

        pandas_gbq.to_gbq(
            bigquery_data['agent'],
            agents_table_id, 
            project_id=self.bq_project_id,
            if_exists='append', 
            table_schema=agents_schema,
            progress_bar=False
        )

        # Intents
        intents_table_id = f"{self.bq_project_id}.{self.bq_dataset_name}.dfcx_intents"

        logging.info(f"Writing data to Bigquery table {intents_table_id}")

        pandas_gbq.to_gbq(
            bigquery_data['intents'],
            intents_table_id, 
            project_id=self.bq_project_id,
            if_exists='append', 
            table_schema=intents_schema,
            progress_bar=False
        )

        # Playbooks
        playbooks_table_id = f"{self.bq_project_id}.{self.bq_dataset_name}.dfcx_playbooks"

        logging.info(f"Writing data to Bigquery table {playbooks_table_id}")

        pandas_gbq.to_gbq(
            bigquery_data['playbooks'],
            playbooks_table_id, 
            project_id=self.bq_project_id,
            if_exists='append', 
            table_schema=playbooks_schema,
            progress_bar=False
        )

        # Tools
        tools_table_id = f"{self.bq_project_id}.{self.bq_dataset_name}.dfcx_tools"

        logging.info(f"Writing data to Bigquery table {tools_table_id}")

        pandas_gbq.to_gbq(
            bigquery_data['tools'],
            tools_table_id, 
            project_id=self.bq_project_id,
            if_exists='append', 
            table_schema=tools_schema,
            progress_bar=False
        )

        # Flows
        flows_table_id = f"{self.bq_project_id}.{self.bq_dataset_name}.dfcx_flows"

        logging.info(f"Writing data to Bigquery table {flows_table_id}")

        pandas_gbq.to_gbq(
            bigquery_data['flows'],
            flows_table_id, 
            project_id=self.bq_project_id,
            if_exists='append', 
            table_schema=flows_schema,
            progress_bar=False
        )

        # pages
        pages_table_id = f"{self.bq_project_id}.{self.bq_dataset_name}.dfcx_pages"

        logging.info(f"Writing data to Bigquery table {pages_table_id}")

        pandas_gbq.to_gbq(
            bigquery_data['pages'],
            pages_table_id, 
            project_id=self.bq_project_id,
            if_exists='append', 
            table_schema=pages_schema,
            progress_bar=False
        )
    
    def convert_protobuf(self, obj):
        """Recursive function to convert protobuf object to
        python object with lists and/or dictionaries"""

        if isinstance(obj, MapComposite):
            res = {}
            for key, value in obj.items():
                res[key] = self.convert_protobuf(value)
            return res
        elif isinstance(obj, RepeatedComposite):
            res = []
            for value in obj:
                res.append(self.convert_protobuf(value))
            return res
        else:
            return obj
        
    def get_pages_from_flow(self, flow):
        pages = Pages().list_pages(flow_id=flow.name)
        result = []
        for page in pages:
            page_result = {}

            flow_id = flow.name.split('/')[7]

            fulfillment = self.parse_fulfillment(
                fulfillment=page.entry_fulfillment
            )

            page_result['agent_project_id'] = self.agent_project_id
            page_result['agent_location_id'] = self.agent_location_id
            page_result['agent_id'] = self.agent_id
            page_result['agent_name'] = self.agent_name
            page_result['test_run_guid'] = self.test_guid
            page_result['test_run_timestamp'] = self.test_start_time
            page_result['flow_id'] = flow_id
            page_result['page_id'] = page.name.split("/")[9]
            page_result['page_name'] = page.display_name
            page_result['webhook_id'] = fulfillment['webhook_id']
            page_result['webhook_name'] = fulfillment['webhook_name']
            page_result['webhook_tag'] = fulfillment['webhook_tag']
            page_result['fulfillment'] = fulfillment['messages']
            page_result['partial_response'] = fulfillment['partial_response']
            page_result['parameter_presets'] = fulfillment['parameter_presets']

            result.append(page_result)

        return result

    def parse_fulfillment(self, fulfillment):
        messages = []
        
        # Parse the different fulfillment message types
        if getattr(fulfillment, 'messages', None):
            for message in fulfillment.messages:
                if getattr(message, 'text', None):
                    message_options = list(message.text.text)  # list
                    messages.append(json.dumps(
                        {'type': 'Agent says', 'data': message_options}))
                if getattr(message, 'payload', None):
                    message_payload = self.convert_protobuf(message.payload)  # dict
                    messages.append(json.dumps(
                        {'type': 'Custom payload', 'data': message_payload}))
                if getattr(message, 'live_agent_handoff', None):
                    message_metadata = self.convert_protobuf(
                        message.live_agent_handoff.metadata)  # dict
                    messages.append(json.dumps(
                        {'type': 'Live agent handoff', 'data': message_metadata}))
                if getattr(message, 'conversation_success', None):
                    message_metadata = self.convert_protobuf(
                        message.conversation_success.metadata)  # dict
                    messages.append(json.dumps(
                        {'type': 'Conversation success metadata', 'data': message_metadata}))
                if getattr(message, 'output_audio_text', None):
                    message_ssml = message.output_audio_text.ssml  # str
                    messages.append(json.dumps(
                        {'type': 'Output audio text', 'data': message_ssml}))
                # Other unused options: Play pre-recorded audio, Telephony transfer call

        # Conditional response needs to be handled differently
        if getattr(fulfillment, 'conditional_cases', None):
            for conditional_response in fulfillment.conditional_cases:
                cond_res_text = self.parse_conditional_fulfillment(conditional_response)
                messages.append(json.dumps(
                    {'type': 'Conditional response', 'data': cond_res_text}))

        webhookId = getattr(fulfillment, 'webhook', None)
        webhookName = self.webhooks_map[getattr(fulfillment, 'webhook', None)] if getattr(
            fulfillment, 'webhook', None) in self.webhooks_map else None
        webhookTag = getattr(fulfillment, 'tag', None)
        partialResponse = getattr(fulfillment, 'return_partial_responses', False)
        parameterPresets = []  # {}
        if getattr(fulfillment, 'set_parameter_actions', None):
            for param_preset in fulfillment.set_parameter_actions:
                # List form
                parameterPresets.append(json.dumps(
                    {"parameter": param_preset.parameter, "value": self.parse_value(param_preset.value)}))
                # Dict form
                # parameterPresets[param_preset.parameter] = parse_value(param_preset.value)
        return {
            'messages': messages,
            'webhook_id': webhookId,
            'webhook_name': webhookName,
            'webhook_tag': webhookTag,
            'partial_response': partialResponse,
            'parameter_presets': parameterPresets
        }
    
    def parse_value(self, value):
        return str(value)  # Placeholder
    
    def parse_conditional_fulfillment(self, conditional_response, cond_res_text='', tabs=0):
        tab_symbol = '  '
        if isinstance(conditional_response, DFCXCase) and tabs == 0:
            cond_res_text += tab_symbol*tabs + 'if '
            if getattr(conditional_response, 'condition', None):
                cond_res_text += conditional_response.condition + '\n'
        else:
            for i, case in enumerate(conditional_response.cases):
                if i == 0:
                    cond_res_text += tab_symbol*tabs + 'if '
                elif i != len(conditional_response.cases) - 1:
                    cond_res_text += tab_symbol*tabs + 'elif '
                else:
                    cond_res_text += tab_symbol*tabs + 'else\n'
                if getattr(case, 'condition', None):
                    cond_res_text += case.condition + '\n'
                for content in case.case_content:
                    tabs += 1
                    if getattr(content, 'additional_cases', None):
                        self.parse_conditional_fulfillment(
                            content.additional_cases, cond_res_text, tabs)
                        # Nested conditions, use recursion (note cond_res_text side effect)
                        # for additional_case in content.additional_cases.cases:
                        #     parse_conditional_fulfillment_new(
                        #         additional_case, cond_res_text, tabs)
                    elif getattr(content, 'message', None):
                        if getattr(content.message, 'text', None):
                            # For some reason this is a list even though it can only be one thing...
                            text_message = content.message.text.text[0]
                            cond_res_text += tab_symbol*tabs + text_message + '\n'
                    tabs -= 1
        return cond_res_text

    def convert_protobuf(self, obj):
        """Recursive function to convert protobuf object to
        python object with lists and/or dictionaries"""

        if isinstance(obj, MapComposite):
            res = {}
            for key, value in obj.items():
                res[key] = self.convert_protobuf(value)
            return res
        elif isinstance(obj, RepeatedComposite):
            res = []
            for value in obj:
                res.append(self.convert_protobuf(value))
            return res
        else:
            return obj
    