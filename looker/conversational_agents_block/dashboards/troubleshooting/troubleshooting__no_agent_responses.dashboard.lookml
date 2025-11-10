- dashboard: troubleshooting__no_agent_responses
  title: Troubleshooting - No Agent Responses
  layout: newspaper
  preferred_viewer: dashboards-next
  description: ''
  preferred_slug: nOSso6AcHNcXaFfjtI9HyW
  elements:
  - title: No Agent Response Rate
    name: No Agent Response Rate
    #model: billTest
    explore: dfcx_session_metadata
    type: looker_line
    fields: [dfcx_transcript.no_agent_response_rate, dfcx_transcript.total_no_agent_response_turns,
      dfcx_session_metadata.session_start_date]
    fill_fields: [dfcx_session_metadata.session_start_date]
    filters:
      dfcx_transcript.total_turns: ''
    sorts: [dfcx_session_metadata.session_start_date]
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
    y_axes: [{label: '', orientation: left, series: [{axisId: dfcx_transcript.no_agent_response_rate,
            id: dfcx_transcript.no_agent_response_rate, name: No Agent Response %}],
        showLabels: true, showValues: true, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}, {label: !!null '', orientation: right,
        series: [{axisId: dfcx_transcript.total_no_agent_response_turns, id: dfcx_transcript.total_no_agent_response_turns,
            name: Total No Agent Response Turns}], showLabels: true, showValues: true,
        unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear}]
    hidden_series: [dfcx_transcript.total_no_agent_response_turns, dfcx_transcript.total_turns]
    defaults_version: 1
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    listen:
      Session Start Date: dfcx_session_metadata.session_start_date
      Flow Display Name: dfcx_transcript.flow_display_name
      Page Display Name: dfcx_transcript.page_display_name
      Agent Name: dfcx_session_metadata.agent_name
    row: 0
    col: 0
    width: 12
    height: 7
  - title: Pages with No Agent Response
    name: Pages with No Agent Response
    #model: billTest
    explore: dfcx_session_metadata
    type: looker_grid
    fields: [dfcx_transcript.flow_display_name, dfcx_transcript.page_display_name,
      dfcx_transcript.total_no_agent_response_turns]
    filters:
      dfcx_transcript.did_agent_respond: 'No'
    sorts: [dfcx_transcript.total_no_agent_response_turns desc 0]
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
    hidden_series: [dfcx_transcript.total_no_agent_response_turns, dfcx_transcript.total_turns]
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    defaults_version: 1
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    listen:
      Session Start Date: dfcx_session_metadata.session_start_date
      Flow Display Name: dfcx_transcript.flow_display_name
      Page Display Name: dfcx_transcript.page_display_name
      Agent Name: dfcx_session_metadata.agent_name
    row: 0
    col: 12
    width: 12
    height: 7
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
  - name: Flow Display Name
    title: Flow Display Name
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
    #model: billTest
    explore: dfcx_session_metadata
    listens_to_filters: [Session Start Date,Page Display Name, Agent Name]
    field: dfcx_transcript.flow_display_name
  - name: Page Display Name
    title: Page Display Name
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
    #model: billTest
    explore: dfcx_session_metadata
    listens_to_filters: [Session Start Date, Flow Display Name, Agent Name]
    field: dfcx_transcript.page_display_name
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
    listens_to_filters: [Session Start Date, Flow Display Name, Page Display Name]
    field: dfcx_session_metadata.agent_name