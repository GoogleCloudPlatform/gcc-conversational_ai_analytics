- dashboard: overall__agent_transitions
  title: Overall - Agent Transitions
  layout: newspaper
  preferred_viewer: dashboards-next
  description: ''
  preferred_slug: VMWIFiM4dkYUk3pJf9kZbH
  elements:
  - title: Pre-Transitions Pages
    name: Pre-Transitions Pages

    explore: dfcx_session_metadata
    type: looker_grid
    fields: [dfcx_transcript.source_page_display_name, dfcx_session_metadata.total_sessions,
      dfcx_transcript.total_turns, dfcx_transcript.percent_total]
    sorts: [dfcx_session_metadata.total_sessions desc]
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
      dfcx_transcript.percent_total: 60
      dfcx_transcript.total_turns: 60
      dfcx_session_metadata.total_sessions: 60
    series_cell_visualizations:
      dfcx_transcript.total_turns:
        is_active: false
        value_display: true
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    defaults_version: 1
    listen:
      Flow Before: dfcx_transcript.source_flow_display_name
      Page Before: dfcx_transcript.source_page_display_name
      Agent Response Before: dfcx_transcript_metadata.source_agent_response
      Matched Intent: dfcx_transcript.matched_intent
      Match Type: dfcx_transcript.match_type
      User Utterance: dfcx_transcript.user_utterance
      Flow After: dfcx_transcript.flow_display_name
      Page After: dfcx_transcript.page_display_name
      Agent Response After: dfcx_transcript.agent_response
      Session Start Date: dfcx_session_metadata.session_start_date
      Agent Name: dfcx_session_metadata.agent_name
    row: 6
    col: 0
    width: 8
    height: 6
  - title: Transition Intents
    name: Transition Intents

    explore: dfcx_session_metadata
    type: looker_grid
    fields: [dfcx_transcript.matched_intent, dfcx_session_metadata.total_sessions,
      dfcx_transcript.total_turns, dfcx_transcript.percent_total]
    sorts: [dfcx_session_metadata.total_sessions desc]
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
      dfcx_session_metadata.total_sessions: 60
      dfcx_transcript.total_turns: 60
      dfcx_transcript.percent_total: 60
    series_cell_visualizations:
      dfcx_session_metadata.total_sessions:
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
      Flow Before: dfcx_transcript.source_flow_display_name
      Page Before: dfcx_transcript.source_page_display_name
      Agent Response Before: dfcx_transcript_metadata.source_agent_response
      Matched Intent: dfcx_transcript.matched_intent
      Match Type: dfcx_transcript.match_type
      User Utterance: dfcx_transcript.user_utterance
      Flow After: dfcx_transcript.flow_display_name
      Page After: dfcx_transcript.page_display_name
      Agent Response After: dfcx_transcript.agent_response
      Session Start Date: dfcx_session_metadata.session_start_date
      Agent Name: dfcx_session_metadata.agent_name
    row: 6
    col: 8
    width: 8
    height: 6
  - title: Post-Transition Pages
    name: Post-Transition Pages

    explore: dfcx_session_metadata
    type: looker_grid
    fields: [dfcx_session_metadata.total_sessions, dfcx_transcript.total_turns, dfcx_transcript.percent_total,
      dfcx_transcript.page_display_name]
    sorts: [dfcx_session_metadata.total_sessions desc]
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
      dfcx_session_metadata.total_sessions: 60
      dfcx_transcript.total_turns: 60
      dfcx_transcript.percent_total: 60
    series_cell_visualizations:
      dfcx_session_metadata.total_sessions:
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
      Flow Before: dfcx_transcript.source_flow_display_name
      Page Before: dfcx_transcript.source_page_display_name
      Agent Response Before: dfcx_transcript_metadata.source_agent_response
      Matched Intent: dfcx_transcript.matched_intent
      Match Type: dfcx_transcript.match_type
      User Utterance: dfcx_transcript.user_utterance
      Flow After: dfcx_transcript.flow_display_name
      Page After: dfcx_transcript.page_display_name
      Agent Response After: dfcx_transcript.agent_response
      Session Start Date: dfcx_session_metadata.session_start_date
      Agent Name: dfcx_session_metadata.agent_name
    row: 6
    col: 16
    width: 8
    height: 6
  - title: Agent Response Before
    name: Agent Response Before

    explore: dfcx_session_metadata
    type: looker_grid
    fields: [dfcx_transcript_metadata.source_agent_response, dfcx_session_metadata.total_sessions,
      dfcx_transcript.total_turns, dfcx_transcript.percent_total]
    sorts: [dfcx_session_metadata.total_sessions desc]
    limit: 500
    column_limit: 50
    total: true
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
    show_totals: false
    show_row_totals: true
    truncate_header: true
    minimum_column_width: 75
    series_column_widths:
      dfcx_session_metadata.total_sessions: 60
      dfcx_transcript.total_turns: 60
      dfcx_transcript.percent_total: 60
    series_cell_visualizations:
      dfcx_session_metadata.total_sessions:
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
      Flow Before: dfcx_transcript.source_flow_display_name
      Page Before: dfcx_transcript.source_page_display_name
      Agent Response Before: dfcx_transcript_metadata.source_agent_response
      Matched Intent: dfcx_transcript.matched_intent
      Match Type: dfcx_transcript.match_type
      User Utterance: dfcx_transcript.user_utterance
      Flow After: dfcx_transcript.flow_display_name
      Page After: dfcx_transcript.page_display_name
      Agent Response After: dfcx_transcript.agent_response
      Session Start Date: dfcx_session_metadata.session_start_date
      Agent Name: dfcx_session_metadata.agent_name
    row: 12
    col: 0
    width: 8
    height: 6
  - title: User Utterance
    name: User Utterance

    explore: dfcx_session_metadata
    type: looker_grid
    fields: [dfcx_session_metadata.total_sessions, dfcx_transcript.total_turns, dfcx_transcript.percent_total,
      dfcx_transcript.user_utterance]
    sorts: [dfcx_session_metadata.total_sessions desc]
    limit: 500
    column_limit: 50
    total: true
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
    show_totals: false
    show_row_totals: true
    truncate_header: true
    minimum_column_width: 75
    series_column_widths:
      dfcx_session_metadata.total_sessions: 60
      dfcx_transcript.total_turns: 60
      dfcx_transcript.percent_total: 60
    series_cell_visualizations:
      dfcx_session_metadata.total_sessions:
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
      Flow Before: dfcx_transcript.source_flow_display_name
      Page Before: dfcx_transcript.source_page_display_name
      Agent Response Before: dfcx_transcript_metadata.source_agent_response
      Matched Intent: dfcx_transcript.matched_intent
      Match Type: dfcx_transcript.match_type
      User Utterance: dfcx_transcript.user_utterance
      Flow After: dfcx_transcript.flow_display_name
      Page After: dfcx_transcript.page_display_name
      Agent Response After: dfcx_transcript.agent_response
      Session Start Date: dfcx_session_metadata.session_start_date
      Agent Name: dfcx_session_metadata.agent_name
    row: 12
    col: 8
    width: 8
    height: 6
  - title: Agent Response After
    name: Agent Response After

    explore: dfcx_session_metadata
    type: looker_grid
    fields: [dfcx_session_metadata.total_sessions, dfcx_transcript.total_turns, dfcx_transcript.percent_total,
      dfcx_transcript.agent_response]
    sorts: [dfcx_session_metadata.total_sessions desc]
    limit: 500
    column_limit: 50
    total: true
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
    show_totals: false
    show_row_totals: true
    truncate_header: true
    minimum_column_width: 75
    series_column_widths:
      dfcx_transcript.percent_total: 60
      dfcx_transcript.total_turns: 60
      dfcx_session_metadata.total_sessions: 60
    series_cell_visualizations:
      dfcx_session_metadata.total_sessions:
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
      Flow Before: dfcx_transcript.source_flow_display_name
      Page Before: dfcx_transcript.source_page_display_name
      Agent Response Before: dfcx_transcript_metadata.source_agent_response
      Matched Intent: dfcx_transcript.matched_intent
      Match Type: dfcx_transcript.match_type
      User Utterance: dfcx_transcript.user_utterance
      Flow After: dfcx_transcript.flow_display_name
      Page After: dfcx_transcript.page_display_name
      Agent Response After: dfcx_transcript.agent_response
      Session Start Date: dfcx_session_metadata.session_start_date
      Agent Name: dfcx_session_metadata.agent_name
    row: 12
    col: 16
    width: 8
    height: 6
  - title: Daily Trends of Sessions
    name: Daily Trends of Sessions

    explore: dfcx_session_metadata
    type: looker_line
    fields: [dfcx_session_metadata.session_start_date, dfcx_session_metadata.total_sessions]
    fill_fields: [dfcx_session_metadata.session_start_date]
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
    y_axes: [{label: '', orientation: left, series: [{axisId: dfcx_session_metadata.total_sessions,
            id: dfcx_session_metadata.total_sessions, name: Total Sessions}], showLabels: true,
        showValues: true, unpinAxis: false, tickDensity: custom, tickDensityCustom: 39,
        type: linear}]
    defaults_version: 1
    listen:
      Flow Before: dfcx_transcript.source_flow_display_name
      Page Before: dfcx_transcript.source_page_display_name
      Agent Response Before: dfcx_transcript_metadata.source_agent_response
      Matched Intent: dfcx_transcript.matched_intent
      Match Type: dfcx_transcript.match_type
      User Utterance: dfcx_transcript.user_utterance
      Flow After: dfcx_transcript.flow_display_name
      Page After: dfcx_transcript.page_display_name
      Agent Response After: dfcx_transcript.agent_response
      Session Start Date: dfcx_session_metadata.session_start_date
      Agent Name: dfcx_session_metadata.agent_name
    row: 18
    col: 0
    width: 24
    height: 6
  - title: Transition Pages
    name: Transition Pages

    explore: dfcx_session_metadata
    type: marketplace_viz_sankey::sankey-marketplace
    fields: [dfcx_transcript.source_page_display_name, dfcx_transcript.matched_intent,
      dfcx_transcript.page_display_name, dfcx_transcript.total_turns]
    filters:
      dfcx_session_metadata.session_start_date: 30 days
    sorts: [dfcx_transcript.total_turns desc 0]
    limit: 500
    column_limit: 50
    hidden_fields: []
    hidden_points_if_no: []
    series_labels: {}
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
      dfcx_transcript.total_turns: 60
    series_cell_visualizations:
      dfcx_transcript.total_turns:
        is_active: false
        value_display: true
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    defaults_version: 0
    hidden_pivots: {}
    color_range: ["#dd3333", "#80ce5d", "#f78131", "#369dc1", "#c572d3", "#36c1b3",
      "#b57052", "#ed69af"]
    label_type: name
    show_null_points: true
    listen:
      Flow Before: dfcx_transcript.source_flow_display_name
      Page Before: dfcx_transcript.source_page_display_name
      Agent Response Before: dfcx_transcript_metadata.source_agent_response
      Matched Intent: dfcx_transcript.matched_intent
      Match Type: dfcx_transcript.match_type
      User Utterance: dfcx_transcript.user_utterance
      Flow After: dfcx_transcript.flow_display_name
      Page After: dfcx_transcript.page_display_name
      Agent Response After: dfcx_transcript.agent_response
      Session Start Date: dfcx_session_metadata.session_start_date
      Agent Name: dfcx_session_metadata.agent_name
    row: 0
    col: 12
    width: 12
    height: 6
  - title: Transition Flows
    name: Transition Flows

    explore: dfcx_session_metadata
    type: marketplace_viz_sankey::sankey-marketplace
    fields: [dfcx_transcript.source_flow_display_name, dfcx_transcript.matched_intent,
      dfcx_transcript.flow_display_name, dfcx_transcript.total_turns]
    filters:
      dfcx_session_metadata.session_start_date: 30 days
    sorts: [dfcx_transcript.total_turns desc]
    limit: 500
    column_limit: 50
    hidden_fields: []
    hidden_points_if_no: []
    series_labels: {}
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
      dfcx_transcript.total_turns: 60
    series_cell_visualizations:
      dfcx_transcript.total_turns:
        is_active: false
        value_display: true
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    defaults_version: 0
    hidden_pivots: {}
    color_range: ["#dd3333", "#80ce5d", "#f78131", "#369dc1", "#c572d3", "#36c1b3",
      "#b57052", "#ed69af"]
    label_type: name
    show_null_points: true
    listen:
      Flow Before: dfcx_transcript.source_flow_display_name
      Page Before: dfcx_transcript.source_page_display_name
      Agent Response Before: dfcx_transcript_metadata.source_agent_response
      Matched Intent: dfcx_transcript.matched_intent
      Match Type: dfcx_transcript.match_type
      User Utterance: dfcx_transcript.user_utterance
      Flow After: dfcx_transcript.flow_display_name
      Page After: dfcx_transcript.page_display_name
      Agent Response After: dfcx_transcript.agent_response
      Session Start Date: dfcx_session_metadata.session_start_date
      Agent Name: dfcx_session_metadata.agent_name
    row: 0
    col: 0
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

    explore: dfcx_session_metadata
    listens_to_filters: []
    field: dfcx_session_metadata.session_start_date
  - name: Agent Name
    title: Agent Name
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover

    explore: dfcx_session_metadata
    listens_to_filters: [Session Start Date, Flow Before, Page Before, Agent Response
        Before, Matched Intent, Match Type, User Utterance, Flow After, Page After,
      Agent Response After]
    field: dfcx_session_metadata.agent_name
  - name: Flow Before
    title: Flow Before
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover

    explore: dfcx_session_metadata
    listens_to_filters: [Session Start Date, Page Before, Agent Response Before, Matched
        Intent, Match Type, User Utterance, Flow After, Page After, Agent Response
        After, Agent Name]
    field: dfcx_transcript.source_flow_display_name
  - name: Page Before
    title: Page Before
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover

    explore: dfcx_session_metadata
    listens_to_filters: [Session Start Date, Flow Before, Agent Response Before, Matched
        Intent, Match Type, User Utterance, Flow After, Page After, Agent Response
        After, Agent Name]
    field: dfcx_transcript.source_page_display_name
  - name: Agent Response Before
    title: Agent Response Before
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover

    explore: dfcx_session_metadata
    listens_to_filters: [Session Start Date, Flow Before, Page Before, Matched Intent,
      Match Type, User Utterance, Flow After, Page After, Agent Response After, Agent
        Name]
    field: dfcx_transcript_metadata.source_agent_response
  - name: Matched Intent
    title: Matched Intent
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover

    explore: dfcx_session_metadata
    listens_to_filters: [Session Start Date, Flow Before, Page Before, Agent Response
        Before, Match Type, User Utterance, Flow After, Page After, Agent Response
        After, Agent Name]
    field: dfcx_transcript.matched_intent
  - name: Match Type
    title: Match Type
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover

    explore: dfcx_session_metadata
    listens_to_filters: [Session Start Date, Flow Before, Page Before, Agent Response
        Before, Matched Intent, User Utterance, Flow After, Page After, Agent Response
        After, Agent Name]
    field: dfcx_transcript.match_type
  - name: User Utterance
    title: User Utterance
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover

    explore: dfcx_session_metadata
    listens_to_filters: [Session Start Date, Flow Before, Page Before, Agent Response
        Before, Matched Intent, Match Type, Flow After, Page After, Agent Response
        After, Agent Name]
    field: dfcx_transcript.user_utterance
  - name: Flow After
    title: Flow After
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover

    explore: dfcx_session_metadata
    listens_to_filters: [Session Start Date, Flow Before, Page Before, Agent Response
        Before, Matched Intent, Match Type, User Utterance, Page After, Agent Response
        After, Agent Name]
    field: dfcx_transcript.flow_display_name
  - name: Page After
    title: Page After
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover

    explore: dfcx_session_metadata
    listens_to_filters: [Session Start Date, Flow Before, Page Before, Agent Response
        Before, Matched Intent, Match Type, User Utterance, Flow After, Agent Response
        After, Agent Name]
    field: dfcx_transcript.page_display_name
  - name: Agent Response After
    title: Agent Response After
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover

    explore: dfcx_session_metadata
    listens_to_filters: [Session Start Date, Flow Before, Page Before, Agent Response
        Before, Matched Intent, Match Type, User Utterance, Flow After, Page After,
      Agent Name]
    field: dfcx_transcript.agent_response
