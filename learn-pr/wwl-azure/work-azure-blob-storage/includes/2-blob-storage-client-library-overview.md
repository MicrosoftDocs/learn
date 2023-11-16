The Azure Storage client libraries for .NET offer a convenient interface for making calls to Azure Storage. The latest version of the Azure Storage client library is version 12.x. Microsoft recommends using version 12.x for new applications.

The following table lists the basic classes, along with a brief description:

| Class | Description |
|--|--|
| `BlobServiceClient` | Represents the storage account, and provides operations to retrieve and configure account properties, and to work with blob containers in the storage account. |
| `BlobContainerClient` | Represents a specific blob container, and provides operations to work with the container and the blobs within. |
| `BlobClient` | Represents a specific blob, and provides general operations to work with the blob, including operations to upload, download, delete, and create snapshots. |
| `AppendBlobClient` | Represents an append blob, and provides operations specific to append blobs, such as appending log data. |
| `BlockBlobClient` | Represents a block blob, and provides operations specific to block blobs, such as staging and then committing blocks of data. |

The following packages contain the classes used to work with Blob Storage data resources:

* [Azure.Storage.Blobs](/dotnet/api/azure.storage.blobs): Contains the primary classes (client objects) that you can use to operate on the service, containers, and blobs.
* [Azure.Storage.Blobs.Specialized](/dotnet/api/azure.storage.blobs.specialized): Contains classes that you can use to perform operations specific to a blob type, such as block blobs.
* [Azure.Storage.Blobs.Models](/dotnet/api/azure.storage.blobs.models): All other utility classes, structures, and enumeration types.

