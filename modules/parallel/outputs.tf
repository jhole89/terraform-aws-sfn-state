output "name" {
  value = var.name
}

output "json" {
  description = "JSON encoded state definition for use with other terraform resources"
  value       = local.json
}

output "defn" {
  description = "Raw state definition for use with other terraform resources"
  value       = local.state_defn
}
