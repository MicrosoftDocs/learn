To interact with a container in Blob Storage, use a `BlobContainerClient` object. In addition to creating containers as you saw in the last unit, a `BlobContainerClient` object can also be used to list the blobs in a container.

## Listing blobs in a container

::: zone pivot="csharp"

Get a list of the blobs in a container using `BlobContainerClient`'s `GetBlobsAsync` method. Behind the scenes, the client makes one or more HTTP calls to Azure to list all of the blobs in the container. Since this method is asynchronous, you need to `await` the results as you read them. They might not all be returned in a single HTTP call. The following code shows the standard pattern for reading the results with a `foreach` loop.

```csharp
AsyncPageable<BlobItem> blobs = containerClient.GetBlobsAsync();

await foreach (var blob in blobs)
{
    // Read the BlobItem and work with it here
}
```

::: zone-end

::: zone pivot="java"

You can get a list of the blobs in a container using the `listBlobs` method in `BlobContainerClient`. Behind the scenes, the client makes one or more HTTP calls to Azure to list all of the blobs in the container. This method returns `PagedIterable<BlobItem>` that implements `Iterable<BlobItem>`. You can then read it one item at a time or by page of items. The following code shows the standard pattern for reading the results with a `for` loop.

```java
for (BlobItem blob : blobContainerClient.listBlobs()) {
    // Read the BlobItem and work with it here
}
```

```java
blobContainerClient.listBlobs()
    .stream()
    .map(blobItem -> /* Read the BlobItem and work with it here */)
    .collect(Collectors.toList());
```

::: zone-end

## Exercise

One of the features in your app requires getting a list of blobs from the API. Use the pattern previously shown to list all the blobs in our container. As you process the list, you get the name of each blob.

::: zone pivot="csharp"

Using the editor, replace `GetNames` in *BlobStorage.cs* with the following code, and save your changes.

```csharp
public async Task<IEnumerable<string>> GetNames()
{
    List<string> names = new List<string>();

    BlobServiceClient blobServiceClient = new BlobServiceClient(storageConfig.ConnectionString);

    // Get the container the blobs are saved in
    BlobContainerClient containerClient = blobServiceClient.GetBlobContainerClient(storageConfig.FileContainerName);

    // This gets the info about the blobs in the container
    AsyncPageable<BlobItem> blobs = containerClient.GetBlobsAsync();

    await foreach (var blob in blobs)
    {
        names.Add(blob.Name);
    }
    return names;
}
```

The `FilesController` processes the names that this method returns to turn the names into URLs. When returned to the client, the names are rendered as hyperlinks on the page.

::: zone-end

::: zone pivot="java"

Using the editor, replace `listNames` in `BlobStorage.java` with the following code, and save your changes.

```java
public List<String> listNames() {
    return blobContainerClient.listBlobs()
      .stream()
      .map(BlobItem::getName)
      .collect(Collectors.toList());
}
```

`IndexBean` and `index.xhmtl` process the names returned by this method to be rendered as hyperlinks on the page.

::: zone-end
