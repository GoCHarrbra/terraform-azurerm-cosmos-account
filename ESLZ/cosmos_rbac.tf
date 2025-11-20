# cosmos_rbac.tf
#
# Grants a principal (UMI/SPN/user) the built-in Cosmos DB
# "Data Contributor" **data-plane** role for the account created
# by module.cosmos.

variable "cosmos_rbac" {
  description = "Settings to grant Cosmos SQL data-plane role to a principal."
  type = object({
    # Object ID of the principal (UMI/SPN/user) in Entra ID
    principal_id = string
  })
}

# Well-known GUID for built-in "Cosmos DB Built-in Data Contributor"
# This roleDefinition lives under the Cosmos account:
#   <account_id>/sqlRoleDefinitions/0000...0002
locals {
  cosmos_builtin_data_contributor_guid = "00000000-0000-0000-0000-000000000002"

  cosmos_data_contributor_role_id = "${module.cosmos.account_id}/sqlRoleDefinitions/${local.cosmos_builtin_data_contributor_guid}"
}

resource "azurerm_cosmosdb_sql_role_assignment" "data_contributor" {
  name = uuid()

  resource_group_name = module.cosmos.rg_name
  account_name        = module.cosmos.account_name

  # Data-plane role definition & scope
  role_definition_id = local.cosmos_data_contributor_role_id
  scope              = module.cosmos.account_id

  # Principal getting the data-plane permissions
  principal_id = var.cosmos_rbac.principal_id
}

output "cosmos_data_contributor_assignment_id" {
  description = "Cosmos SQL data-plane role assignment id."
  value       = azurerm_cosmosdb_sql_role_assignment.data_contributor.id
}
