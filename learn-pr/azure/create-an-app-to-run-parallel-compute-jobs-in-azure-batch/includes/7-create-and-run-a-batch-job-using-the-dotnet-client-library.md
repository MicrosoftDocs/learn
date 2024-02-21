You now have a .NET core app that can connect to the Azure Batch service, and has created a pool with three nodes. In the remaining exercises of this module, we'll implement the following list of remaining features:

- Upload video files and make them available for Azure Batch service
- Create a job to run on those nodes
- Add a task to convert the video to the job
- Run the job to convert the uploaded videos
- Monitor the state of the conversion tasks
- Clean up Batch service resources to avoid any extra usage charges (with the option to delete the pool if the processing for the day has finished)

## Batch Management

Using the Batch client API, you'll use the following methods to create, delete, and monitor the components of your app:

___
- **batchClient.PoolOperations.CreatePool**: you added this to the app in the previous exercise
- **batchClient.PoolOperations.DeletePoolAsync**
___
- **batchClient.JobOperations.CreateJob**
- **batchClient.JobOperations.AddTaskAsync**
- **batchClient.JobOperations.DeleteJobAsync**
___
- **batchClient.Utilities.CreateTaskStateMonitor**
___

## File Management

You'll use the storage account you created earlier to create containers to store the input and output files in blob storage. From the Azure Storage Blob client library, you'll use the following classes and methods:

___
- **CloudStorageAccount**: gains access to the created Storage account
- **CloudStorageAccount.Parse(storageConnectionString)**: connects to the Storage account
- **storageAccount.CreateCloudBlobClient**: creates a CloudBlobClient
___
- **CloudBlobClient**: creates a container
- **blobClient.GetContainerReference(containerName)**: enables the creation of containers
___
- **CloudBlobContainer**: creates blob storage
- **container.GetBlockBlobReference(blobName)**: creates a CloudBlockBlob
- **container.CreateIfNotExistsAsync**: creates the container if it doesn't exist
- **container.DeleteIfExistsAsync**: deletes the container if it exists
___
- **CloudBlockBlob**: adds or removes files to blob storage
- **blobData.UploadFromFileAsync(filePath)**: uploads the specified local file to Azure Storage
- **blobData.GetSharedAccessSignature(sasConstraints)**: gets a shared access signature URI to be used to access the uploaded video
___
- **ResourceFile.FromUrl(blobSasUri, blobName)**: provides a filepath to the video in Azure Storage
___

You need to take a number of steps to enable an app to transfer files to Azure Storage. The console app will also need to enable the Batch tasks to write their output to blob storage.

1. Add the `Microsoft.Azure.Storage.Blob` NuGet package
1. Using the Azure Storage credentials, connect to the Storage account
1. Create a blob in the storage account
1. Create two containers for the input and output files using the blob client
1. Upload local MP4 video files using the input container and store a list of files for the Batch job
1. Once the videos have been converted, the input container can be deleted, removing all the uploaded videos from Azure
