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
    type: string
    sql: ${TABLE}.agent_display_name ;;
  }

  dimension: agent_id {
    hidden: yes
    type: string
    sql: ${TABLE}.agent_id ;;
  }

  dimension: not_runnable {
    type: yesno
    sql: ${TABLE}.not_runnable ;;
  }

  dimension: passed {
    type: yesno
    sql: ${TABLE}.passed ;;
  }

  dimension: start_flow {
    type: string
    sql: ${TABLE}.start_flow ;;
  }

  dimension: tags {
    hidden: yes
    sql: ${TABLE}.tags ;;
  }

  dimension: test_case_display_name {
    type: string
    sql: ${TABLE}.test_case_display_name ;;
  }

  dimension: test_case_id {
    type: string
    sql: ${TABLE}.test_case_id ;;
  }

  dimension: test_run_guid {
    hidden: yes
    type: string
    sql: ${TABLE}.test_run_guid ;;
  }

  dimension_group: test_run {
    hidden: yes
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.test_run_timestamp ;;
  }

  dimension_group: test {
    hidden: yes
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    datatype: datetime
    sql: ${TABLE}.test_time ;;
  }

  measure: total_test_cases {
    type: count_distinct
    sql: ${test_case_id} ;;
  }

  measure: total_test_cases_passed {
    type: count_distinct
    sql: ${test_case_id} ;;
    filters: [passed: "Yes"]
  }

  measure: total_test_cases_failed {
    type: count_distinct
    sql: ${test_case_id} ;;
    filters: [passed: "No"]
  }

  measure: test_pass_rate {
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
    type: string
    sql: dfcx_test_cases__tag ;;
  }
}
