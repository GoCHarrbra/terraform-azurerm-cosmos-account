output "account_id" {
  description = "Cosmos DB account resource ID."
  value       = azurerm_cosmosdb_account.this.id
}

output "account_name" {
  description = "Cosmos DB account name."
  value       = azurerm_cosmosdb_account.this.name
}
