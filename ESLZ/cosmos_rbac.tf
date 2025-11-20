# All fields required; must be set in cosmos-rbac.tfvars
variable "cosmos_rbac" {
  description = "Settings to grant a principal data-plane access to Cosmos."
  type = object({
    # Object ID of the principal (UMI or Service Principal)
    principal_object_id     = string

    # Role name to grant, e.g. "Cosmos DB Built-in Data Contributor"
    cosmos_data_role_name   = string
  })
}

resource "azurerm_role_assignment" "cosmos_data_role" {
  scope                = module.cosmos.account_id
  role_definition_name = var.cosmos_rbac.cosmos_data_role_name
  principal_id         = var.cosmos_rbac.principal_object_id
}

output "cosmos_data_role_id" {
  description = "ID of the Cosmos data-plane role assignment."
  value       = azurerm_role_assignment.cosmos_data_role.id
}
