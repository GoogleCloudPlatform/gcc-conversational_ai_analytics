include: "/views/dfcx_transcript.view.lkml"

explore: dfcx_transcript {
  hidden: yes

  persist_with: hourly

  join: dfcx_transcript__webhooks {
    view_label: "DFCX Transcript: Webhooks"
    sql: LEFT JOIN UNNEST(${dfcx_transcript.webhooks}) as dfcx_transcript__webhooks ;;
    relationship: one_to_many
  }

  join: dfcx_transcript__execution_sequence {
    view_label: "DFCX Transcript: Execution Sequence"
    sql: LEFT JOIN UNNEST(${dfcx_transcript.execution_sequence}) as dfcx_transcript__execution_sequence ;;
    relationship: one_to_many
  }

  join: dfcx_transcript__alternative_matched_intents {
    view_label: "DFCX Transcript: Alternative Matched Intents"
    sql: LEFT JOIN UNNEST(${dfcx_transcript.alternative_matched_intents}) as dfcx_transcript__alternative_matched_intents ;;
    relationship: one_to_many
  }

  join: dfcx_transcript__actions {
    view_label: "DFCX Transcript: Actions"
    sql: LEFT JOIN UNNEST(${dfcx_transcript.actions}) as dfcx_transcript__actions ;;
    relationship: one_to_many
  }

  join: dfcx_transcript__playbooks {
    view_label: "DFCX Transcript: Playbooks"
    sql: LEFT JOIN UNNEST(${dfcx_transcript.playbooks}) as dfcx_transcript__playbooks ;;
    relationship: one_to_many
  }

  join: dfcx_transcript__blocks {
    view_label: "DFCX Transcript: Blocks"
    sql: LEFT JOIN UNNEST(${dfcx_transcript.blocks}) as dfcx_transcript__blocks ;;
    relationship: one_to_many
  }

  join: dfcx_transcript__tools {
    view_label: "DFCX Transcript: Tools"
    sql: LEFT JOIN UNNEST(${dfcx_transcript.tools}) as dfcx_transcript__tools ;;
    relationship: one_to_many
  }

  join: dfcx_transcript__response_messages {
    view_label: "DFCX Transcript: Response Messages"
    sql: LEFT JOIN UNNEST(${dfcx_transcript.response_messages}) as dfcx_transcript__response_messages ;;
    relationship: one_to_many
  }
}
