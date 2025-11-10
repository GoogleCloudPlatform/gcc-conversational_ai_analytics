- dashboard: solutions__actions
  title: Solutions - Actions
  layout: newspaper
  preferred_viewer: dashboards-next
  load_configuration: wait
  description: ''
  preferred_slug: 8NPvaXwL8LuWF91WBXcPVy
  elements:
  - title: Actions Not Started
    name: Actions Not Started
    #model: ccai
    explore: dfcx_session_metadata
    type: looker_grid
    fields: [dfcx_interaction.final_message__flow_display_name, dfcx_interaction.final_message__page_display_name,
      dfcx_interaction.total_interactions]
    filters:
      dfcx_interaction__actions.action_started: 'No'
    sorts: [dfcx_interaction.final_message__flow_display_name, dfcx_interaction.final_message__page_display_name,
      dfcx_interaction.total_interactions desc]
    subtotals: [dfcx_interaction.final_message__flow_display_name]
    limit: 500
    dynamic_fields: [{category: table_calculation, label: "% of Total", value_format: !!null '',
        value_format_name: percent_0, calculation_type: percent_of_column_sum, table_calculation: of_total,
        args: [dfcx_interaction.total_interactions], _kind_hint: measure, _type_hint: number,
        id: 2Z1ippz904}]
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: transparent
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
    series_labels: {}
    series_column_widths:
      dfcx_interaction.total_interactions: 129
      of_total: 88
      grouped-column-dfcx_interaction.final_message__flow_display_name: 219
      dfcx_interaction.final_message__page_display_name: 239
    series_cell_visualizations:
      dfcx_interaction.total_interactions:
        is_active: true
    truncate_column_names: false
    defaults_version: 1
    series_types: {}
    listen:
      Session Start Date: dfcx_session_metadata.session_start_date
      Project ID: dfcx_session_metadata.project_id
      Interaction Use Case: dfcx_interaction.interaction_head_intent
      Action: dfcx_interaction__actions.action
    row: 10
    col: 0
    width: 12
    height: 9
  - title: Total Interactions by Date
    name: Total Interactions by Date
    #model: ccai
    explore: dfcx_session_metadata
    type: looker_line
    fields: [dfcx_interaction.total_interactions, dfcx_interaction.total_interactions_started,
      dfcx_interaction.total_interactions_ended, dfcx_interaction.self_service_attempt_rate,
      dfcx_interaction.self_service_success_rate, dfcx_session_metadata.session_start_date]
    fill_fields: [dfcx_session_metadata.session_start_date]
    filters: {}
    sorts: [dfcx_session_metadata.session_start_date]
    limit: 500
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
    y_axes: [{label: '', orientation: left, series: [{axisId: dfcx_interaction.total_interactions,
            id: dfcx_interaction.total_interactions, name: Total Interactions}, {
            axisId: dfcx_interaction.total_interactions_started, id: dfcx_interaction.total_interactions_started,
            name: Total Interactions Started}, {axisId: dfcx_interaction.total_interactions_ended,
            id: dfcx_interaction.total_interactions_ended, name: Total Interactions
              Ended}], showLabels: true, showValues: true, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}, {label: !!null '', orientation: right,
        series: [{axisId: dfcx_interaction.self_service_attempt_rate, id: dfcx_interaction.self_service_attempt_rate,
            name: SS Attempt %}, {axisId: dfcx_interaction.self_service_success_rate,
            id: dfcx_interaction.self_service_success_rate, name: SS Success %}],
        showLabels: true, showValues: true, maxValue: 1, minValue: 0, unpinAxis: false,
        tickDensity: default, tickDensityCustom: 5, type: linear}]
    series_types:
      dfcx_interaction.total_interactions: column
      dfcx_interaction.total_interactions_started: column
      dfcx_interaction.total_interactions_ended: column
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    listen:
      Session Start Date: dfcx_session_metadata.session_start_date
      Project ID: dfcx_session_metadata.project_id
      Interaction Use Case: dfcx_interaction.interaction_head_intent
      Action: dfcx_interaction__actions.action
    row: 0
    col: 0
    width: 24
    height: 10
  - title: Actions Started
    name: Actions Started
    #model: ccai
    explore: dfcx_session_metadata
    type: looker_grid
    fields: [dfcx_interaction__actions.action_ended, dfcx_interaction.final_message__flow_display_name,
      dfcx_interaction.final_message__page_display_name, dfcx_interaction.total_interactions]
    filters:
      dfcx_interaction__actions.action_started: 'Yes'
    sorts: [dfcx_interaction__actions.action_ended, dfcx_interaction.final_message__flow_display_name,
      dfcx_interaction.final_message__page_display_name, dfcx_interaction.total_interactions
        desc]
    subtotals: [dfcx_interaction.final_message__flow_display_name, dfcx_interaction__actions.action_ended]
    limit: 500
    dynamic_fields: [{category: table_calculation, label: "% of Total", value_format: !!null '',
        value_format_name: percent_0, calculation_type: percent_of_column_sum, table_calculation: of_total,
        args: [dfcx_interaction.total_interactions], _kind_hint: measure, _type_hint: number,
        id: 2Z1ippz904}]
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: transparent
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
    series_labels: {}
    series_column_widths:
      dfcx_interaction.total_interactions: 129
      of_total: 88
      dfcx_interaction__actions.action_ended: 164
      dfcx_interaction.final_message__flow_display_name: 219
      dfcx_interaction.final_message__page_display_name: 221
    series_cell_visualizations:
      dfcx_interaction.total_interactions:
        is_active: true
    truncate_column_names: false
    defaults_version: 1
    series_types: {}
    listen:
      Session Start Date: dfcx_session_metadata.session_start_date
      Project ID: dfcx_session_metadata.project_id
      Interaction Use Case: dfcx_interaction.interaction_head_intent
      Action: dfcx_interaction__actions.action
    row: 10
    col: 12
    width: 12
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
    #model: ccai
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
      type: tag_list
      display: popover
    #model: ccai
    explore: dfcx_session_metadata
    listens_to_filters: [Session Start Date, Interaction Use Case]
    field: dfcx_session_metadata.project_id
  - name: Interaction Use Case
    title: Interaction Use Case
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: true
    ui_config:
      type: dropdown_menu
      display: popover
    #model: ccai
    explore: dfcx_session_metadata
    listens_to_filters: [Session Start Date, Project ID]
    field: dfcx_interaction.interaction_head_intent
  - name: Action
    title: Action
    type: field_filter
    default_value: ''
    allow_multiple_values: false
    required: true
    ui_config:
      type: dropdown_menu
      display: inline
    #model: ccai
    explore: dfcx_session_metadata
    listens_to_filters: [Session Start Date, Interaction Use Case, Project ID]
    field: dfcx_interaction__actions.action
