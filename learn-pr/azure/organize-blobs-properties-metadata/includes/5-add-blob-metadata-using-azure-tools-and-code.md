In addition to retrieving properties, there are several ways to update metadata. You can use the Azure portal, command-line, and programmatic methods for reading and writing this data.

Using the chemical company scenario, you want to be able to identify whether a record has been included in a safety report, so you need to analyze the available methods for setting a flag on each document when it is retrieved.

In this unit, you will review the primary methods for setting this type metadata and the steps that are required to implement this functionality.

## Azure portal

Using the Azure portal, you can add and edit container and blob metadata.

1. Sign in to the [Azure portal](https://portal.azure.com), and select **Storage Accounts**.

1. Under **Blob service**, select **Blobs** and select a container.

1. On the left, select **Metadata**.

1. Enter a text string in the **KEY** and **VALUE** boxes, and then select **Save**.

1. On the left, select **Overview**.

1. Select a blob.

1. In the **Metadata** section, enter a text string in the **KEY** and **VALUE** boxes, and then select **Save**.

## Azure PowerShell

You can use PowerShell to add and edit metadata for containers and Blobs, and the commands that you use for viewing metadata are similar to the commands you used to view properties. A key thing to remember is that you must use the `SetMetadata()` method to write your changes to the container or blob.

Here's an example set of commands for adding metadata for a blob called **hazard-tests.docx**, and for the blob's parent container called **safety-reports**:

```powershell
$Storage = "<StorageAccountName>"

$Key = "<StorageAccountKey>"

$ContainerName = "safety-reports"

$BlobName = "hazard-tests.docx"

$Context = New-AzStorageContext -StorageAccountName $Storage -StorageAccountKey $Key

$Blob = Get-AzStorageBlob -Context $Context -Container $ContainerName -Blob $BlobName

$Container = Get-AzStorageContainer -Context $Context -Container $ContainerName

#Add container metadata
$Container.CloudBlobContainer.Metadata["testStatus"] = "approved" 
$Container.CloudBlobContainer.Metadata.SetMetadata()

#Add blob metadata:
$Blob.ICloudBlob.Metadata["productClass"] = "acids"
$Blob.ICloudBlob.Metadata.SetMetadata()

```

## Azure CLI

You can also use Azure CLI to add and edit metadata for blobs and containers. Below are some main cmdlets you can use:

```azurecli
# Updates metadata for a blob
az storage blob metadata update

# Updates metadata for a container 
az storage container metadata update
```

When you update metadata, you are also overwriting any existing key-value pairs. So if you want to add metadata, rather than replacing existing data, you must first save the current metadata.

The following example updates the metadata of a container called **safety-reports**, in the **treyresearch** storage account:

```azurecli
az storage container metadata update \
    --name safety-reports \
    --account-name treyresearch \
    --metadata productClass=acids testStatus=approved
```

The following example updates the metadata stored with the **hazard-tests.docx** blob:

```azurecli
az storage blob metadata update \
    --container-name safety-reports \
    --name hazard-tests.docx \
    --account-name treyresearch \ 
    --metadata productType=solvent state=liquid
```

## C# (.NET)

In your project, import the `Azure.Storage.Blobs` package using NuGet.

Add the following `using` directives to your code:

```csharp
using Azure;
using Azure.Storage.Blobs;
using Azure.Storage.Blobs.Models;
```

The Azure SDK enables you to add metadata for `CloudBlockBlob` and `CloudBlobContainer` objects using the `Metadata.Add` and  `SetMetadataAsync` methods.

The following code shows how to use the `SetMetadataAsync` method to update the metadata for a container:

```csharp
public static async Task AddContainerMetadataAsync(BlobContainerClient blobContainerClient)
{
    Response<BlobContainerProperties> response = await blobContainerClient.GetPropertiesAsync();
    IDictionary<string, string> metadata = response.Value.Metadata;

    // Add metadata to the container
    metadata.Add("docType", "safetyReports");

    // Save the updated container metadata
    await blobContainerClient.SetMetadataAsync(metadata);
}
```

The following code shows how to update the metadata for each blob in a container.  A `BlobClient` object is created for each blob and the `SetMetadataAsync` method is used to update the metadata for a blob:

```csharp
public static async Task AddBlobMetadataAsync(BlobContainerClient blobContainerClient)
{
    AsyncPageable<BlobItem> blobs = blobContainerClient.GetBlobsAsync(BlobTraits.Metadata);
    await foreach (var blobItem in blobs)
    {
        // Get the current metadata for the blob
        IDictionary<string, string> metadata = blobItem.Metadata;

        // Add a value to the metadata for the blob
        metadata.Add("reportStatus", "included");

        // You need a BlobClient object to update the metadata for a blob
        BlobClient blobClient = blobContainerClient.GetBlobClient(blobItem.Name);
        await blobClient.SetMetadataAsync(metadata);
    }
}
```

For example, if you want to create a report covering all safety documents that have been issued recently, you could modify this code to set a status flag for all blobs that have a `LastModified` date within the last three months.

## REST

Using the REST API you can retrieve properties and metadata using HTTP PUT requests.

For a container, use this syntax:

```
PUT https://myaccount.blob.core.windows.net/mycontainer?restype=container&comp=metadata
```

In the list of HTTP headers, you would include the following header:

```http
x-ms-meta-<name>:<value>
```

For example:

```http
x-ms-meta-docType:safetyReports
```

For a blob, use this syntax:

```http
PUT https://myaccount.blob.core.windows.net/mycontainer/myblob?comp=metadata
```

In the list of HTTP headers, you would include the following header:

```http
x-ms-meta-<name>:<value>
```

For example:

```http
x-ms-meta-productStatus:obsolete
```

In the next unit, you will use the knowledge you have gained in this unit to set and retrieve metadata.
