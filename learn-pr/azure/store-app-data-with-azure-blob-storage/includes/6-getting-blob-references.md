Working with an individual blob in the Azure Storage SDK for .NET Core requires a *blob reference* &mdash; an instance of an `ICloudBlob` object.

You can get an `ICloudBlob` by requesting it with the blob's name, or selecting it from a list of blobs in the container. Both require a `CloudBlobContainer`, which you saw how to get in the last unit.

## Getting blobs by name

To get an `ICloudBlob` by name, call one of the `GetXXXReference` methods on a `CloudBlobContainer`. If you know the type of the blob you are retrieving, to get an object that includes methods and properties tailored for that blob type, use one of the specific methods (`GetBlockBlobReference`, `GetAppendBlobReference`, or `GetPageBlobReference`).

None of these methods make network calls, nor do they confirm whether or not the targeted blob actually exists. They only create a blob reference object locally, which can then be used to call methods that *do* operate over the network and interact with blobs in storage. A separate method, `GetBlobReferenceFromServerAsync`, does call the Blob storage API, and will throw an exception if the blob doesn't already exist.

## Listing blobs in a container

You can get a list of the blobs in a container using `CloudBlobContainer`'s `ListBlobsSegmentedAsync` method. *Segmented* refers to the separate pages of results returned &mdash; a single call to `ListBlobsSegmentedAsync` is never guaranteed to return all the results in a single page. You may need to call it repeatedly using the `ContinuationToken` it returns to work our way through the pages. This makes the code for listing blobs a little more complex than the code for uploading or downloading, but there's a standard pattern you can use to get every blob in a container.

```csharp
BlobContinuationToken continuationToken = null;
BlobResultSegment resultSegment = null;

do
{
    resultSegment = await container.ListBlobsSegmentedAsync(continuationToken);

    // Do work here on resultSegment.Results

    continuationToken = resultSegment.ContinuationToken;
} while (continuationToken != null);
```

This will call `ListBlobsSegmentedAsync` repeatedly until `continuationToken` is `null`, which signals the end of the results.

> [!IMPORTANT]
> Never assume that `ListBlobsSegmentedAsync` results will arrive in a single page. Always check for a continuation token and use it if it's present.

### Processing list results

The object you'll get back from `ListBlobsSegmentedAsync` contains a `Results` property of type `IEnumerable<IListBlobItem>`. The `IListBlobItem` interface includes only a handful of properties about the blob's container and URL, and isn't very useful by itself.

To get useful blob objects out of `Results`, and to filter and cast the results to more specific blob object types, use the `OfType<>` method. Here are a few examples.

```csharp
// Get all blobs
var allBlobs = resultSegment.Results.OfType<ICloudBlob>();

// Get only block blobs
var blockBlobs = resultSegment.Results.OfType<CloudBlockBlob>();
```

> [!TIP]
> Using `OfType<>` requires a reference to the `System.Linq` namespace (`using System.Linq;`).

## Exercise

One of the features in your app requires getting a list of blobs from the API. You'll use the pattern previously shown to list all the blobs in our container. As you process the list, you get the name of each blob.

Using the editor, replace `GetNames` in `BlobStorage.cs` with the following code, and save your changes.

```csharp
public async Task<IEnumerable<string>> GetNames()
{
    List<string> names = new List<string>();

    CloudStorageAccount storageAccount = CloudStorageAccount.Parse(storageConfig.ConnectionString);
    CloudBlobClient blobClient = storageAccount.CreateCloudBlobClient();
    CloudBlobContainer container = blobClient.GetContainerReference(storageConfig.FileContainerName);

    BlobContinuationToken continuationToken = null;
    BlobResultSegment resultSegment = null;

    do
    {
        resultSegment = await container.ListBlobsSegmentedAsync(continuationToken);

        // Get the name of each blob.
        names.AddRange(resultSegment.Results.OfType<ICloudBlob>().Select(b => b.Name));

        continuationToken = resultSegment.ContinuationToken;
    } while (continuationToken != null);

    return names;
}
```

> [!TIP]
> Note that the method signature now needs to specify `async`.

To turn them into URLs, the names returned by this method are processed by `FilesController`. When they are returned to the client, they are rendered as hyperlinks on the page.