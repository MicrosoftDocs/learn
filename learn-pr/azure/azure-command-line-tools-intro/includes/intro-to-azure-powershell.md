Azure PowerShell is a collection of modules for managing Azure resources directly from PowerShell.
PowerShell provides automation features that you can use to manage your Azure
resources.

The Az PowerShell module is based on .NET Standard. It works with PowerShell 7.x or later on all
operating systems. It's also compatible with Windows PowerShell 5.1.

You can install the Az PowerShell module locally on Windows, Linux, and macOS. You can also use it
from a web browser through Azure Cloud Shell or inside a Docker container.

## Prerequisites

Because your company already uses Azure, you have an active Azure subscription. You're using
PowerShell in Azure Cloud Shell.

## Create a resource group

Before you create a storage account, you need to create a resource group or use an existing one.

Create an Azure resource group named `storageaccountexamplerg` in the `eastus` region by using the
`New-AzResourceGroup` cmdlet:

```azurepowershell
New-AzResourceGroup -Name storageaccountexamplerg -Location eastus
```

## Create a storage account

Storage account names must
be 3 to 24 characters in length and can contain numbers and lowercase letters only. Your
storage account name must be unique within Azure.

Use the `Get-AzStorageAccountNameAvailability` cmdlet to verify that the name that you chose for
your storage account is valid and not already in use:

```azurepowershell
Get-AzStorageAccountNameAvailability -Name <storage-account-name>
```

Use the `New-AzStorageAccount` cmdlet to create a new Azure storage account. The mandatory
parameters are **Name**, **ResourceGroupName**, **Location**, and **SkuName**. The **Kind**
parameter is optional and defaults to `StorageV2` when it's not specified.

```azurepowershell
New-AzStorageAccount -Name <storage-account-name> -ResourceGroupName storageaccountexamplerg -Location eastus -SkuName Standard_RAGRS
```

## Verify the storage account

You use the `Get-AzStorageAccount` cmdlet to verify that a storage group exists. There are no
mandatory parameters. Use the **ResourceGroupName** parameter to return only storage accounts in a
specific resource group. Use the **Name** and **ResourceGroupName** parameters to return only a
specific storage account.

```azurepowershell
Get-AzStorageAccount -Name <storage-account-name> -ResourceGroupName storageaccountexamplerg
```

## Clean up resources

Use the `Remove-AzResourceGroup` cmdlet to delete a resource group. The only mandatory parameter is **Name**. Deleting a resource group deletes the group and all resources
that it contains. If resources outside the scope of the storage account that you created in this unit
exist in the `storageaccountexamplerg` resource group, they're also deleted.

```azurepowershell
Remove-AzResourceGroup -Name storageaccountexamplerg
```

Use the `Remove-AzStorageAccount` cmdlet to remove a storage account. The mandatory
parameters are **Name** and **ResourceGroupName**.

```azurepowershell
Remove-AzStorageAccount -Name <storage-account-name> -ResourceGroupName storageaccountexamplerg
```
