cosmos_rbac = {
  # UMI or SP object ID you want to test
  # UMI example:
  #   az identity show -g <rg> -n <umi-name> --query principalId -o tsv
  # SP example:
  #   az ad sp show --id <appId> --query id -o tsv
  principal_id = ""

  # Data-plane role
  cosmos_data_role_name = "Cosmos DB Built-in Data Contributor"
}
