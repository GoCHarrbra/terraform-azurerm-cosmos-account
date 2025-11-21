# Useful outputs for downstream modules (and diagnostics/RBAC/PE)
output "cosmos_account_id" {
  description = "Cosmos DB account resource ID."
  value       = module.cosmos.account_id
}

output "cosmos_account_name" {
  description = "Cosmos DB account name."
  value       = module.cosmos.account_name
}

output "cosmos_rg_name" {
  description = "Resource group used for the Cosmos account."
  value       = module.cosmos.rg_name
}

output "cosmos_location" {
  description = "Location used for the Cosmos account."
  value       = module.cosmos.location
}

output "cosmos_tags" {
  description = "Tags applied to the Cosmos account."
  value       = module.cosmos.tags
}
