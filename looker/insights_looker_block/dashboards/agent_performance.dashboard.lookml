#    Copyright 2024 Google LLC

#    Licensed under the Apache License, Version 2.0 (the "License");
#    you may not use this file except in compliance with the License.
#    You may obtain a copy of the License at

#        http://www.apache.org/licenses/LICENSE-2.0

#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS,
#    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#    See the License for the specific language governing permissions and
#    limitations under the License.

- dashboard: agent_performance
  title: Agent Performance
  layout: newspaper
  preferred_viewer: dashboards-next
  crossfilter_enabled: true
  description: ''
  preferred_slug: fo1IFkQStmzblwaodWsHr1
  elements:
  - title: Top 5 Topics by Client Sentiment
    name: Top 5 Topics by Client Sentiment
    model: insights
    explore: insights_data
    type: looker_grid
    fields: [insights_data__topics.name, insights_data.conversation_count, insights_data.average_client_sentiment_category_value,
      insights_data.average_agent_sentiment_category_value]
    sorts: [insights_data.average_client_sentiment_category_value desc]
    limit: 5
    column_limit: 50
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: false
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: gray
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
    truncate_header: false
    minimum_column_width: 75
    series_labels:
      insights_data.conversation_count: Conversations
      insights_data.average_client_sentiment_category_value: Client Sentiment
      insights_data.average_agent_sentiment_category_value: Agent Sentiment
    series_column_widths:
      insights_data.conversation_count: 75
      insights_data.average_agent_sentiment_category_value: 73
      insights_data.average_client_sentiment_category_value: 75
    series_cell_visualizations:
      insights_data.conversation_count:
        is_active: false
      insights_data.average_client_sentiment_category_value:
        is_active: true
      insights_data.average_agent_sentiment_category_value:
        is_active: true
    conditional_formatting: [{type: greater than, value: 0, background_color: '',
        font_color: "#7CB342", color_application: {collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2,
          palette_id: 4a00499b-c0fe-4b15-a304-4083c07ff4c4, options: {constraints: {
              min: {type: minimum}, mid: {type: number, value: 0}, max: {type: maximum}},
            mirror: true, reverse: false, stepped: false}}, bold: false, italic: false,
        strikethrough: false, fields: [insights_data.average_agent_sentiment_category_value,
          insights_data.average_client_sentiment_category_value]}, {type: less than,
        value: 0, background_color: '', font_color: "#EA4335", color_application: {
          collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2, palette_id: 4a00499b-c0fe-4b15-a304-4083c07ff4c4,
          options: {constraints: {min: {type: minimum}, mid: {type: number, value: 0},
              max: {type: maximum}}, mirror: true, reverse: false, stepped: false}},
        bold: false, italic: false, strikethrough: false, fields: [insights_data.average_agent_sentiment_category_value,
          insights_data.average_client_sentiment_category_value]}]
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
    stacking: normal
    legend_position: center
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: '', orientation: bottom, series: [{axisId: insights_data.average_agent_speaking_percentage,
            id: insights_data.average_agent_speaking_percentage, name: Average Agent
              Speaking Percentage}], showLabels: false, showValues: true, unpinAxis: false,
        tickDensity: default, tickDensityCustom: 5, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    hidden_series: []
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    single_value_title: Avg Silence Minutes
    comparison_label: Avg Conversation Silence %
    defaults_version: 1
    show_null_points: true
    interpolation: linear
    hidden_fields:
    hidden_pivots: {}
    listen:
      Agent ID Selector: insights_data__agents.agent_id
      Start Date: insights_data.start_date
      Topic Name: insights_data__topics.name
      Medium: insights_data.medium
    row: 19
    col: 0
    width: 12
    height: 7
  - title: Avg Silence
    name: Avg Silence
    model: insights
    explore: insights_data
    type: single_value
    fields: [agent_filter.agent_id_selected, insights_data.average_talk_minutes, insights_data.average_hold_minutes,
      insights_data.average_silence_minutes, insights_data.average_duration_minutes,
      insights_data.average_talk_minutes_75_percentile, insights_data.average_hold_minutes_75_percentile,
      insights_data.average_silence_minutes_75_percentile, insights_data.average_duration_minutes_75_percentile,
      insights_data.avg_conversations_per_agent, insights_data.conversation_count,
      insights_data.average_client_sentiment_category_value]
    sorts: [agent_filter.agent_id_selected desc]
    limit: 500
    column_limit: 50
    dynamic_fields: [{category: table_calculation, expression: 'if(${agent_filter.agent_id_selected}="
          All Other Agents", ${insights_data.average_silence_minutes_75_percentile},
          ${insights_data.average_silence_minutes})', label: Avg Silence Time, value_format: !!null '',
        value_format_name: decimal_1, _kind_hint: measure, table_calculation: avg_silence_time,
        _type_hint: number}]
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    single_value_title: Avg Silence (min)
    comparison_label: All Other Agents (75%)
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
    header_font_size: '12'
    rows_font_size: '12'
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    truncate_header: false
    minimum_column_width: 75
    series_cell_visualizations:
      insights_data.average_talk_minutes:
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
    hidden_fields: [insights_data.average_hold_minutes, insights_data.average_talk_minutes,
      insights_data.average_silence_minutes, insights_data.average_duration_minutes,
      insights_data.average_talk_minutes_75_percentile, insights_data.average_hold_minutes_75_percentile,
      insights_data.average_silence_minutes_75_percentile, insights_data.average_duration_minutes_75_percentile,
      agent_filter.agent_id_selected, insights_data.avg_conversations_per_agent, insights_data.conversation_count,
      insights_data.average_client_sentiment_category_value]
    note_state: collapsed
    note_display: hover
    note_text: Average speaking time (Agent + Customer) in minutes per conversation
    listen:
      Agent ID Selector: agent_filter.agent_id_selector
      Start Date: insights_data.start_date
      Topic Name: insights_data__topics.name
      Medium: insights_data.medium
    row: 0
    col: 8
    width: 4
    height: 4
  - title: Client Sentiment Over Time
    name: Client Sentiment Over Time
    model: insights
    explore: insights_data
    type: looker_line
    fields: [insights_data.average_client_sentiment_category_value, agent_filter.agent_id_selected,
      insights_data.start_date]
    pivots: [agent_filter.agent_id_selected]
    sorts: [agent_filter.agent_id_selected desc, insights_data.average_client_sentiment_category_value
        desc 0]
    limit: 500
    column_limit: 500
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
    stacking: normal
    limit_displayed_rows: false
    legend_position: center
    point_style: circle
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: false
    interpolation: linear
    y_axes: [{label: '', orientation: bottom, series: [{axisId: insights_data.average_agent_speaking_percentage,
            id: insights_data.average_agent_speaking_percentage, name: Average Agent
              Speaking Percentage}], showLabels: false, showValues: true, unpinAxis: false,
        tickDensity: default, tickDensityCustom: 5, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    hidden_series: []
    series_labels:
      " All Other Agents - insights_data.average_client_sentiment_category_value": All
        Other Agents
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    single_value_title: Avg Silence Minutes
    comparison_label: Avg Conversation Silence %
    defaults_version: 1
    hidden_fields:
    hidden_pivots: {}
    listen:
      Agent ID Selector: agent_filter.agent_id_selector
      Start Date: insights_data.start_date
      Topic Name: insights_data__topics.name
      Medium: insights_data.medium
    row: 26
    col: 0
    width: 24
    height: 7
  - title: Handle Time Trend
    name: Handle Time Trend
    model: insights
    explore: insights_data
    type: looker_line
    fields: [agent_filter.agent_id_selected, insights_data.start_week, insights_data.average_duration_minutes]
    pivots: [agent_filter.agent_id_selected]
    sorts: [agent_filter.agent_id_selected desc, insights_data.start_week desc]
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
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: false
    interpolation: linear
    y_axes: [{label: '', orientation: bottom, series: [{axisId: insights_data.average_agent_speaking_percentage,
            id: insights_data.average_agent_speaking_percentage, name: Average Agent
              Speaking Percentage}], showLabels: false, showValues: true, unpinAxis: false,
        tickDensity: default, tickDensityCustom: 5, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    hidden_series: [" All Other Agents - employee_info.vendor_name___null - insights_data.average_silence_percentage",
      " All Other Agents - employee_info.vendor_name___null - insights_data.average_duration_minutes"]
    series_labels:
      insights_data.conversation_count: Conversations
      insights_data.average_client_sentiment_category_value: Client Sentiment
      insights_data.average_agent_sentiment_category_value: Agent Sentiment
      " All Other Agents - insights_data.average_duration_minutes": All Other Agents
    show_row_numbers: false
    transpose: false
    truncate_text: false
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: gray
    enable_conditional_formatting: true
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
      insights_data.conversation_count:
        is_active: false
      insights_data.average_client_sentiment_category_value:
        is_active: true
      insights_data.average_agent_sentiment_category_value:
        is_active: true
    conditional_formatting: [{type: greater than, value: 0, background_color: '',
        font_color: "#7CB342", color_application: {collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2,
          palette_id: 4a00499b-c0fe-4b15-a304-4083c07ff4c4, options: {constraints: {
              min: {type: minimum}, mid: {type: number, value: 0}, max: {type: maximum}},
            mirror: true, reverse: false, stepped: false}}, bold: false, italic: false,
        strikethrough: false, fields: []}, {type: less than, value: 0, background_color: '',
        font_color: "#EA4335", color_application: {collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2,
          palette_id: 4a00499b-c0fe-4b15-a304-4083c07ff4c4, options: {constraints: {
              min: {type: minimum}, mid: {type: number, value: 0}, max: {type: maximum}},
            mirror: true, reverse: false, stepped: false}}, bold: false, italic: false,
        strikethrough: false, fields: []}]
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    single_value_title: Avg Silence Minutes
    comparison_label: Avg Conversation Silence %
    defaults_version: 1
    hidden_pivots: {}
    listen:
      Agent ID Selector: agent_filter.agent_id_selector
      Start Date: insights_data.start_date
      Topic Name: insights_data__topics.name
      Medium: insights_data.medium
    row: 10
    col: 12
    width: 12
    height: 9
  - title: Silence % Trend
    name: Silence % Trend
    model: insights
    explore: insights_data
    type: looker_line
    fields: [insights_data.average_silence_percentage, agent_filter.agent_id_selected,
      insights_data.start_week]
    pivots: [agent_filter.agent_id_selected]
    sorts: [agent_filter.agent_id_selected desc, insights_data.start_week desc]
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
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: false
    interpolation: linear
    y_axes: [{label: '', orientation: bottom, series: [{axisId: insights_data.average_agent_speaking_percentage,
            id: insights_data.average_agent_speaking_percentage, name: Average Agent
              Speaking Percentage}], showLabels: false, showValues: true, unpinAxis: false,
        tickDensity: default, tickDensityCustom: 5, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    hidden_series: [" All Other Agents - employee_info.vendor_name___null - insights_data.average_silence_percentage"]
    series_labels:
      insights_data.conversation_count: Conversations
      insights_data.average_client_sentiment_category_value: Client Sentiment
      insights_data.average_agent_sentiment_category_value: Agent Sentiment
      " All Other Agents - insights_data.average_silence_percentage": All Other Agents
    show_row_numbers: false
    transpose: false
    truncate_text: false
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: gray
    enable_conditional_formatting: true
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
      insights_data.conversation_count:
        is_active: false
      insights_data.average_client_sentiment_category_value:
        is_active: true
      insights_data.average_agent_sentiment_category_value:
        is_active: true
    conditional_formatting: [{type: greater than, value: 0, background_color: '',
        font_color: "#7CB342", color_application: {collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2,
          palette_id: 4a00499b-c0fe-4b15-a304-4083c07ff4c4, options: {constraints: {
              min: {type: minimum}, mid: {type: number, value: 0}, max: {type: maximum}},
            mirror: true, reverse: false, stepped: false}}, bold: false, italic: false,
        strikethrough: false, fields: []}, {type: less than, value: 0, background_color: '',
        font_color: "#EA4335", color_application: {collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2,
          palette_id: 4a00499b-c0fe-4b15-a304-4083c07ff4c4, options: {constraints: {
              min: {type: minimum}, mid: {type: number, value: 0}, max: {type: maximum}},
            mirror: true, reverse: false, stepped: false}}, bold: false, italic: false,
        strikethrough: false, fields: []}]
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    single_value_title: Avg Silence Minutes
    comparison_label: Avg Conversation Silence %
    defaults_version: 1
    hidden_pivots: {}
    listen:
      Agent ID Selector: agent_filter.agent_id_selector
      Start Date: insights_data.start_date
      Topic Name: insights_data__topics.name
      Medium: insights_data.medium
    row: 10
    col: 0
    width: 12
    height: 9
  - title: Agent Comparison by intents
    name: Agent Comparison by intents
    model: insights
    explore: insights_data
    type: looker_grid
    fields: [agent_filter.agent_id_selected, insights_data.average_talk_minutes, insights_data.average_hold_minutes,
      insights_data.average_silence_minutes, insights_data.average_duration_minutes,
      insights_data.authentication_pct, insights_data.check_issue_resolved_pct, insights_data.confirm_issue_resolved_pct,
      insights_data.conversation_count, insights_data.closing_pct, insights_data.greeting_pct,
      insights_data.ability_to_understand_agent_pct]
    sorts: [agent_filter.agent_id_selected desc, employee_info.vendor_name]
    limit: 500
    column_limit: 50
    show_view_names: false
    show_row_numbers: true
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
    minimum_column_width: 75
    series_cell_visualizations:
      insights_data.average_talk_minutes:
        is_active: false
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    single_value_title: Avg Talk Time (Min)
    comparison_label: All Other Agents
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
    note_state: collapsed
    note_display: hover
    note_text: Average speaking time (Agent + Customer) in minutes per conversation
    listen:
      Agent ID Selector: agent_filter.agent_id_selector
      Start Date: insights_data.start_date
      Topic Name: insights_data__topics.name
      Medium: insights_data.medium
    row: 4
    col: 0
    width: 24
    height: 6
  - title: Avg Hold
    name: Avg Hold
    model: insights
    explore: insights_data
    type: single_value
    fields: [agent_filter.agent_id_selected, insights_data.average_talk_minutes, insights_data.average_hold_minutes,
      insights_data.average_silence_minutes, insights_data.average_duration_minutes,
      insights_data.average_talk_minutes_75_percentile, insights_data.average_hold_minutes_75_percentile,
      insights_data.average_silence_minutes_75_percentile, insights_data.average_duration_minutes_75_percentile,
      insights_data.avg_conversations_per_agent, insights_data.conversation_count,
      insights_data.average_client_sentiment_category_value]
    sorts: [agent_filter.agent_id_selected desc]
    limit: 500
    column_limit: 50
    dynamic_fields: [{category: table_calculation, expression: 'if(${agent_filter.agent_id_selected}="
          All Other Agents", ${insights_data.average_hold_minutes_75_percentile},
          ${insights_data.average_hold_minutes})', label: Avg Hold Time, value_format: !!null '',
        value_format_name: decimal_1, _kind_hint: measure, table_calculation: avg_hold_time,
        _type_hint: number}]
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    single_value_title: Avg Hold (min)
    comparison_label: All Other Agents (75%)
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
    header_font_size: '12'
    rows_font_size: '12'
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    truncate_header: false
    minimum_column_width: 75
    series_cell_visualizations:
      insights_data.average_talk_minutes:
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
    hidden_fields: [insights_data.average_hold_minutes, insights_data.average_talk_minutes,
      insights_data.average_silence_minutes, insights_data.average_duration_minutes,
      insights_data.average_talk_minutes_75_percentile, insights_data.average_hold_minutes_75_percentile,
      insights_data.average_silence_minutes_75_percentile, insights_data.average_duration_minutes_75_percentile,
      agent_filter.agent_id_selected, insights_data.avg_conversations_per_agent, insights_data.conversation_count,
      insights_data.average_client_sentiment_category_value]
    note_state: collapsed
    note_display: hover
    note_text: Average speaking time (Agent + Customer) in minutes per conversation
    listen:
      Agent ID Selector: agent_filter.agent_id_selector
      Start Date: insights_data.start_date
      Topic Name: insights_data__topics.name
      Medium: insights_data.medium
    row: 0
    col: 4
    width: 4
    height: 4
  - title: Avg Client Sentiment
    name: Avg Client Sentiment
    model: insights
    explore: insights_data
    type: single_value
    fields: [agent_filter.agent_id_selected, insights_data.average_talk_minutes, insights_data.average_hold_minutes,
      insights_data.average_silence_minutes, insights_data.average_duration_minutes,
      insights_data.average_talk_minutes_75_percentile, insights_data.average_hold_minutes_75_percentile,
      insights_data.average_silence_minutes_75_percentile, insights_data.average_duration_minutes_75_percentile,
      insights_data.avg_conversations_per_agent, insights_data.conversation_count,
      insights_data.average_client_sentiment_category_value]
    sorts: [agent_filter.agent_id_selected desc]
    limit: 500
    column_limit: 50
    dynamic_fields: [{category: table_calculation, expression: 'if(${agent_filter.agent_id_selected}="
          All Other Agents", ${insights_data.avg_conversations_per_agent}, ${insights_data.conversation_count})',
        label: Volume, value_format: !!null '', value_format_name: decimal_0, _kind_hint: measure,
        table_calculation: volume, _type_hint: number}]
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    single_value_title: Avg Client Sentiment
    comparison_label: All Other Agents Avg
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
    header_font_size: '12'
    rows_font_size: '12'
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    truncate_header: false
    minimum_column_width: 75
    series_cell_visualizations:
      insights_data.average_talk_minutes:
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
    hidden_fields: [insights_data.average_hold_minutes, insights_data.average_talk_minutes,
      insights_data.average_silence_minutes, insights_data.average_duration_minutes,
      insights_data.average_talk_minutes_75_percentile, insights_data.average_hold_minutes_75_percentile,
      insights_data.average_silence_minutes_75_percentile, insights_data.average_duration_minutes_75_percentile,
      agent_filter.agent_id_selected, insights_data.avg_conversations_per_agent, insights_data.conversation_count,
      volume]
    note_state: collapsed
    note_display: hover
    note_text: Average speaking time (Agent + Customer) in minutes per conversation
    listen:
      Agent ID Selector: agent_filter.agent_id_selector
      Start Date: insights_data.start_date
      Topic Name: insights_data__topics.name
      Medium: insights_data.medium
    row: 0
    col: 20
    width: 4
    height: 4
  - title: Avg Talk
    name: Avg Talk
    model: insights
    explore: insights_data
    type: single_value
    fields: [agent_filter.agent_id_selected, insights_data.average_talk_minutes, insights_data.average_hold_minutes,
      insights_data.average_silence_minutes, insights_data.average_duration_minutes,
      insights_data.average_talk_minutes_75_percentile, insights_data.average_hold_minutes_75_percentile,
      insights_data.average_silence_minutes_75_percentile, insights_data.average_duration_minutes_75_percentile,
      insights_data.avg_conversations_per_agent, insights_data.conversation_count,
      insights_data.average_client_sentiment_category_value]
    sorts: [agent_filter.agent_id_selected desc]
    limit: 500
    column_limit: 50
    dynamic_fields: [{category: table_calculation, expression: 'if(${agent_filter.agent_id_selected}="
          All Other Agents", ${insights_data.average_talk_minutes_75_percentile},
          ${insights_data.average_talk_minutes})', label: Avg TalkTime, value_format: !!null '',
        value_format_name: decimal_1, _kind_hint: measure, table_calculation: avg_talktime,
        _type_hint: number}]
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    single_value_title: Avg Talk (min)
    comparison_label: All Other Agents (75%)
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
    header_font_size: '12'
    rows_font_size: '12'
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    truncate_header: false
    minimum_column_width: 75
    series_cell_visualizations:
      insights_data.average_talk_minutes:
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
    hidden_fields: [insights_data.average_hold_minutes, insights_data.average_talk_minutes,
      insights_data.average_silence_minutes, insights_data.average_duration_minutes,
      insights_data.average_talk_minutes_75_percentile, insights_data.average_hold_minutes_75_percentile,
      insights_data.average_silence_minutes_75_percentile, insights_data.average_duration_minutes_75_percentile,
      agent_filter.agent_id_selected, insights_data.avg_conversations_per_agent, insights_data.conversation_count,
      insights_data.average_client_sentiment_category_value]
    note_state: collapsed
    note_display: hover
    note_text: Average speaking time (Agent + Customer) in minutes per conversation
    listen:
      Agent ID Selector: agent_filter.agent_id_selector
      Start Date: insights_data.start_date
      Topic Name: insights_data__topics.name
      Medium: insights_data.medium
    row: 0
    col: 0
    width: 4
    height: 4
  - title: Avg Duration
    name: Avg Duration
    model: insights
    explore: insights_data
    type: single_value
    fields: [agent_filter.agent_id_selected, insights_data.average_talk_minutes, insights_data.average_hold_minutes,
      insights_data.average_silence_minutes, insights_data.average_duration_minutes,
      insights_data.average_talk_minutes_75_percentile, insights_data.average_hold_minutes_75_percentile,
      insights_data.average_silence_minutes_75_percentile, insights_data.average_duration_minutes_75_percentile,
      insights_data.avg_conversations_per_agent, insights_data.conversation_count,
      insights_data.average_client_sentiment_category_value]
    sorts: [agent_filter.agent_id_selected desc]
    limit: 500
    column_limit: 50
    dynamic_fields: [{category: table_calculation, expression: 'if(${agent_filter.agent_id_selected}="
          All Other Agents", ${insights_data.average_duration_minutes_75_percentile},
          ${insights_data.average_duration_minutes})', label: Avg Duration, value_format: !!null '',
        value_format_name: decimal_1, _kind_hint: measure, table_calculation: avg_duration,
        _type_hint: number}]
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    single_value_title: Avg Duration (min)
    comparison_label: All Other Agents (75%)
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
    header_font_size: '12'
    rows_font_size: '12'
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    truncate_header: false
    minimum_column_width: 75
    series_cell_visualizations:
      insights_data.average_talk_minutes:
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
    hidden_fields: [insights_data.average_hold_minutes, insights_data.average_talk_minutes,
      insights_data.average_silence_minutes, insights_data.average_duration_minutes,
      insights_data.average_talk_minutes_75_percentile, insights_data.average_hold_minutes_75_percentile,
      insights_data.average_silence_minutes_75_percentile, insights_data.average_duration_minutes_75_percentile,
      agent_filter.agent_id_selected, insights_data.avg_conversations_per_agent, insights_data.conversation_count,
      insights_data.average_client_sentiment_category_value]
    note_state: collapsed
    note_display: hover
    note_text: Average speaking time (Agent + Customer) in minutes per conversation
    listen:
      Agent ID Selector: agent_filter.agent_id_selector
      Start Date: insights_data.start_date
      Topic Name: insights_data__topics.name
      Medium: insights_data.medium
    row: 0
    col: 12
    width: 4
    height: 4
  - title: Recent Conversation
    name: Recent Conversation
    model: insights
    explore: insights_data
    type: looker_grid
    fields: [insights_data.conversation_name, insights_data.medium, insights_data.start_date,
      insights_data.turn_count, insights_data.client_speaking_minutes, insights_data.client_sentiment_category,
      insights_data.agent_speaking_minutes, insights_data.agent_sentiment_category]
    sorts: [insights_data.start_date desc]
    limit: 250
    column_limit: 50
    show_view_names: false
    show_row_numbers: true
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
    truncate_header: false
    minimum_column_width: 75
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: "#1A73E8",
        font_color: !!null '', color_application: {collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2,
          palette_id: 4a00499b-c0fe-4b15-a304-4083c07ff4c4, options: {constraints: {
              min: {type: minimum}, mid: {type: number, value: 0}, max: {type: maximum}},
            mirror: true, reverse: false, stepped: false}}, bold: false, italic: false,
        strikethrough: false, fields: []}]
    x_axis_gridlines: false
    y_axis_gridlines: true
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
    stacking: normal
    legend_position: center
    point_style: circle
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    y_axes: [{label: '', orientation: bottom, series: [{axisId: insights_data.average_agent_speaking_percentage,
            id: insights_data.average_agent_speaking_percentage, name: Average Agent
              Speaking Percentage}], showLabels: false, showValues: true, unpinAxis: false,
        tickDensity: default, tickDensityCustom: 5, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    hidden_series: []
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    single_value_title: Avg Silence Minutes
    comparison_label: Avg Conversation Silence %
    defaults_version: 1
    hidden_fields:
    hidden_pivots: {}
    listen:
      Agent ID Selector: insights_data__agents.agent_id
      Start Date: insights_data.start_date
      Topic Name: insights_data__topics.name
      Medium: insights_data.medium
    row: 33
    col: 0
    width: 24
    height: 7
  - title: Bottom 5 Topics by Client Sentiment
    name: Bottom 5 Topics by Client Sentiment
    model: insights
    explore: insights_data
    type: looker_grid
    fields: [insights_data__topics.name, insights_data.conversation_count, insights_data.average_client_sentiment_category_value,
      insights_data.average_agent_sentiment_category_value]
    sorts: [insights_data.average_client_sentiment_category_value]
    limit: 5
    column_limit: 50
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: false
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: gray
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
    truncate_header: false
    minimum_column_width: 75
    series_labels:
      insights_data.conversation_count: Conversations
      insights_data.average_client_sentiment_category_value: Client Sentiment
      insights_data.average_agent_sentiment_category_value: Agent Sentiment
    series_column_widths:
      insights_data.conversation_count: 75
      insights_data.average_agent_sentiment_category_value: 73
      insights_data.average_client_sentiment_category_value: 75
    series_cell_visualizations:
      insights_data.conversation_count:
        is_active: false
      insights_data.average_client_sentiment_category_value:
        is_active: true
      insights_data.average_agent_sentiment_category_value:
        is_active: true
    conditional_formatting: [{type: greater than, value: 0, background_color: '',
        font_color: "#7CB342", color_application: {collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2,
          palette_id: 4a00499b-c0fe-4b15-a304-4083c07ff4c4, options: {constraints: {
              min: {type: minimum}, mid: {type: number, value: 0}, max: {type: maximum}},
            mirror: true, reverse: false, stepped: false}}, bold: false, italic: false,
        strikethrough: false, fields: [insights_data.average_agent_sentiment_category_value,
          insights_data.average_client_sentiment_category_value]}, {type: less than,
        value: 0, background_color: '', font_color: "#EA4335", color_application: {
          collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2, palette_id: 4a00499b-c0fe-4b15-a304-4083c07ff4c4,
          options: {constraints: {min: {type: minimum}, mid: {type: number, value: 0},
              max: {type: maximum}}, mirror: true, reverse: false, stepped: false}},
        bold: false, italic: false, strikethrough: false, fields: [insights_data.average_agent_sentiment_category_value,
          insights_data.average_client_sentiment_category_value]}]
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
    stacking: normal
    legend_position: center
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: '', orientation: bottom, series: [{axisId: insights_data.average_agent_speaking_percentage,
            id: insights_data.average_agent_speaking_percentage, name: Average Agent
              Speaking Percentage}], showLabels: false, showValues: true, unpinAxis: false,
        tickDensity: default, tickDensityCustom: 5, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    hidden_series: []
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    single_value_title: Avg Silence Minutes
    comparison_label: Avg Conversation Silence %
    defaults_version: 1
    show_null_points: true
    interpolation: linear
    hidden_fields:
    hidden_pivots: {}
    listen:
      Agent ID Selector: insights_data__agents.agent_id
      Start Date: insights_data.start_date
      Topic Name: insights_data__topics.name
      Medium: insights_data.medium
    row: 19
    col: 12
    width: 12
    height: 7
  - title: Volume
    name: Volume
    model: insights
    explore: insights_data
    type: single_value
    fields: [agent_filter.agent_id_selected, insights_data.average_talk_minutes, insights_data.average_hold_minutes,
      insights_data.average_silence_minutes, insights_data.average_duration_minutes,
      insights_data.average_talk_minutes_75_percentile, insights_data.average_hold_minutes_75_percentile,
      insights_data.average_silence_minutes_75_percentile, insights_data.average_duration_minutes_75_percentile,
      insights_data.avg_conversations_per_agent, insights_data.conversation_count,
      insights_data.average_client_sentiment_category_value]
    sorts: [agent_filter.agent_id_selected desc]
    limit: 500
    column_limit: 50
    dynamic_fields: [{category: table_calculation, expression: 'if(${agent_filter.agent_id_selected}="
          All Other Agents", ${insights_data.avg_conversations_per_agent}, ${insights_data.conversation_count})',
        label: Volume, value_format: !!null '', value_format_name: decimal_0, _kind_hint: measure,
        table_calculation: volume, _type_hint: number}]
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    single_value_title: Conversations
    comparison_label: All Other Agents Avg
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
    header_font_size: '12'
    rows_font_size: '12'
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    truncate_header: false
    minimum_column_width: 75
    series_cell_visualizations:
      insights_data.average_talk_minutes:
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
    hidden_fields: [insights_data.average_hold_minutes, insights_data.average_talk_minutes,
      insights_data.average_silence_minutes, insights_data.average_duration_minutes,
      insights_data.average_talk_minutes_75_percentile, insights_data.average_hold_minutes_75_percentile,
      insights_data.average_silence_minutes_75_percentile, insights_data.average_duration_minutes_75_percentile,
      agent_filter.agent_id_selected, insights_data.avg_conversations_per_agent, insights_data.conversation_count,
      insights_data.average_client_sentiment_category_value]
    note_state: collapsed
    note_display: hover
    note_text: Average speaking time (Agent + Customer) in minutes per conversation
    listen:
      Agent ID Selector: agent_filter.agent_id_selector
      Start Date: insights_data.start_date
      Topic Name: insights_data__topics.name
      Medium: insights_data.medium
    row: 0
    col: 16
    width: 4
    height: 4
  filters:
  - name: Agent ID Selector
    title: Agent ID Selector
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: true
    ui_config:
      type: advanced
      display: popover
    model: insights
    explore: insights_data
    listens_to_filters: []
    field: agent_filter.agent_id_selector
  - name: Start Date
    title: Start Date
    type: field_filter
    default_value: 1 quarter ago for 1 quarter
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
      options: []
    model: insights
    explore: insights_data
    listens_to_filters: []
    field: insights_data.start_date
  - name: Topic Name
    title: Topic Name
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
    model: insights
    explore: insights_data
    listens_to_filters: []
    field: insights_data__topics.name
  - name: Medium
    title: Medium
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: button_toggles
      display: inline
      options:
    model: insights
    explore: insights_data
    listens_to_filters: []
    field: insights_data.medium
