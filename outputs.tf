output "account_id" {
  description = "Cosmos DB account resource ID."
  value       = azurerm_cosmosdb_account.this.id
}

output "account_name" {
  description = "Cosmos DB account name."
  value       = azurerm_cosmosdb_account.this.name
}

# Add these three so callers can treat Cosmos like “foundation”
output "rg_name" {
  description = "Resource group used for the Cosmos account."
  value       = var.rg_name
}

output "location" {
  description = "Location used for the Cosmos account."
  value       = var.location
}

output "tags" {
  description = "Tags applied to the Cosmos account."
  value       = var.tags
}
