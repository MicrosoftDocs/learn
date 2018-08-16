## Motivation

You have security configuration and appropriate client libraries within your app and are ready to use Azure Storage. The client library itself provides an object model that is used to interact with Azure Storage accounts. It is therefore important to know the object model used in the library to be able to quickly connect to an azure Storage account and use the Azure Storage service APIs. This unit will demonstrate how to use the account object model in your code to connect to your Azure Storage account.

## Azure Storage client library object model

Understanding how to use the Azure Storage client library object model is key to simplicity of implementation when connecting to your Azure Storage account.

The foundation of the storage account object model in the .NET Core client library is **CloudStorageAccount**. The simplest way to initialize the object model is to use `CloudStorageAccount.Parse` or `CloudStorageAccount.TryParse` to parse the connection string.

The client library will not attempt to connect until an operation is invoked that requires it. `Parse()` and `TryParse()` only guarantee that the connection string is well-formatted, they do not verify that the account actually exists or that the key is correct. The resulting `CloudStorageAccount` instance returned from the `Parse()` or `TryParse()` method call exposes methods to create a client for blob,file, table, or queue storage types (CreateXXXClient). This is then used to create instances of service client objects for the blob, file, queue and table storage services. The code snippet below shows an example of creating a client to use for blob storage:

```c#
using Microsoft.WindowsAzure.Storage;

var storageAccount = CloudStorageAccount.Parse("your-storage-key-connection-string");
var blobClient = storageAccount.CreateCloudBlobClient()
```

`CloudStorageAccount` and the client objects are lightweight which can be created on demand or created upfront to be shared within your application. A standard approach is to use `CloudStorageAccount.TryParse()` near the entry point of your application to create an instance, and make it available within your application for creating client instances.
