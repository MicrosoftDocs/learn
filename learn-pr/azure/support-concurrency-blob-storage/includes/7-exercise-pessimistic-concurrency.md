Now that you have seen optimistic concurrency, you decide to implement a pessimistic approach to concurrency. In this example, you use a lease to lock the blob in Azure Blob storage while the reporter writes their story. 

In this exercise you'll:

- Change the `SimulateReporter` method to use a lease
- Test the updated app

## Add pessimistic concurrency to the existing code

1. Open the Program.cs file.

    ```bash
    code Program.cs
    ```

1. Change the code in the `SimulateReporter` method from using ETags to using a lease. Replace the method contents with the following code:

    ```csharp
    BlobClient blobClient = containerClient.GetBlobClient(blobName);

    // First, the reporter retrieves the current contents
    Console.WriteLine($"{authorName} begins work");

    Response<BlobDownloadResult> response = await blobClient.DownloadContentAsync();
    BlobDownloadResult downloadResult = response.Value;
    string contents = downloadResult.Content.ToString();
    Console.WriteLine($"{authorName} loads the file and sees the following content: \"{contents}\"");

    // Acquire a lease on the file
    BlobLeaseClient blobLeaseClient = blobClient.GetBlobLeaseClient();
    BlobLease lease = null;
    try
    {
        lease = await blobLeaseClient.AcquireAsync(TimeSpan.FromSeconds(60));
        Console.WriteLine($"{authorName} has this acquired a lease on the blob");

        // Next, the author writes their story. This takes some time.
        Console.WriteLine($"{authorName} begins writing their story...");
        await Task.Delay(writingTime);
        Console.WriteLine($"{authorName} has finished writing their story");

        // Finally, they save their story back to the blob.
        var story = $"[[{authorName.ToUpperInvariant()}'S STORY]]";

        // Set the request condition to include the lease ID.
        BlobUploadOptions blobUploadOptions = new BlobUploadOptions()
        {
            Conditions = new BlobRequestConditions()
            {
                LeaseId = lease.LeaseId
            }
        };
        await blobClient.UploadAsync(BinaryData.FromString(story), blobUploadOptions);
        Console.WriteLine($"{authorName} has saved their story to Blob storage. New blob contents: \"{story}\"");
    }
    catch (RequestFailedException e) when (e.Status == (int)HttpStatusCode.Conflict)
    {
        // Catch error if there is an active lease on the blob.
        // This error indicates to the client that another client has locked the blob.
        // The client should wait until the lease is released and try again.
        Console.WriteLine($"{authorName}: Sorry, cannot retrieve the file as server returned an error: {e.Message}");
    }
    catch (RequestFailedException e) when (e.Status == (int)HttpStatusCode.PreconditionFailed)
    {
        // Catch error if the lease ID is not provided.
        Console.WriteLine($"{authorName}: Sorry, cannot save the file as server returned an error: {e.Message}");
    }
    finally
    {
        // Release the lease - you can also just let it expire
        BlobProperties properties = blobClient.GetProperties();
        if(properties.LeaseState == LeaseState.Available)
            await blobLeaseClient.ReleaseAsync();
    }
    ```

    This code modifies the simulated news editor app to acquire a lease on the blob before the reporter starts writing their story. The first reporter to perform this action acquires the lease. Other users who attempt to acquire a lease while the blob is locked will receive an error.

1. Save your changes with CTRL+S.

## Test the changes

1. In the Cloud Shell, build and run the app with these commands.

    ```bash
    dotnet run
    ```

    The results are:

    ```console
    The newsroom chief has saved story notes to the blob mslearn-blob-concurrency-demo/newsStory.txt

    Reporter A begins work
    Reporter A loads the file and sees the following content: "[[CHIEF'S STORY NOTES]]"
    Reporter A has acquired a lease on the blob
    Reporter A begins writing their story...
    Reporter B begins work
    Reporter B loads the file and sees the following content: "[[CHIEF'S STORY NOTES]]"
    Reporter B: Sorry, cannot retrieve the file as server returned an error: There is already a lease present.
    Reporter A has finished writing their story
    Reporter A has saved their story to Blob storage. New blob contents: "[[REPORTER A'S STORY]]"

    =============================================

    Reporters have finished, here's the story saved to the blob:
    [[REPORTER A'S STORY]]
    ```

    This time, Reporter B is unable to acquire a lease on the blob, and the news editor application prevents them from continuing.

> [!TIP]
> If you have been unable to complete this unit, you can find a fully working version in the PessimisticNewsEditor directory. After adding your storage account connection string, you run the app with `dotnet run`.