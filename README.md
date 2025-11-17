# terraform-azurerm-cosmos-account

This repository contains Terraform configuration to create and manage an Azure Cosmos DB account using the azurerm provider. This README provides quickstart steps to develop, test, and deploy the Terraform code using Visual Studio Code (VS Code).

> Adjust provider versions, resource names, and configuration to match your environment and organizational policies.

## Table of contents
- What this repo contains
- Prerequisites
- Quickstart (local)
- Environment variables and secrets
- Recommended VS Code setup
- Useful VS Code tasks
- Troubleshooting & tips
- Contributing

## What this repo contains
- Terraform code to provision and configure an Azure Cosmos DB account (database account, databases/containers, keys, throughput, etc.)
- Example variable files and module usage (if present)
- Optional backend configuration examples for remote state

## Prerequisites
- Terraform CLI (recommended >= 1.4.x)
- Azure CLI (az) for authentication and management
- An Azure subscription with permissions to create Cosmos DB and related resources
- (Optional) A service principal for automation: az ad sp create-for-rbac --name "tf-cosmos-sp" --role="Contributor" --scopes="/subscriptions/<SUBSCRIPTION_ID>"

## Quickstart (local)
1. Clone the repo
   - git clone https://github.com/GoCHarrbra/terraform-azurerm-cosmos-account.git
   - cd terraform-azurerm-cosmos-account

2. Authenticate to Azure
   - For interactive development: az login
   - For CI / non-interactive: set ARM_* environment variables for a service principal (see below)

3. Initialize Terraform
   - terraform init

4. Format and validate
   - terraform fmt -recursive
   - terraform validate

5. Plan and apply
   - terraform plan -out=tfplan -var-file="example.tfvars"
   - terraform apply "tfplan"

6. Destroy (when needed)
   - terraform destroy -var-file="example.tfvars"

## Environment variables and secrets
Set these environment variables for non-interactive authentication (do not commit secrets):
- ARM_SUBSCRIPTION_ID
- ARM_TENANT_ID
- ARM_CLIENT_ID
- ARM_CLIENT_SECRET

Example (bash):
export ARM_SUBSCRIPTION_ID="your-sub-id"
export ARM_TENANT_ID="your-tenant-id"
export ARM_CLIENT_ID="your-sp-client-id"
export ARM_CLIENT_SECRET="your-sp-client-secret"

## Recommended VS Code setup
Install these extensions:
- HashiCorp Terraform (hashicorp.terraform)
- Azure Account (ms-vscode.azure-account)
- Azure Tools (ms-vscode.vscode-azureextensionpack)
- GitLens (eamodio.gitlens)

.vscode/settings.json suggestions:
{
  "editor.formatOnSave": true,
  "files.trimTrailingWhitespace": true,
  "files.insertFinalNewline": true,
  "terraform.formatOnSave": true
}

## Useful VS Code tasks
Add tasks in .vscode/tasks.json to run common Terraform commands from the Command Palette. Example tasks: terraform fmt, init, validate, plan, apply, destroy.

## Troubleshooting & tips
- Pin azurerm provider versions in required_providers if you encounter compatibility issues.
- Use terraform state commands to inspect state when debugging.
- Configure Private DNS zones for Private Endpoint scenarios so the Cosmos DB hostname resolves.
- Use Azure Key Vault or CI secret stores for sensitive values.

## Contributing
- Open issues or PRs for improvements.
- Create feature branches, add tests where applicable, and include documentation updates.

## License
Add a LICENSE file or include your license information here.
