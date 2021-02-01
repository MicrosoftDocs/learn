Let's add code to upload an image to our Azure Storage account. In this example, we're going to upload the following image to our Azure Storage container.  

![An image of the Microsoft Docs and Azure mascots taking a selfie](../media/docs-and-friends-selfie-stick.png)

If you're working on your local machine, right-click on this image, and save it to the same folder as where you have your application.

1. If you're working in the Microsoft Learn Sandbox environment, run the following command in the same folder as you have your application to download the image into your sandbox.

    ```bash
    wget https://github.com/MicrosoftDocs/mslearn-connect-app-to-azure-storage/blob/main/images/docs-and-friends-selfie-stick.png?raw=true -O docs-and-friends-selfie-stick.png
    ```

In both cases, the name of the image should be _docs-and-friends-selfie-stick.png_.

::: zone pivot="csharp"

## Upload an image to blob storage

To work with individual blob objects in your Azure Storage account, you use a `BlobClient` object. To get a `BlobClient` object is, call the `GetBlobClient` method on the `BlobContainerClient` object of the container where the blob will be stored. When calling the `GetBlobClient` method, you also supply a name for the blob in the container. For our example, the name of the blob will be the same as the name of our file.

1. After you have a `BlobClient` object, you can call the `Upload` method to upload a file to Azure Blob Storage.

    ```csharp
    string blobName = "docs-and-friends-selfie-stick";
    string fileName = "docs-and-friends-selfie-stick.png";
    BlobClient blobClient = container.GetBlobClient(blobName);
    blobClient.Upload(fileName, true);
    ```

The second argument in the `Upload` method specifies if an existing blob object with the same name can be overwritten. By default, this value is `false`. In this case, we are specifying `true` to allow the program to be run multiple times.

## List objects in an Azure Blob Storage container

To validate that our program worked, we'll exercise another capability of the **Azure Storage Blobs SDK** to list the objects stored in a container in blob storage. This can be done by calling the `GetBlobs` method on a `BlobContainerClient` object. The `GetBlobs` method returns a pageable list of `BlobItem` objects that contain data about each blob in the container.

1. Add the following code to your program after the code you previously added.

    ```csharp
    var blobs = container.GetBlobs();
    foreach (var blob in blobs)
    {
        Console.WriteLine($"{blob.Name} --> Created On: {blob.Properties.CreatedOn:yyyy-MM-dd HH:mm:ss}  Size: {blob.Properties.ContentLength}");
    }
    ```

This code calls `GetBlobs` on the `BlobContainerClient` object for the _photos_ container. It then iterates through each blob, printing out the name of the blob, the date and time the blob was created, and the size of the blob. When you run your program, this code should appear as a single line for the one image that has been uploaded.

1. The final **Program.cs** file should look like this if you want to check your work.

    ```csharp
    using System;
    using Microsoft.Extensions.Configuration;
    using System.IO;
    using Azure.Storage.Blobs;

    namespace PhotoSharingApp
    {
        class Program
        {
            static void Main(string[] args)
            {
            var builder = new ConfigurationBuilder()
                .SetBasePath(Directory.GetCurrentDirectory())
                .AddJsonFile("appsettings.json");

            var configuration = builder.Build();

            Console.WriteLine("Hello World!");

            // Get a connection string to our Azure Storage account.
            var connectionString = configuration.GetConnectionString("StorageAccount");

            // Get a reference to the container client object so you can create the "photos" container
            string containerName = "photos";
            BlobContainerClient container = new BlobContainerClient(connectionString, containerName);
            container.CreateIfNotExists();

            // Uploads the image to Blob storage.  If a blb already exists with this name it will be overwritten
            string blobName = "docs-and-friends-selfie-stick";
            string fileName = "docs-and-friends-selfie-stick.png";
            BlobClient blobClient = container.GetBlobClient(blobName);
            blobClient.Upload(fileName, true);

            // List out all the blobs in the container
            var blobs = container.GetBlobs();
            foreach (var blob in blobs)
            {
                Console.WriteLine($"{blob.Name} --> Created On: {blob.Properties.CreatedOn:yyyy-MM-dd HH:mm:ss}  Size: {blob.Properties.ContentLength}");
            }
        }
        }
    }
    ```

## Run the app

1. Build and run the application to verify everything works, and upload your image to Azure Blob Storage.

    > [!NOTE]
    > Make sure you're in the PhotoSharingApp directory.
    
     ```dotnetcli
     dotnet run
     ```  

::: zone-end

::: zone pivot="csharp"

## Congratulations

You have learned the essentials of working with **Azure Storage Blobs** SDK package and Azure Blob Storage. If you want, explore further by creating another container, uploading additional images to your storage account or deleting an image. You can learn more at the [Azure Storage Blobs client library for .NET GitHub page](https://github.com/Azure/azure-sdk-for-net/tree/Azure.Storage.Blobs_12.7.0/sdk/storage/Azure.Storage.Blobs).

::: zone-end

::: zone pivot="javascript"

## Upload an image to blob storage

To work with blob objects in your Azure Storage container, you use a `BlockBlobClient` object. The `BlockBlobClient` object has methods to upload, download, list, and delete blob objects in a container. To get a `BlockBlobObject`, call the method `getBlockBlobClient` on the `ContainerClient` object.  Then, you can use the `uploadFile` method to upload your image to Azure Storage.

1. Add this code to your program immediately after the code that creates the container.

    ```javascript
    const filename = 'docs-and-friends-selfie-stick.png';
    const blockBlobClient = containerClient.getBlockBlobClient(filename);
    blockBlobClient.uploadFile(filename);
    ```

## List objects in an Azure Blob Storage container

1. To verify that our code is working, we can call the `listBlobsFlat` method on the `ContainerClient` object in our program.

    ```javascript
    let blobs = containerClient.listBlobsFlat();
    for await (const blob of blobs) {
    console.log(`${blob.name} --> Created: ${blob.properties.createdOn}   Size: ${blob.properties.contentLength}`);
    }
    ```

This code will print all the blobs in our Azure Blob Storage container with the date the blob was created and its size.  For our program, this code should print one row representing the single image we have uploaded.

1. The final file should look like this.

    ```javascript
    #!/usr/bin/env node
    require('dotenv').config();

    const { BlobServiceClient } = require("@azure/storage-blob");

    const storageAccountConnectionString = process.env.AZURE_STORAGE_CONNECTION_STRING;
    const blobServiceClient = BlobServiceClient.fromConnectionString(storageAccountConnectionString);

    async function main() {
    // Create a container (folder) if it does not exist
    const containerName = 'photos';    
    const containerClient = blobServiceClient.getContainerClient(containerName);
    if ( !containerClient.exists()) {
        const createContainerResponse = await containerClient.createIfNotExists();
        console.log(`Create container ${containerName} successfully`, createContainerResponse.succeeded);
    }
    else {
        console.log(`Container ${containerName} already exists`);
    }

    // Upload the file
    const filename = 'docs-and-friends-selfie-stick.png';
    const blockBlobClient = containerClient.getBlockBlobClient(filename);
    blockBlobClient.uploadFile(filename);

    // Get a list of all the blobs in the container
    let blobs = containerClient.listBlobsFlat();
    for await (const blob of blobs) {
      console.log(`${blob.name} --> Created: ${blob.properties.createdOn}   Size: ${blob.properties.contentLength}`)
    }
    }
    main();
    ```

## Run the app

1. Build and run the application.

    > [!NOTE]
    > Make sure you're in the PhotoSharingApp directory.

    ```bash
        node index.js
    ```

    > [!TIP]
    > If you get an error about the use of the `await` keyword, make sure you have added the `async` keyword to the `main` function definition per the final step in the previous instructions.

## Congratulations

You have learned the essentials of working the **Azure Storage Blob Client Library for JavaScript** and Azure Blob Storage. If you want, explore further by creating another container, uploading more images to your storage account or deleting an image. The [Azure Storage Blob Client Library for JavaScript npm.js page](https://www.npmjs.com/package/@azure/storage-blob) gives many examples of how to use the library.

::: zone-end
