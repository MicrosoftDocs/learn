The Azure SDK for .NET includes methods for retrieving and setting blob properties and metadata.

Using the chemical company example, you want to use this SDK to modify your app, so that when your users locate a document a flag is written to metadata to indicate that the record has been retrieved.

In this unit, you will modify the code in an .NET Core app to write data to blob metadata.

## Metadata

1. Run the following command in the Cloud Shell to set metadata for safety-report-1234.rpt.

   ```azurecli
   az storage blob metadata update \
       --account-name $AZURE_STORAGE_ACCOUNT \
       --container-name $CONTAINER_NAME \
       --name safety-report-1234.rpt \
       --metadata productType=solvent state=liquid
   ```

1. Run the following command in the Cloud Shell to view metadata.

   ```azurecli
   az storage blob metadata show \
       --container-name $CONTAINER_NAME \
       --name safety-report-1234.rpt \
       --account-name $AZURE_STORAGE_ACCOUNT
   ```

1. Run the following command in the Cloud Shell to set metadata for safety-reports container.

   ```azurecli
   az storage container metadata update \
       --account-name $AZURE_STORAGE_ACCOUNT \
       --name $CONTAINER_NAME \
       --metadata auditLevel=high reportingState=included
   ```

1. Run the following command in the Cloud Shell to view container metadata.

   ```azurecli
   az storage container metadata show \
       --name $CONTAINER_NAME \
       --account-name $AZURE_STORAGE_ACCOUNT
   ```

## Edit the .NET app code

In this step, you'll modify the code used by the **ManageMetadata** app so that the app can update metadata.

1. In the Cloud Shell, use the code editor to open **ManageMetadata\Program.cs**.

1. Locate and examine the `AddContainerMetadataAsync()` method; this code adds `docType = SafetyReports` metadata to the container.

   ```csharp
   public static async Task AddContainerMetadataAsync(BlobContainerClient blobContainerClient)
   {
       Response<BlobContainerProperties> response = await blobContainerClient.GetPropertiesAsync();
       IDictionary<string, string> metadata = response.Value.Metadata;

       // Add metadata to the container
       metadata.Add("docType", "safetyReports");

       // Save the updated container metadata
       await blobContainerClient.SetMetadataAsync(metadata);
   }
   ```

1. Locate and examine the `AddBlobMetadataAsync()` method; this code adds `reportStatus = included` metadata every blob in the container. If you only wanted to add metadata to a single Blob, you would use a `BlobClient` to fetch only the individual blob and then use the `SetMetadataAsync` method to add the metadata.

   ```csharp
   public static async Task AddBlobMetadataAsync(BlobContainerClient blobContainerClient)
   {
       AsyncPageable<BlobItem> blobs = blobContainerClient.GetBlobsAsync(BlobTraits.Metadata);
       await foreach (var blobItem in blobs)
       {
           IDictionary<string, string> metadata = blobItem.Metadata;

           // Add a value to the metadata for the blob
           metadata.Add("reportStatus", "included");

           // You need a BlobClient object to update the metadata for a blob
           BlobClient blobClient = blobContainerClient.GetBlobClient(blobItem.Name);
           await blobClient.SetMetadataAsync(metadata);
      }
   }
   ```

1. Uncomment the following `AddContainerMetadataAsync()` call in the `ManageBlobMetadata()` method; this code calls the `AddContainerMetadataAsync()` method to add metadata to the container.

   ```csharp
   //await AddContainerMetadataAsync(blobContainerClient);
   ```

1. Uncomment the following `AddBlobMetadataAsync()` call in the `ManageBlobMetadata()` method; this code calls the `AddBlobMetadataAsync()` method to add metadata to each blob.

   ```csharp
   //await AddBlobMetadataAsync (blobContainerClient);
   ```

1. Save **ManageMetadata\Program.cs** and exit the code editor.

1. Run the following commands in the Cloud Shell to build and run the **ManageMetadata** app:

   ```azurecli
   dotnet build
   dotnet run --project ManageMetadata
   ```

1. The ManageMetadata app now connects to your blob storage, and queries the container and any blobs in that container. The app then updates the metadata, before displaying current properties and the updated metadata for the container and blobs. For example:

   ```bash
   Container Properties
   ------------------------------------------------------------
   Container name  : safety-reports
     Last modified : 9/30/2021 1:40:36 AM +00:00
     Container Metadata
       Key: docType  Value: safetyReports
   Blob Properties
   ------------------------------------------------------------
   Blob name: safety-report-1234.rpt
     Created on   : 9/29/2021 11:19:31 PM +00:00
     Last modified: 9/30/2021 1:40:49 AM +00:00
     Blob Metadata
       Key: reportStatus  Value: included
   Blob name: safety-report-5678.rpt
     Created on   : 9/29/2021 11:20:10 PM +00:00
     Last modified: 9/30/2021 1:40:52 AM +00:00
     Blob Metadata
       Key: reportStatus  Value: included
   Press any key to exit the sample application.
   ```
