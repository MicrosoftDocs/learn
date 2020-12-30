The following is the typical workflow for apps that use Azure Blob storage:

1. **Retrieve configuration**: At startup, load the storage account configuration. This is typically a storage account connection string.

1. **Initialize client**: To initialize the Azure Storage client library, use the connection string. This creates the objects the app will use to work with the Blob storage API.

1. **Use**: To operate on containers and blobs, make API calls with the client library.

## Configure your connection string

Before running your app, you'll need the connection string for the storage account you will use. You can use any Azure management interface to get it, including the Azure portal, the Azure CLI, or Azure PowerShell. When you set up the web app to run your code near the end of this module, you'll use the Azure CLI to get the connection string for the storage account you created earlier.

Storage account connection strings include the account key. The account key is considered a secret and should be stored securely. Here, you will store the connection string in an App Service app setting. App Service app settings are a secure place for app secrets, but this design does not support local development and is not a robust, end-to-end solution on its own.

> [!WARNING]
> **Do not place storage account keys in code or in unprotected configuration files.** Storage account keys enable full access to your storage account. Leaking a key can result in unrecoverable damage and large bills. For storage guidance and advice about how to recover from a leaked key, at the end of this module, see the *Further Reading* section.

## Initialize the Blob storage object model

In the Azure Storage SDK for .NET Core, the standard pattern for using Blob storage consists of the following steps:

1. To get a `CloudStorageAccount`, call `CloudStorageAccount.Parse` (or `TryParse`) with your connection string.

1. To get a `CloudBlobClient`, call `CreateCloudBlobClient` on the `CloudStorageAccount`.

1. To get a `CloudBlobContainer`, call `GetContainerReference` on the `CloudBlobClient`.

1. To get a list of blobs and/or get references to individual blobs to upload and download data, use methods on the container.

In code, steps 1&ndash;3 look like this.

```csharp
CloudStorageAccount storageAccount = CloudStorageAccount.Parse(connectionString); // or TryParse()
CloudBlobClient blobClient = storageAccount.CreateCloudBlobClient();
CloudBlobContainer container = blobClient.GetContainerReference(containerName);
```

None of this initialization code makes calls over the network. This means that some exceptions that occur because of incorrect information won't be thrown until later. For example, the call to `CloudStorageAccount.Parse` will throw an exception immediately if the connection string is formatted incorrectly, but no exception will be thrown if the storage account that a connection string points to doesn't exist.

## Create containers at startup

To create a container when your app starts or when it first tries to use it, call `CreateIfNotExistsAsync` on a `CloudBlobContainer`.

`CreateIfNotExistsAsync` won't throw an exception if the container already exists, but it does make a network call to Azure Storage. Call it once during initialization, not every time you try to use a container.

## Exercise

### Clone and explore the unfinished app

First, let's clone the starter app from GitHub. In the Azure Shell CLI, to get a copy of the source code and open it in the editor, run the following command.

```console
git clone https://github.com/MicrosoftDocs/mslearn-store-data-in-azure.git
cd mslearn-store-data-in-azure/store-app-data-with-azure-blob-storage/src/start
code .
```

In the editor, open the file `Controllers/FilesController.cs`. There's no work to do here, but you're going to have a quick look at what the app does.

This controller implements an API with three actions:

- **Index**: (GET /api/Files) returns a list of URLs, one for each file that's been uploaded. The app front end calls this method to build a list of hyperlinks to the uploaded files.
- **Upload**: (POST /api/Files) receives an uploaded file and saves it.
- **Download**: (GET /api/Files/{filename}) downloads an individual file by its name.

To do its work, each method uses an `IStorage` instance called `storage`. There is an incomplete implementation of `IStorage` in `Models/BlobStorage.cs` that you're going to fill in.

### Add the NuGet package

First, add a reference to the Azure Storage SDK. In the Azure Shell CLI, run the following command.

```console
dotnet add package WindowsAzure.Storage
dotnet restore
```

This will make sure we're using the newest version of the Blob storage client library.

### Configure

The configuration values we need are the storage account connection string and the name of the container the app will use to store files. In this module, you're only going to run the app in Azure App Service, so you'll follow App Service best practice and store the values in App Service app settings. You'll do that when we create the App Service instance, so there's nothing you need to do at the moment.

When it comes to *using* the configuration, our starter app already includes the plumbing you need. The `IOptions<AzureStorageConfig>` constructor parameter in `BlobStorage` has two properties: the storage account connection string, and the name of the container your app will store blobs in. There is code in the `ConfigureServices` method of `Startup.cs` that loads the values from configuration when the app starts.

### Initialize

In the editor, open `Models/BlobStorage.cs`. To the top of the file, add the following `using` statements to prepare it for the code you're going to add during the exercise.

```csharp
using System.Linq;
using Microsoft.WindowsAzure.Storage;
using Microsoft.WindowsAzure.Storage.Blob;
```

Locate the `Initialize` method. Your app will call this method when `BlobStorage` is used for the first time. If you're curious, you can look at `ConfigureServices` in `Startup.cs` to see how this is done.

`Initialize` is where you want to create your container if it doesn't already exist. Replace the current implementation of `Initialize` with the following code, and save your work.

```csharp
public Task Initialize()
{
    CloudStorageAccount storageAccount = CloudStorageAccount.Parse(storageConfig.ConnectionString);
    CloudBlobClient blobClient = storageAccount.CreateCloudBlobClient();
    CloudBlobContainer container = blobClient.GetContainerReference(storageConfig.FileContainerName);
    return container.CreateIfNotExistsAsync();
}
```