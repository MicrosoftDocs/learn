Working with an individual blob in the Azure Storage SDK for .NET Core requires a *blob reference* &mdash; an instance of an `ICloudBlob` object.

You'll usually get an `ICloudBlob` in one of two ways: requesting it with the blob's name, or selecting it from a list of blobs in the container. Both require a `CloudBlobContainer`, which we saw how to get in the last unit.

## Getting blobs by name

Call one of the `GetXXXReference` methods on a `CloudBlobContainer` to get an `ICloudBlob` by name. If you know the type of the blob you are retrieving, prefer using one of the more specific methods (`GetBlockBlobReference`, `GetAppendBlobReference`, or `GetPageBlobReference`).

None of these methods make a network call, nor do they confirm whether or not the blob actually exists. A separate method, `GetBlobReferenceFromServerAsync`, does call the Blob storage API and will throw an exception if the blob doesn't already exist.

## Listing blobs in a container

You can get a list of all blobs in a container with `CloudBlobContainer`'s `ListBlobsSegmentedAsync` method. *Segmented* refers to the separate pages of results returned &mdash; a single call to `ListBlobsSegmentedAsync` is never guaranteed to return all the results in a single page, so we may need to call it repeatedly using the `ContinuationToken` it returns to work our way through the pages. This makes the code for listing blobs a little more complex than the code for uploading or downloading, but there's a standard pattern you can use to get every blob in a container:

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

### Listing virtual blob directories

**TODO may cut this and update unit 2 to indicate we won't talk about it much in this module. It's a lot of detail for a beginner module**

If you organize your blobs into virtual directories, blobs that are inside a directory won't be included in a call to `ListBlobsSegmentedAsync` by default. Instead, the results will include a `CloudBlobDirectory` object representing each directory. `CloudBlobDirectory` objects have the same getting and listing methods as `CloudBlobContainer`, but the results will be scoped to the virtual directory.

**TODO image example; text example is hard to read/follow**

Using virtual directories isn't just a good way to organize data, it can improve performance by reducing the number of results returned when listing blobs. Generally, it's better to make a few API calls that return short lists of results than a single API call that returns tens of thousands of results, especially when those results will require multiple calls to page through anyway.

If you use virtual directories, you can disable the use of `CloudBlobDirectory` objects on a per-call basis if you ever just want a flat list of blobs.

> [!TIP]
> The API supports using any string as the directory delimiter, but use forward slash (`/`) unless you have a strong reason not to. Some client libraries and tools assume it, including the Azure Portal and Storage Explorer.

### Processing list results

The object you'll get back from `ListBlobsSegmentedAsync` contains a `Results` property of type `IEnumerable<IListBlobItem>`. `IListBlobItem`s aren't terribly useful &mdash; just a handful of properties about the blob's container and URL, no upload or download methods. This is because some of the result objects may be `CloudBlobDirectory` objects that represent virtual directories (as discussed in unit 2), not individual blobs.

If you are only interested in individual blobs, you can use the `OfType<>` method to filter the results. Here are a few examples:

```csharp
// Get all blobs
var allBlobs = resultSegment.Results.OfType<ICloudBlob>();

// Get only block blobs
var blockBlobs = resultSegment.Results.OfType<CloudBlockBlob();
```

Using `OfType<>` will require a reference to the `System.Linq` namespace (`using System.Linq;`);

### Additional options
**TODO maybe cut, maybe extraneous detail. If so, mention useFlat in the virtual dir section above**

`ListBlobsSegmentedAsync` has a few overloads with some useful parameters:

* `prefix` will filter the results to only include blobs whose name begins with `prefix`
* `useFlatBlobListing` will list all blobs in results instead of grouping blobs into `CloudBlobContainer`s
* `blobListingDetails` can be used to include additional properties left out of the list by default, such as blob metadata
* `maxResults` will adjust the result page size, up to a maximum of 5000

## Exercise

One of the features in our app requires getting a list of blobs from the API. We'll use the pattern shown above to list all the blobs in our container. As we process the list, we get the name of each blob.

Open `BlobStorage.cs` in the editor and fill in `GetNames` with the following code:

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

The names returned by this method are processed by `FilesController` to turn them into URLs. When they are returned to the client, they are rendered as hyperlinks on the page.