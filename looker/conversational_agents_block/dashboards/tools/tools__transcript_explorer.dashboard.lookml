- dashboard: tools__transcript_explorer
  title: Tools - Transcript Explorer
  layout: newspaper
  preferred_viewer: dashboards-next
  crossfilter_enabled: true
  description: ''
  preferred_slug: 87myHlvvS06EVwS90OGMJE
  elements:
  - title: Webhooks
    name: Webhooks
    #model: DCA_PRD_1
    explore: dfcx_session_metadata
    type: looker_grid
    fields: [dfcx_session_metadata.session_id, dfcx_transcript.position, dfcx_transcript__webhooks.step,
      dfcx_transcript__webhooks.webhook_display_name, dfcx_transcript__webhooks.webhook_status,
      dfcx_transcript__webhooks.webhook_latency_ms]
    filters:
      dfcx_transcript__webhooks.webhook_display_name: "-NULL"
    sorts: [dfcx_session_metadata.session_id, dfcx_transcript.position, dfcx_transcript__webhooks.step]
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
      dfcx_transcript__webhooks.step: 40
    hidden_fields: [dfcx_session_metadata.session_id]
    defaults_version: 1
    listen:
      Session Start Date: dfcx_session_metadata.session_start_date
      Session ID: dfcx_session_metadata.session_id
      Auth User: dfcx_session_metadata.auth_user
      Agent Name: dfcx_session_metadata.agent_name
    row: 15
    col: 15
    width: 9
    height: 5
  - title: Session Parameter at End of Turn
    name: Session Parameter at End of Turn
    #model: DCA_PRD_1
    explore: dfcx_session_metadata
    type: looker_grid
    fields: [dfcx_session_metadata.session_id, dfcx_transcript.position, dfcx_transcript.session_parameters]
    filters: {}
    sorts: [dfcx_session_metadata.session_id, dfcx_transcript.position]
    limit: 500
    column_limit: 50
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: false
    hide_totals: false
    hide_row_totals: false
    size_to_fit: false
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
      dfcx_transcript.session_parameter__vva_milestone: 100
      dfcx_transcript.session_parameter__ccaip_vva_intent: 100
      dfcx_transcript.session_parameter__tags_string: 100
      dfcx_transcript.session_parameter__channel: 100
      dfcx_transcript.session_parameter__subchannel: 100
      dfcx_transcript.session_parameter__channel_type: 100
      dfcx_transcript.session_parameter__is_api_fail: 100
      dfcx_transcript.session_parameter__is_customer_authenticated: 100
      dfcx_transcript.session_parameter__is_info_bot_flow: 100
      dfcx_transcript.session_parameter__is_sidecar_enabled: 100
      dfcx_transcript.session_parameter__is_user_pah: 100
    hidden_fields: [dfcx_session_metadata.session_id]
    defaults_version: 1
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    note_state: collapsed
    column_order: [dfcx_transcript.position, dfcx_transcript.session_parameter__ccaip_vva_intent,
      dfcx_transcript.session_parameter__vva_milestone, dfcx_transcript.session_parameter__tags_string,
      dfcx_transcript.session_parameter__channel, dfcx_transcript.session_parameter__subchannel,
      dfcx_transcript.session_parameter__channel_type, dfcx_transcript.session_parameter__is_api_fail,
      dfcx_transcript.session_parameter__is_customer_authenticated, dfcx_transcript.session_parameter__is_info_bot_flow,
      dfcx_transcript.session_parameter__is_sidecar_enabled, dfcx_transcript.session_parameter__is_user_pah]
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
    listen:
      Session Start Date: dfcx_session_metadata.session_start_date
      Session ID: dfcx_session_metadata.session_id
      Auth User: dfcx_session_metadata.auth_user
      Agent Name: dfcx_session_metadata.agent_name
    row: 20
    col: 15
    width: 9
    height: 4
  - title: Execution Sequence
    name: Execution Sequence
    #model: DCA_PRD_1
    explore: dfcx_session_metadata
    type: looker_grid
    fields: [dfcx_session_metadata.session_id, dfcx_transcript.position, dfcx_transcript__execution_sequence.step,
      dfcx_transcript__execution_sequence.flow_display_name, dfcx_transcript__execution_sequence.page_display_name,
      dfcx_transcript__execution_sequence.status, dfcx_transcript__execution_sequence.triggered_condition,
      dfcx_transcript__execution_sequence.triggered_intent, dfcx_transcript__execution_sequence.triggered_transition_route_id]
    sorts: [dfcx_session_metadata.session_id, dfcx_transcript.position, dfcx_transcript__execution_sequence.step]
    limit: 500
    column_limit: 50
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: false
    hide_totals: false
    hide_row_totals: false
    size_to_fit: false
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
      dfcx_transcript__execution_sequence.step: 40
      dfcx_transcript__execution_sequence.page_display_name: 150
      dfcx_transcript__execution_sequence.triggered_transition_route_id: 150
      dfcx_transcript__execution_sequence.status: 150
    hidden_fields: [dfcx_session_metadata.session_id]
    defaults_version: 1
    listen:
      Session Start Date: dfcx_session_metadata.session_start_date
      Session ID: dfcx_session_metadata.session_id
      Auth User: dfcx_session_metadata.auth_user
      Agent Name: dfcx_session_metadata.agent_name
    row: 11
    col: 0
    width: 15
    height: 7
  - title: Transcript
    name: Transcript
    #model: DCA_PRD_1
    explore: dfcx_session_metadata
    type: looker_grid
    fields: [dfcx_session_metadata.session_id, dfcx_transcript.position, dfcx_transcript.optional_dtmf_digits,
      dfcx_transcript.user_utterance, dfcx_transcript.agent_response,dfcx_transcript_metadata.contain_any_ai_generated_content]
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
      dfcx_transcript.optional_dtmf_digits: 60
      dfcx_transcript_metadata.contain_any_ai_generated_content: 60
    hidden_fields: [dfcx_session_metadata.session_id]
    defaults_version: 1
    title_hidden: true
    listen:
      Session Start Date: dfcx_session_metadata.session_start_date
      Session ID: dfcx_session_metadata.session_id
      Auth User: dfcx_session_metadata.auth_user
      Agent Name: dfcx_session_metadata.agent_name
    row: 3
    col: 0
    width: 15
    height: 8
  - title: Alternative Intents
    name: Alternative Intents
    #model: DCA_PRD_1
    explore: dfcx_session_metadata
    type: looker_grid
    fields: [dfcx_session_metadata.session_id, dfcx_transcript.position, dfcx_transcript__alternative_matched_intents.alternative_matched_intent,
      dfcx_transcript__alternative_matched_intents.score]
    filters:
      dfcx_transcript__alternative_matched_intents.alternative_matched_intent: "-NULL"
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
    series_column_widths:
      dfcx_transcript.position: 75
    hidden_fields: [dfcx_session_metadata.session_id]
    defaults_version: 1
    listen:
      Session Start Date: dfcx_session_metadata.session_start_date
      Session ID: dfcx_session_metadata.session_id
      Auth User: dfcx_session_metadata.auth_user
      Agent Name: dfcx_session_metadata.agent_name
    row: 11
    col: 15
    width: 9
    height: 4
  - title: Turn Information
    name: Turn Information
    #model: DCA_PRD_1
    explore: dfcx_session_metadata
    type: looker_single_record
    fields: [dfcx_session_metadata.session_id, dfcx_transcript.position, dfcx_transcript.source_flow_display_name,
      dfcx_transcript.source_page_display_name, dfcx_transcript.match_type, dfcx_transcript.intent_display_name,
      dfcx_transcript.flow_display_name, dfcx_transcript.page_display_name]
    filters: {}
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
    listen:
      Session Start Date: dfcx_session_metadata.session_start_date
      Session ID: dfcx_session_metadata.session_id
      Auth User: dfcx_session_metadata.auth_user
      Agent Name: dfcx_session_metadata.agent_name
    row: 3
    col: 15
    width: 9
    height: 8
  - title: Session ID
    name: Session ID
    #model: DCA_PRD_1
    explore: dfcx_session_metadata
    type: single_value
    fields: [dfcx_session_metadata.session_id]
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
    listen:
      Session Start Date: dfcx_session_metadata.session_start_date
      Session ID: dfcx_session_metadata.session_id
      Auth User: dfcx_session_metadata.auth_user
      Agent Name: dfcx_session_metadata.agent_name
    row: 0
    col: 0
    width: 11
    height: 3
  - title: Heuristic Outcome
    name: Heuristic Outcome
    #model: DCA_PRD_1
    explore: dfcx_session_metadata
    type: single_value
    fields: [dfcx_session_metadata.is_escalated]
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
    listen:
      Session Start Date: dfcx_session_metadata.session_start_date
      Session ID: dfcx_session_metadata.session_id
      Auth User: dfcx_session_metadata.auth_user
      Agent Name: dfcx_session_metadata.agent_name
    row: 0
    col: 11
    width: 5
    height: 3
  - title: Total Duration
    name: Total Duration
    #model: DCA_PRD_1
    explore: dfcx_session_metadata
    type: looker_bar
    fields: [dfcx_session_metadata.session_id, dfcx_transcript.total_input_audio_ms,
      dfcx_transcript.total_output_audio_ms, dfcx_transcript__execution_sequence.total_webhook_latency_ms,
      dfcx_transcript__execution_sequence.total_step_processing_ms,dfcx_transcript.total_llm_latency_ms]
    sorts: [dfcx_session_metadata.session_id]
    limit: 500
    column_limit: 50
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
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    note_state: collapsed
    note_display: hover
    note_text: Estimated durations of input audio, output audio, webhook latency,
      and DFCX processing
    listen:
      Session Start Date: dfcx_session_metadata.session_start_date
      Session ID: dfcx_session_metadata.session_id
      Auth User: dfcx_session_metadata.auth_user
      Agent Name: dfcx_session_metadata.agent_name
    row: 0
    col: 16
    width: 8
    height: 3
  - title: Generative Actions
    name: Generative Actions
    #model: DCA_PRD_1
    explore: dfcx_session_metadata
    type: looker_grid
    fields: [dfcx_session_metadata.session_id, dfcx_transcript.position, dfcx_transcript__actions.action_step,
      dfcx_transcript__actions.action, dfcx_transcript__actions.action_name, dfcx_transcript__actions.action_input_string,
      dfcx_transcript__actions.action_output_string]
    sorts: [dfcx_session_metadata.session_id, dfcx_transcript.position, dfcx_transcript__actions.action_step]
    limit: 500
    column_limit: 50
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: false
    hide_totals: false
    hide_row_totals: false
    size_to_fit: false
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
    listen:
      Session Start Date: dfcx_session_metadata.session_start_date
      Session ID: dfcx_session_metadata.session_id
      Auth User: dfcx_session_metadata.auth_user
      Agent Name: dfcx_session_metadata.agent_name
    row: 18
    col: 0
    width: 15
    height: 6
  filters:
  - name: Session Start Date
    title: Session Start Date
    type: field_filter
    default_value: 2024/05/13
    allow_multiple_values: true
    required: false
    ui_config:
      type: day_picker
      display: inline
      options: []
    #model: DCA_PRD_1
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
    #model: DCA_PRD_1
    explore: dfcx_session_metadata
    listens_to_filters: [Session Start Date, Agent Name]
    field: dfcx_session_metadata.session_id
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
    #model: DCA_PRD_1
    explore: dfcx_session_metadata
    listens_to_filters: []
    field: dfcx_session_metadata.auth_user
  - name: Agent Name
    title: Agent Name
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
    #model: DCA_PRD_1
    explore: dfcx_session_metadata
    listens_to_filters: [Session Start Date, Session ID]
    field: dfcx_session_metadata.agent_name
