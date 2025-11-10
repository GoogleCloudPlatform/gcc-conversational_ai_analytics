- dashboard: troubleshooting__page_performance
  title: Troubleshooting - Page Performance
  layout: newspaper
  preferred_viewer: dashboards-next
  description: ''
  preferred_slug: iF5rqXJUeByuXFAPl5tN3W
  elements:
  - title: Page Performance Overview
    name: Page Performance Overview
    #model: billTest
    explore: dfcx_session_metadata
    type: looker_grid
    fields: [dfcx_transcript.source_flow_display_name, dfcx_transcript.source_page_display_name,
      dfcx_transcript.total_turns, dfcx_transcript.intent_percentage, dfcx_transcript.no_match_percentage,
      dfcx_transcript.no_input_percentage, dfcx_transcript.parameter_filling_percentage,
      dfcx_transcript.knowledge_connector_percentage, dfcx_transcript.event_percentage,
      dfcx_transcript.yes_percentage, dfcx_transcript.no_percentage, dfcx_transcript.thanks_percentage,
      dfcx_transcript.request_agent_percentage, dfcx_transcript.no_agent_response_rate]
    filters: {}
    sorts: [dfcx_transcript.total_turns desc]
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
    enable_conditional_formatting: true
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    truncate_header: true
    minimum_column_width: 50
    series_column_widths:
      dfcx_transcript.total_turns: 90
      dfcx_transcript.no_match_percentage: 90
      dfcx_transcript.intent_percentage: 90
      dfcx_transcript.parameter_filling_percentage: 90
      dfcx_transcript.event_percentage: 90
      dfcx_transcript.yes_percentage: 90
      dfcx_transcript.no_input_percentage: 90
      dfcx_transcript.no_percentage: 90
      dfcx_transcript.request_agent_percentage: 90
      dfcx_transcript.no_agent_response_rate: 90
      dfcx_transcript.thanks_percentage: 90
      dfcx_transcript.knowledge_connector_percentage: 90
      dfcx_transcript.source_page_display_name: 171
      dfcx_transcript.source_flow_display_name: 133
    series_cell_visualizations:
      dfcx_transcript.no_match_percentage:
        is_active: false
    conditional_formatting: [{type: greater than, value: 0.2, background_color: '',
        font_color: "#EA4335", color_application: {collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2,
          palette_id: 56d0c358-10a0-4fd6-aa0b-b117bef527ab, options: {steps: 5, constraints: {
              min: {type: minimum}, mid: {type: number, value: 0}, max: {type: maximum}},
            mirror: false, reverse: false, stepped: false}}, bold: true, italic: false,
        strikethrough: false, fields: [dfcx_transcript.no_match_percentage, dfcx_transcript.no_input_percentage,
          dfcx_transcript.request_agent_percentage]}, {type: greater than, value: 0.01,
        background_color: '', font_color: "#EA4335", color_application: {collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2,
          palette_id: 4a00499b-c0fe-4b15-a304-4083c07ff4c4, options: {constraints: {
              min: {type: minimum}, mid: {type: number, value: 0}, max: {type: maximum}},
            mirror: true, reverse: false, stepped: false}}, bold: true, italic: false,
        strikethrough: false, fields: [dfcx_transcript.no_agent_response_rate]}]
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    hidden_pivots: {}
    listen:
      Auth User: dfcx_session_metadata.auth_user
      Source Flow Display Name: dfcx_transcript.source_flow_display_name
      Source Page Display Name: dfcx_transcript.source_page_display_name
      Session Start Date: dfcx_session_metadata.session_start_date
      Agent Name: dfcx_session_metadata.agent_name
    row: 0
    col: 0
    width: 24
    height: 9
  - title: Page Performance by Date
    name: Page Performance by Date
    #model: billTest
    explore: dfcx_session_metadata
    type: looker_line
    fields: [dfcx_transcript.total_turns, dfcx_transcript.intent_percentage, dfcx_transcript.no_match_percentage,
      dfcx_transcript.no_input_percentage, dfcx_transcript.parameter_filling_percentage,
      dfcx_transcript.knowledge_connector_percentage, dfcx_transcript.event_percentage,
      dfcx_transcript.yes_percentage, dfcx_transcript.no_percentage, dfcx_transcript.thanks_percentage,
      dfcx_transcript.request_agent_percentage, dfcx_transcript.no_agent_response_rate,
      dfcx_session_metadata.session_start_date]
    fill_fields: [dfcx_session_metadata.session_start_date]
    filters: {}
    sorts: [dfcx_transcript.total_turns desc]
    limit: 500
    column_limit: 50
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    y_axes: [{label: '', orientation: left, series: [{axisId: dfcx_transcript.intent_percentage,
            id: dfcx_transcript.intent_percentage, name: Intent %}, {axisId: dfcx_transcript.no_match_percentage,
            id: dfcx_transcript.no_match_percentage, name: No Match %}, {axisId: dfcx_transcript.no_input_percentage,
            id: dfcx_transcript.no_input_percentage, name: No Input %}, {axisId: dfcx_transcript.parameter_filling_percentage,
            id: dfcx_transcript.parameter_filling_percentage, name: Parameter Filling
              %}, {axisId: dfcx_transcript.knowledge_connector_percentage, id: dfcx_transcript.knowledge_connector_percentage,
            name: Knowledge Connector %}, {axisId: dfcx_transcript.event_percentage,
            id: dfcx_transcript.event_percentage, name: Event %}, {axisId: dfcx_transcript.yes_percentage,
            id: dfcx_transcript.yes_percentage, name: Yes %}, {axisId: dfcx_transcript.no_percentage,
            id: dfcx_transcript.no_percentage, name: No %}, {axisId: dfcx_transcript.thanks_percentage,
            id: dfcx_transcript.thanks_percentage, name: Thanks %}, {axisId: dfcx_transcript.request_agent_percentage,
            id: dfcx_transcript.request_agent_percentage, name: Request Agent %},
          {axisId: dfcx_transcript.no_agent_response_rate, id: dfcx_transcript.no_agent_response_rate,
            name: No Agent Response %}], showLabels: true, showValues: true, unpinAxis: false,
        tickDensity: default, tickDensityCustom: 5, type: linear}, {label: !!null '',
        orientation: right, series: [{axisId: dfcx_transcript.total_turns, id: dfcx_transcript.total_turns,
            name: Total Turns}], showLabels: true, showValues: true, unpinAxis: false,
        tickDensity: default, tickDensityCustom: 5, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    show_row_numbers: false
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
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
    minimum_column_width: 50
    series_column_widths:
      dfcx_transcript.total_turns: 90
      dfcx_transcript.no_match_percentage: 90
      dfcx_transcript.intent_percentage: 90
      dfcx_transcript.parameter_filling_percentage: 90
      dfcx_transcript.event_percentage: 90
      dfcx_transcript.yes_percentage: 90
      dfcx_transcript.no_input_percentage: 90
      dfcx_transcript.no_percentage: 90
      dfcx_transcript.request_agent_percentage: 90
      dfcx_transcript.no_agent_response_rate: 90
      dfcx_transcript.thanks_percentage: 90
      dfcx_transcript.knowledge_connector_percentage: 90
    series_cell_visualizations:
      dfcx_transcript.no_match_percentage:
        is_active: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    hidden_pivots: {}
    listen:
      Auth User: dfcx_session_metadata.auth_user
      Source Flow Display Name: dfcx_transcript.source_flow_display_name
      Source Page Display Name: dfcx_transcript.source_page_display_name
      Session Start Date: dfcx_session_metadata.session_start_date
      Agent Name: dfcx_session_metadata.agent_name
    row: 9
    col: 0
    width: 24
    height: 9
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
    #model: billTest
    explore: dfcx_session_metadata
    listens_to_filters: []
    field: dfcx_session_metadata.session_start_date
  - name: Source Flow Display Name
    title: Source Flow Display Name
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: dropdown_menu
      display: inline
    #model: billTest
    explore: dfcx_session_metadata
    listens_to_filters: [Session Start Date, Source Flow Display Name, Agent Name]
    field: dfcx_transcript.source_flow_display_name
  - name: Source Page Display Name
    title: Source Page Display Name
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: dropdown_menu
      display: inline
    #model: billTest
    explore: dfcx_session_metadata
    listens_to_filters: [Session Start Date, Source Flow Display Name, Agent Name]
    field: dfcx_transcript.source_page_display_name
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
    #model: billTest
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
    listens_to_filters: [Session Start Date, Source Flow Display Name, Source Page Display Name]
    field: dfcx_session_metadata.agent_name