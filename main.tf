resource "azurerm_cosmosdb_account" "this" {
  name                = var.account_name
  resource_group_name = var.rg_name
  location            = var.location

  kind       = "GlobalDocumentDB"
  offer_type = "Standard"

  automatic_failover_enabled    = var.automatic_failover_enabled
  public_network_access_enabled = var.public_network_access_enabled
  minimal_tls_version           = "TLS1_2"
  disable_local_auth            = var.disable_local_auth

  # Keep it simple: Session consistency (same as your draft)
  consistency_policy {
    consistency_level       = "Session"
    max_interval_in_seconds = 5
    max_staleness_prefix    = 100
  }

  # Primary write region
  geo_location {
    location          = var.location
    failover_priority = 0
  }

  # Optional serverless capability
  dynamic "capabilities" {
    for_each = var.enable_serverless ? [1] : []
    content {
      name = "EnableServerless"
    }
  }

  backup {
    type = "Periodic"
    periodic {
      interval_in_minutes = var.backup_interval_minutes
      retention_in_hours  = var.backup_retention_hours
      storage_redundancy  = var.backup_storage_redundancy
    }
  }

  tags = var.tags
}

# Key the databases by their declared name so containers can reference by name
locals {
  dbs_by_name = { for _, v in var.databases : v.name => v }
}

resource "azurerm_cosmosdb_sql_database" "db" {
  for_each            = local.dbs_by_name
  name                = each.key
  resource_group_name = var.rg_name
  account_name        = azurerm_cosmosdb_account.this.name
}

# Flatten all containers across DBs into a single map to iterate
locals {
  containers = merge([
    for db_name, db_def in local.dbs_by_name : {
      for c_name, c_def in db_def.containers : "${db_name}::${c_name}" => {
        db_name               = db_name
        container_name        = c_name
        partition_key_path    = c_def.partition_key_path
        partition_key_version = c_def.partition_key_version
        indexing_included     = c_def.indexing_included
        indexing_excluded     = c_def.indexing_excluded
      }
    }
  ]...)
}

resource "azurerm_cosmosdb_sql_container" "container" {
  for_each            = local.containers
  name                = each.value.container_name
  resource_group_name = var.rg_name
  account_name        = azurerm_cosmosdb_account.this.name
  database_name       = azurerm_cosmosdb_sql_database.db[each.value.db_name].name

  partition_key_path    = each.value.partition_key_path
  partition_key_version = each.value.partition_key_version

  indexing_policy {
    indexing_mode = "consistent"

    dynamic "included_path" {
      for_each = toset(each.value.indexing_included)
      content {
        path = included_path.value
      }
    }

    dynamic "excluded_path" {
      for_each = toset(each.value.indexing_excluded)
      content {
        path = excluded_path.value
      }
    }
  }
}
