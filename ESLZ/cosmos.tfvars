cosmos = {
  # Placement
  rg_name      = "RGNAME"
  location     = "canadacentral"
  account_name = "acctnamecosmosdb"      # must be globally unique

  tags = {
    owner    = "yours@your.com"
    purpose  = "app-data"
    env      = "sand1"
    division = "DIV1"
  }

  # Account shape
  kind                = "GlobalDocumentDB"
  offer_type          = "Standard"
  minimal_tls_version = "Tls12"

  # Security & networking
  disable_local_auth            = true        # AAD-only (maps to local_authentication_disabled)
  public_network_access_enabled = false

  #CKV Azure 132
  access_key_metadata_writes_enabled = false

  # Resiliency & capacity
  automatic_failover_enabled = true
  enable_serverless          = true
  additional_read_locations  = []            # e.g., ["canadaeast"] if you want a read region

  # Consistency
  consistency_level                 = "Session"  # Strong | BoundedStaleness | ConsistentPrefix | Eventual
  consistency_max_interval_seconds  = 5          # used for BoundedStaleness
  consistency_max_staleness_prefix  = 100        # used for BoundedStaleness

  # Backups (azurerm v4 flat shape)
  backup_type               = "Periodic"         # Periodic | Continuous7Days | Continuous30Days
  backup_interval_minutes   = 240                # Periodic only
  backup_retention_hours    = 8                  # Periodic only
  backup_storage_redundancy = "Geo"              # Local | Zone | Geo

  # Databases & containers
  databases = {
    app = {
      name = "app-db"
      containers = {
        ResumeContainer = {
          partition_key_path    = "/applicant_id"
          partition_key_version = 2
          indexing_included     = ["/*"]
          indexing_excluded     = ["/\"_etag\"/?"]
        }
      }
    }
  }
}


