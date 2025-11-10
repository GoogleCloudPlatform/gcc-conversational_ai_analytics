view: dfcx_session_metadata {
  sql_table_name: `@{project_id}.@{dataform_schema}.dfcx_session_metadata`;;

  parameter: auth_user {
    type:  unquoted
    default_value: "0"
  }

  dimension: primary_key {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${session_id} ;;
  }

  dimension: agent_id {
    type: string
    sql: ${TABLE}.agent_id ;;
  }

  dimension: agent_name {
    type: string
    sql: ${TABLE}.agent_name ;;
  }

  dimension: channel {
    type: string
    sql: ${TABLE}.channel ;;
  }

  dimension: final_action {
    type: string
    sql: ${TABLE}.final_action ;;
  }

  dimension: final_action_ended {
    type: yesno
    sql: ${TABLE}.final_action_ended ;;
  }

  dimension: final_action_primary_flow {
    type: string
    sql: ${TABLE}.final_action_primary_flow ;;
  }

  dimension: final_action_started {
    type: yesno
    sql: ${TABLE}.final_action_started ;;
  }

  dimension: final_interaction_head_intent {
    type: string
    sql: ${TABLE}.final_interaction_head_intent ;;
  }

  dimension: final_interaction_head_intent_pod {
    type: string
    sql: ${TABLE}.final_interaction_head_intent_pod ;;
  }

  dimension: final_language_code {
    type: string
    sql: ${TABLE}.final_language_code ;;
  }

  dimension: final_message__authentication_method {
    type: string
    sql: ${TABLE}.final_message.authentication_method ;;
    group_label: "Final Message"
    group_item_label: "Authentication Method"
  }

  dimension: final_message__event {
    type: string
    sql: ${TABLE}.final_message.event ;;
    group_label: "Final Message"
    group_item_label: "Event"
  }

  dimension: final_message__event_flow {
    type: string
    sql: ${TABLE}.final_message.event_flow ;;
    group_label: "Final Message"
    group_item_label: "Event Flow"
  }

  dimension: final_message__event_page {
    type: string
    sql: ${TABLE}.final_message.event_page ;;
    group_label: "Final Message"
    group_item_label: "Event Page"
  }

  dimension: final_message__flow_display_name {
    type: string
    sql: ${TABLE}.final_message.flow_display_name ;;
    group_label: "Final Message"
    group_item_label: "Flow Display Name"
  }

  dimension: final_message__how_delivered {
    type: string
    sql: ${TABLE}.final_message.how_delivered ;;
    group_label: "Final Message"
    group_item_label: "How Delivered"
  }

  dimension: final_message__intent_display_name {
    type: string
    sql: ${TABLE}.final_message.intent_display_name ;;
    group_label: "Final Message"
    group_item_label: "Intent Display Name"
  }

  dimension: final_message__is_authenticated {
    type: string
    sql: ${TABLE}.final_message.isAuthenticated ;;
    group_label: "Final Message"
    group_item_label: "Is Authenticated"
  }

  dimension: final_message__match_type {
    type: string
    sql: ${TABLE}.final_message.match_type ;;
    group_label: "Final Message"
    group_item_label: "Match Type"
  }

  dimension: final_message__page_display_name {
    type: string
    sql: ${TABLE}.final_message.page_display_name ;;
    group_label: "Final Message"
    group_item_label: "Page Display Name"
  }

  dimension: final_message__prev_intent {
    type: string
    sql: ${TABLE}.final_message.prev_intent ;;
    group_label: "Final Message"
    group_item_label: "Prev Intent"
  }

  dimension: final_message__producttype {
    type: string
    sql: ${TABLE}.final_message.producttype ;;
    group_label: "Final Message"
    group_item_label: "Producttype"
  }

  dimension: final_message__sms_needs_response {
    type: string
    sql: ${TABLE}.final_message.sms_needs_response ;;
    group_label: "Final Message"
    group_item_label: "Sms Needs Response"
  }

  dimension: final_message__sms_type {
    type: string
    sql: ${TABLE}.final_message.sms_type ;;
    group_label: "Final Message"
    group_item_label: "Sms Type"
  }

  dimension: final_message__source_flow_display_name {
    type: string
    sql: ${TABLE}.final_message.source_flow_display_name ;;
    group_label: "Final Message"
    group_item_label: "Source Flow Display Name"
  }

  dimension: final_message__source_page_display_name {
    type: string
    sql: ${TABLE}.final_message.source_page_display_name ;;
    group_label: "Final Message"
    group_item_label: "Source Page Display Name"
  }

  dimension: final_message__voice_faq_id {
    type: string
    sql: ${TABLE}.final_message.voice_faq_id ;;
    group_label: "Final Message"
    group_item_label: "Voice Faq ID"
  }

  dimension: flag_failed_webhook {
    type: yesno
    sql: ${TABLE}.flag_failed_webhook ;;
  }

  dimension: is_escalated {
    type: yesno
    sql: ${TABLE}.is_escalated ;;
  }

  dimension: location {
    type: string
    sql: ${TABLE}.location ;;
  }

  dimension: number_of_turns {
    type: number
    sql: ${TABLE}.number_of_turns ;;
  }

  dimension: project_id {
    type: string
    sql: ${TABLE}.project_id ;;
  }

  dimension_group: session_end {
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
    type: string
    sql: ${TABLE}.session_id ;;
    link: {
      label: "Cloud Logging"
      url: "https://console.cloud.google.com/logs/query;query=resource.type%3D%22global%22%0Aresource.labels.project_id%3D%22{{project_id._value}}%22%0Alabels.session_id%3D%22{{session_id._value}}%22;startTime={{session_start_for_link | date:'%Y-%m-%dT%H:%M:%S.000Z'}};endTime={{session_end_for_link | date:'%Y-%m-%dT%H:%M:%S.999Z'}}?project={{project_id._value}}&authuser={{auth_user._parameter_value}}"
    }
    link: {
      label: "Insights"
      url: "https://ccai.cloud.google.com/insights/projects/{{project_id}}/locations/{{location}}/conversations/{{session_id}}?authuser={{auth_user._parameter_value}}"
    }
    link: {
      label: "DFCX"
      url: "https://dialogflow.cloud.google.com/cx/projects/{{project_id}}/locations/{{location}}/agents/{{agent_id}}/conversations/{{session_id}}?authuser={{auth_user._parameter_value}}"
    }
    link: {
      label: "Transcript Explorer"
      url: "/dashboards/{{_model._name}}::tools__transcript_explorer?Session+Start+Date={{session_start_date}}&Session+ID={{session_id | encode_url}}"
    }
  }

  dimension: session_start_for_link {
    hidden: yes
    type: date_raw
    sql: FORMAT_TIMESTAMP('%F %T', ${session_start_raw} ) ;;
  }

  dimension: session_end_for_link {
    hidden: yes
    type: date_raw
    sql: FORMAT_TIMESTAMP('%F %T', ${session_end_raw} ) ;;
  }

  dimension_group: session_start {
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

  measure: total_sessions {
    type: count
  }

  measure: count_final_action_started_sessions {
    type: count_distinct
    sql: CASE WHEN ${final_action_started} THEN ${session_id} ELSE NULL END ;;
    description: "Count of distinct sessions where final action started is TRUE"
  }

  dimension: session_handle_time {
    type: number
    sql: TIMESTAMP_DIFF(
         TIMESTAMP(${session_end_time}),
         TIMESTAMP(${session_start_time}),
         SECOND
       ) ;;
    description: "Session Duration (in seconds)"
  }

  measure: avg_session_handle_time {
    type: average
    sql: TIMESTAMP_DIFF(
         TIMESTAMP(${session_end_time}),
         TIMESTAMP(${session_start_time}),
         SECOND
       ) ;;
    description: "Avg Session Duration (in seconds)"
  }

  measure: total_ss_success_convs {
    type: count_distinct
    sql: IF(${TABLE}.final_action_started AND ${TABLE}.final_action_ended, ${TABLE}.session_id , NULL ) ;;
  }

  measure: total_ss_attempt_sessions {
    type: count_distinct
    sql: ${TABLE}.session_id ;;
    filters: [final_action_started: "Yes"]
  }

  measure: ss_success_percentage {
    type: number
    sql: ${total_ss_success_convs}/ NULLIF(${total_ss_attempt_sessions},0)  ;;
    value_format_name: percent_2
  }

  measure: ss_attempt_percentage {
    type: number
    sql: SAFE_DIVIDE(${total_ss_attempt_sessions},${total_sessions}) ;;
    value_format_name: percent_2
  }

  measure: total_escalated_sessions {
    type: count_distinct
    sql: ${dfcx_session_metadata.session_id} ;;
    filters: [is_escalated: "Yes"]
  }

  measure: escalated_percentage {
    type: number
    sql:  ${total_escalated_sessions}/ NULLIF(${total_sessions},0) ;;
    value_format_name: percent_2
  }

}
