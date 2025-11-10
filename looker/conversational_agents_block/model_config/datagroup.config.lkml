datagroup: daily {
  sql_trigger: SELECT DATE(CURRENT_TIMESTAMP, 'America/New_York') ;;
  max_cache_age: "24 hours"
}

datagroup: hourly {
  sql_trigger: SELECT EXTRACT(HOUR FROM (CURRENT_TIMESTAMP)) ;;
  max_cache_age: "1 hour"
}
