The .NET SDK includes methods for retrieving and setting blob properties and metadata.

Using the chemical company example, you want to use this SDK to develop an ASP.NET Core app, so that your users can easily find all relevant documents as part of the safety audit.

In this unit, you'll deploy an ASP.NET Core app retrieve blob properties.

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

1. Run the following command in the Cloud Shell to create a container in your storage account.

   ```azurecli
   az storage container create \
   --name $CONTAINER_NAME \
   --account-name $AZURE_STORAGE_ACCOUNT
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
   --name safety-report-5678.rpt \
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

You're now ready to deploy and test out some code. First you'll set the environment variables required by the sample app. You'll then build and run the sample app (ignore the warnings about the Microsoft.Azure.KeyVault.Core package).

1. Run the following commands in the Cloud Shell to store the environment variables used by the app:

   ```bash
   export AZURE_STORAGE_KEY=`az storage account keys list --account-name $AZURE_STORAGE_ACCOUNT --query [0].value | tr -d \"`

   export CONNECTION_STRING=`az storage account show-connection-string --name $AZURE_STORAGE_ACCOUNT --query connectionString | tr -d \"`
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
   Connecting to blob storage
   Connected
   Fetching the details of all blobs
   Container metadata:
   Blob metadata:
      Name: safety-report-1234.rpt
      Name: safety-report-5678.rpt
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
      container.FetchAttributesAsync();
      ```

   - And the following code snippet retrieves the properties and metadata for a blob: 

      ```csharp
      blob.FetchAttributesAsync();
      ```

   - The following code displays any properties and metadata to the console:

      ```csharp
      Console.WriteLine("\tKey: {0}", metadataItem.Key);
      Console.WriteLine("\tValue: {0}", metadataItem.Value);
      ```
