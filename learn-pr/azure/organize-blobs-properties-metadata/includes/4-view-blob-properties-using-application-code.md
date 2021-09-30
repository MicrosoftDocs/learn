The Azure SDK for .NET includes methods for retrieving and setting blob properties and metadata.

Using the chemical company example, you want to use this SDK to develop a .NET Core app, so that your users can easily find all relevant documents as part of the safety audit.

In this unit, you'll deploy an .NET Core app retrieve blob properties.

### Prepare storage account and blob

In this step, you'll create a new storage account and container, and then upload a file to the container.

1. Run the following command in the Cloud Shell to create a sample file that you will use in later examples.

   ```bash
   touch safety-report.rpt
   ```

1. Run the following command in the Cloud Shell to set environment variables that you will use in later commands; these variables specify the name of Azure storage account, a storage container name, and a region (select from below).

   [!include[](../../../includes/azure-sandbox-regions-note.md)]

   ```bash
   export AZURE_STORAGE_ACCOUNT=<unique name>
   export CONTAINER_NAME=safety-reports
   export RESOURCE_GROUP=<rgn>[sandbox resource group name]</rgn>
   export AZURE_REGION=<your region>
   ```

1. Run the following command in the Cloud Shell to create a new storage account.

   ```azurecli
   az storage account create \
       --location $AZURE_REGION \
       --name $AZURE_STORAGE_ACCOUNT \
       --resource-group $RESOURCE_GROUP \
       --kind StorageV2 \
       --sku Standard_LRS
   ```

1. To run subsequent operations against your storage account, you will need the storage account key

   ```bash
   export AZURE_STORAGE_KEY=`az storage account keys list -g $RESOURCE_GROUP -n $AZURE_STORAGE_ACCOUNT --query [0].value --output tsv`
   ```

1. Run the following command in the Cloud Shell to create a container in your storage account.

   ```azurecli
   az storage container create \
       --name $CONTAINER_NAME \
       --account-name $AZURE_STORAGE_ACCOUNT \
       --account-key $AZURE_STORAGE_KEY
   ```


1. Run the following command in the Cloud Shell to upload a blob to the **safety-reports** container. The file will be called **safety-report-1234.rpt** when it has been uploaded.

   ```azurecli
   az storage blob upload \
       --file safety-report.rpt \
       --name safety-report-1234.rpt \
       --container-name $CONTAINER_NAME \
       --account-name $AZURE_STORAGE_ACCOUNT
   ```

   Note the `etag` and `lastModified` properties are displayed.

1. Run the following command in the Cloud Shell to upload a blob to the **safety-reports** container. The file will be called **safety-report-5678.rpt** when it has been uploaded.

   ```azurecli
   az storage blob upload \
       --file safety-report.rpt \
       --name safety-report-9876.rpt \
       --container-name $CONTAINER_NAME \
       --account-name $AZURE_STORAGE_ACCOUNT
   ```

1. Run the following command in the Cloud Shell to list the blobs in your container and check that your files have uploaded:

   ```azurecli
   az storage blob list \
       --container-name $CONTAINER_NAME \
       --account-name $AZURE_STORAGE_ACCOUNT \
       --output table
   ```

   The output you see resembles this example.

   ```bash
   Name                    Blob Type    Blob Tier    Length    Content Type              Last Modified         Snapshot
   ----------------------  -----------  -----------  --------  ------------------------  -------------------------  ----------
   safety-report-1234.rpt  BlockBlob    Hot                    application/octet-stream  2019-04-22T00:19:20+00:00
   safety-report-5678.rpt  BlockBlob    Hot                    application/octet-stream  2019-04-22T00:19:23+00:00
   ```

## Manage metadata in code

You're now ready to deploy and test out some code. First you'll set the environment variables required by the sample app. You'll then build and run the sample app.

1. Run the following commands in the Cloud Shell to store the environment variables used by the app:

   ```bash
   export STORAGE_CONNECTION_STRING=`az storage account show-connection-string -g $RESOURCE_GROUP -n $AZURE_STORAGE_ACCOUNT --output tsv`
   ```

1. Run the following command in the Cloud Shell to build and run the **ManageMetadata** app:

   ```bash
   git clone https://github.com/microsoftdocs/mslearn-organize-blobs-properties-metadata ManageMetadata
   cd ManageMetadata
   dotnet build
   dotnet run --project ManageMetadata
   ```
   <!-- TODO: Update the github repo path when it has been set up -->

1. The ManageMetadata app now connects to your blob storage, and queries the container and any blobs in that container. The app then displays some current properties and any metadata for the container and blobs. For example:

   ```bash
   Container Properties
   ------------------------------------------------------------
   Container name  : safety-reports
     Last modified : 9/29/2021 11:18:37 PM +00:00
     Container Metadata
   Blob Properties
   ------------------------------------------------------------
   Blob name: safety-report-1234.rpt
     Created on   : 9/29/2021 11:19:31 PM +00:00
     Last modified: 9/29/2021 11:19:31 PM +00:00
     Blob Metadata
   Blob name: safety-report-5678.rpt
     Created on   : 9/29/2021 11:20:10 PM +00:00
     Last modified: 9/29/2021 11:20:10 PM +00:00
     Blob Metadata
   Press any key to exit the sample application.
   ```

## Review the app code

In this final step, you'll take a look at the code used by the ManageMetadata app to query containers and blobs for properties and metadata.

1. In the Cloud Shell, use the editor to open Program.cs.

   ```bash
   code ManageMetadata/Program.cs
   ```

1. The key parts of the app are the lines of code that look like the following examples:

   - The following code snippet retrieves the properties and metadata for a container:

      ```csharp
      Response<BlobContainerProperties> response = await blobContainerClient.GetPropertiesAsync();
      BlobContainerProperties containerProperties = response.Value;
      Console.WriteLine($"Container name  : {blobContainerClient.Name}");
      Console.WriteLine($"  Last modified : {containerProperties.LastModified}");

      foreach (var key in containerProperties.Metadata.Keys)
      {
          var value = containerProperties.Metadata[key];
          Console.WriteLine($"    Key: {key}  Value: {value}");
      }
      ```

   - And the following code snippet retrieves the properties and metadata for a blob.  Note that you must include the `BlobTraits.Metadata` value when calling `GetblobsAsync` otherwise the metadata will not be included with the returned `BlobItem` objects.

      ```csharp
      AsyncPageable<BlobItem> blobs = blobContainerClient.GetBlobsAsync(BlobTraits.Metadata);
      await foreach (var blobItem in blobs)
      {
          Console.WriteLine($"Blob name: {blobItem.Name}" );
          Console.WriteLine($"  Created on   : {blobItem.Properties.CreatedOn}");
          Console.WriteLine($"  Last modified: {blobItem.Properties.LastModified}");

          foreach (var key in blobItem.Metadata.Keys)
          {
              var value = blobItem.Metadata[key];
              Console.WriteLine($"    Key: {key}  Value: {value}");
          }               
      }
      ```
