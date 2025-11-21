include: "/views/dfcx_test_cases_results.view.lkml"

explore: dfcx_test_cases_results {
  hidden: yes
  label: "DFCX Test Cases Results"

  join: dfcx_test_cases_results__tags {
    sql: LEFT JOIN UNNEST(${dfcx_test_cases_results.tags}) as dfcx_test_cases__tag ;;
    relationship: one_to_many
  }
}
