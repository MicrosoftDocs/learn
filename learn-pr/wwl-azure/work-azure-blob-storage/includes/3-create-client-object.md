Working with any Azure resource using the SDK begins with creating a client object. In this section, you learn how to create client objects to interact with the three types of resources in the storage service: storage accounts, containers, and blobs.

When your application creates a client object, you pass a URI referencing the endpoint to the client constructor. You can construct the endpoint string manually, as shown in the examples in this article, or you can query for the endpoint at runtime using the Azure Storage management library.

The code samples in this unit use [DefaultAzureCredential](/dotnet/api/azure.identity.defaultazurecredential) to authenticate to Azure via a Microsoft Entra security principal. The authentication process includes obtaining an access token for authorization. This access token is passed as a credential when the client is instantiated, and the credential persists throughout the client lifetime. The Microsoft Entra security principal requesting the token must be assigned an appropriate Azure RBAC role that grants access to blob data.

## Create a BlobServiceClient object

An authorized `BlobServiceClient` object allows your app to interact with resources at the storage account level. `BlobServiceClient` provides methods to retrieve and configure account properties, as well as list, create, and delete containers within the storage account. This client object is the starting point for interacting with resources in the storage account.

The following example shows how to create a `BlobServiceClient` object:

```csharp
using Azure.Identity;
using Azure.Storage.Blobs;

public BlobServiceClient GetBlobServiceClient(string accountName)
{
    BlobServiceClient client = new(
        new Uri($"https://{accountName}.blob.core.windows.net"),
        new DefaultAzureCredential());

    return client;
}
```

## Create a BlobContainerClient object

You can use a `BlobServiceClient` object to create a new `BlobContainerClient` object. A `BlobContainerClient` object allows you to interact with a specific container resource. `BlobContainerClient` provides methods to create, delete, or configure a container, and includes methods to list, upload, and delete the blobs within it.

The following example shows how to create a container client from a `BlobServiceClient` object to interact with a specific container resource:

```csharp
public BlobContainerClient GetBlobContainerClient(
    BlobServiceClient blobServiceClient,
    string containerName)
{
    // Create the container client using the service client object
    BlobContainerClient client = blobServiceClient.GetBlobContainerClient(containerName);
    return client;
}
```

If your work is narrowly scoped to a single container, you might choose to create a `BlobContainerClient` object directly without using `BlobServiceClient`.

```csharp
public BlobContainerClient GetBlobContainerClient(
    string accountName,
    string containerName,
    BlobClientOptions clientOptions)
{
    // Append the container name to the end of the URI
    BlobContainerClient client = new(
        new Uri($"https://{accountName}.blob.core.windows.net/{containerName}"),
        new DefaultAzureCredential(),
        clientOptions);

    return client;
}
```

## Create a BlobClient object

To interact with a specific blob resource, create a `BlobClient` object from a service client or container client. A `BlobClient` object allows you to interact with a specific blob resource.

The following example shows how to create a blob client to interact with a specific blob resource:

```csharp
public BlobClient GetBlobClient(
    BlobServiceClient blobServiceClient,
    string containerName,
    string blobName)
{
    BlobClient client =
        blobServiceClient.GetBlobContainerClient(containerName).GetBlobClient(blobName);
    return client;
}
```
