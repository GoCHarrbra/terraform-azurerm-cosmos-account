# All fields required; must be set in cosmos.tfvars
variable "cosmos" {
  description = "Settings for the Cosmos DB account and its SQL databases/containers."
  type = object({
    rg_name                        = string
    location                       = string
    account_name                   = string
    tags                           = map(string)

    disable_local_auth             = bool
    public_network_access_enabled  = bool
    automatic_failover_enabled     = bool
    enable_serverless              = bool

    backup_interval_minutes        = number
    backup_retention_hours         = number
    backup_storage_redundancy      = string     # Local | Zone | Geo

    databases = map(object({
      name       = string
      containers = map(object({
        partition_key_path    = string
        partition_key_version = number
        indexing_included     = list(string)
        indexing_excluded     = list(string)
      }))
    }))
  })
}

module "cosmos" {
  source = "github.com/GoCHarrbra/terraform-azurerm-cosmos-account.git?ref=v0.3.0"

  rg_name                       = var.cosmos.rg_name
  location                      = var.cosmos.location
  account_name                  = var.cosmos.account_name
  tags                          = var.cosmos.tags

  disable_local_auth            = var.cosmos.disable_local_auth
  public_network_access_enabled = var.cosmos.public_network_access_enabled
  automatic_failover_enabled    = var.cosmos.automatic_failover_enabled
  enable_serverless             = var.cosmos.enable_serverless

  backup_interval_minutes       = var.cosmos.backup_interval_minutes
  backup_retention_hours        = var.cosmos.backup_retention_hours
  backup_storage_redundancy     = var.cosmos.backup_storage_redundancy

  databases                     = var.cosmos.databases
}

# Useful outputs for downstream layers (match module outputs)
output "account_id" {
  description = "Cosmos DB account resource ID."
  value       = module.cosmos.account_id
}

output "account_name" {
  description = "Cosmos DB account name."
  value       = module.cosmos.account_name
}

output "rg_name" {
  description = "Resource group used for the Cosmos account."
  value       = module.cosmos.rg_name
}

output "location" {
  description = "Location used for the Cosmos account."
  value       = module.cosmos.location
}

output "tags" {
  description = "Tags applied to the Cosmos account."
  value       = module.cosmos.tags
}
