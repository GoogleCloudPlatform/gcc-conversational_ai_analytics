view: dfcx_nlu_testing_results {
  sql_table_name: `adamminton-sandbox.dfcx_analytics.dfcx_nlu_testing_results` ;;

  dimension: agent_name {
    type: string
    description: "The full resource name of the Dialogflow CX agent."
    sql: ${TABLE}.agent_name ;;
  }
  dimension: confidence {
    type: number
    description: "The confidence score of the intent match."
    sql: ${TABLE}.confidence ;;
  }
  dimension: description {
    type: string
    description: "Additional details or comments about the test result."
    sql: ${TABLE}.description ;;
  }
  dimension: detected_intent {
    type: string
    description: "The actual intent detected by the agent."
    sql: ${TABLE}.detected_intent ;;
  }
  dimension: detected_match_type {
    type: string
    description: "The actual match type detected by the agent."
    sql: ${TABLE}.detected_match_type ;;
  }
  dimension: detected_parameters {
    type: string
    description: "The actual parameters detected by the agent (JSON string)."
    sql: ${TABLE}.detected_parameters ;;
  }
  dimension: expected_intent {
    type: string
    description: "The intent that was expected to be matched."
    sql: ${TABLE}.expected_intent ;;
  }
  dimension: expected_match_type {
    type: string
    description: "The type of match expected (e.g., INTENT, NO_MATCH)."
    sql: ${TABLE}.expected_match_type ;;
  }
  dimension: expected_parameters {
    type: string
    description: "The parameters that were expected to be extracted (JSON string)."
    sql: ${TABLE}.expected_parameters ;;
  }
  dimension: flow_display_name {
    type: string
    description: "The display name of the flow where the test occurred."
    sql: ${TABLE}.flow_display_name ;;
  }
  dimension: input_source {
    type: string
    description: "The source of the input (e.g., AUDIO, TEXT)."
    sql: ${TABLE}.input_source ;;
  }
  dimension: page_display_name {
    type: string
    description: "The display name of the page where the test occurred."
    sql: ${TABLE}.page_display_name ;;
  }
  dimension: passed {
    type: yesno
    description: "Indicates whether the test case passed (true) or failed (false)."
    sql: ${TABLE}.passed ;;
  }
  dimension: target_page {
    type: string
    description: "The expected target page after the turn."
    sql: ${TABLE}.target_page ;;
  }
  dimension: test_run_guid {
    type: string
    description: "A unique identifier for the overall test execution run."
    sql: ${TABLE}.test_run_guid ;;
  }
  dimension_group: test_run {
    type: time
    description: "The timestamp when the test run was initiated."
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.test_run_timestamp ;;
  }
  dimension: utterance {
    type: string
    description: "The user input or utterance being tested."
    sql: ${TABLE}.utterance ;;
  }
  measure: count {
    type: count
  }
  dimension: primary_key {
    hidden: yes
    primary_key: yes
    type: string
    sql: CONCAT(${test_run_guid}, ${utterance}, ${flow_display_name}) ;;
  }

  measure: total_test_cases {
    description: "The total number of unique test cases executed."
    type: count
  }

  measure: total_test_cases_passed {
    description: "The total number of unique test cases that passed."
    type: count
    filters: [passed: "Yes"]
  }

  measure: total_test_cases_failed {
    description: "The total number of unique test cases that failed."
    type: count
    filters: [passed: "No"]
  }

  measure: test_pass_rate {
    description: "The percentage of test cases that passed."
    type: number
    sql: SAFE_DIVIDE(${total_test_cases_passed},${total_test_cases}) ;;
    value_format_name: percent_1
  }

  set: dfcx_nlu_test_run {
    fields: [test_run_time, test_run_guid, flow_display_name, page_display_name, description, input_source, utterance, detected_intent, expected_intent, passed]
  }

  drill_fields: [dfcx_nlu_test_run*]

}
