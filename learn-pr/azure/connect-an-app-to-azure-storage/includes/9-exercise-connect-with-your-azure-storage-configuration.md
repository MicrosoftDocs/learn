## Exercise - Connect with your Azure Storage configuration

In the following exercise, we will load the Azure Storage account connection string from configuration and use it to connect to the Azure Storage account.

1. Ensure the console application from the previous unit is loaded into Visual Studio.
1. In the **Program.cs** file, add a *using* statement at the top of the file to reference the **Microsoft.WindowsAzure.Storage** library:
    ```csharp
    using Microsoft.WindowsAzure.Storage;
    ```
1. At the bottom of the **Main** method, add the following line to retrieve the Azure Storage account connection string from the configuration file:
    ```csharp
    var connectionString = configuration["StorageAccountConnectionString"];
    ```
1. Insert thw following code at the bottom of the **Main** method to parse the connection string and create a blob client:
    ```csharp
    CloudStorageAccount storageAccount;
    if (!CloudStorageAccount.TryParse(connectionString,out storageAccount))
    {
        Console.WriteLine("Unable to parse connection string");
        return;
    }
    var blobClient = storageAccount.CreateCloudBlobClient();
    ```
1. Insert the following code to create a blob client and retrieve a reference to a container, optionally creating it if it does not exist at the bottom of the **Main** method:
    ```csharp
    var containerName = "MyBlobContainer";
    var success = blobClient
        .GetContainerReference(containerName)
        .CreateIfNotExistsAsync()
        .Result;
    ```

  *Note the use of the **async** method **CreateIfNotExistsAsync()** and corresponding **Result** property. In a typical application, we would normally use the **await** keyword. However, since this is a console application and is not async, we need to call the **Result** property to get the results of the async task created by the **CreateIfNotExistsAsync()** method.*

1. Add the following code at the bottom of the **Main** method to print a success or failure message.
    ```csharp
    if (!success)
    {
        Console.WriteLine("Error: Could not connect to Azure Storage container");
        return;
    }
    Console.WriteLine("Successfully connected to Azure Storage container");
    ```
1. Finally, run the application to verify that a successful connection is made, and view the Azure Portal to ensure the Storage container is created if it did not exist previously.
1. **Optional**: If you no longer plan on using the container, delete the resource group where the container is located to ensure you are not charged for resources you are not using.

## Summary

This unit demonstrated how to work with the Azure Storage object model to obtain a connection to your Azure Storage account using the connection string stored in configuration, and optionally create a container if it did not already exist. This information is the fundamental starting point when working with Azure Storage. Note that this only illustrates successful connectivity. Further details about blob storage will be covered in later modules.
