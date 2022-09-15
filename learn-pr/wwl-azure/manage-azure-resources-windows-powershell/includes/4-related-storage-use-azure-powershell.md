You can use Azure PowerShell to manage Azure-related storage. Before you start managing your storage, you should first create a storage account, if you don't have one. Usually, storage accounts are created automatically when you create other Azure resources such as Azure virtual machines (VMs).

You can create a standard, general-purpose storage account with locally redundant storage (LRS) replication by using **New-AzStorageAccount**. Next, get the storage account context that defines the storage account you want to use. When acting on a storage account, reference the context, instead of repeatedly passing in the credentials. Use the following example to create a storage account called **mystorageaccount** with LRS and blob encryption, which is enabled by default.

```powershell
$storageAccount = New-AzStorageAccount -ResourceGroupName $resourceGroup `
  -Name "mystorageaccount" `
  -SkuName Standard_LRS `
  -Location $location `

$ctx = $storageAccount.Context
```

Blobs are always uploaded into a container. You can organize groups of blobs the way you organize your files on your computer in folders.

Set the container name, and then create the container by using **New-AzStorageContainer**. Set the blob permissions to allow public access of the files. The container name in the following example is **quickstartblobs**.

```powershell
$containerName = "quickstartblobs"
New-AzStorageContainer -Name $containerName -Context $ctx -Permission blob
```

You can use the **Set-AzStorageAccount** cmdlet to modify an Azure Storage account. You can use this cmdlet to modify the account type, update a customer domain, or set tags on a Storage account.

For example, to set the storage account type you should use the following command:

```powershell
Set-AzStorageAccount -ResourceGroupName "MyResourceGroup" -AccountName "mystorageaccount" -Type "Standard_RAGRS"
```

To set custom domain for existing storage account, you can use the following command:

```powershell
Set-AzStorageAccount -ResourceGroupName "MyResourceGroup" -AccountName "mystorageaccount" -CustomDomainName "www.contoso.com" -UseSubDomain $True
```

> **Additional reading:** To learn more about the available cmdlets for managing Azure storage, refer to [Az.Storage](https://aka.ms/az-storage-2).
