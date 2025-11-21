view: dfcx_nlu_testing_runs_results {
  label: "DFCX NLU Testing Runs"

  derived_table: {
    explore_source: dfcx_nlu_testing_results {
      column: test_run_time { field: dfcx_nlu_testing_results.test_run_time }
      column: test_run_guid {}
      column: agent_name {}
      column: test_cases { field: dfcx_nlu_testing_results.total_test_cases }
      column: test_cases_passed { field: dfcx_nlu_testing_results.total_test_cases_passed }
    }
  }

  dimension: primary_key {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${test_run_guid} ;;
  }

  dimension: agent_name {
    description: "The full resource name of the Dialogflow CX agent."
    type: string
    sql: ${TABLE}.agent_name ;;
  }

  dimension: test_run_guid {
    description: "A unique identifier for the overall test execution run."
    type: string
    sql: ${TABLE}.test_run_guid ;;
  }

  dimension_group: test_run {
    description: "The timestamp when the test run was initiated."
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.test_run_time ;;
  }

  dimension: test_cases {
    description: "The total number of test cases in this run."
    type: number
    sql: ${TABLE}.test_cases ;;
  }

  dimension: test_cases_passed {
    description: "The number of test cases that passed in this run."
    type: number
    sql: ${TABLE}.test_cases_passed ;;
  }

  dimension: test_run_filter {
    description: "Compound key for sorting test runs by time."
    type: string
    sql: CONCAT(${test_run_raw},${test_run_guid}) ;;
    order_by_field: test_run_raw
  }

  dimension: test_pass_rate {
    description: "The percentage of test cases that passed in this run."
    type: number
    sql: SAFE_DIVIDE(${test_cases_passed},${test_cases}) ;;
    value_format_name: percent_1
  }

  measure: total_tests_runs {
    description: "The total number of test runs executed."
    type: count
  }

  measure: average_test_pass_rate {
    description: "The average pass rate across all test runs."
    type: average
    sql: ${test_pass_rate} ;;
  }

  set: dfcx_test_run {
    fields: [test_run_time, test_run_guid, test_pass_rate, dfcx_nlu_testing_results.total_test_cases, dfcx_nlu_testing_results.total_test_cases_passed, dfcx_nlu_testing_results.total_test_cases_failed]
  }

  drill_fields: [dfcx_test_run*]

}
