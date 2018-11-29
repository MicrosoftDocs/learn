The Azure Storage client library provides an object model that is used to interact with Azure storage accounts. It's used to quickly connect to an Azure storage account and use the Azure Storage service APIs. 

## Azure Storage client library object model

::: zone pivot="csharp"

The foundation of the storage account object model in the .NET Core client library is the class `CloudStorageAccount`. The simplest way to initialize the object model is to use `CloudStorageAccount.Parse` or `CloudStorageAccount.TryParse` to parse the connection string.

> [!NOTE]
> The client library will not attempt to connect until an operation is invoked that requires it. `Parse()` and `TryParse()` only guarantee that the connection string is well-formatted; they don't verify that the account exists or that the key is correct. 

The resulting `CloudStorageAccount` instance returned from the `Parse()` or `TryParse()` method call exposes methods to create a client objects to access the Azure Blob, Files, Queue and Table storage services. 

The code snippet below shows an example of creating a client to use for blob storage:

```csharp
using Microsoft.WindowsAzure.Storage;

CloudStorageAccount storageAccount = CloudStorageAccount.Parse("your-storage-key-connection-string");

CloudBlobClient blobClient = storageAccount.CreateCloudBlobClient();
```

`CloudStorageAccount` and the client objects are lightweight and can be created on demand or created up front to be shared within your application. A standard approach is to use `CloudStorageAccount.TryParse()` near the entry point of your application to create an instance, and make it available within your application for creating client instances.

Once you have a client object to a specific storage type, you can use methods to perform actual work. Methods which make network calls are intentionally asynchronous &mdash; in .NET we use the `async` and `await` keywords to work with these methods efficiently.

As an example, we can use the `CloudBlobClient` to create a _blob container_ and upload a file to blob storage.

```csharp
// Create a local CloudBlobContainer object. No network call.
string containerName = "myblobcontainer";
CloudBlobContainer blobContainer = blobClient.GetContainerReference(containerName);

// This makes an actual service call to the Azure Storage service. 
// Unless this call fails, the container will have been created.
await blobContainer.CreateAsync();

// Create a local object to represent our blob. No network call.
string blobName = "myphoto";
CloudBlockBlob blob = blobContainer.GetBlockBlobReference(blobName);

// This transfers data in the file to the blob on the service.
string filename = "photo.png";
await blob.UploadFromFileAsync(fileName);
```

::: zone-end

::: zone pivot="javascript"

The foundation of the storage account object model in the **Microsoft Azure Storage Client Library for Node.js and JavaScript** is the `azurestorage` object. This is created by adding the **azure-storage** module to your app through a `require` statement.

```javascript
const storage = require('azure-storage');
```

This object provides a series of _factory_ methods that create specific objects to work with each facet of Azure storage. You call `createXXX` methods to create each object.

| Type | Method | Returns |
|--------|---------|-------------|
| **Blob** | `createBlobService` | `BlobService` |
| **Table** | `createTableService` | `TableService` |
| **Queue** | `createQueueService` | `QueueService` |
| **File** | `createFileService` | `FileService` |

> [!NOTE]
> The client library will not attempt to connect until an operation is invoked that requires it. Each of these `create` methods return a lightweight object representing access to the storage type&mdash;it does not validate the connection or the access key being used.

Once you have a service object to a specific storage type, you can use methods to perform actual work. Methods that make network calls are intentionally asynchronous. The library currently supports _callbacks_ to return asynchronous results. For example, here is code that creates a blob container.

```javascript
var azure = require('azure-storage');
var blobService = azure.createBlobService();

blobService.createContainerIfNotExists('myblobcontainer', function(err, result, response) {
  if (!err) {
    // if result.created = true, container was created.
    // if result.created = false, container already existed.
  }
});
```

This approach works fine, but it tends to lead to a lot of code being added into the callbacks, which can get unmanageable. A better approach in JavaScript is to use _promises_ to work with these methods. There are several great libraries which will convert callback-style methods into promises&mdash;you can pick the one you prefer.

Here, we'll use the `util.promisify` feature from Node and use the `BlobService` to create the container and upload a file to blob storage. In addition, we'll use the `async` and `await` keywords to work with the promises a bit more naturally.

```javascript
const util = require('util');
const storage = require('azure-storage');

const blobService = storage.createBlobService();
const createContainerAsync = util.promisify(blobService.createContainerIfNotExists).bind(blobService);
const uploadBlobAsync = util.promisify(blobService.createBlockBlobFromLocalFile).bind(blobService);

async function main() {
    try {
        // This makes an actual service call to the Azure Storage service. 
        // Unless this call fails, the container will have been created.
        await createContainerAsync(containerName);

        // This transfers data in the file to the blob on the service.
        var uploadResult = await uploadBlobAsync(containerName, "myphoto", "photo.png");
        if (uploadResult) {
            console.log("blob uploaded");
        }
    }
    catch (err) {
        console.log(err.message);
    }
}

main();
```
::: zone-end

Let's try this in our app.