agents_schema = [
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
    }
]

intents_schema = [
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
        "name": "intent_id",
        "type": "STRING",
        "mode": "NULLABLE"
    },
    {
        "name": "intent_name",
        "type": "STRING",
        "mode": "NULLABLE"
    },
    {
        "name": "description",
        "type": "STRING",
        "mode": "NULLABLE"
    },
    {
        "name": "labels",
        "type": "STRING",
        "mode": "REPEATED"
    },
    {
        "name": "training_phrases",
        "type": "RECORD",
        "mode": "REPEATED",
        "fields": [
            {
                "name": "phrase_text",
                "mode": "NULLABLE",
                "type": "STRING"
            },
            {
                "name": "phrase_annotated",
                "mode": "NULLABLE",
                "type": "STRING"
            },
            {
                "name": "entity_types",
                "type": "RECORD",
                "mode": "REPEATED",
                "fields": [
                    {
                        "name": "id",
                        "mode": "NULLABLE",
                        "type": "STRING"
                    },
                    {
                        "name": "display_name",
                        "mode": "NULLABLE",
                        "type": "STRING"
                    }
                ]
            }
            
        ]
    }
]

playbooks_schema = [
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
        "name": "playbook_id",
        "type": "STRING",
        "mode": "NULLABLE"
    },
    {
        "name": "playbook_name",
        "type": "STRING",
        "mode": "NULLABLE"
    },
    {
        "name": "description",
        "type": "STRING",
        "mode": "NULLABLE"
    },
    {
        "name": "goal",
        "type": "STRING",
        "mode": "NULLABLE"
    }
]

tools_schema = [
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
        "name": "tool_id",
        "type": "STRING",
        "mode": "NULLABLE"
    },
    {
        "name": "tool_name",
        "type": "STRING",
        "mode": "NULLABLE"
    },
    {
        "name": "description",
        "type": "STRING",
        "mode": "NULLABLE"
    }
]

flows_schema = [
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
        "name": "flow_id",
        "type": "STRING",
        "mode": "NULLABLE"
    },
    {
        "name": "flow_name",
        "type": "STRING",
        "mode": "NULLABLE"
    },
    {
        "name": "description",
        "type": "STRING",
        "mode": "NULLABLE"
    }
]

pages_schema = [
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
        "name": "flow_id",
        "type": "STRING",
        "mode": "NULLABLE"
    },
    {
        "name": "page_id",
        "type": "STRING",
        "mode": "NULLABLE"
    },
    {
        "name": "page_name",
        "type": "STRING",
        "mode": "NULLABLE"
    },
    {
        "name": "webhook_id",
        "type": "STRING",
        "mode": "NULLABLE"
    },
    {
        "name": "webhook_name",
        "type": "STRING",
        "mode": "NULLABLE"
    },
    {
        "name": "webhook_tag",
        "type": "STRING",
        "mode": "NULLABLE"
    },
    {
        "name": "fulfillment",
        "type": "STRING",
        "mode": "REPEATED"
    },
    {
        "name": "partial_response",
        "type": "BOOLEAN",
        "mode": "NULLABLE"
    },
    {
        "name": "parameter_presets",
        "type": "STRING",
        "mode": "REPEATED"
    },
    {
        "name": "routes",
        "type": "STRING",
        "mode": "REPEATED"
    },
    {
        "name": "route_groups",
        "type": "STRING",
        "mode": "REPEATED"
    }
]