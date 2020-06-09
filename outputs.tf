output "json" {
  description = "JSON encoded state definition for use with other terraform resources"
  value       = local.json
}

output "raw" {
  value = local.local_defn
}