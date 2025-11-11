include: "/views/dfcx_interaction.view.lkml"
include: "/views/dfcx_transcript.view.lkml"

explore: dfcx_interaction {
  hidden: yes

  persist_with: hourly

  join: dfcx_interaction_last_turn {
    view_label: "DFCX Interaction: Last Turn"
    from: dfcx_transcript
    fields: [dfcx_interaction_last_turn.source_flow_display_name, source_page_display_name, flow_display_name, page_display_name]
    type: left_outer
    sql_on: ${dfcx_interaction.session_id} = ${dfcx_interaction_last_turn.session_id} AND  ${dfcx_interaction.session_start_raw} = ${dfcx_interaction_last_turn.session_start_raw}
    AND ${dfcx_interaction.end_interaction_raw} = ${dfcx_interaction_last_turn.request_raw} ;;
    relationship: one_to_one
  }

  join: dfcx_interaction__flows {
    view_label: "DFCX Interaction: Actions"
    sql: LEFT JOIN UNNEST(${dfcx_interaction.flows}) as dfcx_interaction__flows ;;
    relationship: one_to_many
  }

}
