The .NET Storage Client library provides programmatic access to Azure Storage. Using this library, you can build custom apps that manipulate items in Azure Storage. This library provides the most flexible approach to uploading, downloading, and transferring blobs between storage accounts.

## Overview of the .NET Storage Client library

The .NET Storage Client library provides a series of objects and methods that you can use to build apps that access Azure storage. The library is available for several languages. This unit shows examples using C#.

The library is available as individual packages for the different storage products, for example Table, Blob, and so on. Two versions are available, one for the .NET Framework, and a version for .NET Core apps.

## Connect to Azure storage

The first task is to connect to Azure Storage itself. A common way to connect is to use the `Parse` method on the`CloudStorageAccount` class; this method takes a connection string. You can find the connection string for a storage account using the Azure portal.

Next, create a *client* object. If you're using blob storage, you create a `CloudBlobClient` object. You create a client with the `CreateCloudBlobClient` method of your storage account connection object.

The following code example shows how to perform these tasks. The relevant types are defined in the `Microsoft.Azure.Storage` and `Microsoft.Azure.Storage.Blob` namespaces.

```C#
using Microsoft.WindowsAzure.Storage;
using Microsoft.WindowsAzure.Storage.Blob;

...

// The variable sourceConnection is a string holding the connection string for the storage account
CloudStorageAccount sourceAccount = CloudStorageAccount.Parse(sourceConnection);
CloudBlobClient sourceClient = sourceAccount.CreateCloudBlobClient();
```

## Download a blob

To download a blob, you obtain a reference to the container holding the blob using your `CloudBlobClient` object. Using this container, you obtain a reference to the blob itself. You can then invoke the `DownloadToFileAsync` method to fetch the contents of the blob to a local file. The blob reference also provides access to properties and other details for the blob, such as its last modified date and creation date. The following code shows an example that downloads a blob named *MyBlob.doc* to a local file named *MyFile.doc*. The code also displays the last modified date for the blob.

```C#
CloudBlobContainer sourceBlobContainer = sourceClient.GetContainerReference(sourceContainer);
ICloudBlob sourceBlob = await sourceBlobContainer.GetBlobReferenceFromServerAsync("MyBlob.doc");
Console.WriteLine($"Last modified: {sourceBlob.Properties.LastModified}");
await sourceBlob.DownloadToFileAsync("MyFile.doc", System.IO.FileMode.Create);
```

You can stream data from a large blob with the `DownloadToStreamAsync` method of your source blob object.

## Upload a blob

To create a new blob using a local file, the process is similar to previously described. Obtain a reference to the container that will hold the blob, and create a reference for your new blob. Specify the name for your new blob. You can then use the `UploadFromFileAsync` method to read data from a local file, and copy it to the new blob. The following code shows an example of this approach.

```C#
CloudBlobContainer destBlobContainer = destClient.GetContainerReference(destContainer);
CloudBlockBlob destBlob = destBlobContainer.GetBlockBlobReference("NewBlob.doc");
await destBlob.UploadFromFileAsync("MyFile.doc");
```

As with downloading, you can stream data to a blob using the  `UploadFromStreamAsync` method of the destination blob object.

## Copy blobs between storage accounts

You can transfer blobs between storage accounts using a combination of the download and upload techniques previously illustrated. However, a more efficient approach is to make use of the blob copying facilities provided by the Azure Storage service. Copying a blob in this way transfers it directly from one container to another without requiring that you download it to an intermediate storage location.

The .NET Client library provides the `StartCopyAsync` method of a blob object to initiate copying the data in this blob to another blob in a destination container. You specify the destination blob using its URI. Additionally, because the data is transferred directly, you need to ensure that the Azure Storage service is provided with the appropriate access rights to the source blob. One way to supply this access is with a Shared Access Signature (SAS) token, as described previously in this module. You append the SAS token to the URI of the source blob.

The following example code shows how to use the `StartCopyAsync` method. The *sourceBlob* variable is a reference to a blob being copied. The code creates a reference to a new blob (*destBlob*) using the same name as the source blob. The `StartCopyAsync` method takes the URI of the blob to be copied, and starts to transfer the data to the new destination blob. The `GetSharedAccessUri` method creates a read-only SAS token for the source blob that is valid for 60 minutes.

```C#
CloudBlockBlob destBlob = destContainer.GetBlockBlobReference(sourceBlob.Name);
await destBlob.StartCopyAsync(new Uri(GetSharedAccessUri(sourceBlob.Name, sourceContainer)));

...

// Create a SAS token for the source blob, to enable it to be read by the StartCopyAsync method
private static string GetSharedAccessUri(string blobName, CloudBlobContainer container)
{
    DateTime toDateTime = DateTime.Now.AddMinutes(60);

    SharedAccessBlobPolicy policy = new SharedAccessBlobPolicy
    {
        Permissions = SharedAccessBlobPermissions.Read,
        SharedAccessStartTime = null,
        SharedAccessExpiryTime = new DateTimeOffset(toDateTime)
    };

    CloudBlockBlob blob = container.GetBlockBlobReference(blobName);
    string sas = blob.GetSharedAccessSignature(policy);

    return blob.Uri.AbsoluteUri + sas;
}
```

The `StartCopyAsync` method initiates the blob copy operation and the process runs in the background. You can check on the progress of the operation by retrieving a reference to the destination blob, and querying its `CopyState`. The state has a value of `Pending` while the copy is in progress. Additionally, you can find out how many bytes have been copied using the `BytesCopied` property of the `CopyState` object.

The following code sample retrieves a reference to the destination blob, and monitors the progress as it is copied. A reference is obtained using the `GetBlobReferenceFromServerAsync` method. This method retrieves the latest status information from the storage server. The `GetBlockBlobReference` method shown in previous examples uses information that is cached in the client library. This cached information isn't updated while a blob is being copied. So, to obtain the up-to-date status of the blob, fetch this information from the server.

```C#
// Display the status of the blob as it is copied
ICloudBlob destBlobRef = await destContainer.GetBlobReferenceFromServerAsync(destBlob.Name);
while (destBlobRef.CopyState.Status == CopyStatus.Pending)
{
    Console.WriteLine($"Blob: {destBlobRef.Name}, Copied: {destBlobRef.CopyState.BytesCopied ?? 0} of  {destBlobRef.CopyState.TotalBytes ?? 0}");
    await Task.Delay(500);
    destBlobRef = await destContainer.GetBlobReferenceFromServerAsync(destBlobRef.Name);
}
Console.WriteLine($"Blob: {destBlob.Name} Complete");
```

## Delete a blob

To remove a blob from a container, use one of the *Delete* methods of the blob object. There are two methods available `DeleteAsync` and `DeleteIfExistsAsync`. Both methods delete the specified blob, but `DeleteIfExistsAsync` returns a boolean value indicating whether the blob actually existed before or not.

The following code uses `DeleteIfExistsAsync` to remove a blob, and detects whether the blob existed beforehand.

```C#
bool blobExisted = await sourceBlob.DeleteIfExistsAsync();
```

## Iterate blobs in a container

You can iterate through the blobs in a container with the `ListBlobsSegmentedAsync` method of a blob container object. This method fetches the details of blobs in batches. You read the first batch, and the method returns an object that contains the details of the blobs in this batch, together with a continuation token. You can process the details in the batch, and then call `ListBlobsSegmentedAsync` again with a continuation token to read the next batch. You repeat this process until the method returns a null token.

The following code shows an example of this method:

```C#
BlobContinuationToken token = null;

// Iterate through the blobs in a container
do
{
    BlobResultSegment segment = await blobContainer.ListBlobsSegmentedAsync(prefix: "", currentToken: token);
    foreach (CloudBlockBlob blobItem in segment.Results)
    {
        // Process the current blob
        ICloudBlob blob = await blobContainer.GetBlobReferenceFromServerAsync(blobItem.Name);
        ...
    }
} while (token != null);
```

The *prefix* parameter to `ListBlobsSegmentedAsync` enables you to find all blobs with names that have the specified prefix.

The `ListBlobsSegmentedAsync` method is overloaded, and variants enable you to walk through a hierarchical container structure.
