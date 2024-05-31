The .NET Client library provides support for Azure storage. You can use this library to write your own custom applications that move data around Azure storage.

In this exercise, you see how to write an application that can migrate blobs from hot to cool storage.

## Create and add data to hot storage

First, create two accounts by using the Azure CLI.

  [!include[](../../../includes/azure-sandbox-regions-first-mention-note.md)]

1. Create environment variables for your storage account name and region. Replace `<location>` with a region from the previous list.

    ```azurecli
    HOT_STORAGE_NAME=hotstorage$RANDOM
    COOL_STORAGE_NAME=coolstorage$RANDOM
    LOCATION=<location>
    ```

1. Next, run the following command to create a storage account to hold blobs.

    ```azurecli
    az storage account create \
      --location $LOCATION \
      --name $HOT_STORAGE_NAME \
      --resource-group <rgn>[Sandbox resource group]</rgn> \
      --sku Standard_RAGRS \
      --kind BlobStorage \
      --access-tier Hot
    ```

1. Create a storage account for holding the archived blobs. Use the **Cool** access tier. As before, specify an appropriate region, and choose a unique name for your storage account.

    ```azurecli
    az storage account create \
      --location $LOCATION \
      --name $COOL_STORAGE_NAME \
      --resource-group <rgn>[Sandbox resource group]</rgn> \
      --sku Standard_RAGRS \
      --kind BlobStorage \
      --access-tier Cool

1. Obtain the keys for your storage account.

    ```azurecli
    az storage account keys list \
      --account-name $HOT_STORAGE_NAME \
      --resource-group <rgn>[Sandbox resource group]</rgn> \
      --output table
    ```

1. Create an environment variable for your account key. Use the value of the first key retrieved by the previous command.

    ```bash
    HOT_KEY="<source account key>"
    ```

1. Create a container named *specifications* in your storage account.

    ```azurecli
    az storage container create \
      --name specifications \
      --account-name $HOT_STORAGE_NAME \
      --account-key $HOT_KEY
   ```

1. Run the following command to download the sample source code for this exercise.

    ```bash
    git clone https://github.com/MicrosoftDocs/mslearn-copy-move-blobs-from-containers-or-storage-accounts sample
    ```

1. Upload the files to your storage account and save each one as a blob. This command uploads several specification files.

    ```azurecli
    az storage blob upload-batch \
      --destination specifications \
      --pattern "*.md" \
      --source ~/sample/specifications \
      --account-name $HOT_STORAGE_NAME \
      --account-key $HOT_KEY
    ```

1. Verify that the blobs are created.

    ```azurecli
    az storage blob list \
      --container-name specifications \
      --output table \
      --account-name $HOT_STORAGE_NAME \
      --account-key $HOT_KEY
    ```

## Set up your project

1. Move to the samples folder.

    ```bash
    cd sample/code
    ```

1. Open the *TransferBlobs.csproj* project file using the `Code` editor.

    ```bash
    code TransferBlobs/TransferBlobs.csproj
    ```

1. Change the `<TargetFramework>` value to *net7.0*.

    ```C#
    <PropertyGroup>
      <OutputType>Exe</OutputType>
      <TargetFramework>net7.0</TargetFramework>
    </PropertyGroup>
    ```

1. Save the file by selecting <kbd>Ctrl+S</kbd>, and close the `Code` editor by selecting <kbd>Ctrl+Q</kbd>.

1. Build the sample application.

    ```bash
    dotnet build TransferBlobs
    ```

## Examine the TransferBlobs application

1. Move to the *TransferBlobs* subdirectory. This subdirectory contains the source code for the sample application.

    ```bash
    cd TransferBlobs
    ```

1. Open the *Program.cs* file using the `Code` editor.

    ```bash
    code Program.cs
    ```

1. Look at the first few lines of the application in the `Main` method:

    ```C#
    string sourceConnection = args[0];
    string sourceContainer = args[1];
    string destConnection = args[2];
    string destContainer = args[3];
    DateTimeOffset transferBlobsModifiedSince = DateTimeOffset.Parse(args[4]);
    Console.WriteLine($"Moving blobs modified since {transferBlobsModifiedSince}");
    ```

    The *TransferBlobs* application takes the following command-line parameters:

    - A connection string for accessing the source storage account.
    - The name of the container in the source storage account containing the blobs that you want to move.
    - A connection string for accessing the destination storage account.
    - The name of the container in the destination storage account for holding the blobs after they're moved.
    - A date/time string ([in UTC](https://www.bing.com/search?q=utc+time)). Blobs in the source container that **have been modified** since this date and time are moved to the destination.

    > [!NOTE]
    > This application performs no validation or error handling. This is to keep the code short and concise. In a production system, you should validate all input carefully, and implement error handling for all storage account operations.

1. Examine the code under the comment `Connect to Azure Storage`.

    ```C#
    // Connect to Azure Storage
    BlobServiceClient sourceClient = new BlobServiceClient(sourceConnection);
    BlobServiceClient destClient = new BlobServiceClient(destConnection);

    BlobContainerClient sourceBlobContainer = sourceClient.GetBlobContainerClient(sourceContainer);
    sourceBlobContainer.CreateIfNotExists();

    BlobContainerClient destBlobContainer = destClient.GetBlobContainerClient(destContainer);
    destBlobContainer.CreateIfNotExists();
    ```

    This block of code creates `BlobServiceClient` objects for the source and destination accounts. Then, it creates `BlobContainerClient` objects that you can use to access blobs in these accounts. The *sourceBlobContainer* variable is a reference to the container in the source account, containing the blobs to be moved. The *destBlobContainer* variable is a reference to the container in the destination account, where the blobs are to be transferred and stored.

1. Scroll down to the method `FindMatchingBlobsAsync`.

    ```C#
    // Find all blobs that have been modified since the specified date and time
    private static async Task<IEnumerable<BlobClient>> FindMatchingBlobsAsync(BlobContainerClient blobContainer, DateTimeOffset transferBlobsModifiedSince)
    {
        List<BlobClient> blobList = new List<BlobClient>();

        // Iterate through the blobs in the source container
        List<BlobItem> segment = await blobContainer.GetBlobsAsync(prefix: "").ToListAsync();
        foreach (BlobItem blobItem in segment)
        {
            BlobClient blob = blobContainer.GetBlobClient(blobItem.Name);

            // Check the source file's metadata
            Response<BlobProperties> propertiesResponse = await blob.GetPropertiesAsync();
            BlobProperties properties = propertiesResponse.Value;
            
            // Check the last modified date and time
            // Add the blob to the list if has been modified since the specified date and time
            if (DateTimeOffset.Compare(properties.LastModified.ToUniversalTime(), transferBlobsModifiedSince.ToUniversalTime()) > 0)
            {
                blobList.Add(blob);
            }
        }

        // Return the list of blobs to be transferred
        return blobList;
    }
    ```

    This method takes a blob container and a `DateTimeOffset` object. The method iterates through the container to find all blobs that have a last modified date after the value specified in the `DateTimeOffset` object. The *blobList* collection is populated with a reference to each matching blob. When the method finishes, the *blobList* collection is passed back to the caller.

    In the *Main* method, invoke the `FindMatchingBlobsAsync` method with the following statement.

    ```C#
    // Find all blobs that have been changed since the specified date and time
    IEnumerable<BlobClient> sourceBlobRefs = await FindMatchingBlobsAsync(sourceBlobContainer, transferBlobsModifiedSince);
    ```

1. Scroll down to the `MoveMatchingBlobsAsync` method.

    ```C#
    // Iterate through the list of source blobs, and transfer them to the destination container
    private static async Task MoveMatchingBlobsAsync(IEnumerable<BlobClient> sourceBlobRefs, BlobContainerClient sourceContainer, BlobContainerClient destContainer)
    {
        foreach (BlobClient sourceBlobRef in sourceBlobRefs)
        {
            // Copy the source blob
            BlobClient sourceBlob = sourceContainer.GetBlobClient(sourceBlobRef.Name);

            // Check the source file's metadata
            Response<BlobProperties> propertiesResponse = await sourceBlob.GetPropertiesAsync();
            BlobProperties properties = propertiesResponse.Value;
            BlobClient destBlob = destContainer.GetBlobClient(sourceBlobRef.Name);
            CopyFromUriOperation ops = await destBlob.StartCopyFromUriAsync(GetSharedAccessUri(sourceBlobRef.Name, sourceContainer));

            // Display the status of the blob as it is copied
            while(ops.HasCompleted == false)
            {
                long copied = await ops.WaitForCompletionAsync();
                Console.WriteLine($"Blob: {destBlob.Name}, Copied: {copied} of {properties.ContentLength}");
                    await Task.Delay(500);
            }
            Console.WriteLine($"Blob: {destBlob.Name} Complete");

            // Remove the source blob
            bool blobExisted = await sourceBlobRef.DeleteIfExistsAsync();
        }
    }
    ```

    The parameters to this method are the list of blobs to be moved, and the source and destination containers. The code iterates through the list of blobs and uses the `StartCopyFromUriAsync` method to start copying each blob in turn. Once the copy operation is initiated, the code queries the status of the destination blob at 0.5-second intervals, displaying the progress of the operation, until the copy is complete. The blob is removed from the source container when the copy is complete.

    The `StartCopyFromUriAsync` method call takes a URL containing a SAS token for the source object, as described in the previous unit.

    In the *Main* method, invoke `MoveMatchingBlobsAsync` method with the following statement.

    ```C#
    // Move matching blobs to the destination container
    await MoveMatchingBlobsAsync(sourceBlobRefs, sourceBlobContainer, destBlobContainer);
    ```

## Test the TransferBlobs application

1. Using the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true), move to your source (hot) storage account.

1. Under **Security + networking**, select **Access keys**. Make a copy of the connection string for **key** in a text file on your local computer.

1. Under **Data storage**, select **Containers**.

1. Select the **specifications** container.

Modify a few of the blobs, so that you have some blobs with a different modified date from the batch upload time.

1. From the **specifications** container, select one of the specification files (for example, _specifications04.md_).

1. Select the **Edit** tab from the blob panel, and add any text you want.

1. Select **Save** to commit the changes to the blob.

1. Repeat these steps to modify one or two other blob files.

With several blobs showing newer modification dates, you can differentiate between them when you run the .NET app.

1. In the list of blobs in this container, note the modification date for the blobs. Select a date and time that is roughly in the middle of the modification date for the blobs (some blobs should have a modification time before your selected date, and others after).

    > [!NOTE]
    > The Azure portal will show times in your local time zone, but our program will expect them in [UTC time](https://www.bing.com/search?q=utc+time&PC=U316&FORM=CHROMN). Adjust your date from what the Azure portal has shown to it's UTC value. For example, if your time was `6/15/2021, 10:04:27 AM` in Korean Standard Time (KST), you would need to subtract 9 hours to UTC: `6/15/2021, 01:04:27 AM`.

1. Using the portal, move to your destination (cool) storage account.

1. Under **Security + networking**, select **Access keys**. Make a copy of the connection string for **key** in a text file on your local computer.

1. In the **Data storage** section, select **Containers**.

1. Select **+ Container**, and create a new container named **transfer-test**.

1. In the Cloud Shell window, run the following command. Replace *\<source connection string>* and *\<destination connection string>* with the connection strings you recorded in notepad. Replace *\<selected date and time>* with the date and time for your blobs, in the same format as it appeared in the Azure portal. To prevent the Bash shell from interpreting the connection strings and date/time, enclose them in double quotes:

    ```bash
    dotnet run "<source connection string>" specifications "<destination connection string>" transfer-test "<selected date and time>"
    ```

    > [!NOTE]
    > If your file does not find any files to move, you may need to adjust your date from what the Azure portal has customized to your timezone to it's UTC time as it is used by the program. For example, if your time was edit date was `6/15/2021, 10:04:27 AM` in Korea Standard Time (KST), you would need to subtract 9 hours to UTC: `6/15/2021, 01:04:27 AM`.

1. The application should list the name of each matching blob that it finds, and move them.

1. When the application finishes, return to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true).

1. Move to your destination (cool) storage account.

1. Browse the **transfer-test** folder. Verify it contains the blobs that were moved.

1. Move to your source (hot) storage account.

1. Browse the **specifications** folder. Verify that the blobs that were transferred are removed from this folder.
