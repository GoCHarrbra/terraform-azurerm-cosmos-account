provider "azurerm" {
  features {}
  # Use AAD auth for the azurerm backend/provider; subscription is provided via ARM_* env (Terragrunt/pipeline)
  storage_use_azuread = true
}
