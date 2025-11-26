# All fields required; must be set in cosmos.tfvars
variable "cosmos" {
  description = "Settings for the Cosmos DB account and its SQL databases/containers."
  type = object({
    rg_name                        = string
    location                       = string
    account_name                   = string
    tags                           = map(string)

    # Account shape
    kind                           = string               # e.g., "GlobalDocumentDB"
    offer_type                     = string               # e.g., "Standard"
    minimal_tls_version            = string               # "Tls" | "Tls11" | "Tls12"

    # Security / networking
    disable_local_auth             = bool
    public_network_access_enabled  = bool

    # CKV Azure 132
    access_key_metadata_writes_enabled = bool

    # Resiliency / capacity
    automatic_failover_enabled     = bool
    enable_serverless              = bool
    additional_read_locations      = list(string)         # [] or e.g., ["canadaeast"]

    # Consistency
    consistency_level                 = string            # Session | Strong | BoundedStaleness | ConsistentPrefix | Eventual
    consistency_max_interval_seconds  = number
    consistency_max_staleness_prefix  = number

    # Backup (azurerm v4)
    backup_type                    = string               # Periodic | Continuous7Days | Continuous30Days
    backup_interval_minutes        = number               # used for Periodic
    backup_retention_hours         = number               # used for Periodic
    backup_storage_redundancy      = string               # Local | Zone | Geo

    # DBs/containers
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
  source = "github.com/GoCHarrbra/terraform-azurerm-cosmos-account.git?ref=v0.9.0"

  rg_name                       = var.cosmos.rg_name
  location                      = var.cosmos.location
  account_name                  = var.cosmos.account_name
  tags                          = var.cosmos.tags

  # Account shape
  kind                          = var.cosmos.kind
  offer_type                    = var.cosmos.offer_type
  minimal_tls_version           = var.cosmos.minimal_tls_version

  # Security / networking
  disable_local_auth            = var.cosmos.disable_local_auth
  public_network_access_enabled = var.cosmos.public_network_access_enabled

  # CKV Azure 132 -- Disabling the management plane changes
  access_key_metadata_writes_enabled = var.cosmos.access_key_metadata_writes_enabled

  # Resiliency / capacity
  automatic_failover_enabled    = var.cosmos.automatic_failover_enabled
  enable_serverless             = var.cosmos.enable_serverless
  additional_read_locations     = var.cosmos.additional_read_locations

  # Consistency
  consistency_level                 = var.cosmos.consistency_level
  consistency_max_interval_seconds  = var.cosmos.consistency_max_interval_seconds
  consistency_max_staleness_prefix  = var.cosmos.consistency_max_staleness_prefix

  # Backup (azurerm v4)
  backup_type                    = var.cosmos.backup_type
  backup_interval_minutes        = var.cosmos.backup_interval_minutes
  backup_retention_hours         = var.cosmos.backup_retention_hours
  backup_storage_redundancy      = var.cosmos.backup_storage_redundancy

  # DBs/containers
  databases                     = var.cosmos.databases
}

# Useful outputs for downstream modules (and diagnostics/RBAC/PE)
output "cosmos_account_id" {
  description = "Cosmos DB account resource ID."
  value       = module.cosmos.cosmos_account_id
}

output "cosmos_account_name" {
  description = "Cosmos DB account name."
  value       = module.cosmos.cosmos_account_name
}

output "cosmos_rg_name" {
  description = "Resource group used for the Cosmos account."
  value       = module.cosmos.cosmos_rg_name
}

output "cosmos_location" {
  description = "Location used for the Cosmos account."
  value       = module.cosmos.cosmos_location
}

output "cosmos_tags" {
  description = "Tags applied to the Cosmos account."
  value       = module.cosmos.cosmos_tags
}







