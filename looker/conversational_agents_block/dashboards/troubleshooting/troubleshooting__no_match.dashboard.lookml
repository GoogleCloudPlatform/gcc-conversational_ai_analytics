- dashboard: troubleshooting__no_match
  title: Troubleshooting - No Match
  layout: newspaper
  preferred_viewer: dashboards-next
  description: ''
  preferred_slug: 05mVvTHZVqMSaI43On1w2c
  elements:
  - title: No Match Page Details
    name: No Match Page Details
    #model: billTest
    explore: dfcx_session_metadata
    type: looker_grid
    fields: [dfcx_transcript.source_flow_display_name, dfcx_transcript.source_page_display_name,
      dfcx_transcript.total_turns, dfcx_transcript.total_no_match_utterances, dfcx_transcript.no_match_percentage]
    filters: {}
    sorts: [dfcx_transcript.total_no_match_utterances desc]
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
      dfcx_transcript.no_match_percentage: 70
      dfcx_transcript.total_no_match_utterances: 70
    series_cell_visualizations:
      dfcx_transcript.no_match_percentage:
        is_active: false
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
    listen:
      Auth User: dfcx_session_metadata.auth_user
      Source Flow Display Name: dfcx_transcript.source_flow_display_name
      Source Page Display Name: dfcx_transcript.source_page_display_name
      Flow Display Name: dfcx_transcript.flow_display_name
      Session Start Date: dfcx_session_metadata.session_start_date
      Page Display Name: dfcx_transcript.page_display_name
      Agent Name: dfcx_session_metadata.agent_name
    row: 5
    col: 0
    width: 12
    height: 6
  - title: Daily No Match Rate
    name: Daily No Match Rate
    #model: billTest
    explore: dfcx_session_metadata
    type: looker_line
    fields: [dfcx_transcript.no_match_percentage, dfcx_session_metadata.session_start_date]
    fill_fields: [dfcx_session_metadata.session_start_date]
    filters: {}
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
    y_axes: [{label: '', orientation: left, series: [{axisId: dfcx_transcript.no_match_percentage,
            id: 2024-03-26 - dfcx_transcript.no_match_percentage, name: '2024-03-26'},
          {axisId: dfcx_transcript.no_match_percentage, id: 2024-03-27 - dfcx_transcript.no_match_percentage,
            name: '2024-03-27'}, {axisId: dfcx_transcript.no_match_percentage, id: 2024-03-28
              - dfcx_transcript.no_match_percentage, name: '2024-03-28'}, {axisId: dfcx_transcript.no_match_percentage,
            id: 2024-03-29 - dfcx_transcript.no_match_percentage, name: '2024-03-29'},
          {axisId: dfcx_transcript.no_match_percentage, id: 2024-03-30 - dfcx_transcript.no_match_percentage,
            name: '2024-03-30'}, {axisId: dfcx_transcript.no_match_percentage, id: 2024-03-31
              - dfcx_transcript.no_match_percentage, name: '2024-03-31'}, {axisId: dfcx_transcript.no_match_percentage,
            id: 2024-04-01 - dfcx_transcript.no_match_percentage, name: '2024-04-01'},
          {axisId: dfcx_transcript.no_match_percentage, id: 2024-04-02 - dfcx_transcript.no_match_percentage,
            name: '2024-04-02'}, {axisId: dfcx_transcript.no_match_percentage, id: 2024-04-03
              - dfcx_transcript.no_match_percentage, name: '2024-04-03'}, {axisId: dfcx_transcript.no_match_percentage,
            id: 2024-04-04 - dfcx_transcript.no_match_percentage, name: '2024-04-04'},
          {axisId: dfcx_transcript.no_match_percentage, id: 2024-04-05 - dfcx_transcript.no_match_percentage,
            name: '2024-04-05'}, {axisId: dfcx_transcript.no_match_percentage, id: 2024-04-06
              - dfcx_transcript.no_match_percentage, name: '2024-04-06'}, {axisId: dfcx_transcript.no_match_percentage,
            id: 2024-04-07 - dfcx_transcript.no_match_percentage, name: '2024-04-07'},
          {axisId: dfcx_transcript.no_match_percentage, id: 2024-04-08 - dfcx_transcript.no_match_percentage,
            name: '2024-04-08'}, {axisId: dfcx_transcript.no_match_percentage, id: 2024-04-09
              - dfcx_transcript.no_match_percentage, name: '2024-04-09'}, {axisId: dfcx_transcript.no_match_percentage,
            id: 2024-04-10 - dfcx_transcript.no_match_percentage, name: '2024-04-10'},
          {axisId: dfcx_transcript.no_match_percentage, id: 2024-04-11 - dfcx_transcript.no_match_percentage,
            name: '2024-04-11'}, {axisId: dfcx_transcript.no_match_percentage, id: 2024-04-12
              - dfcx_transcript.no_match_percentage, name: '2024-04-12'}, {axisId: dfcx_transcript.no_match_percentage,
            id: 2024-04-13 - dfcx_transcript.no_match_percentage, name: '2024-04-13'},
          {axisId: dfcx_transcript.no_match_percentage, id: 2024-04-14 - dfcx_transcript.no_match_percentage,
            name: '2024-04-14'}, {axisId: dfcx_transcript.no_match_percentage, id: 2024-04-15
              - dfcx_transcript.no_match_percentage, name: '2024-04-15'}, {axisId: dfcx_transcript.no_match_percentage,
            id: 2024-04-16 - dfcx_transcript.no_match_percentage, name: '2024-04-16'},
          {axisId: dfcx_transcript.no_match_percentage, id: 2024-04-17 - dfcx_transcript.no_match_percentage,
            name: '2024-04-17'}, {axisId: dfcx_transcript.no_match_percentage, id: 2024-04-18
              - dfcx_transcript.no_match_percentage, name: '2024-04-18'}, {axisId: dfcx_transcript.no_match_percentage,
            id: 2024-04-19 - dfcx_transcript.no_match_percentage, name: '2024-04-19'},
          {axisId: dfcx_transcript.no_match_percentage, id: 2024-04-20 - dfcx_transcript.no_match_percentage,
            name: '2024-04-20'}, {axisId: dfcx_transcript.no_match_percentage, id: 2024-04-21
              - dfcx_transcript.no_match_percentage, name: '2024-04-21'}, {axisId: dfcx_transcript.no_match_percentage,
            id: 2024-04-22 - dfcx_transcript.no_match_percentage, name: '2024-04-22'},
          {axisId: dfcx_transcript.no_match_percentage, id: 2024-04-23 - dfcx_transcript.no_match_percentage,
            name: '2024-04-23'}, {axisId: dfcx_transcript.no_match_percentage, id: 2024-04-24
              - dfcx_transcript.no_match_percentage, name: '2024-04-24'}], showLabels: true,
        showValues: true, unpinAxis: false, tickDensity: custom, tickDensityCustom: 18,
        type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    hidden_series: []
    reference_lines: []
    trend_lines: []
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    hidden_pivots: {}
    listen:
      Session Start Date: dfcx_session_metadata.session_start_date
      Page Display Name: dfcx_transcript.page_display_name
      Agent Name: dfcx_session_metadata.agent_name
    row: 0
    col: 0
    width: 24
    height: 5
  - title: Common No Match User Utterances
    name: Common No Match User Utterances
    #model: billTest
    explore: dfcx_session_metadata
    type: looker_grid
    fields: [dfcx_transcript.source_flow_display_name, dfcx_transcript.source_page_display_name,
      dfcx_transcript.total_turns, dfcx_transcript.user_utterance]
    filters:
      dfcx_transcript.match_type: '"NO_MATCH"'
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
      dfcx_transcript.total_turns: 70
    series_cell_visualizations:
      dfcx_transcript.no_match_percentage:
        is_active: false
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
      Flow Display Name: dfcx_transcript.flow_display_name
      Session Start Date: dfcx_session_metadata.session_start_date
      Page Display Name: dfcx_transcript.page_display_name
      Agent Name: dfcx_session_metadata.agent_name
    row: 5
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
      type: dropdown_menu
      display: inline
    #model: billTest
    explore: dfcx_session_metadata
    listens_to_filters: [Session Start Date,  Source Page Display Name, Flow Display Name, Page Display Name, Agent Name]
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
    listens_to_filters: [Session Start Date,  Source Flow Display Name, Flow Display Name, Page Display Name, Agent Name]
    field: dfcx_transcript.source_page_display_name
  - name: Flow Display Name
    title: Flow Display Name
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: dropdown_menu
      display: inline
    #model: billTest
    explore: dfcx_session_metadata
    listens_to_filters: [Session Start Date,  Source Flow Display Name, Source Page Display Name, Page Display Name, Agent Name]
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
    listens_to_filters: [Session Start Date,  Source Flow Display Name, Source Page Display Name, Flow Display Name, Agent Name]
    field: dfcx_transcript.page_display_name
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
    listens_to_filters: [Session Start Date,  Source Flow Display Name, Source Page Display Name, Flow Display Name, Page Display Name]
    field: dfcx_session_metadata.agent_name