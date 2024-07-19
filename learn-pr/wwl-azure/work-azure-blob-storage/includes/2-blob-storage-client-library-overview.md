The Azure Storage client libraries for .NET offer a convenient interface for making calls to Azure Storage. The latest version of the Azure Storage client library is version 12.x. Microsoft recommends using version 12.x for new applications.

The following table lists the basic classes, along with a brief description:

| Class | Description |
|--|--|
| `BlobClient` | The [`BlobClient`](/dotnet/api/azure.storage.blobs.blobclient) allows you to manipulate Azure Storage blobs. |
| `BlobClientOptions` | Provides the client configuration options for connecting to Azure Blob Storage. |
| `BlobContainerClient` | The [BlobContainerClient](/dotnet/api/azure.storage.blobs.blobcontainerclient) allows you to manipulate Azure Storage containers and their blobs. |
| `BlobServiceClient` | The [BlobServiceClient](/dotnet/api/azure.storage.blobs.blobserviceclient) allows you to manipulate Azure Storage service resources and blob containers. The storage account provides the top-level namespace for the Blob service. |
| `BlobUriBuilder` | The [BlobUriBuilder](/dotnet/api/azure.storage.blobs.bloburibuilder) class provides a convenient way to modify the contents of a Uri instance to point to different Azure Storage resources like an account, container, or blob. |

The following packages contain the classes used to work with Blob Storage data resources:

* [Azure.Storage.Blobs](/dotnet/api/azure.storage.blobs): Contains the primary classes (client objects) that you can use to operate on the service, containers, and blobs.
* [Azure.Storage.Blobs.Specialized](/dotnet/api/azure.storage.blobs.specialized): Contains classes that you can use to perform operations specific to a blob type, such as block blobs.
* [Azure.Storage.Blobs.Models](/dotnet/api/azure.storage.blobs.models): All other utility classes, structures, and enumeration types.

