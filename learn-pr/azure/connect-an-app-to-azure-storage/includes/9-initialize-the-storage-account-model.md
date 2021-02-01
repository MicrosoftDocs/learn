The Azure Storage client library provides an object model that is used to interact with Azure storage accounts. It's used to quickly connect to an Azure storage account and use the Azure Storage service APIs. 

## Azure Storage client library object model

::: zone pivot="csharp"

A storage account in Azure is organized into one or more _containers_ that store the actual blob objects (files) in your account.  These containers are similar folders in a file system.  We can use the **Azure Storage Blobs client library for .NET** to create a container in our storage account to store our photos in.

To use the **Azure Storage Blobs client library for .NET** in your program, first you need to add a using statement at the top of your program for the `Azure.Storage.Blobs` namespace.

1. Run the following command to add **Azure Storage Blobs client library for .NET**.

    ```csharp
    using Azure.Storage.Blobs;
    ```

    To create and manage containers in your storage account from your .NET application, you use a `BlobContainerClient` object. To instantiate a `BlobContainerClient` client object, you must provide the connection string to your storage account and the container name. The container name must be between 3 and 63 characters long and may only contain lowercase letters and the dash (-) character. For this application, we will simply use the name _photos_.

1. Next, add the following code to your application to get the Azure Storage connection string and create the `BlobContainerClient` object.

    ```csharp
    var connectionString = configuration.GetConnectionString("StorageAccount");
    string containerName = "photos";

    BlobContainerClient container = new BlobContainerClient(connectionString, containerName);
    ```

    > [!NOTE]
    > At this point, the client library has not attempted to connect to Azure or validate the connection string and access key being used. It has simply constructed a lightweight client object used to perform operations against Azure Blob Storage. Only when an operation is invoked against the storage account, will a network call be made.

1. Now we can add code to create the _photos_ container where we will store our images.

    ```csharp
    container.CreateIfNotExists();
    ```

1. Now, run the application to have it create the container in the storage account. Because we used the `CreateIfNotExists` method, you can run your program multiple times but the container will only be created on the first run.

    ```dotnetcli
    dotnet run
    ```

1. You can verify you have created the container by running the following Azure CLI command. Remember to replace `<name>` with the name of your storage account.

    ```azurecli
    az storage container list \
    --account-name <name>
    ```

::: zone-end

::: zone pivot="javascript"

1. The **Azure Storage Blob client library for JavaScript** contains a number of client objects for interacting with Azure Storage Blobs. At the top of this hierarchy is the `BlobServiceClient` object. To use this object in your JavaScript code, you need to add the following statement to your index.js file immediately after the `require('dotenv').config();` statement.

    ```javascript
    require('dotenv').config();

    const { BlobServiceClient } = require("@azure/storage-blob");
   ```

1. Now, you can create a `BlobServiceClient` object in your code by getting the storage account connection string, and passing it to the factory method `fromConnectionString` on the `BlobServiceClient` object like this.

    ```javascript
    const storageAccountConnectionString = process.env.AZURE_STORAGE_CONNECTION_STRING;
    const blobServiceClient = BlobServiceClient.fromConnectionString(storageAccountConnectionString);
    ```

    > [!NOTE]
    > The client library will not attempt to connect to Azure until an operation is invoked that requires it. The client object is a lightweight object enabling access to the Azure Blob Storage; it does not validate the connection or the access key being used.

1. After you have a client object, you can use the methods on the client object to perform actual work. Methods that make network calls are intentionally asynchronous. The library uses Promises to return asynchronous results. For that reason, you need to mark your main function as async as shown below.

    ```javascript
    async function main() {
     // Function code here
    }
    ```
    
    Now let's execute an operation against our storage account. A storage account is organized into one or more containers which act like folders in your storage account. The blob objects (files) you create in your storage account are stored in one of these containers. You need to create a container in your storage account to store your photos.

    The container name must be between 3 and 63 characters long and may only contain lowercase letters and the dash (-) character.  For this application, we will simply use the name  _photos_.

    To create a container in your storage account, you need to obtain a `ContainerClient` object that represents the container in the storage account. Even though our container does not yet exist in our storage account, the `ContainerClient` can be used to create the container as well as manage it once it is created.

1. Run the following command to obtain the `ContainerClient` object, you call the `getContainerClient` method on the `BlobServiceClient` object and provide the name of the container as a parameter. Then, to create the container in your Azure Storage account, use the `createIfNotExists` method on the **containerClient** object.

    ```javascript
    async function main() {
       // Create a container (folder) if it does not exist
      const containerName = 'photos';
      const containerClient = blobServiceClient.getContainerClient(containerName);
      const createContainerResponse = await containerClient.createIfNotExists();
      console.log(`Create container ${containerName} successfully`, createContainerResponse.succeeded);
    }
    ```

1. Now, build and run the app to have your program create the container in your storage account.

    ```bash
    node index.js
    ```

    > [!TIP]
    > If you get an error about the use of the `await` keyword, make sure you have added the `async` keyword to the `main` function definition per the final step in the previous instructions.

    The first time you run the program, you should see a message that the container was created successfully. The second and subsequent times you run your program, you will see a message of false because the container already exists.

1. You can verify you have created the container by running the following Azure CLI command. Remember to replace `<name>` with the name of your storage account.

    ```azurecli
    az storage container list \
    --account-name <name>
    ```

::: zone-end

    Now that our program is connecting to our Azure storage account and we have created a _photos_ container, let's have our program upload an image to it.
