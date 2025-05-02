agents_schema = [
    {"name": "test_run_guid", "type": "STRING", "mode": "NULLABLE"},
    {"name": "test_run_timestamp", "type": "TIMESTAMP", "mode": "NULLABLE"},
    {"name": "agent_project_id", "type": "STRING", "mode": "NULLABLE"},
    {"name": "agent_location_id", "type": "STRING", "mode": "NULLABLE"},
    {"name": "agent_id", "type": "STRING", "mode": "NULLABLE"},
    {"name": "agent_name", "type": "STRING", "mode": "NULLABLE"},
    {"name": "agent_settings", "type":"JSON", "mode":"NULLABLE"}
]

intents_schema = [
    {"name": "test_run_guid", "type": "STRING", "mode": "NULLABLE"},
    {"name": "test_run_timestamp", "type": "TIMESTAMP", "mode": "NULLABLE"},
    {"name": "agent_project_id", "type": "STRING", "mode": "NULLABLE"},
    {"name": "agent_location_id", "type": "STRING", "mode": "NULLABLE"},
    {"name": "agent_id", "type": "STRING", "mode": "NULLABLE"},
    {"name": "agent_name", "type": "STRING", "mode": "NULLABLE"},
    {"name": "intent_id", "type": "STRING", "mode": "NULLABLE"},
    {"name": "intent_name", "type": "STRING", "mode": "NULLABLE"},
    {"name": "description", "type": "STRING", "mode": "NULLABLE"},
    {"name": "labels", "type": "STRING", "mode": "REPEATED"},
    {
        "name": "training_phrases",
        "type": "RECORD",
        "mode": "REPEATED",
        "fields": [
            {"name": "phrase_text", "mode": "NULLABLE", "type": "STRING"},
            {"name": "phrase_annotated", "mode": "NULLABLE", "type": "STRING"},
            {
                "name": "entity_types",
                "type": "RECORD",
                "mode": "REPEATED",
                "fields": [
                    {"name": "id", "mode": "NULLABLE", "type": "STRING"},
                    {"name": "display_name", "mode": "NULLABLE", "type": "STRING"},
                ],
            },
        ],
    },
]

playbooks_schema = [
    {"name": "test_run_guid", "type": "STRING", "mode": "NULLABLE"},
    {"name": "test_run_timestamp", "type": "TIMESTAMP", "mode": "NULLABLE"},
    {"name": "agent_project_id", "type": "STRING", "mode": "NULLABLE"},
    {"name": "agent_location_id", "type": "STRING", "mode": "NULLABLE"},
    {"name": "agent_id", "type": "STRING", "mode": "NULLABLE"},
    {"name": "agent_name", "type": "STRING", "mode": "NULLABLE"},
    {"name": "playbook_id", "type": "STRING", "mode": "NULLABLE"},
    {"name": "playbook_name", "type": "STRING", "mode": "NULLABLE"},
    {"name": "description", "type": "STRING", "mode": "NULLABLE"},
    {"name": "goal", "type": "STRING", "mode": "NULLABLE"},
]

tools_schema = [
    {"name": "test_run_guid", "type": "STRING", "mode": "NULLABLE"},
    {"name": "test_run_timestamp", "type": "TIMESTAMP", "mode": "NULLABLE"},
    {"name": "agent_project_id", "type": "STRING", "mode": "NULLABLE"},
    {"name": "agent_location_id", "type": "STRING", "mode": "NULLABLE"},
    {"name": "agent_id", "type": "STRING", "mode": "NULLABLE"},
    {"name": "agent_name", "type": "STRING", "mode": "NULLABLE"},
    {"name": "tool_id", "type": "STRING", "mode": "NULLABLE"},
    {"name": "tool_name", "type": "STRING", "mode": "NULLABLE"},
    {"name": "description", "type": "STRING", "mode": "NULLABLE"},
]

flows_schema = [
    {"name": "test_run_guid", "type": "STRING", "mode": "NULLABLE"},
    {"name": "test_run_timestamp", "type": "TIMESTAMP", "mode": "NULLABLE"},
    {"name": "agent_project_id", "type": "STRING", "mode": "NULLABLE"},
    {"name": "agent_location_id", "type": "STRING", "mode": "NULLABLE"},
    {"name": "agent_id", "type": "STRING", "mode": "NULLABLE"},
    {"name": "agent_name", "type": "STRING", "mode": "NULLABLE"},
    {"name": "flow_id", "type": "STRING", "mode": "NULLABLE"},
    {"name": "flow_name", "type": "STRING", "mode": "NULLABLE"},
    {"name": "description", "type": "STRING", "mode": "NULLABLE"},
    {"name":"flow_settings", "type":"JSON", "mode":"NULLABLE"}
]

pages_schema = [
    {"name": "test_run_guid", "type": "STRING", "mode": "NULLABLE"},
    {"name": "test_run_timestamp", "type": "TIMESTAMP", "mode": "NULLABLE"},
    {"name": "agent_project_id", "type": "STRING", "mode": "NULLABLE"},
    {"name": "agent_location_id", "type": "STRING", "mode": "NULLABLE"},
    {"name": "agent_id", "type": "STRING", "mode": "NULLABLE"},
    {"name": "agent_name", "type": "STRING", "mode": "NULLABLE"},
    {"name": "flow_id", "type": "STRING", "mode": "NULLABLE"},
    {"name": "page_id", "type": "STRING", "mode": "NULLABLE"},
    {"name": "page_name", "type": "STRING", "mode": "NULLABLE"},
    {"name": "webhook_id", "type": "STRING", "mode": "NULLABLE"},
    {"name": "webhook_name", "type": "STRING", "mode": "NULLABLE"},
    {"name": "webhook_tag", "type": "STRING", "mode": "NULLABLE"},
    {"name": "fulfillment", "type": "STRING", "mode": "REPEATED"},
    {"name": "partial_response", "type": "BOOLEAN", "mode": "NULLABLE"},
    {"name": "parameter_presets", "type": "STRING", "mode": "REPEATED"},
    {"name": "routes", "type": "STRING", "mode": "REPEATED"},
    {"name": "route_groups", "type": "STRING", "mode": "REPEATED"},
]

entity_types_schema = [
    {
        "name": "entity_type_id",
        "type": "STRING",
        "mode": "NULLABLE",
        "description": "Unique identifier for the Dialogflow CX Entity Type.",
    },
    {
        "name": "display_name",
        "type": "STRING",
        "mode": "NULLABLE",
        "description": "The human-readable name for the entity type displayed in the console.",
    },
    {
        "name": "kind",
        "type": "STRING",
        "mode": "NULLABLE",
        "description": "The kind of entity type (e.g., KIND_MAP, KIND_LIST, KIND_REGEXP).",
    },
    {
        "name": "auto_expansion_mode",
        "type": "BOOLEAN",
        "mode": "NULLABLE",
        "description": "Indicates if automatic expansion is enabled for the entity type.",
    },
    {
        "name": "fuzzy_extraction",
        "type": "BOOLEAN",
        "mode": "NULLABLE",
        "description": "Indicates if fuzzy matching is enabled for the entity type.",
    },
    {
        "name": "redact",
        "type": "BOOLEAN",
        "mode": "NULLABLE",
        "description": "Indicates if entity values should be redacted in logs and storage.",
    },
    {
        "name": "entity_value",
        "type": "STRING",
        "mode": "NULLABLE",
        "description": "The specific canonical value for an entity entry within the entity type.",
    },
    {
        "name": "synonyms",
        "type": "STRING",
        "mode": "NULLABLE",
        "description": "A list of alternative strings that map to the entity_value.",
    },
]

entity_exclusions_schema = [
    {
        "name": "entity_type_id",
        "type": "STRING",
        "mode": "NULLABLE",
        "description": "Unique ID for the Dialogflow CX Entity Type to which this exclusion applies.",
    },
    {
        "name": "display_name",
        "type": "STRING",
        "mode": "NULLABLE",
        "description": "The human-readable name for the entity type (at the time of data extraction).",
    },
    {
        "name": "excluded_phrase",
        "type": "STRING",
        "mode": "NULLABLE",
        "description": "A specific phrase that should *not* be matched as part of this entity type.",
    },
]
