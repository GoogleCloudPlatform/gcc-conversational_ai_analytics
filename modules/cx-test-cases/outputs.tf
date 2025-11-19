output "function_name" {
  description = "Name of the Cloud Function"
  value       = module.cf_cx_test_cases.function_name
}

output "function_uri" {
  description = "URI of the Cloud Function"
  value       = module.cf_cx_test_cases.uri
}
