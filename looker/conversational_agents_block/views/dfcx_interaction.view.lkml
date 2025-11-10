view: dfcx_interaction {
  sql_table_name: `@{project_id}.@{dataform_schema}.dfcx_interaction`;;

  dimension: primary_key {
    hidden: yes
    primary_key: yes
    type: string
    sql: CONCAT(${session_id}, ${interaction_position}) ;;
  }

  dimension: actions {
    hidden: yes
    sql: ${TABLE}.actions ;;
  }

  dimension: end_interaction_position {
    type: number
    sql: ${TABLE}.end_interaction_position ;;
  }

  dimension: execution_steps {
    hidden: yes
    sql: ${TABLE}.execution_steps ;;
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

  dimension_group: insert_timestamp {
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
    sql: ${TABLE}.insert_timestamp ;;
  }

  dimension: interaction_head_intent {
    type: string
    sql: ${TABLE}.interaction_head_intent ;;
  }

  dimension: interaction_position {
    type: number
    sql: ${TABLE}.interaction_position ;;
  }

  dimension: interaction_position_reverse {
    hidden: yes
    type: number
    sql: ${TABLE}.interaction_position_reverse ;;
  }

  dimension: project_id {
    hidden: yes
    type: string
    sql: ${TABLE}.project_id ;;
  }

  dimension: session_id {
    type: string
    sql: ${TABLE}.session_id ;;
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

  dimension: start_interaction_position {
    type: number
    sql: ${TABLE}.start_interaction_position ;;
  }

  measure: total_interactions {
    type: count
    drill_fields: [standard_interaction_drill*,total_interactions]
  }

  measure: total_interactions_started {
    type: count
    filters: [
      dfcx_interaction__actions.action_started: "yes"
    ]
    value_format_name: decimal_0
    drill_fields: [standard_interaction_drill*,total_interactions_started]
  }

  measure: total_interactions_ended {
    type: count
    filters: [
      dfcx_interaction__actions.action_started: "yes",
      dfcx_interaction__actions.action_ended: "yes"
    ]
    value_format_name: decimal_0
    drill_fields: [standard_interaction_drill*,total_interactions_ended]
  }

  measure: self_service_attempt_rate {
    label: "SS Attempt %"
    type: number
    sql: ${total_interactions_started} / NULLIF(${dfcx_interaction.total_interactions},0) ;;
    value_format_name: percent_0
    drill_fields: [standard_interaction_drill*,total_interactions_started,total_interactions,self_service_attempt_rate]
  }

  measure: self_service_success_rate {
    label: "SS Success %"
    type: number
    sql: ${total_interactions_ended} / NULLIF(${total_interactions_started},0) ;;
    value_format_name: percent_0
    drill_fields: [standard_interaction_drill*,total_interactions_ended,total_interactions_started,self_service_success_rate]
  }

  set: standard_interaction_drill {
    fields: [
      dfcx_session_metadata.session_id,
      interaction_position,
      dfcx_interaction__actions.action,
      dfcx_interaction__actions.action_started,
      dfcx_interaction__actions.action_ended,
      final_message__source_flow_display_name,
      final_message__source_page_display_name,
      final_message__flow_display_name,
      final_message__page_display_name,
      final_message__intent_display_name
      ]
  }

}

view: dfcx_interaction__actions {
  dimension: action {
    type: string
    sql: action ;;
  }

  dimension: action_ended {
    type: yesno
    sql: action_ended ;;
  }

  dimension: action_ended_position {
    type: number
    sql: action_ended_position ;;
  }

  dimension: action_started {
    type: yesno
    sql: action_started ;;
  }

  dimension: action_started_position {
    type: number
    sql: action_started_position ;;
  }

  dimension: action_type {
    type: string
    sql: action_type ;;
  }

  dimension: dfcx_interaction__actions {
    type: string
    hidden: yes
    sql: dfcx_interaction__actions ;;
  }

  dimension: primary_action {
    type: yesno
    sql: primary_action ;;
  }

  dimension: primary_flow {
    type: string
    sql: primary_flow ;;
  }

}

view: dfcx_interaction__execution_steps {
  dimension: dfcx_interaction__execution_steps {
    type: string
    sql: dfcx_interaction__execution_steps ;;
  }
}
