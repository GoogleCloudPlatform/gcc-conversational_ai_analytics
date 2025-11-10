- dashboard: tools__session_lookup
  title: Tools - Session Lookup
  layout: newspaper
  preferred_viewer: dashboards-next
  description: ''
  preferred_slug: zGmvLe0ailPKYWpeylQHhr
  elements:
  - title: Session Lookup
    name: Session Lookup
    #model:: billTest
    explore: dfcx_session_metadata
    type: looker_grid
    fields: [dfcx_session_metadata.session_id,dfcx_session_metadata.session_start_date]
    filters: {}
    sorts: [dfcx_session_metadata.session_id]
    limit: 500
    column_limit: 50
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: true
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
    truncate_header: false
    minimum_column_width: 75
    defaults_version: 1
    listen:
      Session Start Date: dfcx_session_metadata.session_start_date
      Auth User: dfcx_session_metadata.auth_user
      Session ID: dfcx_session_metadata.session_id
      Agent Name: dfcx_session_metadata.agent_name
    row: 0
    col: 0
    width: 24
    height: 10
  filters:
  - name: Session Start Date
    title: Session Start Date
    type: field_filter
    default_value: 7 day
    allow_multiple_values: true
    required: false
    ui_config:
      type: relative_timeframes
      display: inline
      options: []
    #model:: billTest
    explore: dfcx_session_metadata
    listens_to_filters: []
    field: dfcx_session_metadata.session_start_date
  - name: Session ID
    title: Session ID
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
    #model:: billTest
    explore: dfcx_session_metadata
    listens_to_filters: [Session Start Date, Agent Name]
    field: dfcx_session_metadata.session_id
  - name: Auth User
    title: Auth User
    type: field_filter
    default_value: '1'
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: overflow
      options:
      - '1'
    #model:: billTest
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
    listens_to_filters: [Session Start Date]
    field: dfcx_session_metadata.agent_name