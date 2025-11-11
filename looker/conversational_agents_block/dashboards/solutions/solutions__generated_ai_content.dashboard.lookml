---
- dashboard: solutions__generated_ai_content
  title: Solutions - Generated AI Content
  layout: newspaper
  preferred_viewer: dashboards-next
  description: ''
  preferred_slug: j9CfF1wOkU1ZyJPLh551YV
  elements:
  - title: Total AI Generated Content Turns
    name: Total AI Generated Content Turns
    #model: tmo-ccai-dev
    explore: dfcx_session_metadata
    type: looker_column
    fields: [dfcx_transcript_metadata.total_turns_contain_ai_generated_content,
      dfcx_transcript_metadata.total_turns_contain_data_store_content, dfcx_transcript_metadata.total_turns_contain_data_store_faq_content,
      dfcx_transcript_metadata.total_turns_contain_generative_fallback, dfcx_transcript_metadata.total_turns_contain_generators_content,
      dfcx_transcript_metadata.total_turns_contain_playbook_content, dfcx_session_metadata.session_start_date]
    fill_fields: [dfcx_session_metadata.session_start_date]
    filters:

      dfcx_transcript_metadata.contain_any_ai_generated_content: 'Yes'
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
    stacking: normal
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
    x_axis_zoom: true
    y_axis_zoom: true
    hidden_pivots: {}
    show_null_points: true
    interpolation: linear
    defaults_version: 1
    listen:
      Session Start Date: dfcx_session_metadata.session_start_date
      Project ID: dfcx_session_metadata.project_id
      Agent Display Name: dfcx_session_metadata.agent_name
    row: 7
    col: 0
    width: 24
    height: 9
  - title: Generative Content Rate
    name: Generative Content Rate
    #model: tmo-ccai-dev
    explore: dfcx_session_metadata
    type: looker_line
    fields: [dfcx_session_metadata.session_start_date, dfcx_transcript_metadata.total_turns_contain_any_ai_generated_content,
      dfcx_transcript_metadata.total_turns_curated_responses, dfcx_transcript_metadata.ai_generated_content_percentage]
    fill_fields: [dfcx_session_metadata.session_start_date]
    filters:

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
    stacking: normal
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    y_axes: [{label: '', orientation: left, series: [{axisId: dfcx_transcript_metadata.total_turns_contain_any_ai_generated_content,
            id: dfcx_transcript_metadata.total_turns_contain_any_ai_generated_content,
            name: Total Turns Contain Any AI Generated Content}, {axisId: dfcx_transcript_metadata.total_turns_curated_responses,
            id: dfcx_transcript_metadata.total_turns_curated_responses, name: Total
              Turns Curated Respones}], showLabels: true, showValues: true, unpinAxis: false,
        tickDensity: default, tickDensityCustom: 5, type: linear}, {label: !!null '',
        orientation: right, series: [{axisId: dfcx_transcript_metadata.ai_generated_content_percentage,
            id: dfcx_transcript_metadata.ai_generated_content_percentage,
            name: AI Generated Content %}], showLabels: true, showValues: true, unpinAxis: false,
        tickDensity: default, tickDensityCustom: 5, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    series_types:
      dfcx_transcript_metadata.total_turns_contain_any_ai_generated_content: column
      dfcx_transcript_metadata.total_turns_curated_responses: column
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    hidden_pivots: {}
    defaults_version: 1
    listen:
      Session Start Date: dfcx_session_metadata.session_start_date
      Project ID: dfcx_session_metadata.project_id
      Agent Display Name: dfcx_session_metadata.agent_name
    row: 0
    col: 0
    width: 24
    height: 7
  filters:
  - name: Session Start Date
    title: Session Start Date
    type: field_filter
    default_value: 30 day
    allow_multiple_values: true
    required: false
    ui_config:
      type: relative_timeframes
      display: inline
      options: []
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
  - name: Agent Display Name
    title: Agent Display Name
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
