output "function_name" {
  description = "Name of the Cloud Function"
  value       = module.cf_agent_structure.function_name
}

output "function_uri" {
  description = "URI of the Cloud Function"
  value       = module.cf_agent_structure.uri
}
