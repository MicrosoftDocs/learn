In addition to retrieving properties, there are several ways to update metadata. You can use the Azure portal, command-line, and programmatic methods for reading and writing this data.

Using the chemical company scenario, you want to be able to identify whether a record has been included in a safety report, so you need to analyze the available methods for setting a flag on each document when it is retrieved.

In this unit, you will review the primary methods for setting this type metadata and the steps that are required to implement this functionality.

## Azure portal

Using the Azure portal, you can add and edit container and blob metadata.

1. Sign in to the [Azure portal](https://portal.azure.com), and click **Storage Accounts**.

1. Under **Blob service**, click **Blobs** and select a container.

1. On the left, click **Metadata**.

1. Enter a text string in the **KEY** and **VALUE** boxes, and then click **Save**.

1. On the left, click **Overview**.

1. Click a blob.

1. In the **Metadata** section, enter a text string in the **KEY** and **VALUE** boxes, and then click **Save**.

## Azure Powershell

You can use Powershell to add and edit metadata for containers and Blobs, and the commands that you use for viewing metadata are similar to the commands you used to view properties. A key thing to remember is that you must use the `SetMetadata()` method to write your changes to the container or blob.

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

In your project, import the `Microsoft.Azure.Storage.Blob` package using NuGet.

Add the following `using` directives to your code:

```csharp
using Microsoft.WindowsAzure.Storage;

using Microsoft.WindowsAzure.Storage.Blob;
```

The Azure SDK enables you to add metadata for `CloudBlockBlob` and `CloudBlobContainer` objects using the `Metadata.Add` and  `SetMetadataAsync` methods.

The following code shows how to use the `SetMetadataAsync` method to update the metadata for a container:

```csharp
public static async Task AddContainerMetadataAsync(CloudBlobContainer container)
{
    // Add metadata to the container
    cloudBlobContainer.Metadata.Add("docType", "safetyReports");
    // Save the updated container metadata
    await cloudBlobContainer.SetMetadataAsync();
}
```
The following code shows how to use the `SetMetadataAsync` method to update the metadata for a blob:

```csharp
public static async Task AddContainerMetadataAsync(CloudBlobContainer blob)
{
    // Add metadata to the blob
    cloudBlob.Metadata.Add("reportStatus", "included");
    // Save the updated blob metadata
    await cloudBlob.SetMetadataAsync();
}
```

For example, if you want to create a report covering all safety documents that have been issued recently, you could call this code for all blobs that have a `LastModified` date within the last three months.

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

```
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
