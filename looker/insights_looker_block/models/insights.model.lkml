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

connection: "@{db_connection_name}"

# include all the views
include: "/views/**/*.view"
include: "/dashboards/**/*.dashboard"

datagroup: insights_daily_datagroup {
  sql_trigger: SELECT current_date;;
}

persist_with: insights_daily_datagroup

explore: insights_data {
  label: "CCAI Insights"
  join: insights_data__words {
    view_label: "4: Words"
    sql: LEFT JOIN UNNEST(${insights_data.words}) as insights_data__words ;;
    relationship: one_to_many
  }

  join: insights_data__labels {
    view_label: "1: Conversations"
    sql: LEFT JOIN UNNEST(${insights_data.labels}) as insights_data__labels ;;
    relationship: one_to_many
  }

  join: insights_data__topics {
    view_label: "1: Conversations"
    sql: LEFT JOIN UNNEST(${insights_data.topics}) as insights_data__topics ;;
    relationship: one_to_many
  }

  join: insights_data__entities {
    view_label: "3: Entities"
    sql: LEFT JOIN UNNEST(${insights_data.entities}) as insights_data__entities ;;
    relationship: one_to_many
  }

  join: insights_data__sentences {
    view_label: "2: Sentences"
    sql: LEFT JOIN UNNEST(${insights_data.sentences}) as insights_data__sentences ;;
    relationship: one_to_many
  }

  join: insights_data__sentences__annotations {
    view_label: "2: Sentences"

    sql: LEFT JOIN UNNEST(${insights_data__sentences.annotations}) as insights_data__sentences__annotations ;;
    relationship: one_to_many
  }

  join: insights_data__sentences__intent_match_data {
    view_label: "2: Sentences"
    sql: LEFT JOIN UNNEST(${insights_data__sentences.intent_match_data}) as insights_data__sentences__intent_match_data ;;
    relationship: one_to_many
  }

  join: insights_data__sentences__phrase_match_data {
    view_label: "2: Sentences"
    sql: LEFT JOIN UNNEST(${insights_data__sentences.phrase_match_data}) as insights_data__sentences__phrase_match_data ;;
    relationship: one_to_many
  }

  join: insights_data__sentences__dialogflow_intent_match_data {
    view_label: "2: Sentences"
    sql: LEFT JOIN UNNEST(${insights_data__sentences.dialogflow_intent_match_data}) as insights_data__sentences__dialogflow_intent_match_data ;;
    relationship: one_to_many
  }

  join: insights_data__sentences__highlight_data {
    view_label: "2: Sentences"
    sql: LEFT JOIN UNNEST(${insights_data__sentences.highlight_data}) as insights_data__sentences__highlight_data ;;
    relationship: one_to_many
  }


  join: sentence_turn_number {
    view_label: "2: Sentences"
    relationship: one_to_many
    sql_on: ${insights_data.conversation_name}=${sentence_turn_number.conversation_name}
          and ${insights_data__sentences.sentence} = ${sentence_turn_number.sentence}
          and ${insights_data__sentences.created_raw} = ${sentence_turn_number.created_raw};;
  }

  join: insights_data__agents {
    view_label: "6: Agents"
    sql: LEFT JOIN UNNEST(${insights_data.agents}) as insights_data__agents ;;
    relationship: one_to_many
  }

  join: insights_data__latest_summary__metadata {
    view_label: "5: Latest Summary"
    sql: LEFT JOIN UNNEST(${insights_data.latest_summary__metadata}) as insights_data__latest_summary__metadata ;;
    relationship: one_to_many
  }

  join: insights_data__latest_summary__text_sections {
    view_label: "5: Latest Summary"
    sql: LEFT JOIN UNNEST(${insights_data.latest_summary__text_sections}) as insights_data__latest_summary__text_sections ;;
    relationship: one_to_many
  }

  join: insights_data__qa_scorecard_results {
    view_label: "7: QA Scorecard"
    sql: LEFT JOIN UNNEST(${insights_data.qa_scorecard_results}) as insights_data__qa_scorecard_results ;;
    relationship: one_to_many
  }

  join: insights_data__qa_scorecard_results__qa_answers__tags {
    view_label: "7: QA Scorecard"
    sql: LEFT JOIN UNNEST(${insights_data__qa_scorecard_results.qa_answers__tags}) as insights_data__qa_scorecard_results__qa_answers__tags ;;
    relationship: one_to_many
  }

  join: insights_data__qa_scorecard_results__qa_answers {
    view_label: "7: QA Scorecard"
    sql: LEFT JOIN UNNEST(${insights_data__qa_scorecard_results.qa_answers}) as insights_data__qa_scorecard_results__qa_answers ;;
    relationship: one_to_many
  }

  join: insights_data__qa_scorecard_results__qa_tag_results {
    view_label: "7: QA Scorecard"
    sql: LEFT JOIN UNNEST(${insights_data__qa_scorecard_results.qa_tag_results}) as insights_data__qa_scorecard_results__qa_tag_results ;;
    relationship: one_to_many
  }

  # join: human_agent_turns {
  #   view_label: "1: Conversations"
  #   relationship: one_to_one
  #   sql_on: ${insights_data.conversation_name} = ${human_agent_turns.conversation_name} ;;
  # }

  join: daily_facts {
    view_label: "1: Conversations"
    relationship: many_to_one
    sql_on: ${insights_data.start_date}=${daily_facts.start_date} AND ${insights_data.medium} = ${daily_facts.conversation_medium};;
  }

  join: agent_filter { # Select an agent to compare against other agents in Agent Performance Ranking dashboard
    view_label: "6: Agents"
    type: left_outer
    sql:  ;;
    relationship: one_to_one
}

}

explore: insights_data__topics_filter {hidden:yes}
explore: insights_data__sentences__custom_highlight_filter {hidden:yes}
explore: insights_data__agent_id_filter {hidden:yes}
