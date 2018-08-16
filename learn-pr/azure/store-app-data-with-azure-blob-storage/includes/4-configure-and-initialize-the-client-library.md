Let's start writing code for an app that uses Blob storage. Here's the typical workflow inside an app that uses blobs:

1. At startup, load configuration for a storage account. This is usually a connection string: a single string containing the endpoint URL for the storage account and the account key that the app will use to authenticate all of its API calls.
1. Use the connection string to initialize the Azure Storage client library. This creates the objects the app will use to work with the Blob storage API.
1. Use the client library to operate on containers and blobs: creating, deleting and configuring blobs and containers, requesting lists of blobs, and reading and writing data in blobs.

## Configuring your connection string

Before writing any code, you'll need to know how to get a hold of the connection string for the storage account your app will be using. Most apps keep connection strings in some kind of configuration store, but keep in mind that the account key in a connection string is secret and should be stored securely.

> [!WARNING]
> **Do not place storage account keys in code or in unprotected configuration files.** Accidentally leaking keys by sharing source code or configuration files or placing them in a public location is an easy mistake to make without even realizing it, regardless of experience or skill level. Anyone who finds your storage account key has full access to the storage account and has the potential to inflict unrecoverable damage and generate large bills.
>
> In the exercise for this module, we will put a storage account connection string in an App Service Application Setting. Application Settings is a secure place for application secrets, but it does not support local development and is not a robust end-to-end solution on its own. The Additional Resources section at the end of this module has information about a more complete solution, as well as information about how to recover from a leaked storage account key.

## Initializing the blob storage object model

In the Azure Storage SDK for .NET Core, the standard pattern for using Blob storage consists of the following steps:

1. Call `CloudStorageAccount.Parse` (or `TryParse`) with your connection string to get a `CloudStorageAccount`.
1. Call `CreateCloudBlobClient` on the `CloudStorageAccount` to get a `CloudBlobClient`.
1. Call `GetContainerReference` on the `CloudBlobClient` to get a `CloudBlobContainer`.
1. Use methods on the container to get a list of blobs and/or get references to individual blobs to upload and download data.

In code, steps 1&ndash;3 look like this:

```csharp
CloudStorageAccount storageAccount = CloudStorageAccount.Parse(connectionString); // or TryParse()
CloudBlobClient blobClient = storageAccount.CreateCloudBlobClient();
CloudBlobContainer container = blobClient.GetContainerReference(containerName);
```

Keep in mind that none of this code makes calls over the network, so exceptions that may occur from incorrect information won't be thrown until later. For example, `GetContainerReference` will succeed whether or not the container actually exists in the account.

## Creating containers at startup

In unit 2, we discussed how we should let our application create its own containers, even when we know what those containers will be up-front. Calling `CreateIfNotExistsAsync` on a `CloudBlobContainer` is the best way to do this, and we should use it to create each container we know we'll need before we use them.

`CreateIfNotExistsAsync` *does* make a network call to Azure Storage, so we should call it only once, not every time we access a container.

## Exercise

### Clone and explore the unfinished app

It's time to work on some code! First, let's grab the unfinished upload/download app from GitHub and take a look around.

In the Cloud Shell terminal, run the following to get a copy of the source code from GitHub and open it in the editor:

```console
git clone TODO
cd TODO
code .
```

The best place for us to start is `Controllers/FilesController.cs` &mdash; open it up in the editor to have a look. This controller implements an API with three actions:

* **Index** (GET /api/Files) returns a list of URLs, one for each file that's been uploaded. The frontend calls this method to build a list of hyperlinks to the uploaded files.
* **Upload** (POST /api/Files) receives an uploaded file and saves it.
* **Download** (GET /api/Files/{filename}) downloads an individual file by its name.

Each method uses an `IStorage` instance called `storage` to do its work. There's already an implementation of `IStorage` in the app &mdash; `Models/BlobStorage.cs` &mdash; but before you start thinking that our work is already done, have a look at the implementation. It's useless! If we were to deploy the app right now, it would run, but uploaded files would simply be thrown away and there would never be anything available for download.

### Add the NuGet package

First, add a reference to the Azure Storage SDK. In the terminal, run the following:

```console
dotnet add package WindowsAzure.Storage
dotnet restore
```

This will make sure we're using the newest version of the Blob storage client library.

### Configuration

Our starter app already includes the configuration plumbing we need. The `IOptions<AzureStorageConfig>` constructor parameter in `BlobStorage` has two properties: the storage account connection string and the name of the container our app will store blobs in. Code in the `ConfigureServices` method of `Startup.cs` loads the values from configuration when the app starts up.

In this exercise, we won't be running the app anywhere except in Azure App Service, so we will add the configuration values to the App Service Application Settings later on. For now, we don't need to do any work related to configuration.

### Initialization

Open up `BlobStorage.cs` in the editor if you haven't already. You'll see it has a method called `Initialize` that our app will call when it's first used. If you're curious, you can take a look at `ConfigureServices` in `Startup.cs` to see how this is done. `Initialize` is where we want to create our container if it doesn't already exist.

Fill in `Initialize` with the following code:

```csharp
public Task Initialize()
{
    CloudStorageAccount storageAccount = CloudStorageAccount.Parse(storageConfig.ConnectionString);
    CloudBlobClient blobClient = storageAccount.CreateCloudBlobClient();
    CloudBlobContainer container = blobClient.GetContainerReference(storageConfig.FileContainerName);
    return container.CreateIfNotExistsAsync();
}
```

> [!NOTE]
> Make sure to save files with Ctrl+S when you're done editing them.