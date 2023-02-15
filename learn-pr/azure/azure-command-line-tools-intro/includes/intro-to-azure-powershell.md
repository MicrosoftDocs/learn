# Azure PowerShell

Azure PowerShell is a collection of modules for managing Azure resources directly from PowerShell.
PowerShell provides powerful features for automation that can be leveraged for managing your Azure
resources.

The Az PowerShell module is based on .NET Standard, and works with PowerShell 7.x or higher on all
platforms including Windows, Linux, and macOS. It's also compatible with Windows PowerShell 5.1.

You can install the Az PowerShell module locally on Windows, Linux, and macOS. It can also be used
from a browser through Azure Cloud Shell or inside a Docker container.


## Prerequisites

Since your company already uses Azure, you have an active Azure subscription and you're using
PowerShell in Azure Cloud Shell.

## Create a resource group

Before creating a storage account, you need to create a resource group for your Azure storage
account or use an existing resource group. A resource group is a logical container in which Azure
resources are deployed and managed as a group.

Create an Azure resource group named **storageaccountexamplerg** in the **eastus** region using the
`New-AzResourceGroup` cmdlet.

```azurepowershell
New-AzResourceGroup -Name storageaccountexamplerg -Location eastus
```

## Create a storage account

A storage account is an Azure resource and is part of a resource group. Storage account names must
be between 3 and 24 characters in length and may contain numbers and lowercase letters only. Your
storage account name must be unique within Azure. No two storage accounts can have the same name.

The `Get-AzStorageAccountNameAvailability` cmdlet is used to verify that the name you've chosen for
your storage account is valid and not already in use.

```azurepowershell
Get-AzStorageAccountNameAvailability -Name <storage-account-name>
```

The `New-AzStorageAccount` cmdlet is used to create a new Azure storage account. The mandatory
parameters include **Name**, **ResourceGroupName**, **Location**, and **SkuName**. The **Kind**
parameter is optional and defaults to `StorageV2` when not specified.

```azurepowershell
New-AzStorageAccount -Name <storage-account-name> -ResourceGroupName storageaccountexamplerg -Location eastus -SkuName Standard_RAGRS
```

## Verify the storage account

The `Get-AzStorageAccount` cmdlet is used to verify that a storage group exists. There are no
mandatory parameters. Use the **ResourceGroupName** parameter to return only storage accounts in a
specific resource group or the **Name** and **ResourceGroupName** parameters to return only a
specific storage account.

```azurepowershell
Get-AzStorageAccount -Name <storage-account-name> -ResourceGroupName storageaccountexamplerg
```

## Clean up resources

The `Remove-AzResourceGroup` cmdlet is used to delete a resource group. **Name** is the only
mandatory parameter. Deleting a resource group deletes the resource group and all resources
contained within it. If resources outside the scope of the storage account created in this unit
exist in the **storageaccountexamplerg** resource group, they will also be deleted.

```azurepowershell
Remove-AzResourceGroup -Name storageaccountexamplerg
```

The `Remove-AzStorageAccount` cmdlet is used to remove a storage account. The mandatory
parameters include **Name** and **ResourceGroupName**.

```azurepowershell
Remove-AzStorageAccount -Name <storage-account-name> -ResourceGroupName storageaccountexamplerg
```