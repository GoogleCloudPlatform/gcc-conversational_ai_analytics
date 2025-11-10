---
- dashboard: troubleshooting__llm_latency
  title: Troubleshooting - LLM Latency
  layout: newspaper
  preferred_viewer: dashboards-next
  description: ''
  preferred_slug: G0keJpP4JPF9RsF86ZLNlr
  elements:
  - title: LLM Latency
    name: LLM Latency
    #model: tmo-ccai-dev
    explore: dfcx_session_metadata
    type: single_value
    fields: [dfcx_transcript.total_turns]
    filters:
      
      dfcx_transcript.contains_playbook_metrics: 'Yes'
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
    custom_color: "#1A73E8"
    single_value_title: Total Turns
    defaults_version: 1
    listen:
      Session Start Date: dfcx_session_metadata.session_start_date
      Project ID: dfcx_session_metadata.project_id
      Agent Name: dfcx_session_metadata.agent_name
    row: 0
    col: 6
    width: 6
    height: 3
  - title: Playbook Failures
    name: Playbook Failures
    #model: tmo-ccai-dev
    explore: dfcx_session_metadata
    type: single_value
    fields: [dfcx_transcript.playbook_failure]
    filters:
      
      dfcx_transcript.contains_playbook_metrics: 'Yes'
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
    color_application:
      collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7
      palette_id: fb7bb53e-b77b-4ab6-8274-9d420d3d73f3
    custom_color: "#cc3d49"
    single_value_title: Playbook Failures
    value_format: ''
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    hidden_pivots: {}
    defaults_version: 1
    listen:
      Session Start Date: dfcx_session_metadata.session_start_date
      Project ID: dfcx_session_metadata.project_id
      Agent Name: dfcx_session_metadata.agent_name
    row: 0
    col: 18
    width: 6
    height: 3
  - title: Playbook Success
    name: Playbook Success
    #model: tmo-ccai-dev
    explore: dfcx_session_metadata
    type: single_value
    fields: [dfcx_transcript.playbook_success]
    filters:
      
      dfcx_transcript.contains_playbook_metrics: 'Yes'
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
    color_application:
      collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7
      palette_id: fb7bb53e-b77b-4ab6-8274-9d420d3d73f3
    custom_color: "#3da12f"
    single_value_title: Playbook Success
    value_format: ''
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    hidden_pivots: {}
    defaults_version: 1
    listen:
      Session Start Date: dfcx_session_metadata.session_start_date
      Project ID: dfcx_session_metadata.project_id
      Agent Name: dfcx_session_metadata.agent_name
    row: 0
    col: 12
    width: 6
    height: 3
  - title: Max Total Latency Ms
    name: Max Total Latency Ms
    #model: tmo-ccai-dev
    explore: dfcx_session_metadata
    type: looker_line
    fields: [dfcx_transcript.max_total_latency_ms, dfcx_session_metadata.session_start_date]
    fill_fields: [dfcx_session_metadata.session_start_date]
    filters:
      
      dfcx_transcript.contains_playbook_metrics: 'Yes'
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
    show_x_axis_label: false
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
    interpolation: monotone
    y_axes: [{label: '', orientation: left, series: [{axisId: dfcx_transcript.max_total_latency_ms,
            id: dfcx_transcript.max_total_latency_ms, name: Max Total Latency Ms}],
        showLabels: false, showValues: true, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    series_types:
      dfcx_transcript.max_total_latency_ms: area
    series_labels:
      dfcx_transcript.max_total_latency_ms: Max Total Latency Ms
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    custom_color: "#1A73E8"
    single_value_title: Max. Total Latency
    value_format: '0.00'
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    show_row_numbers: true
    transpose: false
    truncate_text: true
    truncate_header: false
    size_to_fit: true
    minimum_column_width: 75
    series_cell_visualizations:
      dfcx_transcript.max_total_latency_s:
        is_active: true
    table_theme: white
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    hidden_pivots: {}
    defaults_version: 1
    hide_totals: false
    hide_row_totals: false
    listen:
      Session Start Date: dfcx_session_metadata.session_start_date
      Project ID: dfcx_session_metadata.project_id
      Agent Name: dfcx_session_metadata.agent_name
    row: 6
    col: 8
    width: 4
    height: 3
  - title: Avg Total Latency
    name: Avg Total Latency
    #model: tmo-ccai-dev
    explore: dfcx_session_metadata
    type: looker_line
    fields: [dfcx_transcript.average_total_latency_ms, dfcx_session_metadata.session_start_date]
    fill_fields: [dfcx_session_metadata.session_start_date]
    filters:
      
      dfcx_transcript.contains_playbook_metrics: 'Yes'
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
    show_x_axis_label: false
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
    y_axes: [{label: '', orientation: left, series: [{axisId: dfcx_transcript.average_total_latency_ms,
            id: dfcx_transcript.average_total_latency_ms, name: Average Total Latency
              Ms}], showLabels: false, showValues: true, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    series_types:
      dfcx_transcript.average_total_latency_ms: area
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    custom_color: "#1A73E8"
    single_value_title: Avg. Total Latency
    value_format: '0.00'
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    show_row_numbers: true
    transpose: false
    truncate_text: true
    truncate_header: false
    size_to_fit: true
    minimum_column_width: 75
    series_cell_visualizations:
      dfcx_transcript.max_total_latency_s:
        is_active: true
    table_theme: white
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    hidden_pivots: {}
    defaults_version: 1
    hide_totals: false
    hide_row_totals: false
    listen:
      Session Start Date: dfcx_session_metadata.session_start_date
      Project ID: dfcx_session_metadata.project_id
      Agent Name: dfcx_session_metadata.agent_name
    row: 9
    col: 8
    width: 4
    height: 3
  - title: Min Total Latency
    name: Min Total Latency
    #model: tmo-ccai-dev
    explore: dfcx_session_metadata
    type: looker_line
    fields: [dfcx_transcript.min_total_latency_ms, dfcx_session_metadata.session_start_date]
    fill_fields: [dfcx_session_metadata.session_start_date]
    filters:
      
      dfcx_transcript.contains_playbook_metrics: 'Yes'
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
    show_x_axis_label: false
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
    y_axes: [{label: '', orientation: left, series: [{axisId: dfcx_transcript.min_total_latency_ms,
            id: dfcx_transcript.min_total_latency_ms, name: Min Total Latency Ms}],
        showLabels: false, showValues: true, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    series_types:
      dfcx_transcript.min_total_latency_ms: area
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    custom_color: "#1A73E8"
    single_value_title: Min. Total Latency
    value_format: '0.00'
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    show_row_numbers: true
    transpose: false
    truncate_text: true
    truncate_header: false
    size_to_fit: true
    minimum_column_width: 75
    series_cell_visualizations:
      dfcx_transcript.max_total_latency_s:
        is_active: true
    table_theme: white
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    hidden_pivots: {}
    defaults_version: 1
    hide_totals: false
    hide_row_totals: false
    listen:
      Session Start Date: dfcx_session_metadata.session_start_date
      Project ID: dfcx_session_metadata.project_id
      Agent Name: dfcx_session_metadata.agent_name
    row: 12
    col: 8
    width: 4
    height: 3
  - title: Total Latency
    name: Total Latency
    #model: tmo-ccai-dev
    explore: dfcx_session_metadata
    type: looker_line
    fields: [dfcx_transcript.total_latency_ms, dfcx_session_metadata.session_start_date]
    fill_fields: [dfcx_session_metadata.session_start_date]
    filters:
      
      dfcx_transcript.contains_playbook_metrics: 'Yes'
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
    show_x_axis_label: false
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
    y_axes: [{label: '', orientation: left, series: [{axisId: dfcx_transcript.total_latency_ms,
            id: dfcx_transcript.total_latency_ms, name: Total Latency Ms}], showLabels: false,
        showValues: true, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    series_types:
      dfcx_transcript.total_latency_ms: area
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    custom_color: "#1A73E8"
    single_value_title: Total Latency(ms.)
    value_format: '0.00'
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    show_row_numbers: true
    transpose: false
    truncate_text: true
    truncate_header: false
    size_to_fit: true
    minimum_column_width: 75
    series_cell_visualizations:
      dfcx_transcript.max_total_latency_s:
        is_active: true
    table_theme: white
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    hidden_pivots: {}
    defaults_version: 1
    hide_totals: false
    hide_row_totals: false
    listen:
      Session Start Date: dfcx_session_metadata.session_start_date
      Project ID: dfcx_session_metadata.project_id
      Agent Name: dfcx_session_metadata.agent_name
    row: 3
    col: 8
    width: 4
    height: 3
  - title: Avg LLM Latency
    name: Avg LLM Latency
    #model: tmo-ccai-dev
    explore: dfcx_session_metadata
    type: looker_line
    fields: [dfcx_transcript.average_llm_latency_ms, dfcx_session_metadata.session_start_date]
    fill_fields: [dfcx_session_metadata.session_start_date]
    filters:
      
      dfcx_transcript.contains_playbook_metrics: 'Yes'
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
    show_x_axis_label: false
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
    y_axes: [{label: '', orientation: left, series: [{axisId: dfcx_transcript.average_llm_latency_ms,
            id: dfcx_transcript.average_llm_latency_ms, name: Average Llm Latency
              Ms}], showLabels: false, showValues: true, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    series_types:
      dfcx_transcript.average_llm_latency_ms: area
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    custom_color: "#1A73E8"
    single_value_title: Avg. LLM Latency
    value_format: '0.00'
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    show_row_numbers: true
    transpose: false
    truncate_text: true
    truncate_header: false
    size_to_fit: true
    minimum_column_width: 75
    series_cell_visualizations:
      dfcx_transcript.max_total_latency_s:
        is_active: true
    table_theme: white
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    hidden_pivots: {}
    defaults_version: 1
    hide_totals: false
    hide_row_totals: false
    listen:
      Session Start Date: dfcx_session_metadata.session_start_date
      Project ID: dfcx_session_metadata.project_id
      Agent Name: dfcx_session_metadata.agent_name
    row: 9
    col: 12
    width: 4
    height: 3
  - title: Max LLM Latency
    name: Max LLM Latency
    #model: tmo-ccai-dev
    explore: dfcx_session_metadata
    type: looker_line
    fields: [dfcx_transcript.max_llm_latency_ms, dfcx_session_metadata.session_start_date]
    fill_fields: [dfcx_session_metadata.session_start_date]
    filters:
      
      dfcx_transcript.contains_playbook_metrics: 'Yes'
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
    show_x_axis_label: false
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
    y_axes: [{label: '', orientation: left, series: [{axisId: dfcx_transcript.max_llm_latency_ms,
            id: dfcx_transcript.max_llm_latency_ms, name: Max Llm Latency Ms}], showLabels: false,
        showValues: true, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    series_types:
      dfcx_transcript.max_llm_latency_ms: area
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    custom_color: "#1A73E8"
    single_value_title: Max. LLM Latency
    value_format: '0.00'
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    show_row_numbers: true
    transpose: false
    truncate_text: true
    truncate_header: false
    size_to_fit: true
    minimum_column_width: 75
    series_cell_visualizations:
      dfcx_transcript.max_total_latency_s:
        is_active: true
    table_theme: white
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    hidden_pivots: {}
    defaults_version: 1
    hide_totals: false
    hide_row_totals: false
    listen:
      Session Start Date: dfcx_session_metadata.session_start_date
      Project ID: dfcx_session_metadata.project_id
      Agent Name: dfcx_session_metadata.agent_name
    row: 6
    col: 12
    width: 4
    height: 3
  - title: Min LLM Latency
    name: Min LLM Latency
    #model: tmo-ccai-dev
    explore: dfcx_session_metadata
    type: looker_line
    fields: [dfcx_transcript.min_llm_latency_ms, dfcx_session_metadata.session_start_date]
    fill_fields: [dfcx_session_metadata.session_start_date]
    filters:
      
      dfcx_transcript.contains_playbook_metrics: 'Yes'
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
    show_x_axis_label: false
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
    y_axes: [{label: '', orientation: left, series: [{axisId: dfcx_transcript.min_llm_latency_ms,
            id: dfcx_transcript.min_llm_latency_ms, name: Min Llm Latency Ms}], showLabels: false,
        showValues: true, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    series_types:
      dfcx_transcript.min_llm_latency_ms: area
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    custom_color: "#1A73E8"
    single_value_title: Min. LLM Latency
    value_format: '0.00'
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    show_row_numbers: true
    transpose: false
    truncate_text: true
    truncate_header: false
    size_to_fit: true
    minimum_column_width: 75
    series_cell_visualizations:
      dfcx_transcript.max_total_latency_s:
        is_active: true
    table_theme: white
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    hidden_pivots: {}
    defaults_version: 1
    hide_totals: false
    hide_row_totals: false
    listen:
      Session Start Date: dfcx_session_metadata.session_start_date
      Project ID: dfcx_session_metadata.project_id
      Agent Name: dfcx_session_metadata.agent_name
    row: 12
    col: 12
    width: 4
    height: 3
  - title: Total LLM Latency
    name: Total LLM Latency
    #model: tmo-ccai-dev
    explore: dfcx_session_metadata
    type: looker_line
    fields: [dfcx_transcript.total_llm_latency_ms, dfcx_session_metadata.session_start_date]
    fill_fields: [dfcx_session_metadata.session_start_date]
    filters:
      
      dfcx_transcript.contains_playbook_metrics: 'Yes'
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
    show_x_axis_label: false
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
    y_axes: [{label: '', orientation: left, series: [{axisId: dfcx_transcript.total_llm_latency_ms,
            id: dfcx_transcript.total_llm_latency_ms, name: Total Llm Latency Ms}],
        showLabels: false, showValues: true, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    series_types:
      dfcx_transcript.total_llm_latency_ms: area
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    custom_color: "#1A73E8"
    single_value_title: LLM Latency
    value_format: '0.00'
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    show_row_numbers: true
    transpose: false
    truncate_text: true
    truncate_header: false
    size_to_fit: true
    minimum_column_width: 75
    series_cell_visualizations:
      dfcx_transcript.max_total_latency_s:
        is_active: true
    table_theme: white
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    hidden_pivots: {}
    defaults_version: 1
    hide_totals: false
    hide_row_totals: false
    listen:
      Session Start Date: dfcx_session_metadata.session_start_date
      Project ID: dfcx_session_metadata.project_id
      Agent Name: dfcx_session_metadata.agent_name
    row: 3
    col: 12
    width: 4
    height: 3
  - title: Total Out Token
    name: Total Out Token
    #model: tmo-ccai-dev
    explore: dfcx_session_metadata
    type: looker_line
    fields: [dfcx_session_metadata.session_start_date, dfcx_transcript.total_output_tokens]
    fill_fields: [dfcx_session_metadata.session_start_date]
    filters:
      
      dfcx_transcript.contains_playbook_metrics: 'Yes'
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
    show_x_axis_label: false
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
    y_axes: [{label: '', orientation: left, series: [{axisId: dfcx_transcript.output_tokens_count_sum,
            id: dfcx_transcript.output_tokens_count_sum, name: Output Tokens Count
              Sum}], showLabels: false, showValues: true, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    series_types:
      dfcx_transcript.total_output_tokens: area
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    custom_color: "#c81ee6"
    single_value_title: Total Out Tokens
    value_format: '0.00'
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    show_row_numbers: true
    transpose: false
    truncate_text: true
    truncate_header: false
    size_to_fit: true
    minimum_column_width: 75
    series_cell_visualizations:
      dfcx_transcript.max_total_latency_s:
        is_active: true
    table_theme: white
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    hidden_pivots: {}
    defaults_version: 1
    hide_totals: false
    hide_row_totals: false
    listen:
      Session Start Date: dfcx_session_metadata.session_start_date
      Project ID: dfcx_session_metadata.project_id
      Agent Name: dfcx_session_metadata.agent_name
    row: 3
    col: 4
    width: 4
    height: 3
  - title: Total IN Tokens
    name: Total IN Tokens
    #model: tmo-ccai-dev
    explore: dfcx_session_metadata
    type: looker_line
    fields: [dfcx_session_metadata.session_start_date, dfcx_transcript.total_input_tokens]
    fill_fields: [dfcx_session_metadata.session_start_date]
    filters:
      
      dfcx_transcript.contains_playbook_metrics: 'Yes'
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
    show_x_axis_label: false
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
    y_axes: [{label: '', orientation: left, series: [{axisId: dfcx_transcript.input_tokens_count_sum,
            id: dfcx_transcript.input_tokens_count_sum, name: Input Tokens Count Sum}],
        showLabels: false, showValues: true, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    series_types:
      dfcx_transcript.total_input_tokens: area
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    custom_color: "#c81ee6"
    single_value_title: Total IN Tokens
    value_format: ''
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    show_row_numbers: true
    transpose: false
    truncate_text: true
    truncate_header: false
    size_to_fit: true
    minimum_column_width: 75
    series_cell_visualizations:
      dfcx_transcript.max_total_latency_s:
        is_active: true
    table_theme: white
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    hidden_pivots: {}
    defaults_version: 1
    hide_totals: false
    hide_row_totals: false
    listen:
      Session Start Date: dfcx_session_metadata.session_start_date
      Project ID: dfcx_session_metadata.project_id
      Agent Name: dfcx_session_metadata.agent_name
    row: 3
    col: 0
    width: 4
    height: 3
  - title: Max IN Tokens
    name: Max IN Tokens
    #model: tmo-ccai-dev
    explore: dfcx_session_metadata
    type: looker_line
    fields: [dfcx_session_metadata.session_start_date, dfcx_transcript.max_tokens_count]
    fill_fields: [dfcx_session_metadata.session_start_date]
    filters:
      
      dfcx_transcript.contains_playbook_metrics: 'Yes'
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
    show_x_axis_label: false
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
    y_axes: [{label: '', orientation: left, series: [{axisId: dfcx_transcript.input_tokens_count_max,
            id: dfcx_transcript.input_tokens_count_max, name: Input Tokens Count Max}],
        showLabels: false, showValues: true, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    series_types:
      dfcx_transcript.max_tokens_count: area
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    custom_color: "#c81ee6"
    single_value_title: Max. IN Tokens
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    listen:
      Session Start Date: dfcx_session_metadata.session_start_date
      Project ID: dfcx_session_metadata.project_id
      Agent Name: dfcx_session_metadata.agent_name
    row: 6
    col: 0
    width: 4
    height: 3
  - title: Max OUT Tokens
    name: Max OUT Tokens
    #model: tmo-ccai-dev
    explore: dfcx_session_metadata
    type: looker_line
    fields: [dfcx_session_metadata.session_start_date, dfcx_transcript.max_output_tokens]
    fill_fields: [dfcx_session_metadata.session_start_date]
    filters:
      
      dfcx_transcript.contains_playbook_metrics: 'Yes'
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
    show_x_axis_label: false
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
    y_axes: [{label: '', orientation: left, series: [{axisId: dfcx_transcript.output_tokens_count_max,
            id: dfcx_transcript.output_tokens_count_max, name: Output Tokens Count
              Max}], showLabels: false, showValues: true, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    series_types:
      dfcx_transcript.max_output_tokens: area
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    custom_color: "#c81ee6"
    single_value_title: Max. OUT Tokens
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    listen:
      Session Start Date: dfcx_session_metadata.session_start_date
      Project ID: dfcx_session_metadata.project_id
      Agent Name: dfcx_session_metadata.agent_name
    row: 6
    col: 4
    width: 4
    height: 3
  - title: Avg IN Tokens
    name: Avg IN Tokens
    #model: tmo-ccai-dev
    explore: dfcx_session_metadata
    type: looker_line
    fields: [dfcx_session_metadata.session_start_date, dfcx_transcript.avg_input_tokens_count]
    fill_fields: [dfcx_session_metadata.session_start_date]
    filters:
      
      dfcx_transcript.contains_playbook_metrics: 'Yes'
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
    show_x_axis_label: false
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
    y_axes: [{label: '', orientation: left, series: [{axisId: dfcx_transcript.input_tokens_count_avg,
            id: dfcx_transcript.input_tokens_count_avg, name: Input Tokens Count Avg}],
        showLabels: false, showValues: true, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    series_types:
      dfcx_transcript.avg_input_tokens_count: area
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    custom_color: "#c81ee6"
    single_value_title: Avg. IN Tokens
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    listen:
      Session Start Date: dfcx_session_metadata.session_start_date
      Project ID: dfcx_session_metadata.project_id
      Agent Name: dfcx_session_metadata.agent_name
    row: 9
    col: 0
    width: 4
    height: 3
  - title: Avg OUT Tokens
    name: Avg OUT Tokens
    #model: tmo-ccai-dev
    explore: dfcx_session_metadata
    type: looker_line
    fields: [dfcx_session_metadata.session_start_date, dfcx_transcript.avg_output_tokens]
    fill_fields: [dfcx_session_metadata.session_start_date]
    filters:
      
      dfcx_transcript.contains_playbook_metrics: 'Yes'
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
    show_x_axis_label: false
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
    y_axes: [{label: '', orientation: left, series: [{axisId: dfcx_transcript.output_tokens_count_avg,
            id: dfcx_transcript.output_tokens_count_avg, name: Output Tokens Count
              Avg}], showLabels: false, showValues: true, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    series_types:
      dfcx_transcript.avg_output_tokens: area
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    custom_color: "#c81ee6"
    single_value_title: Avg. OUT Tokens
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    listen:
      Session Start Date: dfcx_session_metadata.session_start_date
      Project ID: dfcx_session_metadata.project_id
      Agent Name: dfcx_session_metadata.agent_name
    row: 9
    col: 4
    width: 4
    height: 3
  - title: Min IN Tokens
    name: Min IN Tokens
    #model: tmo-ccai-dev
    explore: dfcx_session_metadata
    type: looker_line
    fields: [dfcx_session_metadata.session_start_date, dfcx_transcript.min_input_tokens]
    fill_fields: [dfcx_session_metadata.session_start_date]
    filters:
      
      dfcx_transcript.contains_playbook_metrics: 'Yes'
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
    show_x_axis_label: false
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
    y_axes: [{label: '', orientation: left, series: [{axisId: dfcx_transcript.input_tokens_count_min,
            id: dfcx_transcript.input_tokens_count_min, name: Input Tokens Count Min}],
        showLabels: false, showValues: true, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    series_types:
      dfcx_transcript.min_input_tokens: area
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    custom_color: "#c81ee6"
    single_value_title: Min. IN Tokens
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    listen:
      Session Start Date: dfcx_session_metadata.session_start_date
      Project ID: dfcx_session_metadata.project_id
      Agent Name: dfcx_session_metadata.agent_name
    row: 12
    col: 0
    width: 4
    height: 3
  - title: Min OUT Tokens
    name: Min OUT Tokens
    #model: tmo-ccai-dev
    explore: dfcx_session_metadata
    type: looker_line
    fields: [dfcx_session_metadata.session_start_date, dfcx_transcript.min_output_tokens]
    fill_fields: [dfcx_session_metadata.session_start_date]
    filters:
      
      dfcx_transcript.contains_playbook_metrics: 'Yes'
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
    show_x_axis_label: false
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
    y_axes: [{label: '', orientation: left, series: [{axisId: dfcx_transcript.output_tokens_count_min,
            id: dfcx_transcript.output_tokens_count_min, name: Output Tokens Count
              Min}], showLabels: false, showValues: false, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    series_types:
      dfcx_transcript.min_output_tokens: area
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    custom_color: "#c81ee6"
    single_value_title: Min. OUT Tokens
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    listen:
      Session Start Date: dfcx_session_metadata.session_start_date
      Project ID: dfcx_session_metadata.project_id
      Agent Name: dfcx_session_metadata.agent_name
    row: 12
    col: 4
    width: 4
    height: 3
  - title: Total LLM Calls
    name: Total LLM Calls
    #model: tmo-ccai-dev
    explore: dfcx_session_metadata
    type: looker_line
    fields: [dfcx_transcript.total_llm_calls, dfcx_session_metadata.session_start_date]
    fill_fields: [dfcx_session_metadata.session_start_date]
    filters:
      
      dfcx_transcript.contains_playbook_metrics: 'Yes'
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
    show_x_axis_label: false
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
    y_axes: [{label: '', orientation: left, series: [{axisId: dfcx_transcript.total_llm_calls,
            id: dfcx_transcript.total_llm_calls, name: Total Llm Calls}], showLabels: false,
        showValues: true, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    series_types:
      dfcx_transcript.total_llm_calls: area
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    custom_color: "#1A73E8"
    single_value_title: Total  LLM Calls
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
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
    listen:
      Session Start Date: dfcx_session_metadata.session_start_date
      Project ID: dfcx_session_metadata.project_id
    row: 3
    col: 20
    width: 4
    height: 3
  - title: Max LLM Calls/Turn
    name: Max LLM Calls/Turn
    #model: tmo-ccai-dev
    explore: dfcx_session_metadata
    type: looker_line
    fields: [dfcx_transcript.max_llm_calls_per_turn, dfcx_session_metadata.session_start_date]
    fill_fields: [dfcx_session_metadata.session_start_date]
    filters:
      
      dfcx_transcript.contains_playbook_metrics: 'Yes'
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
    show_x_axis_label: false
    show_x_axis_ticks: false
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
    y_axes: [{label: '', orientation: left, series: [{axisId: dfcx_transcript.max_llm_calls_per_turn,
            id: dfcx_transcript.max_llm_calls_per_turn, name: Max Llm Calls per Turn}],
        showLabels: false, showValues: true, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    series_types:
      dfcx_transcript.max_llm_calls_per_turn: area
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    custom_color: "#1A73E8"
    single_value_title: Max LLM Calls/Turn
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
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
    hidden_pivots: {}
    listen:
      Session Start Date: dfcx_session_metadata.session_start_date
      Project ID: dfcx_session_metadata.project_id
    row: 6
    col: 20
    width: 4
    height: 3
  - title: Avg LLM Calls/Turn
    name: Avg LLM Calls/Turn
    #model: tmo-ccai-dev
    explore: dfcx_session_metadata
    type: looker_line
    fields: [dfcx_transcript.avg_llm_calls_per_turn, dfcx_session_metadata.session_start_date]
    fill_fields: [dfcx_session_metadata.session_start_date]
    filters:
      
      dfcx_transcript.contains_playbook_metrics: 'Yes'
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
    show_x_axis_label: false
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
    y_axes: [{label: '', orientation: left, series: [{axisId: dfcx_transcript.avg_llm_calls_per_turn,
            id: dfcx_transcript.avg_llm_calls_per_turn, name: Avg Llm Calls per Turn}],
        showLabels: false, showValues: true, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    series_types:
      dfcx_transcript.avg_llm_calls_per_turn: area
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    custom_color: "#1A73E8"
    single_value_title: Avg LLM Calls/Turn
    value_format: '0.00'
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
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
    hidden_pivots: {}
    listen:
      Session Start Date: dfcx_session_metadata.session_start_date
      Project ID: dfcx_session_metadata.project_id
    row: 9
    col: 20
    width: 4
    height: 3
  - title: Min LLM Calls/Turn
    name: Min LLM Calls/Turn
    #model: tmo-ccai-dev
    explore: dfcx_session_metadata
    type: looker_line
    fields: [dfcx_transcript.min_llm_calls_per_turn, dfcx_session_metadata.session_start_date]
    fill_fields: [dfcx_session_metadata.session_start_date]
    filters:
      
      dfcx_transcript.contains_playbook_metrics: 'Yes'
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
    show_x_axis_label: false
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
    y_axes: [{label: '', orientation: left, series: [{axisId: dfcx_transcript.min_llm_calls_per_turn,
            id: dfcx_transcript.min_llm_calls_per_turn, name: Min Llm Calls per Turn}],
        showLabels: false, showValues: true, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    series_types:
      dfcx_transcript.min_llm_calls_per_turn: area
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    custom_color: "#1A73E8"
    single_value_title: Min. LLM Calls/Turn
    value_format: '0.00'
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
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
    hidden_pivots: {}
    listen:
      Session Start Date: dfcx_session_metadata.session_start_date
      Project ID: dfcx_session_metadata.project_id
    row: 12
    col: 20
    width: 4
    height: 3
  - title: Total Tool Latency
    name: Total Tool Latency
    #model: tmo-ccai-dev
    explore: dfcx_session_metadata
    type: looker_line
    fields: [dfcx_transcript.total_tool_latency_ms, dfcx_session_metadata.session_start_date]
    fill_fields: [dfcx_session_metadata.session_start_date]
    filters:
      
      dfcx_transcript.contains_playbook_metrics: 'Yes'
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
    show_x_axis_label: false
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
    y_axes: [{label: '', orientation: left, series: [{axisId: dfcx_transcript.total_tool_latency_ms,
            id: dfcx_transcript.total_tool_latency_ms, name: Total Tool Latency Ms}],
        showLabels: false, showValues: true, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    series_types:
      dfcx_transcript.total_tool_latency_ms: area
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    custom_color: "#1A73E8"
    single_value_title: Tool Latency
    value_format: '0.00'
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
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
    hidden_pivots: {}
    listen:
      Session Start Date: dfcx_session_metadata.session_start_date
      Project ID: dfcx_session_metadata.project_id
    row: 3
    col: 16
    width: 4
    height: 3
  - title: Max Tool Latency
    name: Max Tool Latency
    #model: tmo-ccai-dev
    explore: dfcx_session_metadata
    type: looker_line
    fields: [dfcx_transcript.max_tool_latency_ms, dfcx_session_metadata.session_start_date]
    fill_fields: [dfcx_session_metadata.session_start_date]
    filters:
      
      dfcx_transcript.contains_playbook_metrics: 'Yes'
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
    show_x_axis_label: false
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
    y_axes: [{label: '', orientation: left, series: [{axisId: dfcx_transcript.max_tool_latency_ms,
            id: dfcx_transcript.max_tool_latency_ms, name: Max Tool Latency Ms}],
        showLabels: false, showValues: true, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    series_types:
      dfcx_transcript.max_tool_latency_ms: area
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    custom_color: "#1A73E8"
    single_value_title: Max Tool Latency
    value_format: '0.00'
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
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
    hidden_pivots: {}
    listen:
      Session Start Date: dfcx_session_metadata.session_start_date
      Project ID: dfcx_session_metadata.project_id
    row: 6
    col: 16
    width: 4
    height: 3
  - title: Avg Tool Latency
    name: Avg Tool Latency
    #model: tmo-ccai-dev
    explore: dfcx_session_metadata
    type: looker_line
    fields: [dfcx_transcript.avg_tool_latency_ms, dfcx_session_metadata.session_start_date]
    fill_fields: [dfcx_session_metadata.session_start_date]
    filters:
      
      dfcx_transcript.contains_playbook_metrics: 'Yes'
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
    show_x_axis_label: false
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
    y_axes: [{label: '', orientation: left, series: [{axisId: dfcx_transcript.avg_tool_latency_ms,
            id: dfcx_transcript.avg_tool_latency_ms, name: Avg Tool Latency Ms}],
        showLabels: false, showValues: true, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    series_types:
      dfcx_transcript.avg_tool_latency_ms: area
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    custom_color: "#1A73E8"
    single_value_title: Avg Tool Latency
    value_format: '0.00'
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
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
    hidden_pivots: {}
    listen:
      Session Start Date: dfcx_session_metadata.session_start_date
      Project ID: dfcx_session_metadata.project_id
    row: 9
    col: 16
    width: 4
    height: 3
  - title: Min Tool Latency
    name: Min Tool Latency
    #model: tmo-ccai-dev
    explore: dfcx_session_metadata
    type: looker_line
    fields: [dfcx_transcript.min_tool_latency_ms, dfcx_session_metadata.session_start_date]
    fill_fields: [dfcx_session_metadata.session_start_date]
    filters:
      
      dfcx_transcript.contains_playbook_metrics: 'Yes'
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
    y_axes: [{label: '', orientation: left, series: [{axisId: dfcx_transcript.min_tool_latency_ms,
            id: dfcx_transcript.min_tool_latency_ms, name: Min Tool Latency Ms}],
        showLabels: false, showValues: true, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    series_types:
      dfcx_transcript.min_tool_latency_ms: area
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    custom_color: "#1A73E8"
    single_value_title: Min Tool Latency
    value_format: '0.00'
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
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
    hidden_pivots: {}
    listen:
      Session Start Date: dfcx_session_metadata.session_start_date
      Project ID: dfcx_session_metadata.project_id
    row: 12
    col: 16
    width: 4
    height: 3
  - title: Total Sessions
    name: Total Sessions
    #model: tmo-ccai-dev
    explore: dfcx_session_metadata
    type: single_value
    fields: [dfcx_session_metadata.total_sessions]
    filters:
      
      dfcx_transcript.contains_playbook_metrics: 'Yes'
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
    custom_color: "#1A73E8"
    single_value_title: Total Sessions
    defaults_version: 1
    listen:
      Session Start Date: dfcx_session_metadata.session_start_date
      Project ID: dfcx_session_metadata.project_id
    row: 0
    col: 0
    width: 6
    height: 3
  - name: ''
    type: text
    title_text: ''
    body_text: ''
    row: 15
    col: 0
    width: 4
    height: 3
  - name: " (2)"
    type: text
    title_text: ''
    body_text: ''
    row: 15
    col: 4
    width: 4
    height: 3
  filters:
  - name: Session Start Date
    title: Session Start Date
    type: field_filter
    default_value: 30 days
    allow_multiple_values: true
    required: false
    ui_config:
      type: relative_timeframes
      display: inline
    #model: tmo-ccai-dev
    explore: dfcx_session_metadata
    listens_to_filters: []
    field: dfcx_session_metadata.session_start_date
  - name: Project ID
    title: Project ID
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: button_group
      display: inline
    #model: tmo-ccai-dev
    explore: dfcx_session_metadata
    listens_to_filters: []
    field: dfcx_session_metadata.project_id
  - name: Agent Name
    title: Agent Name
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
    #model: tmo-ccai-dev
    explore: dfcx_session_metadata
    listens_to_filters: []
    field: dfcx_session_metadata.agent_name