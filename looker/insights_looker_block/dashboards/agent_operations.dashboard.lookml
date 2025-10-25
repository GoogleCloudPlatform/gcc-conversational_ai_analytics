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

- dashboard: agent_operations
  title: Agent Operations
  layout: newspaper
  preferred_viewer: dashboards-next
  description: ''
  preferred_slug: TWKoGAUkTA1irNA8sL89NV
  elements:
  - title: by Date
    name: by Date
    model: insights
    explore: insights_data
    type: looker_line
    fields: [insights_data.start_date, insights_data.average_talk_minutes, insights_data.average_hold_minutes,
      insights_data.average_silence_minutes]
    fill_fields: [insights_data.start_date]
    filters: {}
    sorts: [insights_data.start_date desc]
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
    point_style: circle
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: false
    interpolation: linear
    y_axes: [{label: '', orientation: left, series: [{axisId: insights_data.average_agent_speaking_percentage,
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
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    single_value_title: Avg Silence Minutes
    comparison_label: Avg Conversation Silence %
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    hidden_fields:
    hidden_pivots: {}
    listen:
      Start Date: insights_data.start_date
      Topic Name: insights_data__topics.name
      Custom Highlight Name: insights_data__sentences__phrase_match_data.display_name
      Medium: insights_data.medium
    row: 4
    col: 0
    width: 16
    height: 7
  - title: Avg Hold Time
    name: Avg Hold Time
    model: insights
    explore: insights_data
    type: single_value
    fields: [insights_data.average_hold_minutes, insights_data.average_hold_percentage]
    filters: {}
    limit: 500
    column_limit: 50
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    single_value_title: Avg Hold Time (Min)
    comparison_label: of Conversation
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
    defaults_version: 1
    hidden_pivots: {}
    note_state: collapsed
    note_display: hover
    note_text: Average minutes of total conversation spent on hold (calculated as
      conversation duration - talk time - silence time)
    listen:
      Start Date: insights_data.start_date
      Topic Name: insights_data__topics.name
      Custom Highlight Name: insights_data__sentences__phrase_match_data.display_name
      Medium: insights_data.medium
    row: 0
    col: 4
    width: 4
    height: 4
  - title: Avg Talk Time
    name: Avg Talk Time
    model: insights
    explore: insights_data
    type: single_value
    fields: [insights_data.average_talk_minutes, insights_data.average_talk_percentage]
    filters: {}
    limit: 500
    column_limit: 50
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    single_value_title: Avg Talk Time (Min)
    comparison_label: of Conversation
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
    defaults_version: 1
    hidden_pivots: {}
    note_state: collapsed
    note_display: hover
    note_text: Average speaking time (Agent + Customer) in minutes per conversation
    listen:
      Start Date: insights_data.start_date
      Topic Name: insights_data__topics.name
      Custom Highlight Name: insights_data__sentences__phrase_match_data.display_name
      Medium: insights_data.medium
    row: 0
    col: 0
    width: 4
    height: 4
  - title: by Top Topics
    name: by Top Topics
    model: insights
    explore: insights_data
    type: looker_bar
    fields: [insights_data__topics.name, insights_data.average_talk_minutes, insights_data.average_hold_minutes,
      insights_data.conversation_count, insights_data.average_silence_minutes]
    filters: {}
    sorts: [insights_data.conversation_count desc]
    limit: 15
    column_limit: 50
    filter_expression: NOT is_null(${insights_data__topics.name})
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
    legend_position: right
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: true
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
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    single_value_title: Avg Silence Minutes
    comparison_label: Avg Conversation Silence %
    defaults_version: 1
    show_null_points: true
    interpolation: linear
    hidden_fields: [insights_data.conversation_count]
    hidden_pivots: {}
    listen:
      Start Date: insights_data.start_date
      Topic Name: insights_data__topics.name
      Custom Highlight Name: insights_data__sentences__phrase_match_data.display_name
      Medium: insights_data.medium
    row: 11
    col: 0
    width: 16
    height: 7
  - title: Untitled
    name: Untitled
    model: insights
    explore: insights_data
    type: single_value
    fields: [insights_data.average_silence_minutes, insights_data.average_silence_percentage]
    filters: {}
    limit: 500
    column_limit: 50
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    single_value_title: Average Silence (Min)
    comparison_label: "% of Conversation"
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
    defaults_version: 1
    listen:
      Start Date: insights_data.start_date
      Custom Highlight Name: insights_data__sentences__phrase_match_data.display_name
      Medium: insights_data.medium
    row: 0
    col: 8
    width: 4
    height: 4
  - title: Volume
    name: Volume
    model: insights
    explore: insights_data
    type: single_value
    fields: [insights_data.conversation_count]
    filters: {}
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
    single_value_title: Conversation Volume
    comparison_label: Avg Conversation Hold %
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
    defaults_version: 1
    hidden_pivots: {}
    listen:
      Start Date: insights_data.start_date
      Topic Name: insights_data__topics.name
      Custom Highlight Name: insights_data__sentences__phrase_match_data.display_name
      Medium: insights_data.medium
    row: 0
    col: 16
    width: 4
    height: 4
  - title: Sentiment
    name: Sentiment
    model: insights
    explore: insights_data
    type: single_value
    fields: [insights_data.average_client_sentiment_category_value, insights_data.average_agent_sentiment_category_value]
    filters: {}
    limit: 500
    column_limit: 50
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    single_value_title: Client Sentiment
    comparison_label: Agent Sentiment
    conditional_formatting: []
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
    defaults_version: 1
    hidden_pivots: {}
    listen:
      Start Date: insights_data.start_date
      Topic Name: insights_data__topics.name
      Custom Highlight Name: insights_data__sentences__phrase_match_data.display_name
      Medium: insights_data.medium
    row: 0
    col: 20
    width: 4
    height: 4
  - title: Bottom 5 Topics (By Sentiment)
    name: Bottom 5 Topics (By Sentiment)
    model: insights
    explore: insights_data
    type: looker_grid
    fields: [insights_data__topics.name, insights_data.conversation_count, insights_data.average_client_sentiment_category_value,
      insights_data.average_agent_sentiment_category_value]
    filters: {}
    sorts: [insights_data.average_client_sentiment_category_value]
    limit: 5
    column_limit: 50
    filter_expression: NOT is_null(${insights_data__topics.name})
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
      Start Date: insights_data.start_date
      Topic Name: insights_data__topics.name
      Custom Highlight Name: insights_data__sentences__phrase_match_data.display_name
      Medium: insights_data.medium
    row: 11
    col: 16
    width: 8
    height: 7
  - title: Client and Agent Sentiment Over Time
    name: Client and Agent Sentiment Over Time
    model: insights
    explore: insights_data
    type: looker_line
    fields: [insights_data.start_date, insights_data.average_client_sentiment_category_value,
      insights_data.average_agent_sentiment_category_value]
    filters: {}
    sorts: [insights_data.average_client_sentiment_category_value desc]
    limit: 15
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
    stacking: normal
    limit_displayed_rows: false
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
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    single_value_title: Avg Silence Minutes
    comparison_label: Avg Conversation Silence %
    defaults_version: 1
    hidden_fields:
    hidden_pivots: {}
    listen:
      Start Date: insights_data.start_date
      Topic Name: insights_data__topics.name
      Custom Highlight Name: insights_data__sentences__phrase_match_data.display_name
      Medium: insights_data.medium
    row: 18
    col: 0
    width: 24
    height: 5
  - title: Agent List
    name: Agent List
    model: insights
    explore: insights_data
    type: looker_grid
    fields: [insights_data.average_duration_minutes, insights_data.average_hold_minutes,
      insights_data.conversation_count, insights_data.average_client_sentiment_score,
      insights_data.good_sentiment_ratio, insights_data__agents.agent_id]
    filters: {}
    sorts: [insights_data.average_duration_minutes desc]
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
      insights_data.average_duration_minutes:
        is_active: true
    hidden_pivots: {}
    defaults_version: 1
    listen:
      Start Date: insights_data.start_date
      Medium: insights_data.medium
    row: 23
    col: 0
    width: 24
    height: 7
  - title: Top 5 Topics (By Sentiment)
    name: Top 5 Topics (By Sentiment)
    model: insights
    explore: insights_data
    type: looker_grid
    fields: [insights_data__topics.name, insights_data.conversation_count, insights_data.average_client_sentiment_category_value,
      insights_data.average_agent_sentiment_category_value]
    filters: {}
    sorts: [insights_data.average_client_sentiment_category_value desc]
    limit: 5
    column_limit: 50
    filter_expression: NOT is_null(${insights_data__topics.name})
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
      Start Date: insights_data.start_date
      Topic Name: insights_data__topics.name
      Custom Highlight Name: insights_data__sentences__phrase_match_data.display_name
      Medium: insights_data.medium
    row: 4
    col: 16
    width: 8
    height: 7
  - title: Untitled
    name: Untitled (2)
    model: insights
    explore: insights_data
    type: single_value
    fields: [insights_data.average_duration_minutes]
    filters: {}
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
    single_value_title: Average Duration (Minutes)
    defaults_version: 1
    listen:
      Start Date: insights_data.start_date
      Custom Highlight Name: insights_data__sentences__phrase_match_data.display_name
      Medium: insights_data.medium
    row: 0
    col: 12
    width: 4
    height: 4
  filters:
  - name: Start Date
    title: Start Date
    type: field_filter
    default_value: 1 month ago for 1 month
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
      options: []
    model: insights
    explore: insights_data
    listens_to_filters: []
    field: insights_data__topics.name
  - name: Custom Highlight Name
    title: Custom Highlight Name
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
      options: []
    model: insights
    explore: insights_data
    listens_to_filters: []
    field: insights_data__sentences__phrase_match_data.display_name
  - name: Medium
    title: Medium
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: button_group
      display: inline
      options:
    model: insights
    explore: insights_data
    listens_to_filters: []
    field: insights_data.medium
