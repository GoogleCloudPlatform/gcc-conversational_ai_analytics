view: dfcx_interaction {
  sql_table_name: `@{project_id}.@{dataform_schema}.dfcx_interaction`;;

  dimension: primary_key {
    hidden: yes
    primary_key: yes
    type: string
    sql: CONCAT(${session_id}, ${interaction_position}) ;;
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

  dimension: flows {
    hidden: yes
    sql: ${TABLE}.flows ;;
  }

  dimension: interaction_head_intent {
    type: string
    description: "The head intent of the interaction"
    sql: ${TABLE}.interaction_head_intent ;;
  }

  dimension_group: start_interaction {
    type: time
    description: "The timestamp at which the interaction started"
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.start_interaction_time ;;
  }

  dimension_group: end_interaction {
    type: time
    description: "The timestamp at which the interaction ended"
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.end_interaction_time ;;
  }

  dimension: interaction_position {
    type: number
    description: "The position of the interaction within the session"
    sql: ${TABLE}.interaction_position ;;
  }

  dimension: interaction_position_reverse {
    hidden: yes
    type: number
    description: "The reverse position of the interaction within the session"
    sql: ${TABLE}.interaction_position_reverse ;;
  }

  dimension: project_id {
    hidden: yes
    type: string
    description: "The GCP project ID"
    sql: ${TABLE}.project_id ;;
  }

  dimension: location {
    hidden: yes
    type: string
    description: "The GCP location of the agent"
    sql: ${TABLE}.location ;;
  }

  dimension: agent_id {
    hidden: yes
    type: string
    description: "The user-provided identifier for the agent"
    sql: ${TABLE}.agent_id ;;
  }

  dimension: session_id {
    type: string
    description: "The fully qualified unique ID for the session"
    sql: ${TABLE}.session_id ;;
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



  measure: total_interactions {
    type: count
    drill_fields: [standard_interaction_drill*,total_interactions]
  }

  measure: total_interactions_started {
    type: count
    filters: [
      dfcx_interaction__flows.action_started: "yes"
    ]
    value_format_name: decimal_0
    drill_fields: [standard_interaction_drill*,total_interactions_started]
  }

  measure: total_interactions_ended {
    type: count
    filters: [
      dfcx_interaction__flows.action_started: "yes",
      dfcx_interaction__flows.action_ended: "yes"
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
      dfcx_interaction__flows.flow_display_name,
      dfcx_interaction__flows.action_started,
      dfcx_interaction__flows.action_ended
      ]
  }

}

view: dfcx_interaction__flows {
  dimension: flow_id {
    type: string
    description: "The unique ID of the flow"
    sql: ${TABLE}.flow_id ;;
  }

  dimension: flow_display_name {
    type: string
    description: "The human readable name of the flow"
    sql: ${TABLE}.flow_display_name ;;
  }

  dimension: action_started {
    type: yesno
    description: "Whether the action started in the flow"
    sql: ${TABLE}.action_started ;;
  }

  dimension_group: action_started {
    type: time
    description: "The timestamp at which the action started"
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.action_started_time ;;
  }

  dimension: action_ended {
    type: yesno
    description: "Whether the action ended in the flow"
    sql: ${TABLE}.action_ended ;;
  }

  dimension_group: action_ended {
    type: time
    description: "The timestamp at which the action ended"
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.action_ended_time ;;
  }
}
