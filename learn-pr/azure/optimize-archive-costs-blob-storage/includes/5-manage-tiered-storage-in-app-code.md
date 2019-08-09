Azure Storage can be configured and managed in code. This means you can create your own apps to take advantage of storage tiers.

Using the manufacturing company example, you'd now like to plan for creating some custom applications to manage your documentation lifecycle.

In this unit, you'll compare the methods for configuring and managing storage tiers using several programming environments.

## C# (.NET)

In your project, import the **Microsoft.Azure.Storage.Blob** package using NuGet.

Add the following **using** directives to your code:

```csharp
using Microsoft.WindowsAzure.Storage;

using Microsoft.WindowsAzure.Storage.Blob;
```

The Azure SDK enables you to set the storage tier for a **CloudBlockBlob** object using the **SetStandardBlobTier** method. You can set the tier to **StandardBlobTier.Archive**, **StandardBlobTier.Cool**, or **StandardBlobTier.Hot**.

The following code shows how to retrieve a blob from a blob container and change the storage tier:

```csharp
CloudBlockBlob blob1 = cloudBlobContainer.GetBlockBlobReference(blobName);

blob1.SetStandardBlobTier(StandardBlobTier.Cool);
```

When switching a blob from the Archive tier, the **SetStandardBlobTier** method runs asynchronously. It can actually take several hours for a blob that was previously in the Archive tier to be rehydrated and moved to the Cool or Hot tiers.

To view the storage tier for a **CloudBlockBlob** object, read the **StandardBlobTier** property in the Properties collection of the object. This property will be one of **Archive**, **Cool**, or **Hot**. The following code shows an example:

```csharp
CloudBlockBlob blob1 = cloudBlobContainer.GetBlockBlobReference(blobName);

Console.WriteLine(@"Blob name {0}: Tier {1}", blob1.Name, blob1.Properties.StandardBlobTier);
```

## REST

The REST API provides the **Set Blob Tier** operation on a block blob. This operation is an HTTP PUT request with the following format:

`https://myaccount.blob.core.windows.net/mycontainer/myblob?comp=tier`

The `tier` parameter is **Archive**, **Cool**, or **Hot**.

To retrieve the storage tier of a block blob, use the **Get Blob Properties** operation. This is an HTTP HEAD request (the contents of the blob are not returned, only a response header):

`https://myaccount.blob.core.windows.net/mycontainer/myblob`

The **x-ms-access-tier** response header specifies the storage tier of the blob.

## Java

The Azure SDK for Java provides similar functionality. You need to import the `com.microsoft.azure.storage.blob` package.

You can set the storage tier when you create a new **CloudBlockBlob**:

```java
CloudBlockBlob blob1 = cloudBlobContainer.getBlockBlobReference(blobName);

blob1.uploadStandardBlobTier(StandardBlobTier.COOL);
```

You can also read and modify the storage tier using the **getStandardBlobTier** and **setStandardBlobTier** methods of the blob's **BlobProperties** collection:

```java
CloudBlockBlob blob1 = cloudBlobContainer.getBlockBlobReference(blobName);

blob1.getProperties().getStandardBlobTier(); /* retrieve the current tier */

blob1.getProperties().setStandardBlobTier(StandardBlobTier.COOL); /* modify the tier */
```
