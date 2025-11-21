view: dfcx_test_cases_results {
  label: "DFCX Test Cases Results"

  sql_table_name: `dfcx_analytics.dfcx_test_cases_results` ;;

  dimension: primary_key {
    hidden: yes
    type: string
    sql: CONCAT(${test_run_guid}, ${test_case_id}) ;;
  }

  dimension: agent_display_name {
    hidden: yes
    description: "The human-readable display name of the Dialogflow CX agent."
    type: string
    sql: ${TABLE}.agent_display_name ;;
  }

  dimension: agent_id {
    hidden: yes
    description: "The unique identifier (UUID) of the Dialogflow CX agent."
    type: string
    sql: ${TABLE}.agent_id ;;
  }

  dimension: not_runnable {
    description: "Indicates whether the test case could not be executed (true) or was runnable (false)."
    type: yesno
    sql: ${TABLE}.not_runnable ;;
  }

  dimension: passed {
    description: "Indicates whether the test case passed (true) or failed (false)."
    type: yesno
    sql: ${TABLE}.passed ;;
  }

  dimension: start_flow {
    description: "The display name of the flow where the test case execution begins."
    type: string
    sql: ${TABLE}.start_flow ;;
  }

  dimension: tags {
    hidden: yes
    description: "A list of tags associated with the test case for categorization."
    sql: ${TABLE}.tags ;;
  }

  dimension: test_case_display_name {
    description: "The human-readable display name of the test case."
    type: string
    sql: ${TABLE}.test_case_display_name ;;
  }

  dimension: test_case_id {
    description: "The unique identifier (UUID) of the specific test case."
    type: string
    sql: ${TABLE}.test_case_id ;;
  }

  dimension: test_run_guid {
    hidden: yes
    description: "A unique identifier for the overall test execution run."
    type: string
    sql: ${TABLE}.test_run_guid ;;
  }

  dimension_group: test_run {
    hidden: yes
    description: "The timestamp when the test run was initiated."
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.test_run_timestamp ;;
  }

  dimension_group: test {
    hidden: yes
    description: "The specific date and time when this test case was executed."
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    datatype: datetime
    sql: ${TABLE}.test_time ;;
  }

  measure: total_test_cases {
    description: "The total number of unique test cases executed."
    type: count_distinct
    sql: ${test_case_id} ;;
  }

  measure: total_test_cases_passed {
    description: "The total number of unique test cases that passed."
    type: count_distinct
    sql: ${test_case_id} ;;
    filters: [passed: "Yes"]
  }

  measure: total_test_cases_failed {
    description: "The total number of unique test cases that failed."
    type: count_distinct
    sql: ${test_case_id} ;;
    filters: [passed: "No"]
  }

  measure: test_pass_rate {
    description: "The percentage of test cases that passed."
    type: number
    sql: SAFE_DIVIDE(${total_test_cases_passed},${total_test_cases}) ;;
    value_format_name: percent_1
  }

  set: dfcx_test_run {
    fields: [test_run_time, test_run_guid, test_case_id, passed]
  }

  drill_fields: [dfcx_test_run*]

}

view: dfcx_test_cases_results__tags {
  label: "DFCX Test Cases Results: Tags"

  dimension: dfcx_test_cases_results__tag {
    label: "DFCX Test Case Tag"
    description: "A single tag associated with the test case."
    type: string
    sql: dfcx_test_cases__tag ;;
  }
}
