Let's add code to upload an image to our Azure Storage account. In this example, we upload the following image to our Azure Storage container.

![An image of the Docs mascot and the Azure mascot taking a selfie.](../media/docs-and-friends-selfie-stick.png)

If you're working on your local machine, right-click this image and save it to the same folder as your application.

- If you're working in the Microsoft Learn Sandbox environment, run the following command in the application folder to download the image into your sandbox:

    ```bash
    wget https://github.com/MicrosoftDocs/mslearn-connect-app-to-azure-storage/blob/main/images/docs-and-friends-selfie-stick.png?raw=true -O docs-and-friends-selfie-stick.png
    ```

    In both cases, the name of the image should be *docs-and-friends-selfie-stick.png*.

::: zone pivot="csharp"

## Upload an image to blob storage

To work with individual blob objects in your Azure Storage account, you use a `BlobClient` object. To get a `BlobClient` object, call the `GetBlobClient` method on the `BlobContainerClient` object of the container where the blob is to be stored. When calling the `GetBlobClient` method, you also supply a name for the blob in the container. For our example, the name of the blob is the same as the name of our file.

- After you have a `BlobClient` object, you can call the `Upload` method to upload a file to Azure Blob Storage. Add the following code to your _Program.cs_ file:

    ```csharp
    string blobName = "docs-and-friends-selfie-stick";
    string fileName = "docs-and-friends-selfie-stick.png";
    BlobClient blobClient = container.GetBlobClient(blobName);
    blobClient.Upload(fileName, true);
    ```

    The second argument in the `Upload` method specifies if an existing blob object with the same name can be overwritten. By default, this value is `false`. In this case, we're specifying `true` to allow the program to be run multiple times.

## List objects in an Azure Blob Storage container

To validate that our program worked, let's exercise another capability of the **Azure Storage Blobs SDK** and list the objects stored in a container in blob storage. Call the `GetBlobs` method on a `BlobContainerClient` object. The `GetBlobs` method returns a pageable list of `BlobItem` objects that contain data about each blob in the container.

1. Add the following code to your program after the code you previously added, then save the file:

    ```csharp
    var blobs = container.GetBlobs();
    foreach (var blob in blobs)
    {
        Console.WriteLine($"{blob.Name} --> Created On: {blob.Properties.CreatedOn:yyyy-MM-dd HH:mm:ss}  Size: {blob.Properties.ContentLength}");
    }
    ```

    This code calls `GetBlobs` on the `BlobContainerClient` object for the *photos* container. It iterates through each blob, printing the name of the blob, the creation date and time of the blob, and the size of the blob. When you run your program, this code should appear as a single line for the one image that you uploaded.

1. If you want to check your work, the final *Program.cs* file should look like the following code.

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

- Build and run the application to verify everything works, and upload your image to Azure Blob Storage.

    > [!NOTE]
    > Make sure you're in the PhotoSharingApp directory.

    ```dotnetcli
    dotnet run
    ```

   The output should list a single line of information for the one image that you uploaded.

::: zone-end

::: zone pivot="csharp"

## Congratulations

You learned the essentials of working with **Azure Storage Blobs** SDK package and Azure Blob Storage. If you want, explore further by creating another container, uploading more images to your storage account or deleting an image. You can learn more at the [Azure Storage Blobs client library for .NET GitHub page](https://github.com/Azure/azure-sdk-for-net/tree/Azure.Storage.Blobs_12.7.0/sdk/storage/Azure.Storage.Blobs).

::: zone-end

::: zone pivot="javascript"

## Upload an image to blob storage

To work with blob objects in your Azure Storage container, you use a `BlockBlobClient` object. The `BlockBlobClient` object has methods to upload, download, list, and delete blob objects in a container. To get a `BlockBlobObject`, call the method `getBlockBlobClient` on the `ContainerClient` object. Then, you can use the `uploadFile` method to upload your image to Azure Storage.

- Add this code to your *index.js* program file immediately after the code that creates the container:

    ```javascript
    const filename = 'docs-and-friends-selfie-stick.png';
    const blockBlobClient = containerClient.getBlockBlobClient(filename);
    blockBlobClient.uploadFile(filename);
    ```

## List objects in an Azure Blob Storage container

1. To verify that our code is working, we can call the `listBlobsFlat` method on the `ContainerClient` object in our program. Add this code to the *index.js* file, then save the file:

    ```javascript
    let blobs = containerClient.listBlobsFlat();
    let blob = await blobs.next();
    while (!blob.done) {
        console.log(`${blob.value.name} --> Created: ${blob.value.properties.createdOn}   Size: ${blob.value.properties.contentLength}`);
        blob = await blobs.next();
    }
    ```

    This code prints all the blobs in our Azure Blob Storage container with the date the blob was created and its size. For our program, this code should print one row representing the single image that you uploaded.

1. The final file should look like this example.

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
        const containerExists = await containerClient.exists()
        if ( !containerExists) {
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
        let blob = await blobs.next();
        while (!blob.done) {
            console.log(`${blob.value.name} --> Created: ${blob.value.properties.createdOn}   Size: ${blob.value.properties.contentLength}`);
            blob = await blobs.next();
        }
    }
    main();
    ```

## Run the app

- Build and run the application. The output should list a single line of information for the one image that you uploaded.

    > [!NOTE]
    > Make sure you're in the PhotoSharingApp directory.

    ```bash
    node index.js
    ```

    > [!TIP]
    > If you get an error about the use of the `await` keyword, make sure you've added the `async` keyword to the `main` function definition per the final step in the previous instructions.

## Congratulations

You learned the essentials of working the **Azure Storage Blob Client Library for JavaScript** and Azure Blob Storage. If you want, explore further by creating another container, uploading more images to your storage account or deleting an image. The [Azure Storage Blob Client Library for JavaScript npm.js page](https://www.npmjs.com/package/@azure/storage-blob) has many examples of how to use the library.

::: zone-end
