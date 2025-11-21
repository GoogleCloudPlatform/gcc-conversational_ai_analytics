include: "/views/dfcx_test_runs_results.view.lkml"
include: "/views/dfcx_test_cases_results.view.lkml"
include: "/explores/dfcx_test_cases_results.explore.lkml"

explore: dfcx_test_runs_results {
  extends: [dfcx_test_cases_results]

  label: "DFCX Test Runs Results"
  view_label: "01 - DFCX Test Runs Results"

  join: dfcx_test_cases_results {
    view_label: "02 - DFCX Test Cases Results"
    type: inner
    sql_on: ${dfcx_test_runs_results.test_run_guid} = ${dfcx_test_cases_results.test_run_guid} ;;
    relationship: one_to_many
  }

  join: dfcx_test_cases_results__tags {
    view_label: "03 - DFCX Test Cases Results Tags"
  }

}
