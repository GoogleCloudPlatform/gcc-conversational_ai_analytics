include: "/views/dfcx_nlu_testing_runs_results.view.lkml"
include: "/views/dfcx_nlu_testing_results.view.lkml"
include: "/explores/dfcx_nlu_testing_results.explore.lkml"

explore: dfcx_nlu_testing_runs_results {
  extends: [dfcx_nlu_testing_results]

  label: "DFCX NLU Testing Runs Results"
  view_label: "01 - DFCX NLU Testing Runs Results"

  join: dfcx_nlu_testing_results {
    view_label: "02 - DFCX NLU Testing Results"
    type: inner
    sql_on: ${dfcx_nlu_testing_runs_results.test_run_guid} = ${dfcx_nlu_testing_results.test_run_guid} ;;
    relationship: one_to_many
  }

}
