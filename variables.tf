variable "rg_name" {
  description = "Resource group where Cosmos resources will be created."
  type        = string
}

variable "location" {
  description = "Primary Azure region (write region), e.g., canadacentral."
  type        = string
}

variable "account_name" {
  description = "Cosmos DB account name. Must be globally unique."
  type        = string
}

variable "tags" {
  description = "Tags to apply to Cosmos resources."
  type        = map(string)
}

# Account shape & access
variable "kind" {
  description = "Cosmos account kind. Typically GlobalDocumentDB."
  type        = string
}

variable "offer_type" {
  description = "Offer type; for SQL API use 'Standard'."
  type        = string
}

variable "minimal_tls_version" {
  description = "Minimum TLS version (Tls, Tls11, Tls12)."
  type        = string
  validation {
    condition     = contains(["Tls", "Tls11", "Tls12"], var.minimal_tls_version)
    error_message = "minimal_tls_version must be one of: Tls, Tls11, Tls12."
  }
}

variable "disable_local_auth" {
  description = "Disable local auth keys and require AAD (maps to local_authentication_disabled)."
  type        = bool
}

variable "public_network_access_enabled" {
  description = "Enable public network access to the Cosmos account."
  type        = bool
}

variable "automatic_failover_enabled" {
  description = "Enable automatic failover between regions."
  type        = bool
}

variable "additional_read_locations" {
  description = "Optional additional read regions in priority order (failover priority starts at 1)."
  type        = list(string)
}

variable "enable_serverless" {
  description = "Enable serverless capability ('EnableServerless' capability)."
  type        = bool
}

# Consistency policy
variable "consistency_level" {
  description = "Session | Strong | BoundedStaleness | ConsistentPrefix | Eventual."
  type        = string
  validation {
    condition     = contains(["Session","Strong","BoundedStaleness","ConsistentPrefix","Eventual"], var.consistency_level)
    error_message = "consistency_level must be one of: Session, Strong, BoundedStaleness, ConsistentPrefix, Eventual."
  }
}

variable "consistency_max_interval_seconds" {
  description = "Max interval (BoundedStaleness). Ignored by other levels."
  type        = number
}

variable "consistency_max_staleness_prefix" {
  description = "Max staleness prefix (BoundedStaleness). Ignored by other levels."
  type        = number
}

# Backup (azurerm v4 flat shape)
variable "backup_type" {
  description = "Backup type: Periodic, Continuous7Days, Continuous30Days."
  type        = string
  validation {
    condition     = contains(["Periodic","Continuous7Days","Continuous30Days"], var.backup_type)
    error_message = "backup_type must be one of: Periodic, Continuous7Days, Continuous30Days."
  }
}

variable "backup_interval_minutes" {
  description = "For Periodic backups: interval in minutes."
  type        = number
}

variable "backup_retention_hours" {
  description = "For Periodic backups: retention in hours."
  type        = number
}

variable "backup_storage_redundancy" {
  description = "Backup redundancy: Local | Zone | Geo."
  type        = string
  validation {
    condition     = contains(["Local","Zone","Geo"], var.backup_storage_redundancy)
    error_message = "backup_storage_redundancy must be one of: Local, Zone, Geo."
  }
}

# Databases & containers
variable "databases" {
  description = "Map of SQL databases and their containers."
  type = map(object({
    name       = string
    containers = map(object({
      partition_key_path    = string
      partition_key_version = number
      indexing_included     = list(string)
      indexing_excluded     = list(string)
    }))
  }))
}

variable "access_key_metadata_writes_enabled" {
  description = "Whether key-based clients can modify metadata (DBs/containers). Set to false to restrict management-plane changes and satisfy CKV_AZURE_132."
  type        = bool
}

