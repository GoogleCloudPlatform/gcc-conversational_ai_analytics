view: dfcx_transcript {
  sql_table_name: `@{project_id}.@{dataform_schema}.dfcx_transcript`;;

  parameter: session_parameter_path {
    type: string
    default_value: "$"
  }

  dimension: primary_key {
    hidden: yes
    primary_key: yes
    type: string
    sql: CONCAT(${session_id}, ${position}) ;;
  }

  dimension: actions {
    hidden: yes
    sql: ${TABLE}.actions ;;
  }

  dimension: agent_id {
    type: string
    sql: ${TABLE}.agent_id ;;
  }

  dimension: agent_response {
    type: string
    sql: ${TABLE}.agent_response ;;
  }

  dimension: alternative_matched_intents {
    hidden: yes
    sql: ${TABLE}.alternative_matched_intents ;;
  }

  dimension: event {
    type: string
    sql: ${TABLE}.event ;;
  }

  dimension: execution_sequence {
    hidden: yes
    sql: ${TABLE}.execution_sequence ;;
  }

  dimension: execution_sequence_count {
    type: number
    sql: ${TABLE}.execution_sequence_count ;;
  }

  dimension: flow_display_name {
    type: string
    sql: ${TABLE}.flow_display_name ;;
  }

  dimension: flow_id {
    hidden: yes
    type: string
    sql: ${TABLE}.flow_id ;;
  }

  dimension: intent_confidence_score {
    type: number
    sql: ${TABLE}.intent_confidence_score ;;
  }

  dimension: intent_display_id {
    hidden: yes
    type: string
    sql: ${TABLE}.intent_display_id ;;
  }

  dimension: intent_display_name {
    type: string
    sql: ${TABLE}.intent_display_name ;;
  }

  dimension: language_code {
    type: string
    sql: ${TABLE}.language_code ;;
  }

  dimension: live_agent_escalation {
    hidden: yes
    type: yesno
    sql: ${TABLE}.live_agent_escalation ;;
  }

  dimension: live_agent_handoff {
    hidden: yes
    type: yesno
    sql: ${TABLE}.live_agent_handoff ;;
  }

  dimension: location {
    hidden: yes
    type: string
    sql: ${TABLE}.location ;;
  }

  dimension: match_type {
    type: string
    sql: ${TABLE}.match_type ;;
  }

  dimension: optional_dtmf_digits {
    type: string
    sql: ${TABLE}.optional_dtmf_digits ;;
  }

  dimension: page_display_name {
    type: string
    sql: ${TABLE}.page_display_name ;;
  }

  dimension: page_id {
    hidden: yes
    type: string
    sql: ${TABLE}.page_id ;;
  }

  dimension: position {
    type: number
    sql: ${TABLE}.position ;;
  }

  dimension: project_id {
    hidden: yes
    type: string
    sql: ${TABLE}.project_id ;;
  }

  dimension_group: request {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.request_time ;;
  }

  dimension: response_id {
    type: string
    sql: ${TABLE}.response_id ;;
  }

  dimension_group: session_end {
    hidden: yes
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.session_end_time ;;
  }

  dimension: session_id {
    hidden: yes
    type: string
    sql: ${TABLE}.session_id ;;
  }

  dimension: session_parameters {
    #Underlying data type is JSON
    hidden: yes
    type: string
    sql: ${TABLE}.session_parameters ;;
  }

  dimension: session_parameters_string {
    group_label: "Session Parameters"
    label: "Session Parameters (string)"
    type: string
    sql: TO_JSON_STRING(${session_parameters}) ;;
  }

  dimension: session_parameter_value {
    group_label: "Session Parameters"
    label: "Session Parameter (Value)"
    type: string
    description: "Use with Session Parameter Path parameter to extract a specific string value"
    sql: JSON_VALUE(${session_parameters},{{session_parameter_path._parameter_value}}) ;;
  }

  dimension: session_parameter_query {
    group_label: "Session Parameters"
    label: "Session Parameter (Query)"
    type: string
    description: "Use with Session Parameter Path parameter to extract a specific string value"
    sql: TO_JSON_STRING(JSON_QUERY(${session_parameters},{{session_parameter_path._parameter_value}})) ;;
  }

  dimension_group: session_start {
    hidden: yes
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.session_start_time ;;
  }

  dimension: source_flow_display_name {
    type: string
    sql: ${TABLE}.source_flow_display_name ;;
  }

  dimension: source_flow_id {
    hidden: yes
    type: string
    sql: ${TABLE}.source_flow_id ;;
  }

  dimension: source_page_display_name {
    type: string
    sql: ${TABLE}.source_page_display_name ;;
  }

  dimension: source_page_id {
    hidden: yes
    type: string
    sql: ${TABLE}.source_page_id ;;
  }

  dimension: user_utterance {
    type: string
    sql: ${TABLE}.user_utterance ;;
  }

  dimension: webhooks {
    hidden: yes
    sql: ${TABLE}.webhooks ;;
  }

  measure: total_turns {
    type: count
    drill_fields: [standard_transcript_drill*]
  }

  dimension: did_agent_respond {
    label: "Did agent respond?"
    type: yesno
    sql: ${agent_response} is not null ;;
  }

  measure: total_no_agent_response_turns {
    type: count
    filters: [
      did_agent_respond: "No"
    ]
    drill_fields: [standard_transcript_drill*]
  }

  measure: total_no_match_utterances {
    type: count
    filters: [match_type: "NO_MATCH"]
    drill_fields: [standard_transcript_drill*]
  }

  measure: total_no_input_utterances {
    type: count
    filters: [match_type: "NO_INPUT"]
    drill_fields: [standard_transcript_drill*]
  }

  measure: no_match_percentage {
    label: "No Match %"
    type: number
    sql: ${total_no_match_utterances} / NULLIF(${total_turns}, 0) ;;
    value_format: "0.00%"
  }

  measure: no_input_percentage {
    label: "No Input %"
    type: number
    sql: ${total_no_input_utterances} / NULLIF(${total_turns}, 0) ;;
    value_format: "0.00%"
  }

  measure: no_agent_response_rate {
    label: "No Agent Response %"
    type: number
    sql: ${total_no_agent_response_turns} / NULLIF(${total_turns},0) ;;
    value_format_name: percent_1
    drill_fields: [standard_transcript_drill*]
  }

  measure: confidence_score_percentile_min {
    group_label: "Confidence Score Percentiles"
    label: "Confidence Score - Min"
    type: max
    sql: ${TABLE}.intent_confidence_score ;;
    value_format_name: percent_2
    drill_fields: [standard_transcript_drill*]
  }

  measure: confidence_score_percentile_05 {
    group_label: "Confidence Score Percentiles"
    label: "Confidence Score - 05%"
    type: percentile
    percentile: 5
    sql: ${TABLE}.intent_confidence_score ;;
    value_format_name: percent_2
    drill_fields: [standard_transcript_drill*]
  }

  measure: confidence_score_percentile_25 {
    group_label: "Confidence Score Percentiles"
    label: "Confidence Score - 25%"
    type: percentile
    percentile: 25
    sql: ${TABLE}.intent_confidence_score ;;
    value_format_name: percent_2
    drill_fields: [standard_transcript_drill*]
  }

  measure: confidence_score_percentile_50 {
    group_label: "Confidence Score Percentiles"
    label: "Confidence Score - 50%"
    type: percentile
    percentile: 50
    sql: ${TABLE}.intent_confidence_score ;;
    value_format_name: percent_2
    drill_fields: [standard_transcript_drill*]
  }

  measure: confidence_score_percentile_75 {
    group_label: "Confidence Score Percentiles"
    label: "Confidence Score - 75%"
    type: percentile
    percentile: 75
    sql: ${TABLE}.intent_confidence_score ;;
    value_format_name: percent_2
    drill_fields: [standard_transcript_drill*]
  }

  measure: confidence_score_percentile_95 {
    group_label: "Confidence Score Percentiles"
    label: "Confidence Score - 95%"
    type: percentile
    percentile: 95
    sql: ${TABLE}.intent_confidence_score ;;
    value_format_name: percent_2
    drill_fields: [standard_transcript_drill*]
  }

  measure: confidence_score_percentile_max {
    group_label: "Confidence Score Percentiles"
    label: "Confidence Score - Max"
    type: max
    sql: ${TABLE}.intent_confidence_score ;;
    value_format_name: percent_2
    drill_fields: [standard_transcript_drill*]
  }

  dimension: playbook_metrics__llm_latency_ms {
    type: number
    sql: ${TABLE}.playbook_metrics.llm_latency_ms ;;
    group_label: "Playbook Metrics"
    group_item_label: "LLM Latency (ms)"
    value_format_name: decimal_2
  }

  dimension: playbook_metrics__tool_latency_ms {
    type: number
    sql: ${TABLE}.playbook_metrics.tool_latency_ms ;;
    group_label: "Playbook Metrics"
    group_item_label: "Tool Latency (ms)"
    value_format_name: decimal_2
  }

  dimension: playbook_metrics__total_latency_ms {
    type: number
    sql: ${TABLE}.playbook_metrics.total_latency_ms ;;
    group_label: "Playbook Metrics"
    group_item_label: "Total Latency (ms)"
    value_format_name: decimal_2
  }

  dimension: playbook_metrics__input_token_limit {
    type: number
    sql: ${TABLE}.playbook_metrics.input_token_limit ;;
    group_label: "Playbook Metrics"
    group_item_label: "Input Tokens Limit"
  }

  dimension: playbook_metrics__output_token_limit {
    type: number
    sql: ${TABLE}.playbook_metrics.output_token_limit ;;
    group_label: "Playbook Metrics"
    group_item_label: "Output Tokens Limit"
  }

  dimension: llm_calls_per_turn {
    type: number
    sql: ARRAY_LENGTH(playbook_metrics.input_tokens_count) ;;
    group_label: "Playbook Metrics"
    group_item_label: "LLM Calls per Turn"
  }

  measure: total_llm_calls {
    type: sum
    sql: ${llm_calls_per_turn} ;;
    filters: [contains_playbook_metrics: "Yes"]
    group_label: "Playbook Metrics"
    group_item_label: "Total LLM Calls"
    value_format_name: decimal_0
  }

  measure: avg_llm_calls_per_turn {
    type: average
    sql: ${llm_calls_per_turn} ;;
    filters: [contains_playbook_metrics: "Yes"]
    group_label: "Playbook Metrics"
    group_item_label: "Avg LLM Calls per Turn"
    value_format_name: decimal_2
  }

  measure: min_llm_calls_per_turn {
    type: min
    sql: ${llm_calls_per_turn} ;;
    filters: [contains_playbook_metrics: "Yes"]
    group_label: "Playbook Metrics"
    group_item_label: "Min LLM Calls per Turn"
    value_format_name: decimal_2
  }

  measure: max_llm_calls_per_turn {
    type: max
    sql: ${llm_calls_per_turn} ;;
    filters: [contains_playbook_metrics: "Yes"]
    group_label: "Playbook Metrics"
    group_item_label: "Max LLM Calls per Turn"
    value_format_name: decimal_2
  }

  measure: p05_llm_calls_per_turn {
    type: percentile
    percentile: 5
    sql: ${llm_calls_per_turn} ;;
    filters: [contains_playbook_metrics: "Yes"]
    group_label: "Playbook Metrics"
    group_item_label: "5% LLM Calls per Turn"
    value_format_name: decimal_2
  }

  measure: p25_llm_calls_per_turn {
    type: percentile
    percentile: 25
    sql: ${llm_calls_per_turn} ;;
    filters: [contains_playbook_metrics: "Yes"]
    group_label: "Playbook Metrics"
    group_item_label: "25% LLM Calls per Turn"
    value_format_name: decimal_2
  }

  measure: p50_llm_calls_per_turn {
    type: percentile
    percentile: 50
    sql: ${llm_calls_per_turn} ;;
    filters: [contains_playbook_metrics: "Yes"]
    group_label: "Playbook Metrics"
    group_item_label: "50% LLM Calls per Turn"
    value_format_name: decimal_2
  }

  measure: p75_llm_calls_per_turn {
    type: percentile
    percentile: 75
    sql: ${llm_calls_per_turn} ;;
    filters: [contains_playbook_metrics: "Yes"]
    group_label: "Playbook Metrics"
    group_item_label: "75% LLM Calls per Turn"
    value_format_name: decimal_2
  }

  measure: p95_llm_calls_per_turn {
    type: percentile
    percentile: 95
    sql: ${llm_calls_per_turn} ;;
    filters: [contains_playbook_metrics: "Yes"]
    group_label: "Playbook Metrics"
    group_item_label: "95% LLM Calls per Turn"
    value_format_name: decimal_2
  }

  measure: p99_llm_calls_per_turn {
    type: percentile
    percentile: 99
    sql: ${llm_calls_per_turn} ;;
    filters: [contains_playbook_metrics: "Yes"]
    group_label: "Playbook Metrics"
    group_item_label: "99% LLM Calls per Turn"
    value_format_name: decimal_2
  }

  dimension: playbook_metrics {
    hidden: yes
    type: string
    sql: ${TABLE}.playbook_metrics ;;
  }

  dimension: playbook_metrics__output_tokens_count {
    hidden: yes
    type: string
    sql: ${playbook_metrics}.output_tokens_count ;;
  }

  dimension: playbook_metrics__total_output_tokens {
    type: number
    sql: (SELECT SUM(value) FROM UNNEST(${playbook_metrics__output_tokens_count}) as value) ;;
    value_format_name: decimal_0
    group_label: "Playbook Metrics"
    group_item_label: "Total Output Tokens"
  }

  measure: total_output_tokens {
    type: sum
    sql: ${playbook_metrics__total_output_tokens} ;;
    value_format_name: decimal_0
    group_label: "Playbook Metrics"
    group_item_label: "Total Output Tokens"
  }

  measure: min_output_tokens {
    type: min
    sql: ${playbook_metrics__total_output_tokens} ;;
    value_format_name: decimal_0
    group_label: "Playbook Metrics"
    group_item_label: "Min Output Tokens"
  }

  measure: max_output_tokens {
    type: max
    sql: ${playbook_metrics__total_output_tokens} ;;
    value_format_name: decimal_0
    group_label: "Playbook Metrics"
    group_item_label: "Max Output Tokens"
  }

  measure: avg_output_tokens {
    type: average
    sql: ${playbook_metrics__total_output_tokens} ;;
    value_format_name: decimal_0
    group_label: "Playbook Metrics"
    group_item_label: "Avg Output Tokens"
  }

  dimension: playbook_metrics__input_tokens_count {
    hidden: yes
    type: string
    sql: ${playbook_metrics}.input_tokens_count ;;
  }

  dimension: playbook_metrics__total_input_tokens {
    type: number
    sql: (SELECT SUM(value) FROM UNNEST(${playbook_metrics__input_tokens_count}) as value) ;;
    value_format_name: decimal_0
    group_label: "Playbook Metrics"
    group_item_label: "Total Input Tokens"
  }

  measure: total_input_tokens {
    type: sum
    sql: ${playbook_metrics__total_input_tokens} ;;
    value_format_name: decimal_0
    group_label: "Playbook Metrics"
    group_item_label: "Total Input Tokens"
  }

  measure: min_input_tokens {
    type: min
    sql: ${playbook_metrics__total_input_tokens} ;;
    value_format_name: decimal_0
    group_label: "Playbook Metrics"
    group_item_label: "Min Input Tokens"
  }

  measure: max_tokens_count {
    type: max
    sql: ${playbook_metrics__total_input_tokens} ;;
    value_format_name: decimal_0
    group_label: "Playbook Metrics"
    group_item_label: "Max Input Tokens"
  }

  measure: avg_input_tokens_count {
    type: average
    sql: ${playbook_metrics__total_input_tokens} ;;
    value_format_name: decimal_0
    group_label: "Playbook Metrics"
    group_item_label: "Avg Input Tokens"
  }

  dimension: playbook_metrics__states {
    type: string
    sql: ${TABLE}.playbook_metrics.states[SAFE_OFFSET(0)] ;;
    group_label: "Playbook Metrics"
    group_item_label: "States"
  }

  dimension: contains_playbook_metrics {
    group_label: "Playbook Metrics"
    type: yesno
    sql: ${playbook_metrics__states} IS NOT NULL ;;
  }

  measure: total_latency_ms {
    type: sum
    sql: ${playbook_metrics__total_latency_ms};;
    filters: [contains_playbook_metrics: "Yes"]
    group_label: "Playbook Metrics"
    group_item_label: "Total Latency (ms)"
    value_format_name: decimal_2
  }

  measure: average_total_latency_ms {
    type: average
    sql: ${playbook_metrics__total_latency_ms} ;;
    filters: [contains_playbook_metrics: "Yes"]
    group_label: "Playbook Metrics"
    group_item_label: "Avg Total Latency (ms)"
    value_format_name: decimal_2
  }

  measure: p05_total_latency_ms {
    type: percentile
    percentile: 5
    sql: ${playbook_metrics__total_latency_ms} ;;
    filters: [contains_playbook_metrics: "Yes"]
    group_label: "Playbook Metrics"
    group_item_label: "5% Total Latency (ms)"
    value_format_name: decimal_2
  }

  measure: p25_total_latency_ms {
    type: percentile
    percentile: 25
    sql: ${playbook_metrics__total_latency_ms} ;;
    filters: [contains_playbook_metrics: "Yes"]
    group_label: "Playbook Metrics"
    group_item_label: "25% Total Latency (ms)"
    value_format_name: decimal_2
  }

  measure: p50_total_latency_ms {
    type: percentile
    percentile: 50
    sql: ${playbook_metrics__total_latency_ms} ;;
    filters: [contains_playbook_metrics: "Yes"]
    group_label: "Playbook Metrics"
    group_item_label: "50% Total Latency (ms)"
    value_format_name: decimal_2
  }

  measure: p75_total_latency_ms {
    type: percentile
    percentile: 75
    sql: ${playbook_metrics__total_latency_ms} ;;
    filters: [contains_playbook_metrics: "Yes"]
    group_label: "Playbook Metrics"
    group_item_label: "75% Total Latency (ms)"
    value_format_name: decimal_2
  }

  measure: p95_total_latency_ms {
    type: percentile
    percentile: 95
    sql: ${playbook_metrics__total_latency_ms} ;;
    filters: [contains_playbook_metrics: "Yes"]
    group_label: "Playbook Metrics"
    group_item_label: "95% Total Latency (ms)"
    value_format_name: decimal_2
  }

  measure: p99_total_latency_ms {
    type: percentile
    percentile: 99
    sql: ${playbook_metrics__total_latency_ms} ;;
    filters: [contains_playbook_metrics: "Yes"]
    group_label: "Playbook Metrics"
    group_item_label: "99% Total Latency (ms)"
    value_format_name: decimal_2
  }

  measure: min_total_latency_ms {
    type: min
    sql: ${playbook_metrics__total_latency_ms} ;;
    filters: [contains_playbook_metrics: "Yes"]
    group_label: "Playbook Metrics"
    group_item_label: "Min Total Latency (ms)"
    value_format_name: decimal_2
  }

  measure: max_total_latency_ms {
    type: max
    sql: ${playbook_metrics__total_latency_ms} ;;
    filters: [contains_playbook_metrics: "Yes"]
    group_label: "Playbook Metrics"
    group_item_label: "Max Total Latency (ms)"
    value_format_name: decimal_2
  }

  measure: total_llm_latency_ms {
    type: sum
    sql: ${playbook_metrics__llm_latency_ms} ;;
    filters: [contains_playbook_metrics: "Yes"]
    group_label: "Playbook Metrics"
    group_item_label: "Total LLM Latency (ms)"
    value_format_name: decimal_2
  }

  measure: average_llm_latency_ms {
    type: average
    sql: ${playbook_metrics__llm_latency_ms} ;;
    filters: [contains_playbook_metrics: "Yes"]
    group_label: "Playbook Metrics"
    group_item_label: "Avg LLM Latency (ms)"
    value_format_name: decimal_2
  }

  measure: p05_llm_latency_ms {
    type: percentile
    percentile: 5
    sql: ${playbook_metrics__llm_latency_ms} ;;
    filters: [contains_playbook_metrics: "Yes"]
    group_label: "Playbook Metrics"
    group_item_label: "5% LLM Latency (ms)"
    value_format_name: decimal_2
  }

  measure: p25_llm_latency_ms {
    type: percentile
    percentile: 25
    sql: ${playbook_metrics__llm_latency_ms} ;;
    filters: [contains_playbook_metrics: "Yes"]
    group_label: "Playbook Metrics"
    group_item_label: "25% LLM Latency (ms)"
    value_format_name: decimal_2
  }

  measure: p50_llm_latency_ms {
    type: percentile
    percentile: 50
    sql: ${playbook_metrics__llm_latency_ms} ;;
    filters: [contains_playbook_metrics: "Yes"]
    group_label: "Playbook Metrics"
    group_item_label: "50% LLM Latency (ms)"
    value_format_name: decimal_2
  }

  measure: p75_llm_latency_ms {
    type: percentile
    percentile: 75
    sql: ${playbook_metrics__llm_latency_ms} ;;
    filters: [contains_playbook_metrics: "Yes"]
    group_label: "Playbook Metrics"
    group_item_label: "75% LLM Latency (ms)"
    value_format_name: decimal_2
  }

  measure: p90_llm_latency_ms {
    type: percentile
    percentile: 90
    sql: ${playbook_metrics__llm_latency_ms} ;;
    filters: [contains_playbook_metrics: "Yes"]
    group_label: "Playbook Metrics"
    group_item_label: "90% LLM Latency (ms)"
    value_format_name: decimal_2
  }

  measure: p95_llm_latency_ms {
    type: percentile
    percentile: 95
    sql: ${playbook_metrics__llm_latency_ms} ;;
    filters: [contains_playbook_metrics: "Yes"]
    group_label: "Playbook Metrics"
    group_item_label: "95% LLM Latency (ms)"
    value_format_name: decimal_2
  }

  measure: p99_llm_latency_ms {
    type: percentile
    percentile: 99
    sql: ${playbook_metrics__llm_latency_ms} ;;
    filters: [contains_playbook_metrics: "Yes"]
    group_label: "Playbook Metrics"
    group_item_label: "99% LLM Latency (ms)"
    value_format_name: decimal_2
  }

  measure: min_llm_latency_ms {
    type: min
    sql: ${playbook_metrics__llm_latency_ms} ;;
    filters: [contains_playbook_metrics: "Yes"]
    group_label: "Playbook Metrics"
    group_item_label: "Min LLM Latency (ms)"
    value_format_name: decimal_2
  }

  measure: max_llm_latency_ms {
    type: max
    sql: ${playbook_metrics__llm_latency_ms} ;;
    filters: [contains_playbook_metrics: "Yes"]
    group_label: "Playbook Metrics"
    group_item_label: "Max LLM Latency (ms)"
    value_format_name: decimal_2
  }

  measure: total_tool_latency_ms {
    type: sum
    sql: ${playbook_metrics__tool_latency_ms} ;;
    filters: [contains_playbook_metrics: "Yes"]
    group_label: "Playbook Metrics"
    group_item_label: "Total Tool Latency (ms)"
    value_format_name: decimal_2
  }

  measure: avg_tool_latency_ms {
    type: average
    sql: ${playbook_metrics__tool_latency_ms} ;;
    filters: [contains_playbook_metrics: "Yes"]
    group_label: "Playbook Metrics"
    group_item_label: "Avg Tool Latency (ms)"
    value_format_name: decimal_2
  }

  measure: min_tool_latency_ms {
    type: min
    sql: ${playbook_metrics__tool_latency_ms} ;;
    filters: [contains_playbook_metrics: "Yes"]
    group_label: "Playbook Metrics"
    group_item_label: "Min Tool Latency (ms)"
    value_format_name: decimal_2
  }

  measure: max_tool_latency_ms {
    type: max
    sql: ${playbook_metrics__tool_latency_ms} ;;
    filters: [contains_playbook_metrics: "Yes"]
    group_label: "Playbook Metrics"
    group_item_label: "Max Tool Latency (ms)"
    value_format_name: decimal_2
  }

  measure: p05_tool_latency_ms {
    type: percentile
    percentile: 5
    sql: ${playbook_metrics__tool_latency_ms} ;;
    filters: [contains_playbook_metrics: "Yes"]
    group_label: "Playbook Metrics"
    group_item_label: "5% Tool Latency (ms)"
    value_format_name: decimal_2
  }

  measure: p25_tool_latency_ms {
    type: percentile
    percentile: 25
    sql: ${playbook_metrics__tool_latency_ms} ;;
    filters: [contains_playbook_metrics: "Yes"]
    group_label: "Playbook Metrics"
    group_item_label: "25% Tool Latency (ms)"
    value_format_name: decimal_2
  }

  measure: p50_tool_latency_ms {
    type: percentile
    percentile: 50
    sql: ${playbook_metrics__tool_latency_ms} ;;
    filters: [contains_playbook_metrics: "Yes"]
    group_label: "Playbook Metrics"
    group_item_label: "50% Tool Latency (ms)"
    value_format_name: decimal_2
  }

  measure: p75_tool_latency_ms {
    type: percentile
    percentile: 75
    sql: ${playbook_metrics__tool_latency_ms} ;;
    filters: [contains_playbook_metrics: "Yes"]
    group_label: "Playbook Metrics"
    group_item_label: "75% Tool Latency (ms)"
    value_format_name: decimal_2
  }

  measure: p90_tool_latency_ms {
    type: percentile
    percentile: 90
    sql: ${playbook_metrics__tool_latency_ms} ;;
    filters: [contains_playbook_metrics: "Yes"]
    group_label: "Playbook Metrics"
    group_item_label: "90% Tool Latency (ms)"
    value_format_name: decimal_2
  }

  measure: p95_tool_latency_ms {
    type: percentile
    percentile: 95
    sql: ${playbook_metrics__tool_latency_ms} ;;
    filters: [contains_playbook_metrics: "Yes"]
    group_label: "Playbook Metrics"
    group_item_label: "95% Tool Latency (ms)"
    value_format_name: decimal_2
  }

  measure: p99_tool_latency_ms {
    type: percentile
    percentile: 99
    sql: ${playbook_metrics__tool_latency_ms} ;;
    filters: [contains_playbook_metrics: "Yes"]
    group_label: "Playbook Metrics"
    group_item_label: "99% Tool Latency (ms)"
    value_format_name: decimal_2
  }

  measure: playbook_success {
    type: count
    filters: [playbook_metrics__states: "SUCCEEDED",contains_playbook_metrics: "Yes"]
    group_label: "Playbook Metrics"
    label: "Playbook Success"
    drill_fields: [standard_transcript_drill*,playbook_success]
  }

  measure: playbook_failure {
    type: count
    filters: [playbook_metrics__states: "-SUCCEEDED",contains_playbook_metrics: "Yes"]
    group_label: "Playbook Metrics"
    label: "Playbook Failures"
    drill_fields: [standard_transcript_drill*,playbook_failure]
  }

  measure: total_intent_utterances {
    type: count
    filters: [match_type: "INTENT"]
    drill_fields: [standard_transcript_drill*]
  }

  measure: total_parameter_filling_utterances {
    type: count
    filters: [match_type: "PARAMETER_FILLING"]
    drill_fields: [standard_transcript_drill*]
  }

  measure: total_event_utterances {
    type: count
    filters: [match_type: "EVENT"]
    drill_fields: [standard_transcript_drill*]
  }

  measure: total_knowledge_connector_utterances {
    type: count
    filters: [match_type: "KNOWLEDGE_CONNECTOR"]
    drill_fields: [standard_transcript_drill*]
  }

  measure: total_request_agent_utterances {
    type: count
    filters: [intent_display_name: "req_agent"]
    drill_fields: [standard_transcript_drill*]
  }

  measure: total_confirmation_yes_utterances {
    type: count
    filters: [intent_display_name: "confirmation.yes"]
    drill_fields: [standard_transcript_drill*]
  }

  measure: total_confirmation_no_utterances {
    type: count
    filters: [intent_display_name: "confirmation.no"]
    drill_fields: [standard_transcript_drill*]
  }

  measure: total_confirmation_thanks_utterances {
    type: count
    filters: [intent_display_name: "confirmation.thanks"]
    drill_fields: [standard_transcript_drill*]
  }

  measure: parameter_filling_percentage {
    label: "Parameter Filling %"
    type: number
    sql: ${total_parameter_filling_utterances} / NULLIF(${total_turns}, 0) ;;
    value_format: "0.00%"
    drill_fields: [standard_transcript_drill*,parameter_filling_percentage]
  }

  measure: event_percentage {
    label: "Event %"
    type: number
    sql: ${total_event_utterances} / NULLIF(${total_turns}, 0) ;;
    value_format: "0.00%"
    drill_fields: [standard_transcript_drill*,event_percentage]
  }

  measure: intent_percentage {
    label: "Intent %"
    type: number
    sql: ${total_intent_utterances} / NULLIF(${total_turns}, 0) ;;
    value_format: "0.00%"
    drill_fields: [standard_transcript_drill*,intent_percentage]
  }

  measure: request_agent_percentage {
    label: "Request Agent %"
    type: number
    sql: ${total_request_agent_utterances} / NULLIF(${total_turns}, 0) ;;
    value_format: "0.00%"
    drill_fields: [standard_transcript_drill*,request_agent_percentage]
  }

  measure: yes_percentage {
    label: "Yes %"
    type: number
    sql: ${total_confirmation_yes_utterances} / NULLIF(${total_turns}, 0) ;;
    value_format: "0.00%"
    drill_fields: [standard_transcript_drill*,yes_percentage]
  }

  measure: no_percentage {
    label: "No %"
    type: number
    sql: ${total_confirmation_no_utterances} / NULLIF(${total_turns}, 0) ;;
    value_format: "0.00%"
    drill_fields: [standard_transcript_drill*,no_percentage]
  }

  measure: knowledge_connector_percentage {
    label: "Knowledge Connector %"
    type: number
    sql: ${total_knowledge_connector_utterances} / NULLIF(${total_turns}, 0) ;;
    value_format: "0.00%"
    drill_fields: [standard_transcript_drill*,knowledge_connector_percentage]
  }

  measure: thanks_percentage {
    label: "Thanks %"
    type: number
    sql: ${total_confirmation_thanks_utterances} / NULLIF(${total_turns}, 0) ;;
    value_format: "0.00%"
    drill_fields: [standard_transcript_drill*,thanks_percentage]
  }

  dimension: input_audio_ms {
    type: number
    sql: ${TABLE}.input_audio_ms ;;
  }

  dimension: output_audio_ms {
    type: number
    sql: ${TABLE}.output_audio_ms ;;
  }

  measure: total_input_audio_ms {
    type: sum
    sql: ${input_audio_ms} ;;
    value_format_name: decimal_0
  }

  measure: total_output_audio_ms {
    type: sum
    sql: ${output_audio_ms} ;;
    value_format_name: decimal_0
  }

  set: standard_transcript_drill {
    fields: [session_id,position,user_utterance,agent_response,source_flow_display_name,source_page_display_name,flow_display_name,page_display_name]
  }

}

view: dfcx_transcript__webhooks {

  dimension: primary_key {
    hidden: yes
    primary_key: yes
    type: string
    sql: CONCAT(
      ${dfcx_transcript.session_id}, '~',
      CAST(${dfcx_transcript.position} AS STRING), '~',
      ${step}) ;;
  }

  dimension: webhook_id {
    hidden: yes
    type: string
    sql: ${TABLE}.webhook_id ;;
  }

  dimension: flow_display_name {
    type: string
    sql: ${TABLE}.flow_display_name ;;
  }

  dimension: flow_id {
    hidden: yes
    type: string
    sql: ${TABLE}.flow_id ;;
  }

  dimension: page_display_name {
    type: string
    sql: ${TABLE}.page_display_name ;;
  }

  dimension: page_id {
    hidden: yes
    type: string
    sql: ${TABLE}.page_id ;;
  }

  dimension: session_parameters_updated {
    hidden: yes
    type: string
    sql: ${TABLE}.session_parameters_updated ;;
  }

  dimension: session_parameters_updated_string {
    label: "Session Parameters Updated (string)"
    type: string
    sql: TO_JSON_STRING(${session_parameters_updated}) ;;
  }

  dimension: step {
    type: number
    sql: ${TABLE}.step ;;
  }

  dimension: webhook_display_name {
    type: string
    sql: ${TABLE}.webhook_display_name;;
  }

  dimension: webhook_latency_ms {
    label: "Webhook Latency MS"
    type: number
    sql: ${TABLE}.webhook_latency_ms ;;
  }

  dimension: webhook_status {
    type: string
    sql: ${TABLE}.webhook_status ;;
  }

  dimension: webhook_url {
    type: string
    sql: ${TABLE}.webhook_url ;;
  }

  dimension: operational_webhook_failure {
    type: yesno
    sql: ${webhook_status} != 'OK' ;;
    description: "Indicates if the webhook status is not 'OK'"
  }

  measure: total_operational_webhook_failures {
    type: count_distinct
    sql: CASE WHEN ${operational_webhook_failure} THEN ${primary_key} ELSE NULL END ;;
    label: "Total Operational Webhook Failures"
  }

  measure: operational_webhook_failure_rate {
    type: number
    sql: ${total_operational_webhook_failures}/ NULLIF(${total_webhooks},0)  ;;
    value_format_name: percent_2
  }

  measure: total_webhooks {
    type: count
  }

  measure: average_webhook_latency_ms {
    label: "Average Webhook Latency MS"
    type: average
    sql: ${webhook_latency_ms} ;;
    value_format_name: decimal_2
  }

  measure: 5th_percentile_webhook_latency_ms {
    group_label: "Webhook Latency MS Percentiles"
    label: "Webhook Latency MS - 05%"
    type: percentile
    sql: ${webhook_latency_ms} ;;
    percentile: 5
  }
  measure: 25th_percentile_webhook_latency_ms {
    group_label: "Webhook Latency MS Percentiles"
    label: "Webhook Latency MS - 25%"
    type: percentile
    sql: ${webhook_latency_ms} ;;
    percentile: 25
  }
  measure: 50th_percentile_webhook_latency_ms {
    group_label: "Webhook Latency MS Percentiles"
    label: "Webhook Latency MS - 50%"
    type: percentile
    sql: ${webhook_latency_ms} ;;
    percentile: 50
  }
  measure: 75th_percentile_webhook_latency_ms {
    group_label: "Webhook Latency MS Percentiles"
    label: "Webhook Latency MS - 75%"
    type: percentile
    sql: ${webhook_latency_ms} ;;
    percentile: 75
  }

  measure: 95th_percentile_webhook_latency_ms {
    group_label: "Webhook Latency MS Percentiles"
    label: "Webhook Latency MS - 95%"
    type: percentile
    sql: ${webhook_latency_ms} ;;
    percentile: 95
  }

  measure: 99th_percentile_webhook_latency_ms {
    group_label: "Webhook Latency MS Percentiles"
    label: "Webhook Latency MS - 99%"
    type: percentile
    sql: ${webhook_latency_ms} ;;
    percentile: 99
  }

}

view: dfcx_transcript__execution_sequence {
  dimension: dfcx_transcript__execution_sequence {
    type: string
    hidden: yes
    sql: ${TABLE}.dfcx_transcript__execution_sequence ;;
  }

  dimension: flow_display_name {
    type: string
    sql: ${TABLE}.flow_display_name ;;
  }

  dimension: flow_id {
    hidden: yes
    type: string
    sql: ${TABLE}.flow_id ;;
  }

  dimension: page_display_name {
    type: string
    sql: ${TABLE}.page_display_name ;;
  }

  dimension: page_id {
    hidden: yes
    type: string
    sql: ${TABLE}.page_id ;;
  }

  dimension: responses {
    hidden: yes
    sql: ${TABLE}.responses ;;
  }

  dimension: responses_string {
    label: "Respones (string)"
    type: string
    sql: TO_JSON_STRING(${responses}) ;;
  }


  dimension: session_parameters_initial {
    hidden: yes
    type: string
    sql: ${TABLE}.session_parameters_initial ;;
  }

  dimension: session_parameters_initial_string {
    label: "Session Parameters Initial (string)"
    type: string
    sql: TO_JSON_STRING(${session_parameters_initial}) ;;
  }

  dimension: session_parameters_updated {
    hidden: yes
    type: string
    sql: ${TABLE}.session_parameters_updated ;;
  }

  dimension: session_parameters_updated_string {
    label: "Session Parameters Updated (string)"
    type: string
    sql: TO_JSON_STRING(${session_parameters_updated}) ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: step {
    type: number
    sql: ${TABLE}.step ;;
  }

  dimension: system_function_results {
    type: string
    sql: ${TABLE}.system_function_results ;;
  }

  dimension: target_flow_id {
    type: string
    sql: ${TABLE}.target_flow_id ;;
  }

  dimension: target_page_id {
    type: string
    sql: ${TABLE}.target_page_id ;;
  }

  dimension: triggered_condition {
    type: string
    sql: ${TABLE}.triggered_condition ;;
  }

  dimension: triggered_intent {
    type: string
    sql: ${TABLE}.triggered_intent ;;
  }

  dimension: triggered_transition_route_id {
    type: string
    sql: ${TABLE}.triggered_transition_route_id ;;
  }

  dimension: step_processing_ms {
    type: number
    sql: ${TABLE}.step_processing_ms ;;
  }

  measure: total_step_processing_ms {
    type: sum
    sql: ${step_processing_ms} ;;
    value_format_name: decimal_0
  }

  dimension: webhook_latency_ms {
    label: "Webhook Latency MS"
    type: number
    sql: ${TABLE}.webhook_latency_ms ;;
  }

  measure: total_webhook_latency_ms {
    type: sum
    sql: ${webhook_latency_ms} ;;
    value_format_name: decimal_0
  }
}

view: dfcx_transcript__actions {

  dimension: primary_key {
    hidden: yes
    primary_key: yes
    type: string
    sql: CONCAT(${dfcx_transcript.session_id}, '~', CAST(${dfcx_transcript.position} AS STRING), '~', ${action_step}) ;;
  }

  dimension: action {
    type: string
    sql: ${TABLE}.action ;;
    full_suggestions: yes
  }

  dimension: action_input {
    hidden: yes
    sql: ${TABLE}.action_input ;;
  }

  dimension: action_input_string {
    label: "Action Input (string)"
    type: string
    sql: TO_JSON_STRING(${action_input}) ;;
    full_suggestions: yes
  }

  dimension: action_input__sql_query {
    group_label: "Action Input Parameters"
    label: "SQL Query"
    type: string
    sql: JSON_VALUE(${action_input},'$.sql-query') ;;
    full_suggestions: yes
  }

  dimension: action_name {
    type: string
    sql: ${TABLE}.action_name ;;
    full_suggestions: yes
  }

  dimension: action_state {
    type: string
    sql: ${TABLE}.action_state ;;
    full_suggestions: yes
  }

  dimension: action_output {
    hidden: yes
    sql: ${TABLE}.action_output ;;
    full_suggestions: yes
  }

  dimension: action_output_string {
    label: "Action Output (string)"
    type: string
    sql: TO_JSON_STRING(${action_output}) ;;
    full_suggestions: yes
  }

  dimension: action_output__column_names {
    group_label: "Action Output Parameters"
    label: "Column Names"
    type: string
    sql: NULLIF(TO_JSON_STRING(JSON_QUERY(${action_output},'$.column_names')),'null') ;;
    full_suggestions: yes
  }

  dimension: action_step {
    type: number
    sql: ${TABLE}.action_step ;;
    full_suggestions: yes
  }

  dimension: is_sql_generated {
    hidden: yes
    type: yesno
    sql: ${action_input__sql_query} IS NOT NULL ;;
    full_suggestions: yes
  }

  dimension: is_data_returned {
    hidden: yes
    type: yesno
    sql: ${action_output__column_names} IS NOT NULL ;;
    full_suggestions: yes
  }

  measure: total_sql_queries {
    label: "Total SQL Queries"
    type: count
    filters: [is_sql_generated: "Yes"]
    drill_fields: [standard_action_drill*,total_sql_queries]
  }

  measure: total_data_returned_queries {
    label: "Total Data Returned Queries"
    type: count
    filters: [is_sql_generated: "Yes",is_data_returned: "Yes"]
    drill_fields: [standard_action_drill*,total_sql_queries,total_data_returned_queries]
  }

  measure: successful_query_percentage {
    label: "Successful Query %"
    type: number
    sql: SAFE_DIVIDE(${total_data_returned_queries},${total_sql_queries}) ;;
    value_format_name: percent_0
    drill_fields: [standard_action_drill*,total_sql_queries,successful_query_percentage]
  }

  set: standard_action_drill {
    fields: [dfcx_session_metadata.session_id,dfcx_transcript.position,action_step,action_name,action_input_string,action_output_string]
  }

}

view: dfcx_transcript__alternative_matched_intents {

  dimension: alternative_matched_intent {
    type: string
    sql: ${TABLE}.alternative_matched_intent ;;
  }

  dimension: score {
    type: number
    sql: ${TABLE}.score ;;
  }
}
