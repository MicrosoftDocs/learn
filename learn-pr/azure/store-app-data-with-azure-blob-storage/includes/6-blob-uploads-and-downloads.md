Once we have a reference to a blob, we can upload and download data. `ICloudBlob` objects have a handful of `Upload` and `Download` methods that support byte arrays, streams and files as sources and targets. Specific types have additional methods for convenience &mdash; for example, `CloudBlockBlob` supports uploading and downloading strings with `UploadTextAsync` and `DownloadTextAsync`.

## Creating new blobs

The Blob storage API does not have a dedicated "Create Blob" operation. New blobs are created by uploading data to blobs that don't yet exist. From your code, getting a reference to a blob that doesn't exist yet and using one of the `Upload` methods to upload data will create the blob in Azure.

## Moving data to and from blobs

Moving data to and from a blob is a network operation that takes time. In the Azure Storage SDK for .NET Core, all methods that require network activity return `Task`s, so make sure your controller methods are `async` as appropriate and that you are `await`ing method calls and not `Wait`ing on them.

Work with streams instead of in-memory structures like byte arrays or strings when possible. Using streams avoids buffering the full content of a request or a blob into memory before sending it to the target. ASP.NET Core supports reading and writing streams from requests and responses.

## Concurrent access

Keep in mind that other processes may be adding, changing or deleting blobs as your app is using them. Always code defensively and think about problems caused by concurrency, such as blobs that are deleted right as you try to download from them, or blobs whose contents change when you don't expect them to. See the Additional Resources section at the end of this module for information about using AccessConditions and blob leases to manage concurrent blob access.

## Exercise

Let's finish our app by adding upload and download code, then deploy it to App Service and see it in action.

### Upload

To upload a blob, we'll implement `BlobStorage.Save` by using `GetBlockBlobReference` to get a `CloudBlockBlob` from the container. `FilesController.Upload` passes the file stream to `Save`, so we can use `UploadFromStreamAsync` to perform the upload for maximum efficiency.

Open `BlobStorage.cs` in the editor and fill in the `Save` implementation with the following code:

```csharp
public Task Save(Stream fileStream, string name)
{
    CloudStorageAccount storageAccount = CloudStorageAccount.Parse(storageConfig.ConnectionString);
    CloudBlobClient blobClient = storageAccount.CreateCloudBlobClient();
    CloudBlobContainer container = blobClient.GetContainerReference(storageConfig.FileContainerName);
    CloudBlockBlob blockBlob = container.GetBlockBlobReference(name);
    return blockBlob.UploadFromStreamAsync(fileStream);
}
```

> [!NOTE]
> The stream-based upload code shown here is more efficient than reading the file into a byte array before sending it to Blob storage. However, the `IFormFile` technique we use to get the file from the client is not a true end-to-end streaming implementation and is only appropriate for handling uploads of small files. See the Additional Resources section at the end of this module for information about fully-streamed file uploads.

### Download

`BlobStorage.Load` returns a `Stream`, meaning that our code doesn't actually need to physically move the bytes from Blob storage at all &mdash; we just need to return a reference to the blob stream. We can do that with `OpenReadAsync`. ASP.NET Core will handle reading and closing the stream when it builds the client response.

Fill in `Load` with this code:

```csharp
public Task<Stream> Load(string name)
{
    CloudStorageAccount storageAccount = CloudStorageAccount.Parse(storageConfig.ConnectionString);
    CloudBlobClient blobClient = storageAccount.CreateCloudBlobClient();
    CloudBlobContainer container = blobClient.GetContainerReference(storageConfig.FileContainerName);
    return container.GetBlobReference(name).OpenReadAsync();
}
```

### Deploy and run in Azure

Our app is finished &mdash; let's deploy it and see it work. Run the following code in the Cloud Shell terminal to build our code and deploy it to a new App Service instance. We also add our storage account connection string to configuration.

```console

```

...

Upload and download some files to see the app in action, then run the following in the shell to see the blobs that have been uploaded:

```console

```

**TODO pic from portal**