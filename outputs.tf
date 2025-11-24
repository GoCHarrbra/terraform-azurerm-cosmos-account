# Useful outputs for downstream modules (and diagnostics/RBAC/PE)

output "cosmos_account_id" {
  description = "Cosmos DB account resource ID."
  value       = azurerm_cosmosdb_account.this.id
}

output "cosmos_account_name" {
  description = "Cosmos DB account name."
  value       = azurerm_cosmosdb_account.this.name
}

output "cosmos_rg_name" {
  description = "Resource group used for the Cosmos account."
  value       = azurerm_cosmosdb_account.this.resource_group_name
}

output "cosmos_location" {
  description = "Location used for the Cosmos account."
  value       = azurerm_cosmosdb_account.this.location
}

output "cosmos_tags" {
  description = "Tags applied to the Cosmos account."
  value       = azurerm_cosmosdb_account.this.tags
}
