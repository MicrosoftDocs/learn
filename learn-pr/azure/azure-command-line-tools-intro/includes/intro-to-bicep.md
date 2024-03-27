In
a Bicep file, you define the infrastructure that you want to deploy to Azure. You then use that file
throughout the development lifecycle to deploy your infrastructure.

## Create a resource group

Before you create a storage account, you need to create a resource group or use an existing one.

Create an Azure resource group named `storageaccountexamplerg` in the `eastus` region:

# [Azure CLI](#tab/azurecli)

```azurecli
az group create --name storageaccountexamplerg --location eastus
```

# [Azure PowerShell](#tab/azurepowershell)

```azurepowershell
New-AzResourceGroup -Name storageaccountexamplerg -Location eastus
```

---

## Create a storage account

Use the following code to create a Bicep file for provisioning an Azure storage account:

```Bicep
@description('Specifies the name for resources.')
param storageAccountName string = 'storage${uniqueString(resourceGroup().id)}'


@description('Specifies the location for resources.')
param location string = resourceGroup().location

resource myStorageAccount 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: storageAccountName
  location: location
  kind: 'StorageV2'
  sku: {
      name: 'Standard_RAGRS'
  }
}
```

If you want to customize the storage account name, remember that it must be 3 to 24
characters in length and can contain numbers and lowercase letters only. Your storage account name
must be unique within Azure.

To deploy Bicep files, use the Azure CLI or Azure PowerShell as shown in the following examples.
After you run the command, the deployment begins and the resources are created in the specified
resource group.

# [Azure CLI](#tab/azurecli)

```azurecli
az deployment group create --resource-group storageaccountexamplerg --template-file <bicep-file>
```

# [Azure PowerShell](#tab/azurepowershell)

```azurepowershell
New-AzResourceGroupDeployment -ResourceGroupName storageaccountexamplerg -TemplateFile <bicep-file>
```

---

## Verify the storage account

To verify that an Azure storage account exists, use the Azure CLI or Azure PowerShell as shown in the
following examples:

# [Azure CLI](#tab/azurecli)

```azurecli
az storage account list --resource-group storageaccountexamplerg
```

# [Azure PowerShell](#tab/azurepowershell)

```azurepowershell
Get-AzStorageAccount -ResourceGroupName storageaccountexamplerg
```

---

## Clean up resources

Deleting a resource group deletes the resource group and all resources
that it contains. If resources outside the scope of the storage account that you created in this unit
exist in the `storageaccountexamplerg` resource group, they're also deleted.

# [Azure CLI](#tab/azurecli)

```azurecli
az group delete --name storageaccountexamplerg
```

# [Azure PowerShell](#tab/azurepowershell)

```azurepowershell
Remove-AzResourceGroup -Name storageaccountexamplerg
```

---
