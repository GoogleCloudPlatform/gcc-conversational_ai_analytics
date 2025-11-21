- dashboard: qa__dfcx_test_cases_results
  title: QA - DFCX Test Cases
  layout: newspaper
  preferred_viewer: dashboards-next
  description: ''
  preferred_slug: Ubxf5GtTWR1UJoYYgHiGsY
  elements:
  - title: Daily Average Test Pass Rate by Agent
    name: Daily Average Test Pass Rate by Agent

    explore: dfcx_test_runs_results
    type: looker_line
    fields: [dfcx_test_runs_results.test_run_date, dfcx_test_runs_results.average_test_pass_rate,
      dfcx_test_runs_results.agent_display_name]
    pivots: [dfcx_test_runs_results.agent_display_name]
    sorts: [dfcx_test_runs_results.agent_display_name, dfcx_test_runs_results.test_run_date desc]
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
    trellis: pivot
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
    x_axis_zoom: true
    y_axis_zoom: true
    hidden_pivots: {}
    defaults_version: 1
    listen:
      Test Run Date: dfcx_test_runs_results.test_run_date
      Agent Display Name: dfcx_test_runs_results.agent_display_name
      Start Flow: dfcx_test_cases_results.start_flow
      Test Run Filter: dfcx_test_runs_results.test_run_filter
    row: 0
    col: 0
    width: 24
    height: 9
  - name: ''
    type: text
    title_text: ''
    subtitle_text: ''
    body_text: '[{"type":"h1","children":[{"text":"Individual Test Case Results"}],"align":"center"}]'
    rich_content_json: '{"format":"slate"}'
    row: 9
    col: 0
    width: 24
    height: 2
  - title: Test Pass Rates by Start Flow
    name: Test Pass Rates by Start Flow

    explore: dfcx_test_runs_results
    type: looker_column
    fields: [dfcx_test_cases_results.start_flow, dfcx_test_cases_results.test_pass_rate]
    sorts: [dfcx_test_cases_results.test_pass_rate desc 0]
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
    trellis: pivot
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
    show_row_numbers: true
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
    truncate_header: false
    minimum_column_width: 75
    series_cell_visualizations:
      dfcx_test_cases_results.total_test_cases:
        is_active: false
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: "#1A73E8",
        font_color: !!null '', color_application: {collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2,
          palette_id: 4a00499b-c0fe-4b15-a304-4083c07ff4c4, options: {constraints: {
              min: {type: minimum}, mid: {type: number, value: 0}, max: {type: maximum}},
            mirror: true, reverse: false, stepped: false}}, bold: false, italic: false,
        strikethrough: false, fields: []}]
    x_axis_zoom: true
    y_axis_zoom: true
    show_null_points: true
    interpolation: linear
    hidden_pivots: {}
    defaults_version: 1
    listen:
      Agent Display Name: dfcx_test_runs_results.agent_display_name
      Start Flow: dfcx_test_cases_results.start_flow
      Test Run Filter: dfcx_test_runs_results.test_run_filter
    row: 11
    col: 0
    width: 12
    height: 9
  - title: Test Pass Rates by Tag
    name: Test Pass Rates by Tag
    explore: dfcx_test_runs_results
    type: looker_column
    fields: [dfcx_test_cases_results.test_pass_rate, dfcx_test_cases_results__tags.dfcx_test_cases_results__tag]
    sorts: [dfcx_test_cases_results.test_pass_rate desc 0]
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
    trellis: pivot
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
    show_row_numbers: true
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
    truncate_header: false
    minimum_column_width: 75
    series_cell_visualizations:
      dfcx_test_cases_results.total_test_cases:
        is_active: false
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: "#1A73E8",
        font_color: !!null '', color_application: {collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2,
          palette_id: 4a00499b-c0fe-4b15-a304-4083c07ff4c4, options: {constraints: {
              min: {type: minimum}, mid: {type: number, value: 0}, max: {type: maximum}},
            mirror: true, reverse: false, stepped: false}}, bold: false, italic: false,
        strikethrough: false, fields: []}]
    x_axis_zoom: true
    y_axis_zoom: true
    show_null_points: true
    interpolation: linear
    hidden_pivots: {}
    defaults_version: 1
    listen:
      Agent Display Name: dfcx_test_runs_results.agent_display_name
      Start Flow: dfcx_test_cases_results.start_flow
      Test Run Filter: dfcx_test_runs_results.test_run_filter
    row: 11
    col: 12
    width: 12
    height: 9
  filters:
  - name: Test Run Date
    title: Test Run Date
    type: field_filter
    default_value: 7 day
    allow_multiple_values: true
    required: false
    ui_config:
      type: relative_timeframes
      display: inline
      options: []

    explore: dfcx_test_runs_results
    listens_to_filters: []
    field: dfcx_test_runs_results.test_run_date
  - name: Agent Display Name
    title: Agent Display Name
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover

    explore: dfcx_test_runs_results
    listens_to_filters: [Test Run Date, Test Run Filter, Start Flow]
    field: dfcx_test_runs_results.agent_display_name
  - name: Test Run Filter
    title: Test Run Filter
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover

    explore: dfcx_test_runs_results
    listens_to_filters: []
    field: dfcx_test_runs_results.test_run_filter
  - name: Start Flow
    title: Start Flow
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover

    explore: dfcx_test_runs_results
    listens_to_filters: [Test Run Date, Agent Display Name, Test Run Filter]
    field: dfcx_test_cases_results.start_flow
