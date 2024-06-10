.NET Aspire is designed to make it easy to build cloud-native apps. .NET Aspire can run in any environment that hosts containers so you don't have to choose Azure to host your finished apps. However, Azure does include some services that can be helpful for cloud-native apps. These include Azure Storage accounts, which you can use to store binary large objects (blobs), message queues, and data tables.

In the outdoor equipment retailer you work for, your team is making good progress with the microservices for the new public-facing eShop. You've already decided to host the final app in Azure. Two separate teams have a need to store blobs: both high resolution photos and product demonstration videos. Now, you want to assess whether an Azure Storage account would be an optimal location to store these files.

In this unit, you'll learn about the .NET Aspire Azure Blob Storage component and how it helps developers to store and retrieve blobs in Azure Storage accounts.

## What is an Azure Storage account?

Azure is Microsoft's industry leading cloud services solution and it includes many features for hosting virtual machines, containers, and serverless functions, which could support your cloud-native apps. The Azure Storage feature includes three services:

- **Azure Blob Storage**: This service is optimized for storing and serving images, videos, documents, and other large objects directly to browsers.
- **Azure Queue Storage**: This service provides simple queues of messages. You can use these queues to exchange messages between microservices in a cloud-native application. You'll learn more about Azure Queue Storage in the next unit in this module.
- **Azure Table Storage**: This service stores nonrelational structured data in tables with no fixed schemas. The lack of schemas ensures that table structure can evolve to meet your changing needs. You'll learn more about Azure Table Storage in a later unit in this module.

You can use one, two, or all three of these services in a single storage account. If your organization uses Azure, you should consider Azure Storage as a simple and effective way to add these backing services to your cloud-native app.

> [!NOTE]
> Azure Storage is only one solution you can use for message queuing, blob storage, and semi-structured data storage. For example, MongoDB and RabbitMQ provide data tables and message queues without requiring Azure. Within Azure you can choose Cosmos DB and Azure Service Bus instead. .NET Aspire includes components for all these services.

## Why use Azure Blob Storage?

When you're building a cloud-native app, you often need to store binary large objects (blobs). For example, if you're retailing outdoor equipment, you might need to serve image files that display products in the catalog, documents with product instructions, and videos that demonstrate products in use in harsh environments. This multimedia content enriches your app and engages users.

Azure Blob Storage is optimized to store large files or large numbers of files that consist of unstructured data. It's designed to serve those files to web browsers and mobile clients throughout the world and supports streaming both video and audio data.

## Using Azure Blob Storage with .NET Aspire

.NET Aspire makes it easy to work with files in Azure Blob Storage by including the built-in **.NET Aspire Azure Blob Storage component**. This component registers a connected `BlobServiceClient` object in the dependency injection container maintained by the app host project. You can pass that client to any microservice in your solution and use it to store or retrieve files. .NET Aspire also configures health checks and telemetry for the Blob Storage client.

### Modifying the app host project

Start by installing the `Aspire.Hosting.Azure.Storage` NuGet package:

```dotnetcli
dotnet add package Aspire.Hosting.Azure.Storage
```

Next, register the Azure Blob Storage component:

```csharp
var blobs = builder.AddAzureStorage("storage")
    .AddBlobs("blobs");
```

Now, you can pass the service to each microservice that consumes it:

```csharp
var catalogMicroservice = builder.AddProject<Projects.CatalogMicroservice>()
    .WithReference(blobs);
```

### Modifying the consuming projects

To use the Azure Blob Storage component in a microservice, first you must install it using the NuGet package manager, or the .NET CLI:

```dotnetcli
dotnet add package Aspire.Azure.Storage.Blobs
```

Now, to register a `BlobServiceClient` object in the dependency injection container, call the `AddAzureBlobService()` method in the _Program.cs_ file:

```csharp
builder.AddAzureBlobClient("blobs");
```

> [!NOTE]
> In the above code, the string "blobs" is the name of a connection string that specifies the location of the Azure Storage account.

Whenever you want to store or retrieve blobs, you can use dependency injection to retrieve the `BlobServiceClient`:

```csharp
public class CatalogService(BlobServiceClient client)
{
    // Use the client object to store or retrieve files
}
```

### Storing files

Once you have the `BlobServiceClient` object, you can use it to store and retrieve files. In the blob service, files are organized in containers, so you must obtain or create a container first:

```csharp
private static async Task<BlobContainerClient> CreateImagesContainerAsync(BlobServiceClient blobServiceClient)
{
    string containerName = "images-container";

    try
    {
        BlobContainerClient container = await blobServiceClient.CreateBlobContainerAsync(containerName);

        if (await container.ExistsAsync())
        {
            return container;
        }
    }
    catch (RequestFailedException e)
    {
        Console.WriteLine("HTTP error code {0}: {1}",
                            e.Status, e.ErrorCode);
        Console.WriteLine(e.Message);
    }

    return null;
}
```

Once you have a reference to a `BlobContainerClient`, you can upload a file to it. In this case, the code uploads a file from the local hard disk:

```csharp
public static async Task UploadFromFileAsync(
    BlobContainerClient containerClient,
    string filePath)
{
    string fileName = Path.GetFileName(filePath);
    BlobClient blobClient = containerClient.GetBlobClient(fileName);

    await blobClient.UploadAsync(localFilePath, true);
}
```

### Configuring the connection to the Storage account

When you register the Azure Blob Service client in the consuming microservice, you use this code:

```csharp
builder.AddAzureBlobClient("blobs");
```

The string you pass to this method is the name of a connection string. You should store this connection string in one of the project's app settings files:

```json
{
  "ConnectionStrings": {
    "blobs": "https://{account_name}.blob.core.windows.net/"
  }
}
```

## Learn more

- [Storage account overview](/azure/storage/common/storage-account-overview)
- [Azure Blob Storage documentation](/azure/storage/blobs/)
- [.NET Aspire Azure Blob Storage component](/dotnet/aspire/storage/azure-storage-blobs-component)
- [Tutorial: Connect an ASP.NET Core app to .NET Aspire storage components](/dotnet/aspire/storage/azure-storage-components)
