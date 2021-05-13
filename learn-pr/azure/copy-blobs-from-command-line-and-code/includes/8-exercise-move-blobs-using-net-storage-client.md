The .NET Client library provides support for Azure storage. You can use this library to write your own custom applications tha move data around Azure storage.

In this exercise, you'll see how to write an application that can migrate blobs from hot to cool storage.

## Setup

We'll start by downloading and building an existing .NET Core application. You may have cloned the sample git repository in a previous exercise.

1. Before we begin, you need to repopulate your hot storage account using the command you ran in the previous exercise. Run this command in the Cloud Shell window to give yourself new blobs to manage.

    ```azurecli
    az storage blob upload-batch \
      --destination specifications \
      --pattern "*.md" \
      --source ~/sample/specifications \
      --account-name $HOT_STORAGE_NAME \
      --account-key $HOT_KEY
    ```

1. Next, run the following command to download the sample source code for this exercise.

    ```bash
    git clone https://github.com/MicrosoftDocs/mslearn-copy-move-blobs-from-containers-or-storage-accounts sample
    ```

1. Move to the samples folder.

    ```bash
    cd sample/code
    ```

1. Build the sample application.

    ```bash
    dotnet build
    ```

## Examine the ArchiveBlobs application

1. Move to the *ArchiveBlobs* subdirectory. This subdirectory contains the source code for the sample application.

    ```bash
    cd ArchiveBlobs
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
    DateTime transferBlobsNotModifiedSince = DateTime.Parse(args[4]);
    Console.WriteLine($"Moving blobs not modified since {transferBlobsNotModifiedSince}");
    ```

    The *ArchiveBlobs* application takes the following command-line parameters:

    - A connection string for accessing the source storage account
    - The name of the container in the source storage account containing the blobs that you want to move
    - A connection string for accessing the destination storage account
    - The name of the container in the destination storage account for holding the blobs after they've been moved
    - A date/time string. Blobs in the source container that haven't been modified since this date and time will be moved to the destination

    > [!NOTE]
    > This application performs no validation or error handling. This is to keep the code short and concise. In a production system, you should validate all input carefully, and implement error handling for all storage account operations.

1. Examine the code under the comment `Connect to Azure Storage`.

    ```C##
    // Connect to Azure Storage
    CloudStorageAccount sourceAccount = CloudStorageAccount.Parse(sourceConnection);
    CloudStorageAccount destAccount = CloudStorageAccount.Parse(destConnection);
    CloudBlobClient sourceClient = sourceAccount.CreateCloudBlobClient();
    CloudBlobClient destClient = destAccount.CreateCloudBlobClient();
    CloudBlobContainer sourceBlobContainer = sourceClient.GetContainerReference(sourceContainer);
    ```

    This block of code creates `CloudStorageAccount` objects for the source and destination accounts, and then creates `CloudBlobClient` objects that you can use to access blobs in these accounts. The *sourceBlobContainer* variable is a reference to the container in the source account, containing the blobs to be moved.

1. Scroll down to the method `FindMatchingBlobsAsync`.

    ```C#
    // Find all blobs that haven't been modified since the specified date and time
    private static async Task<IEnumerable<ICloudBlob>> FindMatchingBlobsAsync(CloudBlobContainer blobContainer, DateTime transferBlobsNotModifiedSince)
    {
        List<ICloudBlob> blobList = new List<ICloudBlob>();
        BlobContinuationToken token = null;

        // Iterate through the blobs in the source container
        do
        {
            BlobResultSegment segment = await
                blobContainer.ListBlobsSegmentedAsync(prefix: "", currentToken: token);

            foreach (CloudBlockBlob blobItem in segment.Results)
            {
                ICloudBlob blob = await blobContainer.GetBlobReferenceFromServerAsync(blobItem.Name);

                // Check the last modified date and time
                // Add the blob to the list if has not been modified since the specified date and time
                if (DateTime.Compare(blob.Properties.LastModified.Value.UtcDateTime, transferBlobsNotModifiedSince) <= 0)
                {
                    blobList.Add(blob);
                }
            }
        } while (token != null);

        // Return the list of blobs to be transferred
        return blobList;
    }
    ```

    This method takes a blob container and a `DateTime` object. The method iterates through the container to find all blobs that have a last modified date before the value specified in the `DateTime` object. The *blobList* collection is populated with a reference to each matching blob. When the method finishes, the *blobList* collection is passed back to the caller.

    In the *Main* method, this method is invoked by the following statement.

    ```C#
    // Find all blobs that haven't changed since the specified date and time
     Enumerable<ICloudBlob> sourceBlobRefs = FindMatchingBlobsAsync(sourceBlobContainer, transferBlobsNotModifiedSince).Result;
    ```

1. Scroll down to the `MoveMatchingBlobsAsync` method.

    ```C#
    // Iterate through the list of source blobs, and transfer them to the destination container
    private static async Task MoveMatchingBlobsAsync(
        IEnumerable<ICloudBlob> sourceBlobRefs,
        CloudBlobContainer sourceContainer,
        CloudBlobContainer destContainer)
    {
        foreach (ICloudBlob sourceBlobRef in sourceBlobRefs)
        {
            // Copy the source blob
            CloudBlockBlob destBlob = destContainer.GetBlockBlobReference(sourceBlobRef.Name);

            await destBlob.StartCopyAsync(new Uri(GetSharedAccessUri(sourceBlobRef.Name, sourceContainer)));

            // Display the status of the blob as it is copied
            ICloudBlob destBlobRef = await destContainer.GetBlobReferenceFromServerAsync(sourceBlobRef.Name);
            while (destBlobRef.CopyState.Status == CopyStatus.Pending)
            {
                Console.WriteLine($"Blob: {destBlobRef.Name}, Copied: {destBlobRef.CopyState.BytesCopied ?? 0} of  {destBlobRef.CopyState.TotalBytes ?? 0}");
                await Task.Delay(500);
                destBlobRef = await destContainer.GetBlobReferenceFromServerAsync(sourceBlobRef.Name);
            }
            Console.WriteLine($"Blob: {destBlob.Name} Complete");

            // Remove the source blob
            bool blobExisted = await sourceBlobRef.DeleteIfExistsAsync();
        }
    }
    ```

    The parameters to this method are the list of blobs to be moved, and the source and destination containers. The code iterates through the list of blobs and uses the `StartCopyAsync` method to start copying each blob in turn. Once the copy operation has been initiated, the code queries the status of the destination blob at 0.5-second intervals, displaying the progress of the operation, until the copy is complete. When the blob has been copied, it is removed from the source container.

    The `StartCopyAsync` method call takes a URL containing a SAS token for the source object, as described in the previous unit.

## Test the ArchiveBlobs application

1. Using the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true), move to your source (hot) storage account.

1. Under **Settings**, select **Access keys**. Make a copy of the connection string for **key** in a text file on your local computer.

1. Under **Blob service**, select **Containers**.

1. Select the **specifications** container.

To have some blobs with a different modified date from the batch upload time, you'll modify a few of them.

1. From the **specifications** container, select one of the specification files (for example, _specifications04.md_).

1. Select the **Edit** tab from the blob panel, and add any text you want.

1. select **Save** to commit the changes to the blob.

1. Repeat this for one or two additional blob files.

With several blobs showing newer modification dates, you can differentiate between them when you run the .NET app.

1. In the list of blobs in this container, note the modification date for the blobs. Select a date and time that is roughly in the middle of the modification date for the blobs (some blobs should have a modification time before your selected date, and others after).

1. Using the portal, move to your destination (cool) storage account.

1. Under **Settings**, select **Access keys**. Make a copy of the connection string for **key** in a text file on your local computer.

1. In the **Blob service** section, click **Containers**.

1. Select **+ Container**, and create a new container named **archive-test**.

1. In the Cloud Shell window, run the following command. Replace *\<source connection string>* and *\<destination connection string>* with the connection strings you recorded in notepad. Replace *\<selected date and time>* with the date and time for your blobs, in the same format as it appeared in the Azure portal. Enclose the connection strings and date/time in double quotes, to prevent them being interpreted by the Bash shell:

    ```bash
    dotnet run "<source connection string>" specifications "<destination connection string>" archive-test "<selected date and time>"
    ```

1. The application should list the name of each matching blob that it finds, and move them.

1. When the application has finished, return to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true).

1. Move to your destination (cool) storage account.

1. Browse the **archive-test** folder. Verify it contains the blobs that were moved.

1. Move to your source (hot) storage account.

1. Browse the **specifications** folder. Verify the blobs that were transferred have been removed from this folder.
