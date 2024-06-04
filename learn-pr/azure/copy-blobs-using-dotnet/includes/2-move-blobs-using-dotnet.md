The .NET Storage Client library provides programmatic access to Azure Storage. Using this library, you can build custom apps that manipulate items in Azure Storage. This library provides the most flexible approach to uploading, downloading, and transferring blobs between storage accounts.

## Overview of the .NET Storage Client library

The .NET Storage Client library provides a series of objects and methods that you can use to build apps that access Azure storage. The library is available for several languages. This unit shows examples using C#.

The library is available as individual packages for the different storage products, for example Table, Blob, and so on. As this library supports cross-platform operation, you can run this library on your preferred operating system.

## Connect to Azure Blob Storage

The first task is to create a *service client* object for Azure Blob Storage by instantiating the `BlobServiceClient` class, which takes a connection string as a parameter. You can find the connection string for the storage account from the Azure portal.

The following code example shows how to perform this task. The relevant types are defined in several namespaces including `Azure`, `Azure.Storage.Blobs`, `Azure.Storage.Blobs.Models`, and `Azure.Storage.Sas`.

```C#
...

using Azure;
using Azure.Storage.Blobs;
using Azure.Storage.Blobs.Models;
using Azure.Storage.Sas;

...

// The variable sourceConnection is a string holding the connection string for the storage account
BlobServiceClient sourceClient = new BlobServiceClient(sourceConnection);

...
```

## Download a blob

To download a blob, you use the `BlobContainerClient` object to obtain a *blob container client* that has a reference to the container holding the blob. Through this container, you obtain a reference to the blob itself, called `BlobClient`. You can then invoke the `DownloadToAsync` method to fetch the contents of the blob to a local file.

The blob reference also provides access to the properties of the blob, such as its last modified date and creation date. The following code shows an example that downloads a blob named *MyBlob.doc* to a local file named *MyFile.doc*. The code also displays the last modified date for the blob.

```C#
...

// The variable sourceContainer is a string holding the container name
BlobContainerClient sourceBlobContainer = sourceClient.GetBlobContainerClient(sourceContainer);
sourceBlobContainer.CreateIfNotExists();

BlobClient sourceBlob = blobContainer.GetBlobClient("MyBlob.doc");
await sourceBlob.DownloadToAsync("MyFile.doc");

BlobProperties properties = (await sourceBlob.GetPropertiesAsync()).Value;
Console.WriteLine($"Last modified: {properties.LastModified}");

...
```

You can stream data from a large blob with the `DownloadStreamingAsync` method of your source blob object.

## Upload a blob

To create a new blob using a local file, the process is similar to downloading. Obtain a reference to the container that is to hold the blob and create a reference for your new blob. Specify the name for your new blob. You can then use the `UploadAsync` method to read data from a local file and copy it to the new blob. The following code shows an example of this approach.

```C#
...

// The variable destClient is a blob service client for the destination storage account
// The variable destContainer is a string holding the container name
BlobContainerClient destBlobContainer = destClient.GetBlobContainerClient(destContainer);
destBlobContainer.CreateIfNotExists();

BlobClient destBlob = destBlobContainer.GetBlobClient("NewBlob.doc");
await destBlob.UploadAsync("MyFile.doc");

...
```

You can also use the same method, `UploadAsync`, for large blob data streaming. In this case, use the stream object instead.

## Copy blobs between storage accounts

You can transfer blobs between storage accounts using a combination of the download and upload techniques previously illustrated. However, a more efficient approach is to make use of the blob copying facilities provided by the Azure Storage service. Copying a blob in this way transfers it directly from one container to another without requiring that you download it to an intermediate storage location.

The .NET Client library provides the `StartCopyFromUriAsync` method of a blob object to initiate copying the data in this blob to another blob in a destination container. You specify the destination blob using its URI. Additionally, because the data is transferred directly, you need to ensure that the Azure Storage service is provided with the appropriate access rights to the source blob. One way to supply this access is with a Shared Access Signature (SAS) token, as described previously in this module. You append the SAS token to the URI of the source blob.

The following example code shows how to use the `StartCopyFromUriAsync` method. The *sourceBlob* variable is a reference to a blob being copied. The code creates a reference to a new blob (*destBlob*) using the same name as the source blob. The `StartCopyFromUriAsync` method takes the URI of the blob to be copied and starts to transfer the data to the new destination blob. The `GetSharedAccessUri` method creates a URI containing a read-only SAS token for the source blob that is valid for 60 minutes.

```C#
...

// The variable sourceBlob is a blob client representing the source blob
BlobClient destBlob = destContainer.GetBlobClient(sourceBlob.Name);
CopyFromUriOperation ops = await destBlob.StartCopyFromUriAsync(GetSharedAccessUri(sourceBlob.Name, sourceContainer));

...

// Create a SAS token for the source blob, to enable it to be read by the StartCopyFromUriAsync method
private static Uri GetSharedAccessUri(string blobName, BlobContainerClient container)
{
    DateTimeOffset expiredOn = DateTimeOffset.UtcNow.AddMinutes(60);

    BlobClient blob = container.GetBlobClient(blobName);
    Uri sasUri = blob.GenerateSasUri(BlobSasPermissions.Read, expiredOn);

    return sasUri;
}
```

The `StartCopyFromUriAsync` method initiates the blob copy operation, and the process runs in the background. As the method returns the `CopyFromUriOperation` object, you can check on the progress of the operation by retrieving a reference to the destination blob and querying its `HasCompleted` property. The property has a value of `false` while the copy is in progress. Additionally, you can find out how many bytes were copied using the `WaitForCompletionAsync` method of the `CopyFromUriOperation` object.

The following code sample retrieves a reference to the destination blob and monitors the progress as the source blob is copied. The `WaitForCompletionAsync` method updates the *copied* variable with the number of bytes that are copied.

```C#
...

// Display the status of the blob as it is copied
while(ops.HasCompleted == false)
{
    long copied = await ops.WaitForCompletionAsync();

    Console.WriteLine($"Blob: {destBlob.Name}, Copied: {copied} of {properties.ContentLength}");
    await Task.Delay(500);
}

Console.WriteLine($"Blob: {destBlob.Name} Complete");

...
```

## Delete a blob

To remove a blob from a container, use one of the *Delete* methods of the blob object. There are two methods available, `DeleteAsync` and `DeleteIfExistsAsync`. Both methods delete the specified blob, but `DeleteIfExistsAsync` returns a boolean value indicating whether the blob actually existed before or not.

The following code uses `DeleteIfExistsAsync` to remove a blob, and detects whether the blob existed beforehand.

```C#
bool blobExisted = await sourceBlob.DeleteIfExistsAsync();
```

## Iterate blobs in a container

You can iterate through the blobs in a container with the `GetBlobsAsync` method of a blob container object. This method fetches the details of blobs as a collection.

The following code shows an example of this method:

```C#
...

// Iterate through the blobs in a container
List<BlobItem> segment = await blobContainer.GetBlobsAsync(prefix: "").ToListAsync();
foreach (BlobItem blobItem in segment)
{
    BlobClient blob = blobContainer.GetBlobClient(blobItem.Name);
    // Check the source file's metadata
    Response<BlobProperties> propertiesResponse = await blob.GetPropertiesAsync();
    BlobProperties properties = propertiesResponse.Value;
    
    // Check the last modified date and time
    // Add the blob to the list if has been modified since the specified date and time
    if (DateTimeOffset.Compare(properties.LastModified.ToUniversalTime(), transferBlobsModifiedSince.ToUniversalTime()) > 0)
    {
        blobList.Add(blob);
    }
}
...
```

The *prefix* parameter to `GetBlobsAsync` lets you find all blobs with names that have the specified prefix.
