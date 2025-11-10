- dashboard: overall__summary
  title: Overall - Summary
  layout: newspaper
  preferred_viewer: dashboards-next
  description: ''
  preferred_slug: JdSXHR2ZBfp3q5c8pcQdj7
  elements:
  - title: Total Sessions
    name: Total Sessions
    #model: billTest
    explore: dfcx_session_metadata
    type: single_value
    fields: [dfcx_session_metadata.total_sessions]
    limit: 500
    column_limit: 50
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: 5591d8d1-6b49-4f8e-bafa-b874d82f8eb7
      palette_id: 18d0c733-1d87-42a9-934f-4ba8ef81d736
    custom_color: "#3381d4"
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: !!null '',
        font_color: !!null '', color_application: {collection_id: aed851c8-b22d-4b01-8fff-4b02b91fe78d,
          palette_id: 6dda4f8b-4e73-4e50-8760-eb378041ce07}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}]
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    truncate_header: false
    size_to_fit: true
    series_cell_visualizations:
      dfcx_session_metadata.total_ss_attempt_sessions:
        is_active: false
        value_display: true
      dfcx_session_metadata.ss_success_percentage:
        is_active: false
        palette:
          palette_id: 1dbf65fc-c10d-6269-a6bb-00f459b2027c
          collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2
          custom_colors:
          - "#e81c0e"
          - "#ffc05b"
          - "#52b226"
      dfcx_session_metadata.ss_attempt_percentage:
        is_active: false
        palette:
          palette_id: 22a19c52-12d2-3bd5-2090-b4210a84ba71
          collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2
          custom_colors:
          - "#e81c0e"
          - "#ffc05b"
          - "#52b226"
      dfcx_session_metadata.escalated_percentage:
        is_active: false
        palette:
          palette_id: 2456ece3-741a-c951-2033-fae090f42b89
          collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2
          custom_colors:
          - "#e81c0e"
          - "#ffc05b"
          - "#52b226"
        value_display: true
    table_theme: white
    limit_displayed_rows: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    hide_totals: false
    hide_row_totals: false
    defaults_version: 1
    listen:
      Project ID: dfcx_session_metadata.project_id
      Final Interaction Use Case: dfcx_session_metadata.final_interaction_head_intent
      Session Start Date: dfcx_session_metadata.session_start_date
    row: 0
    col: 0
    width: 4
    height: 2
  - title: Final Action
    name: Final Action
    #model: billTest
    explore: dfcx_session_metadata
    type: looker_grid
    fields: [dfcx_session_metadata.final_action, dfcx_session_metadata.total_ss_attempt_sessions,
      dfcx_session_metadata.total_sessions, dfcx_session_metadata.ss_attempt_percentage,
      dfcx_session_metadata.ss_success_percentage, dfcx_session_metadata.total_escalated_sessions,
      dfcx_session_metadata.escalated_percentage]
    filters: {}
    sorts: [dfcx_session_metadata.total_ss_attempt_sessions desc]
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
    enable_conditional_formatting: true
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: aed851c8-b22d-4b01-8fff-4b02b91fe78d
      palette_id: c36094e3-d04d-4aa4-8ec7-bc9af9f851f4
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    truncate_header: false
    minimum_column_width: 75
    series_labels:
      dfcx_session_metadata.final_action: Final Action
      dfcx_session_metadata.total_ss_attempt_sessions: Total SS Attempt Session
      dfcx_session_metadata.total_sessions: Total Sessions
      dfcx_session_metadata.ss_attempt_percentage: SS Attempt Percentage
      dfcx_session_metadata.ss_success_percentage: SS Success Percentage
    series_cell_visualizations:
      dfcx_session_metadata.total_ss_attempt_sessions:
        is_active: false
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: "#81BE56",
        font_color: !!null '', color_application: {collection_id: aed851c8-b22d-4b01-8fff-4b02b91fe78d,
          palette_id: e26878fa-802e-47d9-9478-62fb4307f763, options: {steps: 5, constraints: {
              min: {type: minimum}, mid: {type: middle}, max: {type: maximum}}, mirror: false,
            reverse: false, stepped: false}}, bold: false, italic: false, strikethrough: false,
        fields: [dfcx_session_metadata.ss_attempt_percentage, dfcx_session_metadata.ss_success_percentage]},
      {type: along a scale..., value: !!null '', background_color: !!null '', font_color: !!null '',
        color_application: {collection_id: aed851c8-b22d-4b01-8fff-4b02b91fe78d, palette_id: e26878fa-802e-47d9-9478-62fb4307f763,
          options: {steps: 5, reverse: true}}, bold: false, italic: false, strikethrough: false,
        fields: [dfcx_session_metadata.escalated_percentage]}]
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
      Project ID: dfcx_session_metadata.project_id
      Final Interaction Use Case: dfcx_session_metadata.final_interaction_head_intent
      Session Start Date: dfcx_session_metadata.session_start_date
    row: 19
    col: 0
    width: 24
    height: 6
  - title: SS Success %
    name: SS Success %
    #model: billTest
    explore: dfcx_session_metadata
    type: single_value
    fields: [dfcx_session_metadata.ss_success_percentage]
    limit: 500
    column_limit: 50
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: aed851c8-b22d-4b01-8fff-4b02b91fe78d
      palette_id: c36094e3-d04d-4aa4-8ec7-bc9af9f851f4
    custom_color: "#3381d4"
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: !!null '',
        font_color: !!null '', color_application: {collection_id: aed851c8-b22d-4b01-8fff-4b02b91fe78d,
          palette_id: 6dda4f8b-4e73-4e50-8760-eb378041ce07}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}]
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    truncate_header: false
    size_to_fit: true
    series_cell_visualizations:
      dfcx_session_metadata.total_ss_attempt_sessions:
        is_active: false
        value_display: true
      dfcx_session_metadata.ss_success_percentage:
        is_active: false
        palette:
          palette_id: 1dbf65fc-c10d-6269-a6bb-00f459b2027c
          collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2
          custom_colors:
          - "#e81c0e"
          - "#ffc05b"
          - "#52b226"
      dfcx_session_metadata.ss_attempt_percentage:
        is_active: false
        palette:
          palette_id: 22a19c52-12d2-3bd5-2090-b4210a84ba71
          collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2
          custom_colors:
          - "#e81c0e"
          - "#ffc05b"
          - "#52b226"
      dfcx_session_metadata.escalated_percentage:
        is_active: false
        palette:
          palette_id: 2456ece3-741a-c951-2033-fae090f42b89
          collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2
          custom_colors:
          - "#e81c0e"
          - "#ffc05b"
          - "#52b226"
        value_display: true
    table_theme: white
    limit_displayed_rows: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    hide_totals: false
    hide_row_totals: false
    defaults_version: 1
    listen:
      Project ID: dfcx_session_metadata.project_id
      Final Interaction Use Case: dfcx_session_metadata.final_interaction_head_intent
      Session Start Date: dfcx_session_metadata.session_start_date
    row: 0
    col: 10
    width: 4
    height: 2
  - title: ''
    name: ''
    #model: billTest
    explore: dfcx_session_metadata
    type: looker_grid
    fields: [dfcx_session_metadata.final_interaction_head_intent, dfcx_session_metadata.total_sessions,
      dfcx_session_metadata.total_ss_attempt_sessions, dfcx_session_metadata.total_escalated_sessions,
      dfcx_session_metadata.ss_attempt_percentage, dfcx_session_metadata.ss_success_percentage,
      dfcx_session_metadata.escalated_percentage]
    filters: {}
    sorts: [dfcx_session_metadata.total_ss_attempt_sessions desc 0]
    limit: 5000
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
    enable_conditional_formatting: true
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: aed851c8-b22d-4b01-8fff-4b02b91fe78d
      palette_id: c36094e3-d04d-4aa4-8ec7-bc9af9f851f4
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    truncate_header: false
    minimum_column_width: 75
    series_cell_visualizations:
      dfcx_session_metadata.total_ss_attempt_sessions:
        is_active: false
        value_display: true
      dfcx_session_metadata.ss_success_percentage:
        is_active: false
        palette:
          palette_id: 1dbf65fc-c10d-6269-a6bb-00f459b2027c
          collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2
          custom_colors:
          - "#e81c0e"
          - "#ffc05b"
          - "#52b226"
      dfcx_session_metadata.ss_attempt_percentage:
        is_active: false
        palette:
          palette_id: 22a19c52-12d2-3bd5-2090-b4210a84ba71
          collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2
          custom_colors:
          - "#e81c0e"
          - "#ffc05b"
          - "#52b226"
      dfcx_session_metadata.escalated_percentage:
        is_active: false
        palette:
          palette_id: 2456ece3-741a-c951-2033-fae090f42b89
          collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2
          custom_colors:
          - "#e81c0e"
          - "#ffc05b"
          - "#52b226"
        value_display: true
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: "#81BE56",
        font_color: !!null '', color_application: {collection_id: aed851c8-b22d-4b01-8fff-4b02b91fe78d,
          custom: {id: fae21d83-43ae-7690-be5b-c00edfa7ac44, label: Custom, type: continuous,
            stops: [{color: "#d13a3a", offset: 0}, {color: "#F67738", offset: 25},
              {color: "#FCC03E", offset: 50}, {color: "#CBC54B", offset: 75}, {color: "#5ebf34",
                offset: 100}]}, options: {steps: 5, constraints: {min: {type: minimum}},
            reverse: false}}, bold: false, italic: false, strikethrough: false, fields: [
          dfcx_session_metadata.ss_success_percentage, dfcx_session_metadata.ss_attempt_percentage]},
      {type: along a scale..., value: !!null '', background_color: !!null '', font_color: !!null '',
        color_application: {collection_id: aed851c8-b22d-4b01-8fff-4b02b91fe78d, palette_id: e26878fa-802e-47d9-9478-62fb4307f763,
          options: {steps: 5, reverse: true, stepped: false}}, bold: false, italic: false,
        strikethrough: false, fields: [dfcx_session_metadata.escalated_percentage]}]
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
      Project ID: dfcx_session_metadata.project_id
      Final Interaction Use Case: dfcx_session_metadata.final_interaction_head_intent
      Session Start Date: dfcx_session_metadata.session_start_date
    row: 2
    col: 0
    width: 24
    height: 6
  - title: SS Attempt %
    name: SS Attempt %
    #model: billTest
    explore: dfcx_session_metadata
    type: single_value
    fields: [dfcx_session_metadata.ss_attempt_percentage]
    limit: 500
    column_limit: 50
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: aed851c8-b22d-4b01-8fff-4b02b91fe78d
      palette_id: c36094e3-d04d-4aa4-8ec7-bc9af9f851f4
    custom_color: "#3381d4"
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: !!null '',
        font_color: !!null '', color_application: {collection_id: aed851c8-b22d-4b01-8fff-4b02b91fe78d,
          palette_id: 6dda4f8b-4e73-4e50-8760-eb378041ce07}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}]
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    truncate_header: false
    size_to_fit: true
    series_cell_visualizations:
      dfcx_session_metadata.total_ss_attempt_sessions:
        is_active: false
        value_display: true
      dfcx_session_metadata.ss_success_percentage:
        is_active: false
        palette:
          palette_id: 1dbf65fc-c10d-6269-a6bb-00f459b2027c
          collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2
          custom_colors:
          - "#e81c0e"
          - "#ffc05b"
          - "#52b226"
      dfcx_session_metadata.ss_attempt_percentage:
        is_active: false
        palette:
          palette_id: 22a19c52-12d2-3bd5-2090-b4210a84ba71
          collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2
          custom_colors:
          - "#e81c0e"
          - "#ffc05b"
          - "#52b226"
      dfcx_session_metadata.escalated_percentage:
        is_active: false
        palette:
          palette_id: 2456ece3-741a-c951-2033-fae090f42b89
          collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2
          custom_colors:
          - "#e81c0e"
          - "#ffc05b"
          - "#52b226"
        value_display: true
    table_theme: white
    limit_displayed_rows: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    hide_totals: false
    hide_row_totals: false
    defaults_version: 1
    listen:
      Project ID: dfcx_session_metadata.project_id
      Final Interaction Use Case: dfcx_session_metadata.final_interaction_head_intent
      Session Start Date: dfcx_session_metadata.session_start_date
    row: 0
    col: 5
    width: 4
    height: 2
  - title: Escalated %
    name: Escalated %
    #model: billTest
    explore: dfcx_session_metadata
    type: single_value
    fields: [dfcx_session_metadata.escalated_percentage]
    limit: 500
    column_limit: 50
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: aed851c8-b22d-4b01-8fff-4b02b91fe78d
      palette_id: c36094e3-d04d-4aa4-8ec7-bc9af9f851f4
    custom_color: "#3381d4"
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: !!null '',
        font_color: !!null '', color_application: {collection_id: aed851c8-b22d-4b01-8fff-4b02b91fe78d,
          palette_id: 6dda4f8b-4e73-4e50-8760-eb378041ce07}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}]
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    truncate_header: false
    size_to_fit: true
    series_cell_visualizations:
      dfcx_session_metadata.total_ss_attempt_sessions:
        is_active: false
        value_display: true
      dfcx_session_metadata.ss_success_percentage:
        is_active: false
        palette:
          palette_id: 1dbf65fc-c10d-6269-a6bb-00f459b2027c
          collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2
          custom_colors:
          - "#e81c0e"
          - "#ffc05b"
          - "#52b226"
      dfcx_session_metadata.ss_attempt_percentage:
        is_active: false
        palette:
          palette_id: 22a19c52-12d2-3bd5-2090-b4210a84ba71
          collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2
          custom_colors:
          - "#e81c0e"
          - "#ffc05b"
          - "#52b226"
      dfcx_session_metadata.escalated_percentage:
        is_active: false
        palette:
          palette_id: 2456ece3-741a-c951-2033-fae090f42b89
          collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2
          custom_colors:
          - "#e81c0e"
          - "#ffc05b"
          - "#52b226"
        value_display: true
    table_theme: white
    limit_displayed_rows: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    hide_totals: false
    hide_row_totals: false
    defaults_version: 1
    listen:
      Project ID: dfcx_session_metadata.project_id
      Final Interaction Use Case: dfcx_session_metadata.final_interaction_head_intent
      Session Start Date: dfcx_session_metadata.session_start_date
    row: 0
    col: 15
    width: 4
    height: 2
  - title: Intent Specific Trends
    name: Intent Specific Trends
    #model: billTest
    explore: dfcx_session_metadata
    type: looker_line
    fields: [dfcx_session_metadata.session_start_date, dfcx_session_metadata.total_ss_attempt_sessions,
      dfcx_session_metadata.total_sessions, dfcx_session_metadata.ss_attempt_percentage,
      dfcx_session_metadata.ss_success_percentage, dfcx_session_metadata.escalated_percentage]
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
    color_application:
      collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2
      palette_id: 5d189dfc-4f46-46f3-822b-bfb0b61777b1
      options:
        steps: 5
    y_axes: [{label: '', orientation: left, series: [{axisId: dfcx_session_metadata.total_ss_attempt_sessions,
            id: dfcx_session_metadata.total_ss_attempt_sessions, name: Total Ss Attempt
              Sessions}, {axisId: dfcx_session_metadata.total_sessions, id: dfcx_session_metadata.total_sessions,
            name: Total Sessions}], showLabels: true, showValues: true, unpinAxis: false,
        tickDensity: custom, tickDensityCustom: 32, type: linear}, {label: !!null '',
        orientation: right, series: [{axisId: dfcx_session_metadata.ss_attempt_percentage,
            id: dfcx_session_metadata.ss_attempt_percentage, name: Ss Attempt Percentage},
          {axisId: dfcx_session_metadata.ss_success_percentage, id: dfcx_session_metadata.ss_success_percentage,
            name: Ss Success Percentage}, {axisId: dfcx_session_metadata.escalated_percentage,
            id: dfcx_session_metadata.escalated_percentage, name: Escalated Percentage}],
        showLabels: true, showValues: true, unpinAxis: false, tickDensity: custom,
        tickDensityCustom: 56, type: linear}]
    series_types:
      dfcx_session_metadata.total_ss_attempt_sessions: column
      dfcx_session_metadata.total_sessions: column
    series_colors: {}
    series_labels:
      dfcx_session_metadata.ss_attempt_percentage: SS Attempt %
      dfcx_session_metadata.ss_success_percentage: SS Success %
      dfcx_session_metadata.escalated_percentage: Escalated %
    defaults_version: 1
    listen:
      Project ID: dfcx_session_metadata.project_id
      Final Interaction Use Case: dfcx_session_metadata.final_interaction_head_intent
      Session Start Date: dfcx_session_metadata.session_start_date
    row: 8
    col: 0
    width: 24
    height: 6
  - title: Avg Session Handle Time
    name: Avg Session Handle Time
    #model: billTest
    explore: dfcx_session_metadata
    type: single_value
    fields: [dfcx_session_metadata.avg_session_handle_time]
    filters:
      dfcx_session_metadata.session_start_date: 50 days
    limit: 500
    column_limit: 50
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: ed5756e2-1ba8-4233-97d2-d565e309c03b
      palette_id: ff31218a-4f9d-493c-ade2-22266f5934b8
    custom_color: "#3e80b2"
    value_format: '0.00'
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: !!null '',
        font_color: !!null '', color_application: {collection_id: aed851c8-b22d-4b01-8fff-4b02b91fe78d,
          palette_id: 6dda4f8b-4e73-4e50-8760-eb378041ce07}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}]
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    truncate_header: false
    size_to_fit: true
    series_cell_visualizations:
      dfcx_session_metadata.total_ss_attempt_sessions:
        is_active: false
        value_display: true
      dfcx_session_metadata.ss_success_percentage:
        is_active: false
        palette:
          palette_id: 1dbf65fc-c10d-6269-a6bb-00f459b2027c
          collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2
          custom_colors:
          - "#e81c0e"
          - "#ffc05b"
          - "#52b226"
      dfcx_session_metadata.ss_attempt_percentage:
        is_active: false
        palette:
          palette_id: 22a19c52-12d2-3bd5-2090-b4210a84ba71
          collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2
          custom_colors:
          - "#e81c0e"
          - "#ffc05b"
          - "#52b226"
      dfcx_session_metadata.escalated_percentage:
        is_active: false
        palette:
          palette_id: 2456ece3-741a-c951-2033-fae090f42b89
          collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2
          custom_colors:
          - "#e81c0e"
          - "#ffc05b"
          - "#52b226"
        value_display: true
    table_theme: white
    limit_displayed_rows: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    hide_totals: false
    hide_row_totals: false
    defaults_version: 1
    listen:
      Final Interaction Use Case: dfcx_session_metadata.final_interaction_head_intent
      Project ID: dfcx_session_metadata.project_id
    row: 0
    col: 20
    width: 4
    height: 2
  - title: Conversation Sample
    name: Conversation Sample
    #model: billTest
    explore: dfcx_session_metadata
    type: looker_grid
    fields: [dfcx_session_metadata.session_id, dfcx_session_metadata.session_start_date,
      dfcx_session_metadata.final_action, dfcx_session_metadata.final_action_started,
      dfcx_session_metadata.final_action_ended, dfcx_session_metadata.is_escalated]
    filters: {}
    sorts: [dfcx_session_metadata.session_start_date desc]
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
    minimum_column_width: 75
    series_text_format:
      dfcx_session_metadata.session_id:
        fg_color: "#000000"
    header_font_color: "#000"
    header_background_color: ''
    defaults_version: 1
    hidden_fields: []
    y_axes: []
    listen:
      Project ID: dfcx_session_metadata.project_id
      Final Interaction Use Case: dfcx_session_metadata.final_interaction_head_intent
      Session Start Date: dfcx_session_metadata.session_start_date
    row: 14
    col: 0
    width: 24
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
    #model: billTest
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
    #model: billTest
    explore: dfcx_session_metadata
    listens_to_filters: []
    field: dfcx_session_metadata.project_id
  - name: Final Interaction Use Case
    title: Final Interaction Use Case
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
    #model: billTest
    explore: dfcx_session_metadata
    listens_to_filters: []
    field: dfcx_session_metadata.final_interaction_head_intent
