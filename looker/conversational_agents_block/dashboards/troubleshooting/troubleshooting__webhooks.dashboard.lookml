- dashboard: troubleshooting__webhooks
  title: Troubleshooting - Webhooks
  layout: newspaper
  preferred_viewer: dashboards-next
  description: ''
  preferred_slug: 78Sv0rGxXXjiLCebIa5DX8
  elements:
  - name: " (Copy)"
    type: text
    title_text: " (Copy)"
    body_text: '[{"type":"h1","children":[{"text":"Webhook Failures"}],"align":"center"}]'
    rich_content_json: '{"format":"slate"}'
    row: 27
    col: 0
    width: 24
    height: 2
  - name: ''
    type: text
    title_text: ''
    body_text: '[{"type":"h1","children":[{"text":"Webhook Overview"}],"align":"center"}]'
    rich_content_json: '{"format":"slate"}'
    row: 0
    col: 0
    width: 24
    height: 2
  - title: Webhook Latency MS Percentiles (p50, p75, p95, p99)
    name: Webhook Latency MS Percentiles (p50, p75, p95, p99)
    #model: VVA_DEV_1
    explore: dfcx_session_metadata
    type: looker_line
    fields: [dfcx_transcript__webhooks.50th_percentile_webhook_latency_ms, dfcx_transcript__webhooks.75th_percentile_webhook_latency_ms,
      dfcx_transcript__webhooks.95th_percentile_webhook_latency_ms, dfcx_transcript__webhooks.99th_percentile_webhook_latency_ms,
      dfcx_session_metadata.session_start_date]
    fill_fields: [dfcx_session_metadata.session_start_date]
    filters:
      dfcx_transcript__webhooks.webhook_url: "-NULL"
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
    interpolation: monotone
    y_axes: [{label: !!null '', orientation: left, series: [{axisId: dfcx_transcript__webhooks.50th_percentile_webhook_latency_ms,
            id: dfcx_transcript__webhooks.50th_percentile_webhook_latency_ms, name: 50th
              Percentile Webhook Latency Ms}, {axisId: dfcx_transcript__webhooks.75th_percentile_webhook_latency_ms,
            id: dfcx_transcript__webhooks.75th_percentile_webhook_latency_ms, name: 75th
              Percentile Webhook Latency Ms}, {axisId: dfcx_transcript__webhooks.95th_percentile_webhook_latency_ms,
            id: dfcx_transcript__webhooks.95th_percentile_webhook_latency_ms, name: 95th
              Percentile Webhook Latency Ms}, {axisId: dfcx_transcript__webhooks.99th_percentile_webhook_latency_ms,
            id: dfcx_transcript__webhooks.99th_percentile_webhook_latency_ms, name: 99th
              Percentile Webhook Latency Ms}], showLabels: true, showValues: true,
        unpinAxis: false, tickDensity: custom, tickDensityCustom: 38, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    reference_lines: [{reference_type: line, range_start: max, range_end: min, margin_top: deviation,
        margin_value: mean, margin_bottom: deviation, label_position: right, color: "#000000",
        line_value: '0'}]
    swap_axes: false
    defaults_version: 1
    hidden_fields: []
    listen:
      Project ID: dfcx_session_metadata.project_id
      Session Start Date: dfcx_session_metadata.session_start_date
      Webhook Flow Name: dfcx_transcript__webhooks.flow_display_name
      Webhook Page Name: dfcx_transcript__webhooks.page_display_name
      Agent Name: dfcx_session_metadata.agent_name
    row: 2
    col: 0
    width: 24
    height: 6
  - title: Webhook Overall Performance
    name: Webhook Overall Performance
    #model: VVA_DEV_1
    explore: dfcx_session_metadata
    type: looker_line
    fields: [dfcx_session_metadata.session_start_date, dfcx_transcript__webhooks.total_webhooks,
      dfcx_transcript__webhooks.total_operational_webhook_failures, dfcx_transcript__webhooks.operational_webhook_failure_rate]
    fill_fields: [dfcx_session_metadata.session_start_date]
    filters:
      dfcx_transcript__webhooks.webhook_url: "-NULL"
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
    interpolation: monotone
    y_axes: [{label: '', orientation: left, series: [{axisId: dfcx_transcript__webhooks.total_webhooks,
            id: dfcx_transcript__webhooks.total_webhooks, name: Total Webhooks}, {
            axisId: dfcx_transcript__webhooks.total_operational_webhook_failures,
            id: dfcx_transcript__webhooks.total_operational_webhook_failures, name: Total
              Operational Webhook Failures}], showLabels: true, showValues: true,
        unpinAxis: false, tickDensity: default, tickDensityCustom: 37, type: linear},
      {label: !!null '', orientation: right, series: [{axisId: dfcx_transcript__webhooks.operational_webhook_failure_rate,
            id: dfcx_transcript__webhooks.operational_webhook_failure_rate, name: Operational
              Webhook Failure Rate}], showLabels: true, showValues: true, maxValue: 1,
        minValue: 0, unpinAxis: false, tickDensity: default, tickDensityCustom: 49,
        type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    ordering: none
    show_null_labels: false
    hidden_fields: []
    listen:
      Project ID: dfcx_session_metadata.project_id
      Session Start Date: dfcx_session_metadata.session_start_date
      Webhook Flow Name: dfcx_transcript__webhooks.flow_display_name
      Webhook Page Name: dfcx_transcript__webhooks.page_display_name
      Agent Name: dfcx_session_metadata.agent_name
    row: 8
    col: 0
    width: 24
    height: 6
  - title: Webhook Overall Performance
    name: Webhook Overall Performance (2)
    #model: VVA_DEV_1
    explore: dfcx_session_metadata
    type: looker_grid
    fields: [dfcx_transcript__webhooks.webhook_display_name, dfcx_transcript__webhooks.total_webhooks,
      dfcx_transcript__webhooks.total_operational_webhook_failures, dfcx_transcript__webhooks.operational_webhook_failure_rate,
      dfcx_transcript__webhooks.5th_percentile_webhook_latency_ms, dfcx_transcript__webhooks.25th_percentile_webhook_latency_ms,
      dfcx_transcript__webhooks.50th_percentile_webhook_latency_ms, dfcx_transcript__webhooks.75th_percentile_webhook_latency_ms,
      dfcx_transcript__webhooks.95th_percentile_webhook_latency_ms, dfcx_transcript__webhooks.99th_percentile_webhook_latency_ms]
    filters:
      dfcx_transcript__webhooks.webhook_url: "-NULL"
    sorts: [dfcx_transcript__webhooks.webhook_display_name]
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
    series_labels:
      dfcx_transcript__webhooks.webhook_display_name: Webhook Name
      dfcx_transcript__webhooks.5th_percentile_webhook_latency_ms: Webhook Latency
        MS - 05%
      dfcx_transcript__webhooks.25th_percentile_webhook_latency_ms: Webhook Latency
        MS - 25%
      dfcx_transcript__webhooks.50th_percentile_webhook_latency_ms: Webhook Latency
        MS - 50%
      dfcx_transcript__webhooks.75th_percentile_webhook_latency_ms: Webhook Latency
        MS - 75%
      dfcx_transcript__webhooks.95th_percentile_webhook_latency_ms: Webhook Latency
        MS - 95%
      dfcx_transcript__webhooks.99th_percentile_webhook_latency_ms: Webhook Latency
        MS - 99%
    series_cell_visualizations:
      dfcx_transcript.total_webhooks:
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
    hidden_fields: []
    y_axes: []
    listen:
      Project ID: dfcx_session_metadata.project_id
      Session Start Date: dfcx_session_metadata.session_start_date
      Webhook Flow Name: dfcx_transcript__webhooks.flow_display_name
      Webhook Page Name: dfcx_transcript__webhooks.page_display_name
      Agent Name: dfcx_session_metadata.agent_name
    row: 14
    col: 0
    width: 24
    height: 6
  - title: Webhook Latency MS Box Plot
    name: Webhook Latency MS Box Plot
    #model: VVA_DEV_1
    explore: dfcx_session_metadata
    type: looker_boxplot
    fields: [dfcx_transcript__webhooks.webhook_display_name, dfcx_transcript__webhooks.5th_percentile_webhook_latency_ms,
      dfcx_transcript__webhooks.25th_percentile_webhook_latency_ms, dfcx_transcript__webhooks.average_webhook_latency_ms,
      dfcx_transcript__webhooks.75th_percentile_webhook_latency_ms, dfcx_transcript__webhooks.95th_percentile_webhook_latency_ms]
    filters:
      dfcx_transcript__webhooks.webhook_url: "-NULL"
    sorts: [dfcx_transcript__webhooks.webhook_display_name]
    limit: 500
    column_limit: 50
    x_axis_gridlines: true
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: false
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 13
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    color_application:
      collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2
      palette_id: 5d189dfc-4f46-46f3-822b-bfb0b61777b1
      options:
        steps: 5
    y_axes: []
    y_axis_min: ['0']
    y_axis_max: []
    y_axis_labels: []
    x_axis_zoom: true
    y_axis_zoom: true
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: circle
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    defaults_version: 1
    hidden_fields: []
    listen:
      Project ID: dfcx_session_metadata.project_id
      Session Start Date: dfcx_session_metadata.session_start_date
      Webhook Flow Name: dfcx_transcript__webhooks.flow_display_name
      Webhook Page Name: dfcx_transcript__webhooks.page_display_name
      Agent Name: dfcx_session_metadata.agent_name
    row: 20
    col: 0
    width: 24
    height: 7
  - title: Heuristic Outcome Dist
    name: Heuristic Outcome Dist
    #model: VVA_DEV_1
    explore: dfcx_session_metadata
    type: looker_pie
    fields: [dfcx_transcript__webhooks.total_webhooks, dfcx_session_metadata.is_escalated]
    filters:
      dfcx_transcript__webhooks.webhook_url: "-NULL"
    sorts: [dfcx_transcript__webhooks.total_webhooks desc 0]
    limit: 500
    column_limit: 50
    value_labels: legend
    label_type: labPer
    inner_radius: 60
    color_application:
      collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c
      palette_id: 75905e81-dadc-472c-b9a2-a201f788d55d
      options:
        steps: 5
        reverse: false
    series_colors: {}
    defaults_version: 1
    hidden_fields: []
    y_axes: []
    listen:
      Project ID: dfcx_session_metadata.project_id
      Session Start Date: dfcx_session_metadata.session_start_date
      Webhook Flow Name: dfcx_transcript__webhooks.flow_display_name
      Webhook Page Name: dfcx_transcript__webhooks.page_display_name
      Agent Name: dfcx_session_metadata.agent_name
    row: 29
    col: 14
    width: 5
    height: 5
  - title: Webhook Status
    name: Webhook Status
    #model: VVA_DEV_1
    explore: dfcx_session_metadata
    type: looker_pie
    fields: [dfcx_transcript__webhooks.total_webhooks, dfcx_transcript__webhooks.webhook_status]
    filters:
      dfcx_transcript__webhooks.webhook_url: "-NULL"
    sorts: [dfcx_transcript__webhooks.total_webhooks desc 0]
    limit: 500
    column_limit: 50
    value_labels: legend
    label_type: labPer
    inner_radius: 60
    color_application:
      collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7
      palette_id: fb7bb53e-b77b-4ab6-8274-9d420d3d73f3
      options:
        steps: 5
    series_colors: {}
    defaults_version: 1
    hidden_fields: []
    y_axes: []
    listen:
      Project ID: dfcx_session_metadata.project_id
      Session Start Date: dfcx_session_metadata.session_start_date
      Webhook Flow Name: dfcx_transcript__webhooks.flow_display_name
      Webhook Page Name: dfcx_transcript__webhooks.page_display_name
      Agent Name: dfcx_session_metadata.agent_name
    row: 29
    col: 19
    width: 5
    height: 5
  - title: Webhook Failures
    name: Webhook Failures
    #model: VVA_DEV_1
    explore: dfcx_session_metadata
    type: looker_grid
    fields: [dfcx_session_metadata.session_id, dfcx_transcript.position, dfcx_transcript__webhooks.step,
      dfcx_transcript__webhooks.webhook_display_name, dfcx_transcript__webhooks.webhook_status,
      dfcx_transcript__webhooks.operational_webhook_failure]
    filters:
      dfcx_transcript__webhooks.webhook_display_name: "-NULL"
    sorts: [dfcx_transcript.position desc]
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
    defaults_version: 1
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    truncate_header: false
    hidden_fields: []
    y_axes: []
    listen:
      Project ID: dfcx_session_metadata.project_id
      Session Start Date: dfcx_session_metadata.session_start_date
      Webhook Flow Name: dfcx_transcript__webhooks.flow_display_name
      Webhook Page Name: dfcx_transcript__webhooks.page_display_name
      Agent Name: dfcx_session_metadata.agent_name
    row: 29
    col: 0
    width: 14
    height: 5
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
    #model: VVA_DEV_1
    explore: dfcx_session_metadata
    listens_to_filters: []
    field: dfcx_transcript.session_start_date
  - name: Project ID
    title: Project ID
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
    #model: VVA_DEV_1
    explore: dfcx_session_metadata
    listens_to_filters: [Session Start Date, Webhook Flow Name, Webhook Page Name, Webhook Display Name, Agent Name]
    field: dfcx_session_metadata.project_id
  - name: Webhook Flow Name
    title: Webhook Flow Name
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
    #model: VVA_DEV_1
    explore: dfcx_session_metadata
    listens_to_filters: [Session Start Date, Project ID, Webhook Page Name, Webhook Display Name, Agent Name]
    field: dfcx_transcript.flow_display_name
  - name: Webhook Page Name
    title: Webhook Page Name
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
    #model: VVA_DEV_1
    explore: dfcx_session_metadata
    listens_to_filters: [Session Start Date, Project ID, Webhook Flow Name, Webhook Display Name, Agent Name]
    field: dfcx_transcript.page_display_name
  - name: Webhook Display Name
    title: Webhook Display Name
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
      options: []
    #model: VVA_DEV_1
    explore: dfcx_session_metadata
    listens_to_filters: [Session Start Date, Project ID, Webhook Flow Name, Webhook Page Name, Agent Name]
    field: dfcx_transcript__webhooks.webhook_display_name
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
    listens_to_filters: [Session Start Date, Project ID, Webhook Flow Name, Webhook Page Name, Webhook Display Name]
    field: dfcx_session_metadata.agent_name
