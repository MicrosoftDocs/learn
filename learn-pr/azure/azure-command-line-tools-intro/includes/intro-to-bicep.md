# Bicep

Bicep is a domain-specific language (DSL) that uses declarative syntax to deploy Azure resources. In
a Bicep file, you define the infrastructure you want to deploy to Azure, and then use that file
throughout the development lifecycle to deploy your infrastructure. Your resources are deployed in a
consistent manner.

Bicep provides concise syntax, reliable type safety, and support for code reuse. Bicep offers a
first-class authoring experience for your infrastructure-as-code solutions in Azure.

## Create a storage account

The following code can be used to create a Bicep template for provisioning an Azure storage account:

```Bicep
resource storageAccount 'myStorageAccount' = {
    name: '<storage-account-name>'
    location: 'eastus'
    resourceGroupName: '<resource-group-name>'
    accountKind: 'StorageV2'
    sku: {
        name: 'Standard_RAGRS'
    }
}
```

To deploy Bicep templates, use the Azure CLI or Azure PowerShell as shown in the following examples.
After the command is executed, the deployment begins and the resources are created in the specified
resource group.


# [Azure CLI](#tab/azurecli)

```azurecli
az deployment group create --resource-group <resource-group-name> --template-file <bicep-template-file>
```

# [Azure PowerShell](#tab/azurepowershell)

```azurepowershell
New-AzResourceGroupDeployment -TemplateFile <bicep-template-file> -ResourceGroupName <resource-group-name>
```

---

## Verify the storage account

To verify an Azure storage account exists, use the Azure CLI or Azure PowerShell as shown in the
following examples.

# [Azure CLI](#tab/azurecli)

```azurecli
az storage account show --resource-group <resource-group-name> --name <storage-account-name>
```

# [Azure PowerShell](#tab/azurepowershell)

```azurepowershell
Remove-AzStorageAccount -ResourceGroupName <resource-group-name> -Name <storage-account-name>
```

---

## Remove the storage account

To remove an Azure storage account, use the Azure CLI or Azure PowerShell as shown in the following
examples.

# [Azure CLI](#tab/azurecli)

```azurecli
az storage account delete --name <storage-account-name>
```

# [Azure PowerShell](#tab/azurepowershell)

```azurepowershell
Remove-AzStorageAccount -ResourceGroupName <resource-group-name> -Name <storage-account-name>
```

---