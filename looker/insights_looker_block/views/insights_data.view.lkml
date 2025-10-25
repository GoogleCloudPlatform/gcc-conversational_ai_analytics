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

view: insights_data {
  sql_table_name: @{insights_table};;
  view_label: "1: Conversations"

  dimension: agents {
    hidden: yes
    sql: ${TABLE}.agents ;;
  }

  dimension: agent_sentiment_magnitude {
    group_label: "Sentiment"
    type: number
    description: "A non-negative number from zero to infinity that represents the abolute magnitude of the agent sentiment regardless of score."
    sql: ${TABLE}.agentSentimentMagnitude ;;
  }

  dimension: agent_sentiment_score {
    group_label: "Sentiment"
    type: number
    description: "Agent sentiment score between -1.0 (negative) and 1.0 (positive)."
    sql: ${TABLE}.agentSentimentScore ;;
  }

  dimension: agent_speaking_nanos {
    type: number
    hidden: yes
    description: "Duration of the conversation with the agent speaking in nanos."
    sql: ${agent_speaking_percentage} * ${duration_nanos} ;;
    value_format_name: decimal_0
  }

  dimension: agent_speaking_minutes {
    type: number
    description: "Duration of the conversation with the agent speaking (voice)."
    sql: ${agent_speaking_percentage} * CAST(${duration_nanos}/60000000000 as INT64) ;;
    value_format_name: decimal_0
  }

  dimension: agent_speaking_percentage {
    type: number
    description: "Percentage of the conversation with the agent speaking (voice)."
    sql: ${TABLE}.agentSpeakingPercentage ;;
    value_format_name: percent_2
  }

  dimension: audio_file_uri {
    type: string
    description: "Location of the audio file on GCS."
    sql: ${TABLE}.audioFileUri ;;
  }

  dimension: client_sentiment_magnitude {
    group_label: "Sentiment"
    type: number
    description: "A non-negative number from zero to infinity that represents the abolute magnitude of client sentiment regardless of score."
    sql: ${TABLE}.clientSentimentMagnitude ;;
  }

  dimension: client_sentiment_score {
    group_label: "Sentiment"
    type: number
    description: "Client sentiment score between -1.0 (negative) and 1.0 (positive)."
    sql: ${TABLE}.clientSentimentScore ;;
  }

  dimension: client_speaking_nanos {
    type: number
    description: "Duration of the conversation with the client speaking in nanos."
    sql: ${client_speaking_percentage} * ${duration_nanos} ;;
    value_format_name: decimal_0
  }

  dimension: client_speaking_minutes {
    type: number
    description: "Duration of the conversation with the client speaking (voice)."
    sql: ${client_speaking_percentage} * CAST(${duration_nanos}/60000000000 as INT64) ;;
    value_format_name: decimal_0
  }

  dimension: client_speaking_percentage {
    type: number
    description: "Percentage of the conversation with the client speaking (voice)."
    sql: ${TABLE}.clientSpeakingPercentage ;;
    value_format_name: percent_2
  }

  dimension: conversation_name {
    type: string
    primary_key: yes
    description: "Name of the conversation resource."
    sql: ${TABLE}.conversationName ;;
    link: {
      label: "Conversation Lookup Dashboard"
      url: "/dashboards-next/insights::conversation_lookup?Conversation+Name={{ value }}"
    }
  }

  dimension: unnested_conversation_id {
    type: string
    description: "Extracted conversation ID"
    sql: SUBSTR(${conversation_name}, 58, 91);;
  }

  dimension: day {
    group_label: "Dates"
    hidden: yes
    type: number
    description: "Day date part of `load_timestamp_utc`."
    sql: ${TABLE}.day ;;
  }

  dimension: duration_nanos {
    hidden: yes
    type: number
    description: "Conversation duration in nanoseconds."
    sql: ${TABLE}.durationNanos;;
  }

  dimension: duration_seconds {
    hidden: yes
    type: number
    description: "Conversation duration in seconds."
    sql: CAST(${TABLE}.durationNanos/1000000000 as INT64);;
  }

  dimension: duration_minutes {
    hidden: yes
    type: number
    description: "Conversation duration in minutes."
    sql: CAST(${TABLE}.durationNanos/60000000000 as INT64);;
  }

  dimension: entities {
    hidden: yes
    sql: ${TABLE}.entities ;;
  }

  dimension: hold_nanos {
    hidden: yes
    type: number
    description: "Number of nanos calculated to be on hold (voice)."
    sql: (${duration_nanos} - ${agent_speaking_nanos} - ${client_speaking_nanos} - ${silence_nanos}) ;;
  }

  dimension: hold_minutes {
    type: number
    description: "Number of minutes calculated to be on hold (voice)."
    sql: CAST(${hold_nanos}/60000000000 as INT64) ;;
  }

  dimension: hold_percentage {
    type: number
    description: "Percentage of the total conversation spent on hold (voice)."
    sql: ${hold_nanos}/NULLIF(${duration_nanos},0) ;;
    value_format_name: percent_2
  }

  dimension: labels {
    hidden: yes
    sql: ${TABLE}.labels ;;
  }

  dimension: latest_summary__answer_record {
    type: string
    description: "The name of the answer record. Format: projects/{project}/locations/{location}/answerRecords/{answer_record}"
    sql: ${TABLE}.latestSummary.answerRecord ;;
    group_label: "Latest Summary"
    group_item_label: "Answer Record"
  }

  dimension: latest_summary__confidence {
    type: number
    description: "The confidence score of the summarization."
    sql: ${TABLE}.latestSummary.confidence ;;
    group_label: "Latest Summary"
    group_item_label: "Confidence"
  }

  dimension: latest_summary__conversation_model {
    type: string
    description: "The name of the model that generates this summary. Format: projects/{project}/locations/{location}/conversationModels/{conversation_model}"
    sql: ${TABLE}.latestSummary.conversationModel ;;
    group_label: "Latest Summary"
    group_item_label: "Conversation Model"
  }

  dimension: latest_summary__metadata {
    hidden: yes
    sql: ${TABLE}.latestSummary.metadata ;;
    group_label: "Latest Summary"
    group_item_label: "Metadata"
  }

  dimension: latest_summary__text {
    type: string
    description: "The summarization content that is concatenated into one string."
    sql: ${TABLE}.latestSummary.text ;;
    group_label: "Latest Summary"
    group_item_label: "Text"
  }

  dimension: latest_summary__text_sections {
    hidden: yes
    sql: ${TABLE}.latestSummary.textSections ;;
    group_label: "Latest Summary"
    group_item_label: "Text Sections"
  }

  dimension_group: load {
    group_label: "Dates"
    label: "Import"
    type: time
    timeframes: [time, hour_of_day, date, day_of_week, week, month_name, year, raw]
    description: "The time in UTC at which the conversation was loaded into Insights."
    sql: TIMESTAMP_SECONDS(${TABLE}.loadTimestampUtc) ;;
  }

  dimension: medium {
    type: string
    description: "PHONE_CALL or CHAT"
    sql: ${TABLE}.medium ;;
  }

  dimension: month {
    group_label: "Dates"
    hidden: yes
    type: number
    description: "Month date part of `load_timestamp_utc`."
    sql: ${TABLE}.month ;;
  }

  dimension: qa_scorecard_results {
    hidden: yes
    sql: ${TABLE}.qaScorecardResults ;;
  }

  dimension: sentences {
    hidden: yes
    sql: ${TABLE}.sentences ;;
  }

  dimension: silence_nanos {
    hidden: yes
    type: number
    description: "Number of nanoseconds calculated to be in silence (voice)."
    sql: ${TABLE}.silenceNanos ;;
  }

  dimension: silence_seconds {
    hidden: yes
    type: number
    description: "Number of seconds calculated to be in silence (voice)."
    sql: CAST(${TABLE}.silenceNanos/1000000000 as INT64);;
  }

  dimension: silence_minutes {
    type: number
    description: "Number of minutes calculated to be in silence (voice)."
    sql: CAST(${TABLE}.silenceNanos/60000000000 as INT64) ;;
  }

  dimension: talk_nanos {
    hidden: yes
    type: number
    description: "Number of nanoseconds agent + client talk time (voice)."
    sql: ${agent_speaking_nanos}+${client_speaking_nanos} ;;
  }

  dimension: talk_seconds {
    hidden: yes
    type: number
    description: "Number of seconds agent + client talk time (voice)."
    sql: CAST(${talk_nanos}/1000000000 as INT64);;
  }

  dimension: talk_minutes {
    type: number
    description: "Number of minutes agent + client talk time (voice))."
    sql: CAST(${talk_nanos}/60000000000 as INT64) ;;
  }

  dimension: talk_percentage {
    type: number
    description: "Percentage of the total conversation spent talking (voice)."
    sql: ${talk_nanos}/NULLIF(${duration_nanos},0) ;;
    value_format_name: percent_2
  }

  dimension: silence_percentage {
    type: number
    description: "Percentage of the total conversation spent in silence (voice)."
    sql: ${TABLE}.silencePercentage ;;
    value_format_name: percent_2
  }

  dimension_group: start {
    group_label: "Dates"
    type: time
    timeframes: [time, hour_of_day, date, day_of_week, week, month_name, year, raw]
    description: "The time in UTC at which the conversation started."
    sql: TIMESTAMP_SECONDS(${TABLE}.startTimestampUtc) ;;
    drill_fields: [insights_data__topics.name]
  }

  dimension_group: end {
    group_label: "Dates"
    type: time
    timeframes: [time, hour_of_day, date, day_of_week, week, month_name, year, raw]
    description: "The time in UTC at which the conversation ended."
    sql: TIMESTAMP_SECONDS(${TABLE}.startTimestampUtc+${duration_seconds}) ;;
  }

  dimension_group: conversation {
    description: "The time between conversation start and end."
    type: duration
    intervals: [second, minute, hour]
    sql_start: ${start_raw} ;;
    sql_end: ${end_raw} ;;
  }

  dimension: topics {
    hidden: yes
    sql: ${TABLE}.issues ;;
  }

  dimension: transcript {
    type: string
    description: "The complete text transcript of the conversation."
    sql: ${TABLE}.transcript ;;
  }

  dimension: turn_count {
    type: number
    description: "The number of turns taken in the conversation."
    sql: ${TABLE}.turnCount ;;
  }

  # dimension: type {
  #   description: "If the call was never transferred to a human, then the call is classified as Virtual. If the call was transferred to a human, then the call is classified as human."
  #   type: string
  #   sql: case when ${human_agent_turns.first_turn_human_agent} is null then "Virtual Agent"
  #     else "Human Agent" end;;
  # }

  # dimension: status {
  #   description: "If the call was never transferred to a human, then Contained. If it was contained but lasted less than 1 minute, then Abandoned. If it was transferred to a human, then Transferred."
  #   type: string
  #   sql: case when ${human_agent_turns.first_turn_human_agent} is null and ${duration_minutes} < 1 then "Abandoned"
  #         when ${human_agent_turns.first_turn_human_agent} is null then "Contained"
  #           else "Transferred" end;;
  # }

  dimension: words {
    hidden: yes
    sql: ${TABLE}.words ;;
  }

  dimension: year {
    group_label: "Dates"
    hidden: yes
    type: number
    description: "Year date part of `load_timestamp_utc`."
    sql: ${TABLE}.year ;;
  }

  ################## Sentiment Analysis ###########################
  #Configure manual score and magnitude thresholds here in the default_value parameter. To allow users to eadjust these values in the UI, set the hidden parameter to no.
  #Documentation to guide interpretation here:https://cloud.google.com/natural-language/docs/basics#interpreting_sentiment_analysis_values

  parameter: sentiment_score_threshold {
    description: "Score of the sentiment ranges between -1.0 (negative) and 1.0 (positive) and corresponds to the overall emotional leaning of the text. Set a custom minimum threshold to trigger Positive and Negative. E.g., choosing 0.05 will set Score > 0.05 to Positive, and Score < -0.05 to be Negative, while also incorporating the Magnitude selection."
    hidden:  no #Set no if you want this exposed in the Browse/Explore
    type: number
    default_value: "0.05"
  }
  parameter: sentiment_magnitude_threshold {
    description: "Magnitude indicates the overall strength of emotion (both positive and negative) within the given text, between 0.0 and +inf. Unlike score, magnitude is not normalized; each expression of emotion within the text (both positive and negative) contributes to the text's magnitude (so longer text blocks may have greater magnitudes). Set a custom minimum threshold to trigger Positive, Negative, and Mixed vs. Neutral. E.g., choosing 0.1 will allow Positive scores to be considered Positive (vs. Mixed) if Magnitude exceeds 0.1."
    hidden:  no #Set no if you want this exposed in the Browse/Explore
    type:  number
    default_value: "0.1"
  }

  dimension: client_sentiment_category {
    group_label: "Sentiment"
    type: string
    description: "Negative sentiment score is bad, 0 sentiment score is neutral, and positive sentiment score is good."
    sql: CASE
          WHEN ${client_sentiment_score} <= -{% parameter sentiment_score_threshold %} AND ${client_sentiment_magnitude} > {% parameter sentiment_magnitude_threshold %}  THEN "Negative"
          WHEN ${client_sentiment_score} >= {% parameter sentiment_score_threshold %} AND ${client_sentiment_magnitude} > {% parameter sentiment_magnitude_threshold %} THEN "Positive"
          WHEN (${client_sentiment_score} < {% parameter sentiment_score_threshold %} OR ${client_sentiment_score} > -{% parameter sentiment_score_threshold %})
          AND ${client_sentiment_magnitude} > {% parameter sentiment_magnitude_threshold %} THEN "Mixed"
          ELSE "Neutral" END;;
  }

  dimension: agent_sentiment_category {
    group_label: "Sentiment"
    type: string
    description: "Negative sentiment score is bad, 0 sentiment score is neutral, and positive sentiment score is good."
    sql: CASE
          WHEN ${agent_sentiment_score} <= -{% parameter sentiment_score_threshold %} AND ${agent_sentiment_magnitude} > {% parameter sentiment_magnitude_threshold %}  THEN "Negative"
          WHEN ${agent_sentiment_score} >= {% parameter sentiment_score_threshold %} AND ${agent_sentiment_magnitude} > {% parameter sentiment_magnitude_threshold %} THEN "Positive"
          WHEN (${agent_sentiment_score} < {% parameter sentiment_score_threshold %} OR ${agent_sentiment_score} > -{% parameter sentiment_score_threshold %})
          AND ${agent_sentiment_magnitude} > {% parameter sentiment_magnitude_threshold %} THEN "Mixed"
          ELSE "Neutral" END;;
  }

  dimension: client_sentiment_category_value {
    group_label: "Sentiment"
    description: "Sentiment score multiplied by sentiment magnitude"
    type: number
    hidden: yes
    sql: ${client_sentiment_score}*${client_sentiment_magnitude} ;;
    value_format_name: decimal_4
  }

  measure: average_client_sentiment_category_value{
    group_label: "Sentiment"
    type: average
    sql: ${client_sentiment_category_value} ;;
    value_format_name: decimal_2
  }

  dimension: agent_sentiment_category_value {
    group_label: "Sentiment"
    description: "Sentiment score multiplied by sentiment magnitude"
    type: number
    hidden: yes
    sql: ${agent_sentiment_score}*${agent_sentiment_magnitude} ;;
    value_format_name: decimal_4
  }

  measure: average_agent_sentiment_category_value{
    group_label: "Sentiment"
    type: average
    sql: ${agent_sentiment_category_value} ;;
    value_format_name: decimal_2
  }

  measure: bad_sentiment_conversation_count {
    label: "Negative Conversation Count"
    group_label: "Sentiment"
    description: "Based on client sentiment category"
    type: count
    filters: [client_sentiment_category: "Negative"]
    drill_fields: [convo_info*]
  }

  measure: good_sentiment_conversation_count {
    label: "Positive Conversation Count"
    group_label: "Sentiment"
    description: "Based on client sentiment category"
    type: count
    filters: [client_sentiment_category: "Positive"]
    drill_fields: [convo_info*]
  }

  measure: neutral_sentiment_conversation_count {
    label: "Neutral Conversation Count"
    group_label: "Sentiment"
    description: "Based on client sentiment category"
    type: count
    filters: [client_sentiment_category: "Neutral"]
    drill_fields: [convo_info*]
  }

  measure: mixed_sentiment_conversation_count {
    label: "Mixed Conversation Count"
    group_label: "Sentiment"
    description: "Based on client sentiment category"
    type: count
    filters: [client_sentiment_category: "Mixed"]
    drill_fields: [convo_info*]
  }

  measure: bad_sentiment_ratio {
    label: "Negative Conversation Ratio"
    description: "Negative Conversations / Total Conversations"
    group_label: "Sentiment"
    type: number
    sql: ${bad_sentiment_conversation_count}/NULLIF(${conversation_count},0) ;;
    value_format_name: percent_0
    drill_fields: [convo_info*]
  }

  measure: good_sentiment_ratio {
    label: "Positive Conversation Ratio"
    description: "Positive Conversations / Total Conversations"
    group_label: "Sentiment"
    type: number
    sql: ${good_sentiment_conversation_count}/NULLIF(${conversation_count},0) ;;
    value_format_name: percent_0
    drill_fields: [convo_info*]
  }

  measure: neutral_sentiment_ratio {
    label: "Neutral Conversation Ratio"
    description: "Neautral Conversations / Total Conversations"
    group_label: "Sentiment"
    type: number
    sql: ${neutral_sentiment_conversation_count}/NULLIF(${conversation_count},0) ;;
    value_format_name: percent_0
    drill_fields: [convo_info*]
  }

  measure: mixed_sentiment_ratio {
    label: "Mixed Conversation Ratio"
    description: "Mixed Conversations / Total Conversations"
    group_label: "Sentiment"
    type: number
    sql: ${mixed_sentiment_conversation_count}/NULLIF(${conversation_count},0) ;;
    value_format_name: percent_0
    drill_fields: [convo_info*]
  }

  measure: average_client_sentiment_score {
    group_label: "Sentiment"
    type: average
    sql: ${client_sentiment_score} ;;
    value_format_name: decimal_2
    drill_fields: [convo_info*,client_sentiment_score]
  }

  measure: average_client_sentiment_magnitude {
    group_label: "Sentiment"
    type: average
    sql: ${client_sentiment_magnitude} ;;
    value_format_name: decimal_2
    drill_fields: [convo_info*,client_sentiment_score, client_sentiment_magnitude]
  }

  measure: average_agent_sentiment_score {
    group_label: "Sentiment"
    type: average
    sql: ${agent_sentiment_score} ;;
    value_format_name: decimal_2
    drill_fields: [convo_info*,agent_sentiment_score]
  }

  measure: average_agent_sentiment_magnitude {
    group_label: "Sentiment"
    type: average
    sql: ${agent_sentiment_magnitude} ;;
    value_format_name: decimal_2
    drill_fields: [convo_info*,agent_sentiment_score, agent_sentiment_magnitude]
  }

### Measures ###
  measure: conversation_count {
    type: count
    link: {
      label: "by Agent"
      url: "/explore/insights/insights_data?fields=insights_data__agents.agent_id,insights_data.conversation_count&f[insights_data.start_date]={{ _filters['insights_data.start_date'] }}&f[insights_data__topics.name]={{ _filters['insights_data__topics.name'] }}&f[insights_data.medium]={{ _filters['insights_data.medium'] }}&f[insights_data__sentences__phrase_match_data.display_name]={{ _filters['insights_data__sentences__phrase_match_data.display_name'] }}&limit=500"
    }
    link: {
      label: "by Topic"
      url: "/explore/insights/insights_data?fields=insights_data__topics.name,insights_data.conversation_count,&f[insights_data.start_date]={{ _filters['insights_data.start_date'] }}&f[insights_data__topics.name]={{ _filters['insights_data__topics.name'] }}&f[insights_data.medium]={{ _filters['insights_data.medium'] }}&f[insights_data__sentences__phrase_match_data.display_name]={{ _filters['insights_data__sentences__phrase_match_data.display_name'] }}&limit=500"
    }
    drill_fields: [convo_info*]
  }

  measure: agent_count {
    type: count_distinct
    sql: ${insights_data__agents.agent_id} ;;
    drill_fields: [convo_info*]
  }

  measure: avg_conversations_per_agent {
    type: number
    sql: ${conversation_count} / ${agent_count} ;;
    drill_fields: [convo_info*]
    value_format_name: decimal_0
  }

  # measure: contained_count {
  #   description: "A conversation is considered contained if it was never passed to a human agent."
  #   type: count
  #   filters: [type: "Virtual Agent"]
  #   drill_fields: [convo_info*]
  # }

  # measure: contained_percentage {
  #   description: "A conversation is considered contained if it was never passed to a human agent."
  #   type: number
  #   sql: ${contained_count}/${conversation_count} ;;
  #   value_format_name: percent_0
  #   drill_fields: [convo_info*]
  # }

  measure: num_of_characters {
    label: "Number of Characters"
    type: sum
    sql: length(${transcript}) ;;
  }

  measure: num_of_characters_no_space {
    label: "Number of Characters (no spaces)"
    type: sum
    sql: length(REGEXP_REPLACE(${transcript}, ' ', '')) ;;
  }

  measure: average_turn_count {
    type: average
    sql: ${turn_count} ;;
    value_format_name: decimal_0
    drill_fields: [convo_info*, turn_count]
  }

  measure: average_conversation_minutes {
    type: average
    sql: ${minutes_conversation} ;;
    value_format_name: decimal_0
    drill_fields: [convo_info*, duration_minutes]
  }

  measure: average_hold_minutes {
    description: "Average minutes of total conversation spent on hold (voice only)"
    type: average
    sql: ${hold_minutes} ;;
    value_format_name: decimal_0
    # drill_fields: [convo_info*, hold_minutes]
    link: {
      label: "by Agent"
      url: "/explore/insights/insights_data?fields=insights_data__agents.agent_id,insights_data.average_hold_minutes,insights_data.average_hold_percentage&f[insights_data.start_date]={{ _filters['insights_data.start_date'] }}&limit=500"
    }
    link: {
      label: "by Topic"
      url: "/explore/insights/insights_data?fields=insights_data__topics.name,insights_data.average_hold_minutes,insights_data.average_hold_percentage&f[insights_data.start_date]={{ _filters['insights_data.start_date'] }}&limit=500"
    }

  }

  measure: average_hold_minutes_75_percentile {
    description: "Average minutes of total conversation spent on hold (voice only)"
    type: percentile
    percentile: 75
    sql: ${hold_minutes} ;;
    value_format_name: decimal_0
  }


  measure: average_duration_minutes {
    description: "Average minutes of total handle time (voice only)"
    type: average
    sql: ${duration_minutes} ;;
    value_format_name: decimal_0
    # drill_fields: [convo_info*, hold_minutes]
    link: {
      label: "by Agent"
      url: "/explore/insights/insights_data?fields=insights_data__agents.agent_id,insights_data.average_duration_minutes&f[insights_data.start_date]={{ _filters['insights_data.start_date'] }}&limit=500"
    }
    link: {
      label: "by Topic"
      url: "/explore/insights/insights_data?fields=insights_data__topics.name,insights_data.average_duration_minutes&f[insights_data.start_date]={{ _filters['insights_data.start_date'] }}&limit=500"
    }

  }

  measure: average_duration_minutes_75_percentile {
    description: "Average minutes of total handle time (voice only)"
    type: percentile
    percentile: 75
    sql: ${duration_minutes} ;;
    value_format_name: decimal_0
  }

  measure: average_hold_percentage {
    description: "Average % of total conversation spent on hold (voice only)"
    type: average
    sql: ${hold_percentage} ;;
    value_format_name: percent_2
    drill_fields: [convo_info*, hold_percentage, hold_minutes]
  }

  measure: average_silence_minutes {
    description: "Average minutes of total conversation spent in silence (voice only)"
    type: average
    sql: ${silence_minutes} ;;
    value_format_name: decimal_0
    # drill_fields: [convo_info*, silence_minutes]
    link: {
      label: "by Agent"
      url: "/explore/insights/insights_data?fields=insights_data__agents.agent_id,insights_data.average_silence_minutes,insights_data.average_silence_percentage&f[insights_data.start_date]={{ _filters['insights_data.start_date'] }}&limit=500"
    }
    link: {
      label: "by Topic"
      url: "/explore/insights/insights_data?fields=insights_data__topics.name,insights_data.average_silence_minutes,insights_data.average_silence_percentage&f[insights_data.start_date]={{ _filters['insights_data.start_date'] }}&limit=500"
    }
  }

  measure: average_silence_minutes_75_percentile {
    description: "Average minutes of total conversation spent in silence (voice only)"
    type: percentile
    percentile: 75
    sql: ${silence_minutes} ;;
    value_format_name: decimal_0
  }

  measure: average_silence_percentage {
    description: "Average % of total conversation spent in silence (voice only)"
    type: average
    sql: ${silence_percentage} ;;
    value_format_name: percent_2
    drill_fields: [convo_info*, silence_percentage, silence_minutes]
  }

  measure: average_agent_speaking_minutes {
    description: "Average minutes of total conversation where agent is speaking"
    type: average
    sql: ${agent_speaking_minutes} ;;
    value_format_name: decimal_0
  }

  measure: average_agent_speaking_percentage {
    type: average
    sql: ${agent_speaking_percentage} ;;
    value_format_name: percent_2
    drill_fields: [convo_info*, agent_speaking_percentage]
  }

  measure: average_client_speaking_percentage {
    type: average
    sql: ${client_speaking_percentage} ;;
    value_format_name: percent_2
    drill_fields: [convo_info*, client_speaking_percentage]
  }

  measure: average_talk_minutes {
    description: "Average minutes of total conversation spent talking (voice only)"
    type: average
    sql: ${talk_minutes} ;;
    value_format_name: decimal_0
    link: {
      label: "by Agent"
      url: "/explore/insights/insights_data?fields=insights_data__agents.agent_id,insights_data.average_talk_minutes,insights_data.average_talk_percentage&f[insights_data.start_date]={{ _filters['insights_data.start_date'] }}&limit=500"
    }
    link: {
      label: "by Topic"
      url: "/explore/insights/insights_data?fields=insights_data__topics.name,insights_data.average_talk_minutes,insights_data.average_talk_percentage&f[insights_data.start_date]={{ _filters['insights_data.start_date'] }}&limit=500"
    }
  }

  measure: average_talk_minutes_75_percentile {
    description: "Average minutes of total conversation spent talking (voice only"
    type: percentile
    percentile: 75
    sql: ${talk_minutes} ;;
    value_format_name: decimal_0
  }

  measure: average_talk_percentage {
    description: "Average % of total conversation spent talking (voice only)"
    type: average
    sql: ${talk_percentage} ;;
    value_format_name: percent_2
  }

  ################### Scorecard ######################
  dimension: authentication_flag {
    group_label: "Scorecard"
    type: string
    sql: CASE WHEN ${insights_data__sentences__intent_match_data.display_name} = 'AUTHENTICATION_INFO' THEN ${unnested_conversation_id}
       ELSE Null
       END  ;;
  }

  measure: count_authentication_flag {
    group_label: "Scorecard"
    type: count_distinct
    sql: ${authentication_flag} ;;
  }

  measure: authentication_pct {
    group_label: "Scorecard"
    description: "% frequency of agent verifying customer information"
    type: number
    sql: ${count_authentication_flag} / NULLIF(${conversation_count},0) ;;
    value_format_name: percent_0
    link: {
      label: "by Agent"
      url: "/explore/insights/insights_data?fields=insights_data__agents.agent_id,insights_data.authentication_pct&f[insights_data.start_date]={{ _filters['insights_data.start_date'] }}&limit=500"
    }
  }

  dimension: check_issue_resolved_flag {
    group_label: "Scorecard"
    type: string
    sql: CASE WHEN ${insights_data__sentences__intent_match_data.display_name} = 'CHECK_ISSUE_RESOLVED' THEN ${unnested_conversation_id}
      ELSE Null
      END ;;
  }

  measure: count_check_issue_resolved_flag {
    group_label: "Scorecard"
    type: count_distinct
    sql: ${check_issue_resolved_flag} ;;
  }

  measure: check_issue_resolved_pct {
    group_label: "Scorecard"
    description: "% frequency of agent verifying customer information"
    type: number
    sql: ${count_check_issue_resolved_flag} / NULLIF(${conversation_count},0) ;;
    value_format_name: percent_0
    link: {
      label: "by Agent"
      url: "/explore/insights/insights_data?fields=insights_data__agents.agent_id,insights_data.check_issue_resolved_pct&f[insights_data.start_date]={{ _filters['insights_data.start_date'] }}&limit=500"
    }
  }

  dimension: confirm_issue_resolved_flag {
    group_label: "Scorecard"
    type: string
    sql: CASE WHEN ${insights_data__sentences__intent_match_data.display_name} = 'CONFIRM_ISSUE_RESOLVED' THEN ${unnested_conversation_id}
      ELSE Null
      END ;;
  }

  measure: count_confirm_issue_resolved_flag {
    group_label: "Scorecard"
    type: count_distinct
    sql: ${confirm_issue_resolved_flag} ;;
  }

  measure: confirm_issue_resolved_pct {
    group_label: "Scorecard"
    description: "% frequency of agent verifying customer information"
    type: number
    sql: ${count_confirm_issue_resolved_flag} / NULLIF(${conversation_count},0) ;;
    value_format_name: percent_0
    link: {
      label: "by Agent"
      url: "/explore/insights/insights_data?fields=insights_data__agents.agent_id,insights_data.confirm_issue_resolved_pct&f[insights_data.start_date]={{ _filters['insights_data.start_date'] }}&limit=500"
    }
  }

  dimension: closing_flag {
    group_label: "Scorecard"
    type: string
    sql: CASE WHEN ${insights_data__sentences__phrase_match_data.display_name} = 'Closing' THEN ${unnested_conversation_id}
       ELSE Null
       END  ;;
  }

  measure: count_closing_flag {
    group_label: "Scorecard"
    type: count_distinct
    sql: ${closing_flag} ;;
  }

  measure: closing_pct {
    group_label: "Scorecard"
    description: "% frequency of closing"
    type: number
    sql: ${count_closing_flag} / NULLIF(${conversation_count},0) ;;
    value_format_name: percent_0
    link: {
      label: "by Agent"
      url: "/explore/insights/insights_data?fields=insights_data__agents.agent_id,insights_data.closing_pct&f[insights_data.start_date]={{ _filters['insights_data.start_date'] }}&limit=500"
    }
  }

  dimension: greeting_flag {
    group_label: "Scorecard"
    type: string
    sql: CASE WHEN ${insights_data__sentences__phrase_match_data.display_name} = 'Greeting' THEN ${unnested_conversation_id}
       ELSE Null
       END  ;;
  }

  measure: count_greeting_flag {
    group_label: "Scorecard"
    type: count_distinct
    sql: ${greeting_flag} ;;
  }

  measure: greeting_pct {
    group_label: "Scorecard"
    description: "% frequency of greeting"
    type: number
    sql: ${count_greeting_flag} / NULLIF(${conversation_count},0) ;;
    value_format_name: percent_0
    link: {
      label: "by Agent"
      url: "/explore/insights/insights_data?fields=insights_data__agents.agent_id,insights_data.greeting_pct&f[insights_data.start_date]={{ _filters['insights_data.start_date'] }}&limit=500"
    }
  }

  dimension: inflammatory_agent_langugage_flag {
    group_label: "Scorecard"
    type: string
    sql: CASE WHEN ${insights_data__sentences__phrase_match_data.display_name} = 'Inflammatory Agent Language' THEN ${unnested_conversation_id}
       ELSE Null
       END  ;;
  }

  measure: count_inflammatory_agent_langugage_flag {
    group_label: "Scorecard"
    type: count_distinct
    sql: ${inflammatory_agent_langugage_flag} ;;
  }

  measure: inflammatory_agent_langugage_pct {
    group_label: "Scorecard"
    description: "% frequency of inflammatory agent langugage"
    type: number
    sql: ${count_inflammatory_agent_langugage_flag} / NULLIF(${conversation_count},0) ;;
    value_format_name: percent_0
    link: {
      label: "by Agent"
      url: "/explore/insights/insights_data?fields=insights_data__agents.agent_id,insights_data.inflammatory_agent_langugage_pct&f[insights_data.start_date]={{ _filters['insights_data.start_date'] }}&limit=500"
    }
  }

  dimension: ability_to_understand_agent_flag {
    group_label: "Scorecard"
    type: string
    sql: CASE WHEN ${insights_data__sentences__phrase_match_data.display_name} = 'Ability to understand agent' THEN ${unnested_conversation_id}
       ELSE Null
       END  ;;
  }

  measure: count_ability_to_understand_agent_flag {
    group_label: "Scorecard"
    type: count_distinct
    sql: ${ability_to_understand_agent_flag} ;;
  }

  measure: ability_to_understand_agent_pct {
    group_label: "Scorecard"
    description: "% frequency of ability to understand agent"
    type: number
    sql: ${count_ability_to_understand_agent_flag} / NULLIF(${conversation_count},0) ;;
    value_format_name: percent_0
    link: {
      label: "by Agent"
      url: "/explore/insights/insights_data?fields=insights_data__agents.agent_id,insights_data.ability_to_understand_agent_pct&f[insights_data.start_date]={{ _filters['insights_data.start_date'] }}&limit=500"
    }
  }


  set: convo_info {
    fields: [insights_data__agents.agent_id, conversation_name, turn_count, load_time, client_sentiment_category, agent_sentiment_category]
  }
}

view: insights_data__words {
  dimension: end_offset_nanos {
    hidden: yes
    type: number
    description: "Time offset in nanoseconds of the end of this word relative to the beginning of the conversation."
    sql: ${TABLE}.endOffsetNanos ;;
  }

  dimension: language_code {
    type: string
    description: "Language code."
    sql: ${TABLE}.languageCode ;;
  }

  dimension: speaker_tag {
    type: number
    description: "The speaker that the word originated from."
    sql: ${TABLE}.speakerTag ;;
  }

  dimension: start_offset_nanos {
    hidden: yes
    type: number
    description: "Time offset in nanoseconds of the start of this word relative to the beginning of the conversation."
    sql: ${TABLE}.startOffsetNanos ;;
  }

  dimension: word {
    primary_key: yes
    type: string
    description: "The transcribed word."
    sql: ${TABLE}.word ;;
  }

  measure: count {
    type: count_distinct
    sql: ${word} ;;
  }
}

view: insights_data__labels {
  dimension: key {
    label: "Label Key"
    group_label: "Labels"
    type: string
    description: "User-provided label key."
    sql: ${TABLE}.key ;;
  }

  dimension: value {
    label: "Label Value"
    group_label: "Labels"
    type: string
    description: "User-provided label value."
    sql: ${TABLE}.value ;;
  }
}

view: insights_data__topics {
  dimension: name {
    label: "Topic Name"
    group_label: "Topics"
    type: string
    description: "Name of the topic."
    suggest_dimension: insights_data__topics_filter.topic_name
    suggest_explore: insights_data__topics_filter
    sql: ${TABLE}.name ;;
  }

  dimension: score {
    label: "Topic Score"
    group_label: "Topics"
    type: number
    description: "Score indicating the likelihood of the topic assignment, between 0 and 1.0."
    sql: ${TABLE}.score ;;
  }

  dimension: issuemodelid {
    label: "Topic Model ID"
    group_label: "Topics"
    type: string
    sql: ${TABLE}.issuemodelid  ;;
  }

  dimension: issueid {
    label: "Topic ID"
    group_label: "Topics"
    type: string
    sql: ${TABLE}.issueid  ;;
  }

  measure: count {
    label: "Topic Count"
    group_label: "Topics"
    type: count_distinct
    sql: ${name} ;;
    drill_fields: [topic_detail*]
  }

  set: topic_detail {
    fields:[name, score]
  }
}

view: insights_data__topics_filter {
  derived_table: {
    sql: SELECT
          insights_data__topics.name  AS topic_name
          FROM @{insights_table}  AS insights_data
          LEFT JOIN UNNEST(insights_data.issues) as insights_data__topics
          GROUP BY
              1 ;;
  }

  dimension: topic_name {}
}

view: insights_data__entities {
  dimension: name {
    type: string
    description: "Name of the entity."
    sql: ${TABLE}.name ;;
  }

  dimension: salience {
    type: number
    description: "Salience score of the entity."
    sql: ${TABLE}.salience ;;
  }

  dimension: sentiment_magnitude {
    group_label: "Sentiment"
    type: number
    description: "A non-negative number from zero to infinity that represents the abolute magnitude of the entity sentiment regardless of score."
    sql: ${TABLE}.sentimentMagnitude ;;
  }

  dimension: sentiment_score {
    group_label: "Sentiment"
    type: number
    description: "The entity sentiment score between -1.0 (negative) and 1.0 (positive)."
    sql: ${TABLE}.sentimentScore ;;
  }

  dimension: speaker_tag {
    type: number
    description: "The speaker that the entity mention originated from."
    sql: ${TABLE}.speakerTag ;;
  }

  dimension: type {
    type: string
    description: "Type of the entity."
    sql: ${TABLE}.type ;;
  }

  ########################### Sentiment Analysis ############################
  #Configure manual score and magnitude thresholds here in the default_value parameter. To allow users to eadjust these values in the UI, set the hidden parameter to no.
  #Documentation to guide interpretation here:https://cloud.google.com/natural-language/docs/basics#interpreting_sentiment_analysis_values

  parameter: sentiment_score_threshold {
    description: "Score of the sentiment ranges between -1.0 (negative) and 1.0 (positive) and corresponds to the overall emotional leaning of the text. Set a custom minimum threshold to trigger Positive and Negative. E.g., choosing 0.05 will set Score > 0.05 to Positive, and Score < -0.05 to be Negative, while also incorporating the Magnitude selection."
    hidden:  no #Set no if you want this exposed in the Browse/Explore
    type: number
    default_value: "0.05"
  }
  parameter: sentiment_magnitude_threshold {
    description: "Magnitude indicates the overall strength of emotion (both positive and negative) within the given text, between 0.0 and +inf. Unlike score, magnitude is not normalized; each expression of emotion within the text (both positive and negative) contributes to the text's magnitude (so longer text blocks may have greater magnitudes). Set a custom minimum threshold to trigger Positive, Negative, and Mixed vs. Neutral. E.g., choosing 0.1 will allow Positive scores to be considered Positive (vs. Mixed) if Magnitude exceeds 0.1."
    hidden:  no #Set no if you want this exposed in the Browse/Explore
    type:  number
    default_value: "0.1"
  }
  dimension: sentiment_category {
    group_label: "Sentiment"
    type: string
    description: "Negative sentiment score is bad, 0 sentiment score is neutral, and positive sentiment score is good."
    sql: CASE
          WHEN ${sentiment_score} <= -{% parameter sentiment_score_threshold %} AND ${sentiment_magnitude} > {% parameter sentiment_magnitude_threshold %}  THEN "Negative"
          WHEN ${sentiment_score} >= {% parameter sentiment_score_threshold %} AND ${sentiment_magnitude} > {% parameter sentiment_magnitude_threshold %} THEN "Positive"
          WHEN (${sentiment_score} < {% parameter sentiment_score_threshold %} OR ${sentiment_score} > -{% parameter sentiment_score_threshold %})
          AND ${sentiment_magnitude} > {% parameter sentiment_magnitude_threshold %} THEN "Mixed"
          ELSE "Neutral" END;;
  }
  measure: average_sentiment_score {
    group_label: "Sentiment"
    type: average
    sql: ${sentiment_score} ;;
    value_format_name: decimal_2
  }
  measure: average_sentiment_magnitude {
    group_label: "Sentiment"
    type: average
    sql: ${sentiment_magnitude} ;;
    value_format_name: decimal_2
  }
  dimension: sentiment_category_value {
    description: "Sentiment score multiplied by sentiment magnitude"
    type: number
    group_label: "Sentiment"
    sql: ${sentiment_score}*${sentiment_magnitude} ;;
    value_format_name: decimal_4
  }

  measure: average_sentiment_category_value{
    type: average
    group_label: "Sentiment"
    sql: ${sentiment_category_value} ;;
    value_format_name: decimal_4
  }


  ############################ Measures ##################################

  measure: count {
    type: count_distinct
    sql: ${name} ;;
    drill_fields: [entity_detail*]
  }

  measure: average_salience {
    type: average
    sql: ${salience} ;;
    drill_fields: [entity_detail*]
  }

  set: entity_detail {
    fields: [name,type,speaker_tag,sentiment_score, sentiment_magnitude,salience]
  }
}

view: insights_data__sentences {
  dimension: annotations {
    hidden: yes
    sql: ${TABLE}.annotations ;;
  }

  dimension_group: created {

    type: time
    timeframes: [time, minute, minute5, hour_of_day, date, day_of_week, week, month_name, year, raw]
    description: "Time in UTC that the conversation message took place, if provided."
    sql: TIMESTAMP_MICROS(CAST(${TABLE}.createTimeNanos/1000 as INT64)) ;;
  }

  dimension: dialogflow_intent_match_data {
    hidden: yes
    sql: ${TABLE}.dialogflowIntentMatchData ;;
  }

  dimension: end_offset_nanos {
    hidden: yes
    type: number
    description: "Time offset in nanoseconds of the end of this sentence relative to the beginning of the conversation."
    sql: ${TABLE}.endOffsetNanos ;;
  }

  dimension: highlight_data {
    hidden: yes
    sql: ${TABLE}.highlightData ;;
  }

  dimension: intent_match_data {
    hidden: yes
    sql: ${TABLE}.intentMatchData ;;
  }

  dimension: is_covered_by_smart_reply_allowlist {
    type: yesno
    description: "Whether this message is covered by a configured allowlist in Agent Assist."
    sql: ${TABLE}.isCoveredBySmartReplyAllowlist ;;
  }

  dimension: language_code {
    type: string
    description: "Language code."
    sql: ${TABLE}.languageCode ;;
  }

  dimension: obfuscated_external_user_id {
    type: string
    description: "Customer provided obfuscated external user ID for billing purposes."
    sql: ${TABLE}.obfuscatedExternalUserId ;;
  }

  dimension: participant_id {
    type: string
    description: "Participant ID, if provided."
    sql: ${TABLE}.participantId ;;
  }

  dimension: participant_role {
    type: string
    description: "Participant role, if provided."
    suggestions: ["Virtual Agent","Human Agent","Client"]
    sql: case when ${TABLE}.participantRole='AUTOMATED_AGENT' then 'Virtual Agent'
            when ${TABLE}.participantRole='HUMAN_AGENT' then 'Human Agent'
            when ${TABLE}.participantRole='END_USER' then 'Client'
            else ${TABLE}.participantRole end;;
  }

  dimension: phrase_match_data {
    hidden: yes
    sql: ${TABLE}.phraseMatchData ;;
  }

  dimension: sentence {
    primary_key: yes
    type: string
    description: "The transcribed sentence."
    sql: ${TABLE}.sentence ;;
  }

  dimension: sentiment_magnitude {
    group_label: "Sentiment"
    type: number
    description: "A non-negative number from zero to infinity that represents the abolute magnitude of the sentence sentiment regardless of score."
    sql: ${TABLE}.sentimentMagnitude ;;
  }

  dimension: sentiment_score {
    group_label: "Sentiment"
    type: number
    description: "The sentence sentiment score between -1.0 (negative) and 1.0 (positive)."
    sql: ${TABLE}.sentimentScore ;;
  }

  dimension: speaker_tag {
    type: number
    description: "The speaker that the sentence originated from."
    sql: ${TABLE}.speakerTag ;;
  }

  dimension: start_offset_nanos {
    hidden: yes
    type: number
    description: "Time offset in nanoseconds of the start of this sentence relative to the beginning of the conversation."
    sql: ${TABLE}.startOffsetNanos ;;
  }

  # dimension: is_sentence_before_transfer_human {
  #   description: "Identifies the sentence right before the call was transferred to a human agent."
  #   type: yesno
  #   sql: ${human_agent_turns.first_turn_human_agent} = ${sentence_turn_number.turn_number}-1;;
  # }

  ############################ Sentiment Analysis #######################
#Configure manual score and magnitude thresholds here in the default_value parameter. To allow users to eadjust these values in the UI, set the hidden parameter to no.
#Documentation to guide interpretation here:https://cloud.google.com/natural-language/docs/basics#interpreting_sentiment_analysis_values

  parameter: sentiment_score_threshold {
    description: "Score of the sentiment ranges between -1.0 (negative) and 1.0 (positive) and corresponds to the overall emotional leaning of the text. Set a custom minimum threshold to trigger Positive and Negative. E.g., choosing 0.05 will set Score > 0.05 to Positive, and Score < -0.05 to be Negative, while also incorporating the Magnitude selection."
    hidden:  no #Set no if you want this exposed in the Browse/Explore
    type: number
    default_value: "0.05"
  }
  parameter: sentiment_magnitude_threshold {
    description: "Magnitude indicates the overall strength of emotion (both positive and negative) within the given text, between 0.0 and +inf. Unlike score, magnitude is not normalized; each expression of emotion within the text (both positive and negative) contributes to the text's magnitude (so longer text blocks may have greater magnitudes). Set a custom minimum threshold to trigger Positive, Negative, and Mixed vs. Neutral. E.g., choosing 0.1 will allow Positive scores to be considered Positive (vs. Mixed) if Magnitude exceeds 0.1."
    hidden:  no #Set no if you want this exposed in the Browse/Explore
    type:  number
    default_value: "0.1"
  }
  dimension: sentiment_category {
    group_label: "Sentiment"
    type: string
    description: "Negative sentiment score is bad, 0 sentiment score is neutral, and positive sentiment score is good."
    sql: CASE
          WHEN ${sentiment_score} <= -{% parameter sentiment_score_threshold %} AND ${sentiment_magnitude} > {% parameter sentiment_magnitude_threshold %}  THEN "Negative"
          WHEN ${sentiment_score} >= {% parameter sentiment_score_threshold %} AND ${sentiment_magnitude} > {% parameter sentiment_magnitude_threshold %} THEN "Positive"
          WHEN (${sentiment_score} < {% parameter sentiment_score_threshold %} OR ${sentiment_score} > -{% parameter sentiment_score_threshold %})
          AND ${sentiment_magnitude} > {% parameter sentiment_magnitude_threshold %} THEN "Mixed"
          ELSE "Neutral" END;;
  }

  dimension: sentiment_category_value {
    description: "Sentiment score multiplied by sentiment magnitude"
    type: number
    group_label: "Sentiment"
    sql: ${sentiment_score}*${sentiment_magnitude} ;;
    value_format_name: decimal_4
  }

  measure: average_sentiment_category_value{
    type: average
    group_label: "Sentiment"
    sql: ${sentiment_category_value} ;;
    value_format_name: decimal_4
  }

  measure: average_sentiment_score {
    group_label: "Sentiment"
    type: average
    sql: ${sentiment_score} ;;
    value_format_name: decimal_2
  }

  measure: average_sentiment_magnitude {
    group_label: "Sentiment"
    type: average
    sql: ${sentiment_magnitude} ;;
    value_format_name: decimal_2
  }

  ############################# Measures ##################################

  measure: count {
    label: "Sentence Count"
    type: count_distinct
    sql: ${sentence} ;;
  }

  measure: num_of_characters_sentence {
    label: "Number of Characters in Sentence"
    type: sum
    sql: length(${sentence}) ;;
  }

}

view: insights_data__sentences__annotations {
  label: "Insights Data: Sentences"

  dimension: clicked {
    group_label: "Agent Assist Annotations"
    type: yesno
    description: "Customer feedback on whether the suggestion was clicked."
    sql: ${TABLE}.clicked ;;
  }

  dimension: correctness_level {
    group_label: "Agent Assist Annotations"
    type: string
    description: "Customer feedback on the correctness level of the suggestion."
    sql: ${TABLE}.correctnessLevel ;;
  }

  dimension_group: create {
    group_label: "Agent Assist Annotations"
    hidden: yes
    type: time
    timeframes: [time, hour_of_day, date, day_of_week, week, month_name, year, raw]
    description: "The time in UTC when the suggestion was generated."
    sql: TIMESTAMP_MICROS(CAST(${TABLE}.createTimeNanos/1000 as INT64)) ;;
  }

  dimension: displayed {
    group_label: "Agent Assist Annotations"
    type: yesno
    description: "Customer feedback on whether the suggestion was displayed."
    sql: ${TABLE}.displayed ;;
  }

  dimension: record {
    group_label: "Agent Assist Annotations"
    type: string
    description: "The suggestion content returned from CCAI, serialised as JSON."
    sql: ${TABLE}.record ;;
  }

  dimension: type {
    group_label: "Agent Assist Annotations"
    type: string
    description: "The type of suggestion."
    sql: ${TABLE}.type ;;
  }
}

view: insights_data__sentences__intent_match_data {
  #Documentation on Smart Highllights Here: https://cloud.google.com/contact-center/insights/docs/smart-highlights
  dimension: display_name {
    group_label: "Smart Highlights"
    label: "Smart Highlight Name"
    type: string
    description: "The human readable name of the matched intent."
    sql: case when ${TABLE}.displayName is null then "" else ${TABLE}.displayName end ;;
  }

  dimension: intent_id {
    group_label: "Smart Highlights"
    label: "Smart Highlight ID"
    type: string
    primary_key: yes
    hidden: yes
    description: "The unique ID of the matched intent."
    sql: ${TABLE}.intentId ;;
  }

  measure: count {
    label: "Smart Highlight Count"
    group_label: "Smart Highlights"
    type: count
  }
}

view: insights_data__sentences__phrase_match_data {
  dimension: display_name {
    label: "Custom Highlight Name"
    group_label: "Custom Highlights"
    type: string
    description: "The human readable name of the phrase matcher set up as a custom highlight in the Insights console."
    sql: case when ${TABLE}.displayName is null then "" else ${TABLE}.displayName end ;;
    suggest_dimension: insights_data__sentences__custom_highligh_filter.display_name
    suggest_explore: insights_data__sentences__custom_highligh_filter
  }

  dimension: phrase_matcher_id {
    primary_key: yes
    group_label: "Custom Highlights"
    label: "Custom Highlight ID"
    type: string
    hidden: yes
    description: "The unique ID of the phrase matcher set up as a custom highlight in the Insights console."
    sql: ${TABLE}.phraseMatcherId ;;
  }

  dimension: revision_id {
    group_label: "Custom Highlights"
    label: "Custom Highlight Revision ID"
    hidden: yes
    type: number
    description: "Indicating the revision of the phrase matcher set up as a custom highlight in the Insights console."
    sql: ${TABLE}.revisionId ;;
  }
  measure: count {
    label: "Custom Highlight Count"
    group_label: "Custom Highlights"
    type: count
  }
}

view: insights_data__sentences__custom_highlight_filter {
  derived_table: {
    sql: SELECT
          case when insights_data__sentences__phrase_match_data.displayName is null then "No Custom Highlight Match" else insights_data__sentences__phrase_match_data.displayName end  AS display_name
          FROM @{insights_table} AS insights_data
          LEFT JOIN UNNEST(insights_data.sentences) as insights_data__sentences
          LEFT JOIN UNNEST(insights_data__sentences.phraseMatchData) as insights_data__sentences__phrase_match_data
          GROUP BY
              1
          ORDER BY
              1 ;;
  }

  dimension: display_name {}
}

view: insights_data__sentences__dialogflow_intent_match_data {
  dimension: display_name {
    group_label: "Dialogflow Intents"
    label: "Dialogflow Intent Name"
    type: string
    description: "The human readable name of the matched intent."
    sql: case when ${TABLE}.displayName is null then "No Dialogflow Intent Match" else ${TABLE}.displayName end ;;
  }

  dimension: intent_match_source {
    hidden: yes #field no longer exists in database schema
    group_label: "Dialogflow Intents"
    label: "Dialogflow Intent Source"
    type: string
    description: "The source of the matched intent, either ANALYZE_CONTENT or DETECT_INTENT."
    sql: ${TABLE}.intentMatchSource ;;
  }

  dimension: intent_name {
    hidden:  yes
    group_label: "Dialogflow Intents"
    label: "Dialogflow Intent Name"
    type: string
    description: "The resource name of the matched intent."
    sql: ${TABLE}.intentName ;;
  }

  dimension: max_confidence {
    group_label: "Dialogflow Intents"
    label: "Dialogflow Intent Max Confidence"
    type: number
    description: "The maximum confidence seen for the intent in the current transcript chunk."
    sql: ${TABLE}.maxConfidence ;;
  }
}

view: insights_data__sentences__highlight_data {
  #combined view of custom highlights and smart higlights into a single column
  dimension: display_name {
    label: "Highlighter Name"
    group_label: "Highlighter"
    type: string
    description: "The human readable name of the highlighter."
    sql: ${TABLE}.displayName ;;
  }

  dimension: highlighter_id {
    primary_key: yes
    hidden: yes
    label: "Highlighter ID"
    group_label: "Highlighter"
    type: string
    description: "The unique id of the highlighter."
    sql: ${TABLE}.highlighterName ;;
  }

  dimension: type {
    label: "Highlighter Type"
    group_label: "Highlighter"
    type: string
    description: "The type of the highlighter."
    sql: ${TABLE}.type ;;
  }
}

view: sentence_turn_number {
  derived_table: {
    sql: SELECT
          insights_data.conversationName  AS conversation_name,
          insights_data__sentences.sentence  AS sentence,
              insights_data__sentences.createTimeNanos AS created_test,
              rank() over(partition by insights_data.conversationName order by insights_data__sentences.createTimeNanos asc) AS turn_number
          FROM @{insights_table} AS insights_data
          LEFT JOIN UNNEST(insights_data.sentences) as insights_data__sentences
          GROUP BY
          1,
          2,
          3 ;;
  }

  dimension: conversation_name {
    hidden: yes
    description: "Name of the conversation resource."
  }
  dimension: sentence {
    hidden: yes
    description: "The transcribed sentence."
  }
  dimension: created_test {
    hidden: yes
    type: number
  }
  dimension_group: created {
    hidden: yes
    type: time
    timeframes: [time, hour_of_day, date, day_of_week, week, month_name, year, raw]
    description: "Time in UTC that the conversation message took place, if provided."
    sql: TIMESTAMP_MICROS(CAST(${created_test}/1000 as INT64)) ;;
  }
  dimension: turn_number {
    type: number
    description: "The turn number of the sentence within the conversation."
  }
}

view: insights_data__agents {
  drill_fields: [agent_id]

  dimension: agent_id {
    primary_key: yes
    type: string
    description: "A user-specified string representing the agent."
    sql: agentId ;;
    link: {
    label: "Agent Performance Dashboard"
    url: "/dashboards-next/insights::agent_performance?Agent+ID+Selector={{ value }}"
    }
    suggest_dimension: agent_id
    suggest_explore: insights_data__agent_id_filter
  }

  dimension: agent_display_name {
    type: string
    description: "The agent's name"
    sql: agentDisplayName ;;
  }

  dimension: agent_team {
    type: string
    description: "A user-specified string representing the agent's team."
    sql: agentTeam ;;
  }

  dimension: insights_data__agents {
    type: string
    description: "Metadata about the agent dimension."
    hidden: yes
    sql: insights_data__agents ;;
  }
}

view: insights_data__agent_id_filter {
  derived_table: {
    sql: SELECT
          insights_data__agents.agentid  AS agent_id
          FROM @{insights_table}  AS insights_data
          LEFT JOIN UNNEST(insights_data.agents) as insights_data__agents
          GROUP BY
              1 ;;
  }

  dimension: agent_id {}
}

# view: human_agent_turns {
#   derived_table: {
#     sql: WITH sentence_turn_number AS (SELECT
#           insights_data.conversationName  AS conversation_name,
#           insights_data__sentences.sentence  AS sentence,
#           insights_data__sentences.createTimeNanos AS created_test,
#           rank() over(partition by insights_data.conversationName order by insights_data__sentences.createTimeNanos asc) AS turn_number
#           FROM @{insights_table} AS insights_data
#           LEFT JOIN UNNEST(insights_data.sentences) as insights_data__sentences
#           GROUP BY
#           1,
#           2,
#           3 )
#       SELECT
#           insights_data.conversationName  AS conversation_name,
#           min(sentence_turn_number.turn_number) AS first_turn_human_agent
#       FROM @{insights_table} AS insights_data
#       LEFT JOIN UNNEST(insights_data.sentences) as insights_data__sentences
#       LEFT JOIN sentence_turn_number ON insights_data.conversationName=sentence_turn_number.conversation_name
#           and insights_data__sentences.sentence = sentence_turn_number.sentence
#           and (TIMESTAMP_MICROS(CAST(insights_data__sentences.createTimeNanos/1000 as INT64))) = (TIMESTAMP_MICROS(CAST(sentence_turn_number.created_test/1000 as INT64)))
#           where insights_data__sentences.participantRole = "HUMAN_AGENT"
#       GROUP BY
#           1 ;;
#   }

#   dimension: conversation_name {
#     hidden: yes
#     primary_key:  yes
#     description: "Name of the conversation resource."
#   }
#   dimension: first_turn_human_agent {
#     description: "The turn number for the first time a human agent entered a conversation."
#   }
#   measure: average_first_turn_human_agent {
#     type: average
#     sql: ${first_turn_human_agent} ;;
#     value_format_name: decimal_0
#   }
# }

view: daily_facts {

  derived_table: {
    explore_source: insights_data {
      column: start_date {}
      column: conversation_medium {field:insights_data.medium}
      column: conversation_count {}
      # column: contained_count {}
      column: entity_count { field: insights_data__entities.count }
      column: topic_count { field: insights_data__topics.count }
      # column: contained_percentage {}
    }
  }

  dimension: date_type {
    group_label: "Daily Metrics"
    primary_key: yes
    hidden: yes
    sql: concat(${start_date}," ",${conversation_medium}) ;;
  }
  dimension: start_date {
    group_label: "Daily Metrics"
    hidden: yes
    type: date
  }
  dimension: conversation_medium {
    group_label: "Daily Metrics"
    hidden: yes
    type: string
  }
  dimension: conversation_count {
    group_label: "Conversation Type"
    hidden: yes
    label: "Insights Data: Conversations Conversation Count"
    type: number
  }
  measure: avg_daily_conversations {
    description: "Average Conversations Per Day"
    group_label: "Daily Metrics"
    type: average
    sql: ${conversation_count} ;;
    value_format_name: decimal_0
    drill_fields: [insights_data.start_date]
  }
  # dimension: contained_count {
  #   group_label: "Daily Metrics"
  #   hidden: yes
  #   label: "Insights Data: Conversations Contained Count"
  #   description: "A conversation is considered contained if it was never passed to a human agent."
  #   type: number
  # }
  # measure: avg_daily_contained_conversations {
  #   group_label: "Daily Metrics"
  #   description: "Average Contained Conversations Per Day"
  #   type: average
  #   sql: ${contained_count} ;;
  #   value_format_name: decimal_0
  #   drill_fields: [insights_data.convo_info*]
  # }
  dimension: entity_count {
    group_label: "Daily Metrics"
    hidden:  yes
    label: "Insights Data: Entities Count"
    type: number
  }
  measure: avg_daily_entities {
    group_label: "Daily Metrics"
    description: "Average Entities Per Day"
    type: average
    value_format_name: decimal_0
    sql: ${entity_count} ;;
  }
  dimension: topic_count {
    group_label: "Daily Metrics"
    hidden: yes
    type: number
  }
  measure: avg_daily_topics {
    group_label: "Daily Metrics"
    description: "Average Topics Per Day"
    type: average
    value_format_name: decimal_0
    sql: ${topic_count} ;;
  }

}

view: insights_data__latest_summary__metadata {
  dimension: key {
    group_label: "Metadata"
    type: string
    description: "The key of the metadata."
    sql: ${TABLE}.key ;;
  }

  dimension: value {
    group_label: "Metadata"
    type: string
    description: "The value of the metadata."
    sql: ${TABLE}.value ;;
  }
}

view: insights_data__latest_summary__text_sections {
  dimension: key {
    group_label: "Text Sections"
    type: string
    description: "The name of the section."
    sql: ${TABLE}.key ;;
  }

  dimension: value {
    group_label: "Text Sections"
    type: string
    description: "The content of the section."
    sql: ${TABLE}.value ;;
  }
}

view: insights_data__qa_scorecard_results {
  dimension: insights_data__qa_scorecard_results {
    group_label: "Results"
    type: string
    description: "All QaScorecardResult(s) available for the conversation."
    hidden: yes
    sql: insights_data__qa_scorecard_results ;;
  }

  dimension: normalized_score {
    group_label: "Results"
    type: number
    description: "Normalized score assigned for the conversation."
    sql: normalizedScore ;;
  }

  dimension: potential_score {
    group_label: "Results"
    type: number
    description: "The potential score assigned to the conversation."
    sql: potentialScore ;;
  }

  dimension: qa_answers {
    hidden: yes
    sql: qaAnswers ;;
  }

  dimension: qa_answers__tags {
    hidden: yes
    sql: ${TABLE}.qaAnswers.tags ;;
    group_label: "Qa Answers"
    group_item_label: "Tags"
  }

  dimension: qa_scorecard {
    group_label: "Results"
    type: string
    description: "Fully qualified resource name of the scorecard. Format: projects/{project}/locations/{location}/qaScorecards/{qa_scorecard_id}"
    sql: qaScorecard ;;
  }

  dimension: qa_scorecard_result {
    group_label: "Results"
    type: string
    description: "Fully qualified resource name of the scorecard result. Format: projects/{project}/locations/{location}/qaScorecards/{qa_scorecard_id}/revisions/{revision_id}/results/{result_id}"
    sql: qaScorecardResult ;;
  }

  dimension: qa_scorecard_revision {
    group_label: "Results"
    type: string
    description: "Fully qualified resource name of the scorecard revision. Format: projects/{project}/locations/{location}/qaScorecards/{qa_scorecard_id}/revisions/{revision_id}"
    sql: qaScorecardRevision ;;
  }

  dimension: qa_tag_results {
    hidden: yes
    sql: qaTagResults ;;
  }

  dimension: score {
    group_label: "Results"
    type: number
    description: "The score assigned to the conversation."
    sql: score ;;
  }
}

view: insights_data__qa_scorecard_results__qa_answers__tags {
  dimension: insights_data__qa_scorecard_results__qa_answers__tags {
    group_label: "Tags"
    type: string
    description: "User defined list of arbitrary tags."
    sql: insights_data__qa_scorecard_results__qa_answers__tags ;;
  }
}

view: insights_data__qa_scorecard_results__qa_answers {
  dimension: normalized_score {
    group_label: "QA Answers"
    type: number
    description: "The normalized score assigned to the answer."
    sql: ${TABLE}.normalizedScore ;;
  }

  dimension: potential_score {
    group_label: "QA Answers"
    type: number
    description: "The potential score assigned to the answer."
    sql: ${TABLE}.potentialScore ;;
  }

  dimension: qa_answer_bool_value {
    group_label: "QA Answers"
    type: yesno
    sql: ${TABLE}.qaAnswerBoolValue ;;
  }

  dimension: qa_answer_na_value {
    group_label: "QA Answers"
    type: yesno
    sql: ${TABLE}.qaAnswerNaValue ;;
  }

  dimension: qa_answer_numeric_value {
    group_label: "QA Answers"
    type: number
    sql: ${TABLE}.qaAnswerNumericValue ;;
  }

  dimension: qa_answer_string_value {
    group_label: "QA Answers"
    type: string
    sql: ${TABLE}.qaAnswerStringValue ;;
  }

  dimension: qa_question__qa_question {
    type: string
    description: "Resource name of the question. Format: projects/{project}/locations/{location}/qaScorecards/{qa_scorecard_id}/revisions/{revision_id}/qaQuestions/{qa_question_id}"
    sql: ${TABLE}.qaQuestion.qaQuestion ;;
    group_label: "Qa Question"
    group_item_label: "Qa Question"
  }

  dimension: qa_question__question_body {
    type: string
    description: "Question text. E.g., \"Did the agent greet the customer?\""
    sql: ${TABLE}.qaQuestion.questionBody ;;
    group_label: "Qa Question"
    group_item_label: "Question Body"
  }

  dimension: score {
    group_label: "QA Answers"
    type: number
    description: "The score assigned to the answer."
    sql: ${TABLE}.score ;;
  }
}

view: insights_data__qa_scorecard_results__qa_tag_results {
  dimension: normalized_score {
    group_label: "Tag Results"
    type: number
    description: "Normalized score for the given tag for this conversation."
    sql: ${TABLE}.normalizedScore ;;
  }

  dimension: potential_score {
    group_label: "Tag Results"
    type: number
    description: "The potential score assigned to the tag for this conversation."
    sql: ${TABLE}.potentialScore ;;
  }

  dimension: score {
    group_label: "Tag Results"
    type: number
    description: "The score assigned to the tag for this conversation."
    sql: ${TABLE}.score ;;
  }

  dimension: tag {
    group_label: "Tag Results"
    type: string
    description: "The tag assigned to question(s) in the scorecard."
    sql: ${TABLE}.tag ;;
  }
}
