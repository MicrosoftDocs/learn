The Azure Storage client library provides an object model for interacting with Azure storage accounts. You use it to quickly connect to an Azure storage account and use the Azure Storage service APIs. 

## Azure Storage client library object model

::: zone pivot="csharp"

A storage account in Azure is organized into one or more *containers* that store the actual blob objects (files) in your account. These containers are similar to folders in a file system. We can use the **Azure Storage Blobs client library for .NET** to create a container in our storage account in which to store our photos.

To use the **Azure Storage Blobs client library for .NET** in your program, you need to add a `using` statement at the top of your program for the `Azure.Storage.Blobs` namespace.

1. Add the following command to Program.cs.

    ```csharp
    using Azure.Storage.Blobs;
    ```

    To create and manage containers in your storage account from your .NET application, you use a `BlobContainerClient` object. To instantiate a `BlobContainerClient` object, you must provide the connection string to your storage account and the container name. The container name must be between 3 and 63 characters long and can only contain lowercase letters and the dash (-) character. For this application, we use the name *photos*.

1. Add the following code to the `Main` method in your application to get the Azure Storage connection string and create the `BlobContainerClient` object.

    ```csharp
    var connectionString = configuration.GetConnectionString("StorageAccount");
    string containerName = "photos";

    BlobContainerClient container = new BlobContainerClient(connectionString, containerName);
    ```

    > [!NOTE]
    > At this point, the client library is not attempting to connect to Azure or validate the connection string and access key being used. It's simply constructing a lightweight client object used to perform operations against Azure Blob Storage. A network call is only made when an operation is invoked against the storage account.

1. Just below the previous lines, add code to create the *photos* container, where we store our images.

    ```csharp
    container.CreateIfNotExists();
    ```

1. Save your file.

1. Now, run the application to have it create the container in the storage account. Because we used the `CreateIfNotExists` method, you can run your program multiple times, but the container is only created on the first run.

    ```dotnetcli
    dotnet run
    ```

1. You can verify that you created the container by running the following Azure CLI command. Remember to replace `<name>` with the name of your storage account.

    ```azurecli
    az storage container list \
    --account-name <name>
    ```

::: zone-end

::: zone pivot="javascript"

The **Azure Storage Blob client library for JavaScript** contains many client objects for interacting with Azure Storage Blobs. The top of this hierarchy is the `BlobServiceClient` object. To use this object in your JavaScript code:

1. Open your *index.js* file in the code editor and add the following statement immediately after the `require('dotenv').config();` statement:

    ```javascript
    const { BlobServiceClient } = require("@azure/storage-blob");
   ```

1. Now, you need to create a `BlobServiceClient` object in your code by obtaining the storage-account connection string and passing it to the factory method `fromConnectionString` on the `BlobServiceClient` object. Add the following lines of code:

    ```javascript
    const storageAccountConnectionString = process.env.AZURE_STORAGE_CONNECTION_STRING;
    const blobServiceClient = BlobServiceClient.fromConnectionString(storageAccountConnectionString);
    ```

    > [!NOTE]
    > The client library doesn't attempt to connect to Azure until an operation is invoked that requires it. The client object is a lightweight object enabling access to the Azure Blob Storage; it doesn't validate the connection or the access key being used.

1. After you have a client object defined in your program, you can use methods on the client object to perform actual work. Methods that make network calls are intentionally asynchronous. The library uses Promises to return asynchronous results. For that reason, you need to mark your main function as async. Replace the main function object with the following code. The line that begins with two forward slashes is a comment.

    ```javascript
    async function main() {
     // Function code here
    }
    ```

1. Save the changes to *index.js*.

   Now, let's add some code to execute an operation against our storage account. A storage account is organized into one or more containers, which act like folders in your storage account. The blob objects (files) you create in your storage account are stored in one of these containers. You need to create a container in your storage account to store your photos.

   The container name must be between 3 and 63 characters long and can only contain lowercase letters and the dash (-) character. For this application, we use the name  *photos*.

   To create a container in your storage account, you need to obtain a `ContainerClient` object that represents the container in the storage account. Even though a container doesn't yet exist in our storage account, we can use the `ContainerClient` to create the container and manage it.

1. To obtain the `ContainerClient` object, call the `getContainerClient` method on the `BlobServiceClient` object and provide the name of the container as a parameter. Then, to create the container in your Azure Storage account, use the `createIfNotExists` method on the **containerClient** object. Replace the `// Function Code here` comment line with these statements:

    ```javascript
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
    ```

1. Save the changes to the *index.js* file.

1. In the Cloud Shell command line, enter the following command to build and run your program, which creates the container in your storage account:

    ```bash
    node index.js
    ```

    > [!TIP]
    > If you get an error about the use of the `await` keyword, make sure you've added the `async` keyword to the `main` function definition per the final step in the previous instructions.

    The first time you run the program, you should see a message that the container was created successfully, with a status of **true**. The second and subsequent times you run your program, you see a similar message with a status of **false** because the container already exists.

1. You can verify that you created the container by running the following Azure CLI command. Remember to replace `<name>` with the name of your storage account.

    ```azurecli
    az storage container list \
    --account-name <name>
    ```

::: zone-end

Now that our program is connecting to our Azure storage account and we created a *photos* container, let's have our program upload an image to it.
