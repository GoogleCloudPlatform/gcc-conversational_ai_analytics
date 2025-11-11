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
    description: "The user-provided identifier for the agent"
    sql: ${TABLE}.agent_id ;;
  }

  dimension: agent_name {
    type: string
    description: "The human readable name of the agent"
    sql: ${TABLE}.agent_name ;;
  }

  dimension: final_action {
    type: string
    description: "The final action of the session"
    sql: ${TABLE}.final_action ;;
  }

  dimension: final_action_ended {
    type: yesno
    description: "Whether the final action ended"
    sql: ${TABLE}.final_action_ended ;;
  }

  dimension: final_action_started {
    type: yesno
    description: "Whether the final action started"
    sql: ${TABLE}.final_action_started ;;
  }

  dimension: final_interaction_head_intent {
    type: string
    description: "The head intent of the final interaction"
    sql: ${TABLE}.final_interaction_head_intent ;;
  }

  dimension: final_language_code {
    type: string
    description: "The language code of the final interaction"
    sql: ${TABLE}.final_language_code ;;
  }

  dimension: final_session_parameters {
    hidden: yes
    type: string
    description: "The session parameters of the final interaction"
    sql: ${TABLE}.final_session_parameters ;;
  }

  dimension: is_escalated {
    type: yesno
    description: "Whether the session was escalated"
    sql: ${TABLE}.is_escalated ;;
  }

  dimension_group: latest_insert {
    type: time
    description: "The timestamp at which the record was last inserted"
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.latest_insert_time ;;
  }

  dimension: location {
    type: string
    description: "The GCP location of the agent"
    sql: ${TABLE}.location ;;
  }

  dimension: number_of_turns {
    type: number
    description: "The number of turns in the session"
    sql: ${TABLE}.number_of_turns ;;
  }

  dimension: project_id {
    type: string
    description: "The GCP project ID"
    sql: ${TABLE}.project_id ;;
  }

  dimension_group: session_end {
    type: time
    description: "The timestamp at which the session ended"
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
    description: "The fully qualified unique ID for the session"
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
      label: "Conversational Agents"
      url: "https://conversational-agents.cloud.google.com/projects/{{project_id}}/locations/{{location}}/agents/{{agent_id}}/(conversations//right-panel:projects/{{project_id}}/locations/{{location}}/agents/{{agent_id}}/conversations/{{session_id}})?conversationId={{session_id}}"
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
    description: "The timestamp at which the session started"
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
