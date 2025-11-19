- dashboard: tools__transcript_explorer
  title: Tools - Transcript Explorer
  layout: newspaper
  preferred_viewer: dashboards-next
  crossfilter_enabled: true
  description: ''
  preferred_slug: 87myHlvvS06EVwS90OGMJE
  elements:
  - title: Webhook and Tool Calls
    name: Webhook and Tool Calls
    explore: dfcx_session_metadata
    type: looker_grid
    fields: [dfcx_session_metadata.session_id, dfcx_transcript.position, dfcx_transcript__tools.block_step,
      dfcx_transcript__tools.action_step, dfcx_transcript__tools.action_flow_display_name,
      dfcx_transcript__tools.action_page_display_name, dfcx_transcript__tools.playbook_name,
      dfcx_transcript__tools.tool_type, dfcx_transcript__tools.tool_name, dfcx_transcript__tools.tool_latency_ms]
    filters:
      dfcx_session_metadata.session_start_date: 30 days
    sorts: [dfcx_session_metadata.session_id, dfcx_transcript.position, dfcx_transcript__tools.block_step,
      dfcx_transcript__tools.action_step]
    limit: 500
    column_limit: 50
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: false
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    truncate_header: true
    minimum_column_width: 10
    series_column_widths:
      dfcx_transcript.position: 40
      dfcx_transcript__tools.block_step: 40
      dfcx_transcript__tools.action_step: 40
    hidden_fields: [dfcx_session_metadata.session_id]
    defaults_version: 1
    note_state: collapsed
    note_display: hover
    note_text: Latency information of webhooks or tools used in the session
    listen:
      Session Start Date: dfcx_session_metadata.session_start_date
      Session ID: dfcx_session_metadata.session_id
      Auth User: dfcx_session_metadata.auth_user
      Agent Name: dfcx_session_metadata.agent_name
      Session Parameter Path: dfcx_transcript.session_parameter_path
    row: 12
    col: 0
    width: 12
    height: 8
  - title: Session Parameter
    name: Session Parameter
    explore: dfcx_session_metadata
    type: looker_grid
    fields: [dfcx_session_metadata.session_id, dfcx_transcript.position, dfcx_transcript.session_parameter_query]
    filters:
      dfcx_session_metadata.session_start_date: 30 days
    sorts: [dfcx_session_metadata.session_id, dfcx_transcript.position]
    limit: 500
    column_limit: 50
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: false
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: unstyled
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    column_order: [dfcx_transcript.position, dfcx_transcript.session_parameter__ccaip_vva_intent,
      dfcx_transcript.session_parameter__vva_milestone, dfcx_transcript.session_parameter__tags_string,
      dfcx_transcript.session_parameter__channel, dfcx_transcript.session_parameter__subchannel,
      dfcx_transcript.session_parameter__channel_type, dfcx_transcript.session_parameter__is_api_fail,
      dfcx_transcript.session_parameter__is_customer_authenticated, dfcx_transcript.session_parameter__is_info_bot_flow,
      dfcx_transcript.session_parameter__is_sidecar_enabled, dfcx_transcript.session_parameter__is_user_pah]
    show_totals: true
    show_row_totals: true
    truncate_header: true
    minimum_column_width: 10
    series_labels:
      dfcx_transcript.session_parameter__ccaip_vva_intent: CCAI-P VVA Intent
      dfcx_transcript.session_parameter__vva_milestone: VVA Milestone
      dfcx_transcript.session_parameter__tags_string: Tags
      dfcx_transcript.session_parameter__channel: Channel
      dfcx_transcript.session_parameter__subchannel: Subchannel
      dfcx_transcript.session_parameter__channel_type: Channel Type
      dfcx_transcript.session_parameter__is_api_fail: Is API Fail?
      dfcx_transcript.session_parameter__is_customer_authenticated: Is Customer Authenticated?
      dfcx_transcript.session_parameter__is_info_bot_flow: Is Infobot Flow?
      dfcx_transcript.session_parameter__is_sidecar_enabled: Is Sidecar Enabled?
      dfcx_transcript.session_parameter__is_user_pah: Is User PAH?
    series_column_widths:
      dfcx_transcript.position: 40
    custom_color_enabled: true
    show_single_value_title: true
    smart_single_value_size: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    hidden_fields: [dfcx_session_metadata.session_id]
    defaults_version: 1
    note_state: collapsed
    note_display: hover
    note_text: Session parameters at the end of the turn. Use the session parameter
      path in the filter bar to target specific session parameter values.
    listen:
      Session Start Date: dfcx_session_metadata.session_start_date
      Session ID: dfcx_session_metadata.session_id
      Auth User: dfcx_session_metadata.auth_user
      Agent Name: dfcx_session_metadata.agent_name
      Session Parameter Path: dfcx_transcript.session_parameter_path
    row: 3
    col: 19
    width: 5
    height: 9
  - title: Transcript
    name: Transcript
    explore: dfcx_session_metadata
    type: looker_grid
    fields: [dfcx_session_metadata.session_id, dfcx_transcript.request_time, dfcx_transcript.user_utterance,
      dfcx_transcript.agent_response, dfcx_transcript_metadata.contain_any_ai_generated_content,
      dfcx_transcript.match_type, dfcx_transcript.event, dfcx_transcript.conversation_thread_html]
    filters:
      dfcx_session_metadata.session_start_date: 30 days
    sorts: [dfcx_session_metadata.session_id, dfcx_transcript.request_time]
    limit: 500
    column_limit: 50
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: false
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: unstyled
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: center
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    truncate_header: true
    minimum_column_width: 10
    series_labels:
      dfcx_transcript.conversation_thread_html: Conversation
    series_column_widths:
      dfcx_transcript_metadata.contain_any_ai_generated_content: 60
    series_text_format:
      dfcx_transcript.conversation_thread_html:
        align: left
    hidden_fields: [dfcx_session_metadata.session_id, dfcx_transcript.request_time,
      dfcx_transcript.user_utterance, dfcx_transcript.agent_response, dfcx_transcript_metadata.contain_any_ai_generated_content,
      dfcx_transcript.match_type, dfcx_transcript.event]
    defaults_version: 1
    note_state: collapsed
    note_display: hover
    note_text: Transcript including rendering of DTMF, generative responses, event,
      and no inputs.
    title_hidden: true
    listen:
      Session Start Date: dfcx_session_metadata.session_start_date
      Session ID: dfcx_session_metadata.session_id
      Auth User: dfcx_session_metadata.auth_user
      Agent Name: dfcx_session_metadata.agent_name
      Session Parameter Path: dfcx_transcript.session_parameter_path
    row: 3
    col: 0
    width: 12
    height: 9
  - title: Turn Information
    name: Turn Information
    explore: dfcx_session_metadata
    type: looker_single_record
    fields: [dfcx_session_metadata.session_id, dfcx_transcript.position, dfcx_transcript.source_flow_display_name,
      dfcx_transcript.source_page_display_name, dfcx_transcript.match_type, dfcx_transcript.intent_display_name,
      dfcx_transcript.flow_display_name, dfcx_transcript.page_display_name]
    sorts: [dfcx_session_metadata.session_id, dfcx_transcript.position]
    limit: 500
    column_limit: 50
    show_view_names: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    show_row_numbers: false
    transpose: false
    truncate_text: false
    truncate_header: true
    size_to_fit: true
    series_column_widths:
      dfcx_transcript.position: 75
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    hide_totals: false
    hide_row_totals: false
    hidden_fields: [dfcx_session_metadata.session_id]
    defaults_version: 1
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    note_state: collapsed
    note_display: hover
    note_text: Key turn information about where a user is in the agent
    listen:
      Session Start Date: dfcx_session_metadata.session_start_date
      Session ID: dfcx_session_metadata.session_id
      Auth User: dfcx_session_metadata.auth_user
      Agent Name: dfcx_session_metadata.agent_name
      Session Parameter Path: dfcx_transcript.session_parameter_path
    row: 3
    col: 12
    width: 7
    height: 9
  - title: Session ID
    name: Session ID
    explore: dfcx_session_metadata
    type: single_value
    fields: [dfcx_session_metadata.session_id]
    filters:
      dfcx_session_metadata.session_start_date: 30 days
    sorts: [dfcx_session_metadata.session_id]
    limit: 500
    column_limit: 50
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    smart_single_value_size: true
    show_view_names: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    show_row_numbers: false
    transpose: false
    truncate_text: false
    truncate_header: true
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    hide_totals: false
    hide_row_totals: false
    hidden_fields:
    defaults_version: 1
    note_state: collapsed
    note_display: hover
    note_text: Session ID - Contains links to common CES debugging tools
    listen:
      Session Start Date: dfcx_session_metadata.session_start_date
      Session ID: dfcx_session_metadata.session_id
      Auth User: dfcx_session_metadata.auth_user
      Agent Name: dfcx_session_metadata.agent_name
      Session Parameter Path: dfcx_transcript.session_parameter_path
    row: 0
    col: 0
    width: 16
    height: 3
  - title: Heuristic Outcome
    name: Heuristic Outcome
    explore: dfcx_session_metadata
    type: single_value
    fields: [dfcx_session_metadata.is_escalated]
    filters:
      dfcx_session_metadata.session_start_date: 30 days
    sorts: [dfcx_session_metadata.is_escalated]
    limit: 500
    column_limit: 50
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    smart_single_value_size: true
    show_view_names: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    show_row_numbers: false
    transpose: false
    truncate_text: false
    truncate_header: true
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    hide_totals: false
    hide_row_totals: false
    hidden_fields:
    defaults_version: 1
    note_state: collapsed
    note_display: hover
    note_text: Determines if session was escalated or not
    listen:
      Session Start Date: dfcx_session_metadata.session_start_date
      Session ID: dfcx_session_metadata.session_id
      Auth User: dfcx_session_metadata.auth_user
      Agent Name: dfcx_session_metadata.agent_name
      Session Parameter Path: dfcx_transcript.session_parameter_path
    row: 0
    col: 16
    width: 4
    height: 3
  - title: Handle Time (Seconds)
    name: Handle Time (Seconds)
    explore: dfcx_session_metadata
    type: single_value
    fields: [dfcx_session_metadata.session_handle_time]
    filters:
      dfcx_session_metadata.session_start_date: 30 days
    sorts: [dfcx_session_metadata.session_handle_time]
    limit: 500
    column_limit: 50
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    smart_single_value_size: true
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: false
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: normal
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: true
    show_silhouette: false
    totals_color: "#808080"
    x_axis_zoom: true
    y_axis_zoom: true
    hidden_pivots: {}
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    defaults_version: 1
    note_state: collapsed
    note_display: hover
    note_text: Estimated duration of session in seconds
    listen:
      Session Start Date: dfcx_session_metadata.session_start_date
      Session ID: dfcx_session_metadata.session_id
      Auth User: dfcx_session_metadata.auth_user
      Agent Name: dfcx_session_metadata.agent_name
      Session Parameter Path: dfcx_transcript.session_parameter_path
    row: 0
    col: 20
    width: 4
    height: 3
  - title: Generative Actions
    name: Generative Actions
    explore: dfcx_session_metadata
    type: looker_grid
    fields: [dfcx_session_metadata.session_id, dfcx_transcript.position, dfcx_transcript__actions.action_step,
      dfcx_transcript__actions.action, dfcx_transcript__actions.action_name, dfcx_transcript__actions.action_input_string,
      dfcx_transcript__actions.action_output_string]
    filters:
      dfcx_session_metadata.session_start_date: 30 days
    sorts: [dfcx_session_metadata.session_id, dfcx_transcript.position, dfcx_transcript__actions.action_step]
    limit: 500
    column_limit: 50
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: false
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    pinned_columns:
      dfcx_transcript.position: left
      dfcx_transcript__execution_sequence.step: left
    column_order: [dfcx_transcript.position, dfcx_transcript__execution_sequence.step,
      dfcx_transcript__execution_sequence.flow_display_name, dfcx_transcript__execution_sequence.page_display_name,
      dfcx_transcript__execution_sequence.status, dfcx_transcript__execution_sequence.triggered_condition,
      dfcx_transcript__execution_sequence.triggered_intent, dfcx_transcript__execution_sequence.triggered_transition_route_id,
      dfcx_transcript__execution_sequence.session_parameters_updated_string]
    show_totals: true
    show_row_totals: true
    truncate_header: true
    minimum_column_width: 10
    series_column_widths:
      dfcx_transcript.position: 40
    hidden_fields: [dfcx_session_metadata.session_id]
    defaults_version: 1
    note_state: collapsed
    note_display: hover
    note_text: Information exchanged in playbooks and tools
    listen:
      Session Start Date: dfcx_session_metadata.session_start_date
      Session ID: dfcx_session_metadata.session_id
      Auth User: dfcx_session_metadata.auth_user
      Agent Name: dfcx_session_metadata.agent_name
      Session Parameter Path: dfcx_transcript.session_parameter_path
    row: 12
    col: 12
    width: 12
    height: 8
  - title: Trace
    name: Trace
    explore: dfcx_session_metadata
    type: looker_grid
    fields: [dfcx_session_metadata.session_id, dfcx_transcript.position, dfcx_transcript__blocks.block_step,
      dfcx_transcript__blocks.block_type, dfcx_transcript__blocks__actions.action_step,
      dfcx_transcript__blocks__actions.action_type, dfcx_transcript__blocks__actions.action_display_name,
      dfcx_transcript__blocks__actions.action_flow_display_name, dfcx_transcript__blocks__actions.action_page_display_name,
      dfcx_transcript__blocks__actions.playbook_name, dfcx_transcript__blocks__actions.tool_name,
      dfcx_transcript__blocks__actions.tool_type, dfcx_transcript__blocks__actions.tool_latency_ms]
    filters:
      dfcx_session_metadata.session_start_date: 30 days
    sorts: [dfcx_session_metadata.session_id, dfcx_transcript.position, dfcx_transcript__blocks.block_step,
      dfcx_transcript__blocks__actions.action_step]
    limit: 500
    column_limit: 50
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: false
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    pinned_columns:
      dfcx_transcript.position: left
      dfcx_transcript__execution_sequence.step: left
    column_order: [dfcx_transcript.position, dfcx_transcript__execution_sequence.step,
      dfcx_transcript__execution_sequence.flow_display_name, dfcx_transcript__execution_sequence.page_display_name,
      dfcx_transcript__execution_sequence.status, dfcx_transcript__execution_sequence.triggered_condition,
      dfcx_transcript__execution_sequence.triggered_intent, dfcx_transcript__execution_sequence.triggered_transition_route_id,
      dfcx_transcript__execution_sequence.session_parameters_updated_string]
    show_totals: true
    show_row_totals: true
    truncate_header: true
    minimum_column_width: 10
    series_column_widths:
      dfcx_transcript.position: 40
      dfcx_transcript__blocks.block_step: 40
      dfcx_transcript__blocks__actions.action_step: 40
    hidden_fields: [dfcx_session_metadata.session_id]
    defaults_version: 1
    note_state: collapsed
    note_display: hover
    note_text: The diagnostic information about how the session was handled in playbooks
      or flows
    listen:
      Session Start Date: dfcx_session_metadata.session_start_date
      Session ID: dfcx_session_metadata.session_id
      Auth User: dfcx_session_metadata.auth_user
      Agent Name: dfcx_session_metadata.agent_name
      Session Parameter Path: dfcx_transcript.session_parameter_path
    row: 20
    col: 0
    width: 24
    height: 8
  filters:
  - name: Session Start Date
    title: Session Start Date
    type: field_filter
    default_value: 2025/01/01
    allow_multiple_values: true
    required: false
    ui_config:
      type: day_picker
      display: inline
      options: []
    explore: dfcx_session_metadata
    listens_to_filters: []
    field: dfcx_session_metadata.session_start_date
  - name: Session ID
    title: Session ID
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: true
    ui_config:
      type: advanced
      display: popover
    explore: dfcx_session_metadata
    listens_to_filters: [Session Start Date, Agent Name]
    field: dfcx_session_metadata.session_id
  - name: Agent Name
    title: Agent Name
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
    explore: dfcx_session_metadata
    listens_to_filters: [Session Start Date, Session ID]
    field: dfcx_session_metadata.agent_name
  - name: Session Parameter Path
    title: Session Parameter Path
    type: field_filter
    default_value: "$"
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
      options: []
    explore: dfcx_session_metadata
    listens_to_filters: []
    field: dfcx_transcript.session_parameter_path
  - name: Auth User
    title: Auth User
    type: field_filter
    default_value: '0'
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: overflow
      options: []
    explore: dfcx_session_metadata
    listens_to_filters: []
    field: dfcx_session_metadata.auth_user
