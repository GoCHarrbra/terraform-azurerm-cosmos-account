cosmos = {
  rg_name      = "RGNAME"
  location     = "canadacentral"
  account_name = "AcctNamecosmosdb"

  tags = {
    owner    = "yours@your.com"
    purpose  = "app-data"
    env      = "sand1"
    division = "DIV1"
  }

  # Security & networking
  disable_local_auth            = true
  public_network_access_enabled = false

  # Resiliency & capacity
  automatic_failover_enabled = true
  enable_serverless          = true

  # Backups
  backup_interval_minutes   = 240
  backup_retention_hours    = 8
  backup_storage_redundancy = "Geo"  # Local | Zone | Geo

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
