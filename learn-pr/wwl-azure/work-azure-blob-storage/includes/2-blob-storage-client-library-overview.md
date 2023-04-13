
The Azure Storage client libraries for .NET offer a convenient interface for making calls to Azure Storage. The latest version of the Azure Storage client library is version 12.x. Microsoft recommends using version 12.x for new applications.

Below are the classes in the Azure.Storage.Blobs namespace and their purpose:

Class | Description
-- | --
`BlobClient` | The `BlobClient` allows you to manipulate Azure Storage blobs.
`BlobClientOptions` | Provides the client configuration options for connecting to Azure Blob Storage.
`BlobContainerClient` | The `BlobContainerClient` allows you to manipulate Azure Storage containers and their blobs.
`BlobServiceClient` | The `BlobServiceClient` allows you to manipulate Azure Storage service resources and blob containers. The storage account provides the top-level namespace for the Blob service.
`BlobUriBuilder` | The `BlobUriBuilder` class provides a convenient way to modify the contents of a Uri instance to point to different Azure Storage resources like an account, container, or blob.



