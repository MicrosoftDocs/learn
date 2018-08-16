In this module, you learned how to use Blob storage to store web application data. We discussed tips for creating a strategy to use Blob storage in a web app and how to use the Azure Storage SDK for .NET Core to write to and read from blobs. The app we made accepts uploaded files from users, stores them in Blob storage, and makes them available for download.

## Cleanup

To clean up your Azure subscription, run the following in the Cloud Shell to delete the resource group containing all the resources we created in this module.

```console
az group delete --name blob-exercise-group
```

To clean up your Cloud Shell storage, delete the `TODO` directory with `rm -rf TODO`.

## What next?

The app we built can be improved and changed in a number of ways:

* Unit 2 talked about how containers can be configured to allow unauthenticated users to download blob contents. Our app could be modified to do this: enable public access on the container and change `FilesController.Index` to return URLs that point to the storage URLs instead of the `Download` controller action. Once you do this, `FilesController.Download` would no longer be used.
* Refactoring: The code to parse the connection string, create a CloudBlobClient and get a reference to the container is repeated multiple times. All of these methods are lightweight, none of them make network calls and all of the objects they create can be reused. This code could be moved to the `BlobStorage` constructor, and we could store the resulting `CloudBlobClient` and/or `CloudBlobContainer` as reusable field members instead of the `AzureStorageConfig`.
* New features: support multiple folders, zipped uploads and downloads of multiple files at one time... anything you could think of!
* Improved error handling and concurrency management (see Additional Resources for more information on concurrency)
* The app could be modified to use a database to manage blobs instead of relying solely on blob storage. This would add flexibility at the cost of introducing complexity.

## Additional resources

** TODO cross-docset links?**

* **Securely storing storage account keys**: The most robust end-to-end solution for storing secret configuration values is Azure Key Vault. See [here](https://docs.microsoft.com/aspnet/core/security/key-vault-configuration?view=aspnetcore-2.1&tabs=aspnetcore2x) for information about using Key Vault in an ASP.NET Core application. Alternatively, you can safely store connection strings in App Service Application Settings and use the [ASP.NET Core Secret Manager tool](https://docs.microsoft.com/aspnet/core/security/app-secrets?view=aspnetcore-2.1&tabs=windows) to support developer environments.
* [Uploading large files with streaming in ASP.NET Core](https://docs.microsoft.com/aspnet/core/mvc/models/file-uploads?view=aspnetcore-2.1#uploading-large-files-with-streaming)
* [Blob concurrency: AccessConditions and blob leases](https://azure.microsoft.com/blog/managing-concurrency-in-microsoft-azure-storage-2/)
* [Granting limited access to Azure Storage object with Shared Access Signatures (SAS)](https://docs.microsoft.com/azure/storage/common/storage-dotnet-shared-access-signature-part-1)
* [Indexing Blob Storage with Azure Search](https://docs.microsoft.com/azure/search/search-howto-indexing-azure-blob-storage)
* [Container and blob name restrictions](https://docs.microsoft.com/rest/api/storageservices/naming-and-referencing-containers--blobs--and-metadata#resource-names)