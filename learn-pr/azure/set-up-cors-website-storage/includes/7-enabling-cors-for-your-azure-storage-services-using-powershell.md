Using the REST API or the Azure CLI to configure CORS for Azure storage are two ways to configure CORS for your storage resources. However, in the utilities company scenario, one of your IT teams has extensive experience using PowerShell to manage their assets. With that in mind, you decide to examine how to enable CORS using PowerShell.

In this unit, you'll learn how to use PowerShell to enable CORS for Azure storage.

## Enable CORS using PowerShell

Use the `Set-AzureStorageCORSRule` cmdlet to enable CORS rules for a storage account. This cmdlet sets the CORS rules for a single type of Azure Storage service, and overwrites any existing rules. The storage service types are Blob, Table, Queue, and File.

The format of this command is:

```PowerShell
Set-AzureStorageCORSRule
   [-ServiceType] <StorageServiceType>
   -CorsRules <PSCorsRule[]>
   [-PassThru]
   [-Context <IStorageContext>]
   [-ServerTimeoutPerRequest <Int32>]
   [-ClientTimeoutPerRequest <Int32>]
   [-DefaultProfile <IAzureContextContainer>]
   [-ConcurrentTaskCount <Int32>]
   [<CommonParameters>]
```

The important parameters for this command are listed in :

| Parameter | Description |
|---|---|
| `-Context` | This parameter specifies an Azure Storage context. To obtain a context, use the `New-AzureStorageContext` cmdlet. |
| `-CorsRules` | This parameter specifies  an array of CORS rules to apply to the storage account. You can retrieve the existing rules using the `Get-AzureStorageCORSRule` cmdlet. |
| `-ServiceType` | This parameter specifies the Azure Storage service type for which this cmdlet assigns rules. The acceptable values for this parameter are: <ul><li>Blob</li><li>Table</li><li>Queue</li><li>File</li></ul> |

The example below enables CORS for the blob storage account specified by *&lt;account-name&gt;*. The CORS rule permits HTTP GET and PUT requests from the `www.fabrikam.com` and `www.contoso.com` domains.

```PowerShell
$context = New-AzureStorageContext -StorageAccountName <account-name> -StorageAccountKey <key>

$CorsRules = (@{
    AllowedHeaders=@("x-ms-blob-content-type","x-ms-blob-content-disposition");
    AllowedOrigins=@("http://www.fabrikam.com","http://www.contoso.com");
    MaxAgeInSeconds=30;
    AllowedMethods=@("Put","Get")})

Set-AzureStorageCORSRule -ServiceType Blob -CorsRules $CorsRules -Context $context
```

Another useful command is `Get-AzureStorageCORSRule`, which allows you to view the CORS rules that have been set for a Storage service type.

The following example lists the CORS rules for the same storage account that you used in the previous example:

```PowerShell
Get-AzureStorageCORSRule -Context $context -ServiceType Blob
```

## Clear CORS rules using PowerShell

Use the `Remove-AzureStorageCORSRule` cmdlet to remove the CORS rules for a storage account.

The format of this command is:

```PowerShell
Remove-AzureStorageCORSRule
   [-ServiceType] <StorageServiceType>
   [-Context <IStorageContext>]
   [-ServerTimeoutPerRequest <Int32>]
   [-ClientTimeoutPerRequest <Int32>]
   [-DefaultProfile <IAzureContextContainer>]
   [-ConcurrentTaskCount <Int32>]
   [<CommonParameters>]
```

The important parameters for this command are listed in :

| Parameter | Description |
|---|---|
| `-Context` | This parameter specifies an Azure Storage context. To obtain a context, use the `New-AzureStorageContext` cmdlet. |
| `-ServiceType` | This parameter specifies the Azure Storage service type for which this cmdlet assigns rules. The acceptable values for this parameter are: <ul><li>Blob</li><li>Table</li><li>Queue</li><li>File</li></ul> |
