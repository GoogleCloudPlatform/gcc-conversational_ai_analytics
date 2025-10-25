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

- dashboard: conversation_lookup
  title: Conversation Lookup
  layout: newspaper
  preferred_viewer: dashboards-next
  description: ''
  preferred_slug: 3qLDHid925RR9wx3Q725MZ
  elements:
  - title: Transcript
    name: Transcript
    model: insights
    explore: insights_data
    type: looker_grid
    fields: [sentence_turn_number.turn_number, insights_data__sentences__phrase_match_data.display_name,
      insights_data__sentences.sentence, insights_data__sentences.participant_role,
      insights_data__sentences.average_sentiment_category_value, insights_data__sentences.sentiment_category]
    sorts: [sentence_turn_number.turn_number]
    limit: 500
    column_limit: 50
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: false
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
      insights_data__sentences.average_sentiment_category_value:
        is_active: true
    truncate_column_names: false
    defaults_version: 1
    hidden_fields: [sentence_turn_number.turn_number]
    listen:
      Conversation Name: insights_data.conversation_name
    row: 6
    col: 0
    width: 24
    height: 7
  - title: Client Sentiment
    name: Client Sentiment
    model: insights
    explore: insights_data
    type: single_value
    fields: [insights_data.client_sentiment_category, insights_data.average_client_sentiment_category_value]
    sorts: [insights_data.client_sentiment_category]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: false
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    conditional_formatting: [{type: equal to, value: !!null '', background_color: "#1A73E8",
        font_color: !!null '', color_application: {collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2,
          palette_id: 56d0c358-10a0-4fd6-aa0b-b117bef527ab}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}]
    defaults_version: 1
    listen:
      Conversation Name: insights_data.conversation_name
    row: 4
    col: 12
    width: 6
    height: 2
  - title: Duration
    name: Duration
    model: insights
    explore: insights_data
    type: single_value
    fields: [insights_data.minutes_conversation]
    sorts: [insights_data.minutes_conversation]
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
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: white
    limit_displayed_rows: false
    transpose: false
    truncate_text: true
    size_to_fit: true
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    defaults_version: 1
    hidden_fields: []
    listen:
      Conversation Name: insights_data.conversation_name
    row: 2
    col: 12
    width: 6
    height: 2
  - title: Most Salient Entities
    name: Most Salient Entities
    model: insights
    explore: insights_data
    type: looker_column
    fields: [insights_data__entities.average_salience, insights_data__entities.name]
    filters:
      insights_data__sentences.participant_role: ''
      insights_data__entities.average_salience: NOT NULL
    sorts: [insights_data__entities.average_salience desc]
    limit: 10
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
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_null_points: false
    interpolation: monotone
    hidden_series: [insights_data__sentences.participant_role___null - insights_data__sentences.average_sentiment_category_value]
    discontinuous_nulls: false
    defaults_version: 1
    listen:
      Conversation Name: insights_data.conversation_name
    row: 13
    col: 0
    width: 13
    height: 5
  - title: Agent ID
    name: Agent ID
    model: insights
    explore: insights_data
    type: single_value
    fields: [insights_data__agents.agent_id]
    sorts: [insights_data__agents.agent_id]
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
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: white
    limit_displayed_rows: false
    transpose: false
    truncate_text: true
    size_to_fit: true
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    defaults_version: 1
    hidden_fields: []
    listen:
      Conversation Name: insights_data.conversation_name
    row: 2
    col: 0
    width: 6
    height: 2
  - title: Agent Sentiment
    name: Agent Sentiment
    model: insights
    explore: insights_data
    type: single_value
    fields: [insights_data.agent_sentiment_category, insights_data.average_agent_sentiment_category_value]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: false
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    conditional_formatting: [{type: equal to, value: !!null '', background_color: "#1A73E8",
        font_color: !!null '', color_application: {collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2,
          palette_id: 56d0c358-10a0-4fd6-aa0b-b117bef527ab}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}]
    defaults_version: 1
    listen:
      Conversation Name: insights_data.conversation_name
    row: 4
    col: 18
    width: 6
    height: 2
  - title: Topic
    name: Topic
    model: insights
    explore: insights_data
    type: single_value
    fields: [insights_data__topics.name]
    sorts: [insights_data__topics.name]
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
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: white
    limit_displayed_rows: false
    transpose: false
    truncate_text: true
    size_to_fit: true
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    defaults_version: 1
    hidden_fields: []
    listen:
      Conversation Name: insights_data.conversation_name
    row: 2
    col: 18
    width: 6
    height: 2
  - title: Start Date
    name: Start Date
    model: insights
    explore: insights_data
    type: single_value
    fields: [insights_data.start_date]
    fill_fields: [insights_data.start_date]
    sorts: [insights_data.start_date desc]
    limit: 500
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
    listen:
      Conversation Name: insights_data.conversation_name
    row: 4
    col: 0
    width: 6
    height: 2
  - title: Conversation ID
    name: Conversation ID
    model: insights
    explore: insights_data
    type: single_value
    fields: [insights_data.unnested_conversation_id]
    sorts: [insights_data.unnested_conversation_id]
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
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: white
    limit_displayed_rows: false
    transpose: false
    truncate_text: true
    size_to_fit: true
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    defaults_version: 1
    hidden_fields: []
    listen:
      Conversation Name: insights_data.conversation_name
    row: 0
    col: 0
    width: 24
    height: 2
  - title: Import Date
    name: Import Date
    model: insights
    explore: insights_data
    type: single_value
    fields: [insights_data.load_date]
    fill_fields: [insights_data.load_date]
    sorts: [insights_data.load_date desc]
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
      Conversation Name: insights_data.conversation_name
    row: 2
    col: 6
    width: 6
    height: 2
  - title: Top Topics
    name: Top Topics
    model: insights
    explore: insights_data
    type: looker_grid
    fields: [insights_data__topics.name, insights_data__topics.score]
    filters:
      insights_data__sentences.participant_role: ''
      insights_data__topics.name: "-NULL"
    sorts: [insights_data__topics.score desc]
    limit: 10
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
    header_font_size: 12
    rows_font_size: 12
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
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
    show_null_points: false
    interpolation: monotone
    hidden_series: [insights_data__sentences.participant_role___null - insights_data__sentences.average_sentiment_category_value]
    discontinuous_nulls: false
    defaults_version: 1
    series_types: {}
    listen:
      Conversation Name: insights_data.conversation_name
    row: 18
    col: 0
    width: 13
    height: 5
  - title: Custom Highlights
    name: Custom Highlights
    model: insights
    explore: insights_data
    type: looker_column
    fields: [insights_data__sentences.count, insights_data__sentences__phrase_match_data.display_name]
    filters:
      insights_data__sentences__phrase_match_data.display_name: "-EMPTY"
    sorts: [insights_data__sentences.count desc]
    limit: 10
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
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_null_points: false
    interpolation: monotone
    hidden_series: [insights_data__sentences.participant_role___null - insights_data__sentences.average_sentiment_category_value]
    discontinuous_nulls: false
    defaults_version: 1
    listen:
      Conversation Name: insights_data.conversation_name
    row: 18
    col: 13
    width: 11
    height: 5
  - title: Smart Highlights
    name: Smart Highlights
    model: insights
    explore: insights_data
    type: looker_column
    fields: [insights_data__sentences.count, insights_data__sentences__intent_match_data.display_name]
    filters:
      insights_data__sentences__intent_match_data.display_name: "-EMPTY"
    sorts: [insights_data__sentences.count desc]
    limit: 10
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
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_null_points: false
    interpolation: monotone
    hidden_series: [insights_data__sentences.participant_role___null - insights_data__sentences.average_sentiment_category_value]
    discontinuous_nulls: false
    defaults_version: 1
    listen:
      Conversation Name: insights_data.conversation_name
    row: 13
    col: 13
    width: 11
    height: 5
  filters:
  - name: Conversation Name
    title: Conversation Name
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: true
    ui_config:
      type: dropdown_menu
      display: inline
      options: []
    model: insights
    explore: insights_data
    listens_to_filters: []
    field: insights_data.conversation_name
