To interact with a container in Blob Storage, you use a `BlobContainerClient` object.  In addition to creating containers as you saw in the last unit, a `BlobContainerClient` object can also be used to list the blobs in a container.

## Listing blobs in a container

You can get a list of the blobs in a container using `BlobContainerClient`'s `listBlobs` method. Behind the scenes, the client will make one or more HTTP calls to Azure to list all of the blobs in the container. This method returns `PagedIterable<BlobItem>` that implements `Iterable<BlobItem>`. You can then read it one item at a time or by page of items. The standard patterns for reading the results with a `for` loop or streaming API are shown below.

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

## Exercise

One of the features in your application requires getting a list of blobs. You'll use the pattern previously shown to list all the blobs in our container and get the name of each blob.

Using the editor, replace `listFiles` in `BlobStorage.java` with the following code, and save your changes.

```java
public List<String> listFiles() {
    return blobContainerClient.listBlobs()
      .stream()
      .map(BlobItem::getName)
      .collect(Collectors.toList());
}
```

The names returned by this method are processed by `IndexBean` and `index.xhmtl` to rendered as hyperlinks on the page.
