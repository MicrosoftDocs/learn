You can configure and manage Azure Storage in code. This means you can create your own apps to take advantage of storage tiers.

Using the manufacturing-company example, you'd now like to plan for creating some custom applications to manage your documentation lifecycle.

In this unit, you'll compare the methods for configuring and managing storage tiers using several programming environments. You don't need to execute any of the steps in this unit; you'll do that in the next unit.

## C# (.NET)

In your project, import the **Azure.Storage.Blobs** package using NuGet.

Add the following **using** directives to your code:

```csharp
using Azure;
using Azure.Storage.Blobs;
using Azure.Storage.Blobs.Models;
```

The Azure SDK allows you to list all of the blobs in a blob container along with the properties of each blob, including the storage tier.

The following code shows how to use the `GetBlobsAsync` method on `BlobClientContianer` to get a collection of `BlobItem` objects.  The `BlobItem` object encapsulates the properties of the blob in Azure storage, but doesn't contain the actual blob data.

```csharp
AsyncPageable<BlobItem> blobItems = blobContainerClient.GetBlobsAsync();

await foreach (var blobItem in blobItems)
{
    Console.WriteLine($"Blob name {blobItem.Name}:   Tier {blobItem.Properties.AccessTier}");
}
```

If you're only interested in the storage tier of a single blob and know the name of the blob, you can use the `GetPropertiesAsync` method on a `BlobClient` object that returns the blob's properties, including the storage tier.

```csharp
BlobClient blobClient = blobContainerClient.GetBlobClient(blobName);

Response<BlobProperties> response = await blobClient.GetPropertiesAsync();
BlobProperties blobProperties = response.Value;
string accessTier = blobProperties.AccessTier?.ToString();

Console.WriteLine($"Blob name: {blobName}  Access tier: {accessTier}");
```

To change a blob's storage tier programmatically, use the `SetAccessTier` method on the `BlobClient` class.

```csharp
BlobClient blobClient = blobContainerClient.GetBlobClient(blobName);
blobClient.SetAccessTier(AccessTier.Cool);
```

## REST

The REST API provides the **Set Blob Tier** operation on a block blob. This operation is an HTTP PUT request with the following format:

`https://myaccount.blob.core.windows.net/mycontainer/myblob?comp=tier`

The `tier` parameter is **Archive**, **Cold**, **Cool**, or **Hot**.

To retrieve the storage tier of a block blob, use the **Get Blob Properties** operation. This is an HTTP HEAD request (the contents of the blob are not returned, only a response header):

`https://myaccount.blob.core.windows.net/mycontainer/myblob`

The **x-ms-access-tier** response header specifies the storage tier of the blob.
