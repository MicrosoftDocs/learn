In the utilities company scenario, you would like to leverage your IT team's existing PowerShell knowledge, and you have decided to investigate how you can use PowerShell to manage your CORS settings for Azure Storage Services resources

In this exercise, you'll learn how to use PowerShell to enable CORS for Azure storage.

[!include[](../../../includes/azure-sandbox-activate.md)]

## Enable CORS using PowerShell

1. Run the following commands in the Cloud Shell to set environment variables that you will use with later cmdlets; these variables specify the name of Azure storage account, a storage container name, the name of the closest geographical region, and the name resource group that was created when you activated your sandbox account.

   ```powershell
   $storageAccountName = "<account name from previous exercise>"
   $resourceGroup = "<rgn>[sandbox resource group name]</rgn>"
   $storageAccount = Get-AzStorageAccount -ResourceGroupName $resourceGroup -Name $storageAccountName
   ```

1. Run the following command to retrieve an account key for your storage account.

   ```powershell
   $storageAccountKey = (Get-AzStorageAccountKey -ResourceGroupName $resourceGroup -Name $storageAccountName).Value[0]
   ```

1. Run the following commands to add a CORS rule to your blob service.

   ```powershell
   $context = New-AzureStorageContext -StorageAccountName "$storageAccountName" -StorageAccountKey "$storageAccountKey"

   $CorsRules = (@{
      AllowedHeaders=@("x-ms-blob-content-type","x-ms-blob-content-disposition");
      AllowedOrigins=@("http://www.fabrikam.com","http://www.contoso.com");
      MaxAgeInSeconds=30;
      AllowedMethods=@("Put","Get")})

   Set-AzureStorageCORSRule -ServiceType Blob -CorsRules $CorsRules -Context $context
   ```
1. Run the following cmdlet to verify that your CORS rule has been added to your blob service.

   ```powershell
   Get-AzureStorageCORSRule -Context $context -ServiceType Blob
   ```
   You should see a response that resembles the following output.
   ```
   AllowedOrigins  : {http://www.fabrikam.com, http://www.contoso.com}
   AllowedHeaders  : {x-ms-blob-content-type, x-ms-blob-content-disposition}
   ExposedHeaders  : {}
   AllowedMethods  : {Get, Put}
   MaxAgeInSeconds : 30
   ```

## Clear CORS rules using PowerShell

 1. Run the following cmdlet to list your existing CORS rules; you should see the rule that you added in the previous section of this exercise.

   ```powershell
   Get-AzureStorageCORSRule -Context $context -ServiceType Blob
   ```

 1. Run the following cmdlet to clear all of your CORS rules.

   ```powershell
   Remove-AzureStorageCORSRule -Context $context -ServiceType Blob
   ```

 1. Run the following cmdlet to verify that your CORS rules have been removed from your blob service.

   ```powershell
   Get-AzureStorageCORSRule -Context $context -ServiceType Blob
   ```
   You should see an empty response from the cmdlet.
