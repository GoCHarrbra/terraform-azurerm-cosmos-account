variable "rg_name" {
  description = "Resource group where Cosmos resources will be created."
  type        = string
}

variable "location" {
  description = "Azure region (e.g., canadacentral)."
  type        = string
}

variable "account_name" {
  description = "Cosmos DB account name. Must be globally unique."
  type        = string
}

variable "tags" {
  description = "Tags to apply to Cosmos resources."
  type        = map(string)
  default     = {}
}

variable "disable_local_auth" {
  description = "Disable local auth keys and require AAD."
  type        = bool
  default     = false
}

variable "public_network_access_enabled" {
  description = "Enable public network access to the Cosmos account."
  type        = bool
  default     = false
}

variable "automatic_failover_enabled" {
  description = "Enable automatic failover between regions."
  type        = bool
  default     = true
}

variable "enable_serverless" {
  description = "Enable serverless capability."
  type        = bool
  default     = true
}

variable "backup_interval_minutes" {
  description = "Periodic backup interval in minutes."
  type        = number
  default     = 240
}

variable "backup_retention_hours" {
  description = "How long backups are retained (hours)."
  type        = number
  default     = 8
}

variable "backup_storage_redundancy" {
  description = "Storage redundancy for backups. One of: Local, Zone, Geo."
  type        = string
  default     = "Geo"
  validation {
    condition     = contains(["Local", "Zone", "Geo"], var.backup_storage_redundancy)
    error_message = "backup_storage_redundancy must be one of: Local, Zone, Geo."
  }
}

# Map-of-objects for DBs/containers
# Example in tfvars:
# databases = {
#   db1 = {
#     name = "app-db"
#     containers = {
#       ResumeContainer = {
#         partition_key_path    = "/applicant_id"
#         partition_key_version = 2
#         indexing_included     = ["/*"]
#         indexing_excluded     = ["/\"_etag\"/?"]
#       }
#     }
#   }
# }
variable "databases" {
  description = "Map of databases and their containers."
  type = map(object({
    name       = string
    containers = map(object({
      partition_key_path    = string
      partition_key_version = number
      indexing_included     = list(string)
      indexing_excluded     = list(string)
    }))
  }))
  default = {}
}
