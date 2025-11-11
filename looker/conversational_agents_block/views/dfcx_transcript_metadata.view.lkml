view: dfcx_transcript_metadata {
  sql_table_name: `@{project_id}.@{dataform_schema}.dfcx_transcript_metadata`;;

  dimension: primary_key {
    hidden: yes
    primary_key: yes
    type: string
    sql: CONCAT(${session_id}, ${position}) ;;
  }

  dimension: response_id {
    type: string
    description: "The unique ID associated with the response from the agent"
    sql: ${TABLE}.response_id ;;
  }

  dimension: contain_ai_generated_content {
    type: yesno
    description: "Whether the turn contains AI generated content"
    sql: ${TABLE}.contain_ai_generated_content ;;
  }

  dimension: contain_generators_content {
    type: yesno
    description: "Whether the turn contains generators content"
    sql: ${TABLE}.contain_generators_content ;;
  }

  dimension: contain_generative_fallback {
    type: yesno
    description: "Whether the turn contains generative fallback"
    sql: ${TABLE}.contain_generative_fallback ;;
  }


  

  dimension_group: request {
    type: time
    description: "The time of the conversational turn"
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

  dimension_group: insert {
    type: time
    description: "The timestamp when the record was inserted"
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.insert_time ;;
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

  dimension: source_agent_response {
    type: string
    description: "The source agent response"
    sql: ${TABLE}.source_agent_response ;;
  }

  dimension: contain_attempted_data_store_interactions {
    group_label: "AI Indicators"
    type: yesno
    sql: ${TABLE}.contain_attempted_data_store_interactions ;;
  }

  dimension: contain_data_store_content {
    group_label: "AI Indicators"
    type: yesno
    sql: ${TABLE}.contain_data_store_content ;;
  }

  dimension: contain_data_store_faq_content {
    group_label: "AI Indicators"
    label: "Contain Datastore FAQ Content"
    type: yesno
    sql: ${TABLE}.contain_data_store_faq_content ;;
  }

  dimension: contain_playbook {
    group_label: "AI Indicators"
    label: "Contain Playbook"
    type: yesno
    sql: ${TABLE}.contain_playbook ;;
  }

  dimension: contain_any_ai_generated_content {
    group_label: "AI Indicators"
    label: "Contain Any AI Generated Content"
    type: yesno
    sql: ${contain_ai_generated_content} OR ${contain_datastore_content} OR ${contain_datastore_faq_content} OR ${contain_generative_fallback} OR ${contain_generators_content} OR ${contain_playbook_content} ;;
  }

  measure: total_turns_contain_ai_generated_content {
    type: count
    filters: [contain_ai_generated_content: "Yes"]
    group_label: "AI Indicators"
    label: "Total Turns Contain AI Generated Content"
    drill_fields: [dfcx_transcript.standard_transcript_drill*,total_turns_contain_ai_generated_content]
  }

  measure: total_turns_contain_datastore_content {
    type: count
    filters: [contain_datastore_content: "Yes"]
    group_label: "AI Indicators"
    label: "Total Turns Contain Datastore Content"
    drill_fields: [dfcx_transcript.standard_transcript_drill*,total_turns_contain_datastore_content]
  }

  measure: total_turns_contain_datastore_faq_content {
    type: count
    filters: [contain_datastore_faq_content: "Yes"]
    group_label: "AI Indicators"
    label: "Total Turns Contain Datastore FAQ Content"
    drill_fields: [dfcx_transcript.standard_transcript_drill*,total_turns_contain_datastore_faq_content]
  }

  measure: total_turns_contain_generative_fallback {
    type: count
    filters: [contain_generative_fallback: "Yes"]
    group_label: "AI Indicators"
    label: "Total Turns Contain Generative Fallback"
    drill_fields: [dfcx_transcript.standard_transcript_drill*,total_turns_contain_generative_fallback]
  }

  measure: total_turns_contain_generators_content {
    type: count
    filters: [contain_generators_content: "Yes"]
    group_label: "AI Indicators"
    label: "Total Turns Contain Generators Content"
    drill_fields: [dfcx_transcript.standard_transcript_drill*,total_turns_contain_generators_content]
  }

  measure: total_turns_contain_playbook_content {
    type: count
    filters: [contain_playbook_content: "Yes"]
    group_label: "AI Indicators"
    label: "Total Turns Contain Playbook Content"
    drill_fields: [dfcx_transcript.standard_transcript_drill*,total_turns_contain_playbook_content]
  }

  measure: total_turns_contain_any_ai_generated_content {
    type: count
    filters: [contain_any_ai_generated_content: "Yes"]
    group_label: "AI Indicators"
    label: "Total Turns Contain Any AI Generated Content"
    drill_fields: [dfcx_transcript.standard_transcript_drill*,total_turns_contain_any_ai_generated_content]
  }

  measure: total_turns_curated_responses {
    type: count
    filters: [contain_any_ai_generated_content: "No"]
    label: "Total Turns Curated Respones"
    drill_fields: [dfcx_transcript.standard_transcript_drill*,total_turns_curated_responses]
  }

  measure: ai_generated_content_percentage {
    label: "AI Generated Content %"
    type: number
    sql: ${total_turns_contain_any_ai_generated_content} / NULLIF(${dfcx_transcript.total_turns}, 0) ;;
    value_format_name: percent_2
    drill_fields: [dfcx_transcript.standard_transcript_drill*,ai_generated_content_percentage]
  }

  measure: count {
    type: count
    drill_fields: []
  }
}

view: dfcx_transcript_metadata__alternative_matched_intents {
  dimension: alternative_matched_intent {
    type: string
    sql: alternative_matched_intent ;;
  }

  dimension: dfcx_transcript_metadata__alternative_matched_intents {
    type: string
    hidden: yes
    sql: dfcx_transcript_metadata__alternative_matched_intents ;;
  }

  dimension: score {
    type: number
    sql: score ;;
  }
}
