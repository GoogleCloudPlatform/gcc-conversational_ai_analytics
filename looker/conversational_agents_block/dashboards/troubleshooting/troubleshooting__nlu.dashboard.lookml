- dashboard: troubleshooting__nlu
  title: Troubleshooting - NLU
  layout: newspaper
  preferred_viewer: dashboards-next
  description: ''
  preferred_slug: 2t4mibwAeQZqOR8ZlGeT1c
  elements:
  - title: Confidence Score Percentiles
    name: Confidence Score Percentiles
    #model: billTest
    explore: dfcx_session_metadata
    type: looker_line
    fields: [dfcx_session_metadata.session_start_date, dfcx_transcript.confidence_score_percentile_05,
      dfcx_transcript.confidence_score_percentile_25, dfcx_transcript.confidence_score_percentile_50,
      dfcx_transcript.confidence_score_percentile_75, dfcx_transcript.confidence_score_percentile_95]
    fill_fields: [dfcx_session_metadata.session_start_date]
    sorts: [dfcx_transcript.confidence_score_percentile_75 desc]
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
    defaults_version: 1
    listen:
      Session Start Date: dfcx_session_metadata.session_start_date
      Intent Display Name: dfcx_transcript.intent_display_name
      Source Flow Display Name: dfcx_transcript.source_flow_display_name
      Source Page Display Name: dfcx_transcript.source_page_display_name
      Agent Name: dfcx_session_metadata.agent_name
    row: 6
    col: 0
    width: 24
    height: 6
  - title: Confidence Score by Intent Box Plots
    name: Confidence Score by Intent Box Plots
    #model: billTest
    explore: dfcx_session_metadata
    type: looker_boxplot
    fields: [dfcx_transcript.intent_display_name, dfcx_transcript.confidence_score_percentile_min,
      dfcx_transcript.confidence_score_percentile_25, dfcx_transcript.confidence_score_percentile_50,
      dfcx_transcript.confidence_score_percentile_75, dfcx_transcript.confidence_score_percentile_max,
      dfcx_transcript.total_turns]
    filters:
      dfcx_transcript.match_type: -EVENT,-"NO_MATCH",-"NO_INPUT",-"KNOWLEDGE_CONNECTOR",-"PARAMETER_FILLING"
    sorts: [dfcx_transcript.total_turns desc]
    limit: 500
    column_limit: 50
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: custom
    y_axis_tick_density_custom: 22
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    x_axis_zoom: true
    y_axis_zoom: true
    show_value_labels: true
    font_size: 12
    defaults_version: 1
    hidden_fields: [dfcx_transcript.total_turns]
    hidden_pivots: {}
    listen:
      Session Start Date: dfcx_session_metadata.session_start_date
      Intent Display Name: dfcx_transcript.intent_display_name
      Source Flow Display Name: dfcx_transcript.source_flow_display_name
      Source Page Display Name: dfcx_transcript.source_page_display_name
      Agent Name: dfcx_session_metadata.agent_name
    row: 12
    col: 0
    width: 24
    height: 9
  - title: User Inputs by Day
    name: User Inputs by Day
    #model: billTest
    explore: dfcx_session_metadata
    type: looker_grid
    fields: [dfcx_transcript.user_utterance, dfcx_transcript.total_turns, dfcx_transcript.confidence_score_percentile_50]
    filters:
      dfcx_transcript.match_type: INTENT,"DIRECT_INTENT"
    sorts: [dfcx_transcript.total_turns desc 0]
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
    truncate_header: true
    minimum_column_width: 75
    series_column_widths:
      dfcx_transcript.total_turns: 70
      dfcx_transcript.confidence_score_percentile_50: 70
    series_cell_visualizations:
      dfcx_transcript.total_turns:
        is_active: false
    defaults_version: 1
    listen:
      Session Start Date: dfcx_session_metadata.session_start_date
      Intent Display Name: dfcx_transcript.intent_display_name
      Source Flow Display Name: dfcx_transcript.source_flow_display_name
      Source Page Display Name: dfcx_transcript.source_page_display_name
      Agent Name: dfcx_session_metadata.agent_name
    row: 27
    col: 0
    width: 12
    height: 6
  - title: No Match/ No Input per Day
    name: No Match/ No Input per Day
    #model: billTest
    explore: dfcx_session_metadata
    type: looker_line
    fields: [dfcx_transcript.no_match_percentage, dfcx_transcript.no_input_percentage,
      dfcx_session_metadata.session_start_date]
    fill_fields: [dfcx_session_metadata.session_start_date]
    filters: {}
    sorts: [dfcx_session_metadata.session_start_date desc]
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
    y_axes: [{label: '', orientation: left, series: [{axisId: dfcx_transcript.no_match_percentage,
            id: dfcx_transcript.no_match_percentage, name: No Match %}, {axisId: dfcx_transcript.no_input_percentage,
            id: dfcx_transcript.no_input_percentage, name: No Input %}], showLabels: true,
        showValues: true, maxValue: 1, minValue: 0, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 18, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    x_axis_datetime_label: "%b"
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    hidden_pivots: {}
    listen:
      Session Start Date: dfcx_session_metadata.session_start_date
      Intent Display Name: dfcx_transcript.intent_display_name
      Source Flow Display Name: dfcx_transcript.source_flow_display_name
      Source Page Display Name: dfcx_transcript.source_page_display_name
      Agent Name: dfcx_session_metadata.agent_name
    row: 0
    col: 0
    width: 24
    height: 6
  - title: Confidence Score Histogram
    name: Confidence Score Histogram
    #model: billTest
    explore: dfcx_session_metadata
    type: looker_column
    fields: [dfcx_transcript.total_turns, intent_confidence_score_bins]
    filters:
      dfcx_transcript.match_type: '"DIRECT_INTENT",INTENT'
    sorts: [intent_confidence_score_bins]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: dimension
      description: ''
      label: Intent Confidence Score Bins
      value_format:
      value_format_name:
      calculation_type: bin
      dimension: intent_confidence_score_bins
      args:
      - dfcx_transcript.intent_confidence_score
      - ".1"
      - '0'
      - '1'
      -
      - classic
      _kind_hint: dimension
      _type_hint: string
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
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    x_axis_label: ''
    defaults_version: 1
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
    show_null_points: true
    interpolation: linear
    listen:
      Session Start Date: dfcx_session_metadata.session_start_date
      Intent Display Name: dfcx_transcript.intent_display_name
      Source Flow Display Name: dfcx_transcript.source_flow_display_name
      Source Page Display Name: dfcx_transcript.source_page_display_name
      Agent Name: dfcx_session_metadata.agent_name
    row: 21
    col: 0
    width: 24
    height: 6
  - title: Alternative Intents Considered
    name: Alternative Intents Considered
    #model: billTest
    explore: dfcx_session_metadata
    type: looker_grid
    fields: [dfcx_transcript.user_utterance, dfcx_transcript.intent_display_name,
      dfcx_transcript.intent_confidence_score, dfcx_transcript__alternative_matched_intents.alternative_matched_intent,
      dfcx_transcript__alternative_matched_intents.score, dfcx_transcript.total_turns]
    filters:
      dfcx_transcript.match_type: INTENT,"DIRECT_INTENT"
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
    minimum_column_width: 75
    series_column_widths:
      dfcx_transcript.intent_confidence_score: 70
      dfcx_transcript__alternative_matched_intents.alternative_matched_intent: 120
      dfcx_transcript__alternative_matched_intents.score: 70
      dfcx_transcript.total_turns: 70
      dfcx_transcript.intent_display_name: 120
    series_cell_visualizations:
      dfcx_transcript.total_turns:
        is_active: false
    defaults_version: 1
    listen:
      Session Start Date: dfcx_session_metadata.session_start_date
      Intent Display Name: dfcx_transcript.intent_display_name
      Source Flow Display Name: dfcx_transcript.source_flow_display_name
      Source Page Display Name: dfcx_transcript.source_page_display_name
      Agent Name: dfcx_session_metadata.agent_name
    row: 27
    col: 12
    width: 12
    height: 6
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
      type: tag_list
      display: popover
    #model: billTest
    explore: dfcx_session_metadata
    listens_to_filters: [Session Start Date, Source Page Display Name, Intent Display Name, Agent Name]
    field: dfcx_transcript.source_flow_display_name
  - name: Source Page Display Name
    title: Source Page Display Name
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
    #model: billTest
    explore: dfcx_session_metadata
    listens_to_filters: [Session Start Date, Source Flow Display Name, Intent Display Name, Agent Name]
    field: dfcx_transcript.source_page_display_name
  - name: Intent Display Name
    title: Intent Display Name
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
    #model: billTest
    explore: dfcx_session_metadata
    listens_to_filters: [Session Start Date, Source Flow Display Name, Source Page Display Name, Agent Name]
    field: dfcx_transcript.intent_display_name
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
    listens_to_filters: [Session Start Date, Source Flow Display Name, Source Page Display Name, Intent Display Name]
    field: dfcx_session_metadata.agent_name