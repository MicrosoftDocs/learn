Now that you have seen optimistic concurrency, you decide to implement a pessimistic approach to concurrency. You'll use a lease to lock the Azure blob storage while the reporter writes their story. 

In this exercise you'll:

- Change the `SimulateReporter` method to use a lease
- Test the updated app

## Add pessimistic concurrency to the existing code

1. Open the Program.cs file.

    ```bash
    code Program.cs
    ```

1. Change the code in the `SimulateReporter` method from using ETags to using a lease. Delete these lines:

    ```csharp
    // Store the current ETag
    var currentETag = blob.Properties.ETag;
    Console.WriteLine($"\"{contents}\" has this ETag: {blob.Properties.ETag}");
    ```

    and replace them with these:

    ```csharp
    // Acquire a lease on the file
    string lease = null;
    try 
    {
        lease = blob.AcquireLease(TimeSpan.FromSeconds(15), null);
        Console.WriteLine($"{authorName} has acquired a lease on blob storage");
    }
    catch (Microsoft.WindowsAzure.Storage.StorageException e) 
    {
        // Catch error if the ETag has changed it's value since opening the file
        Console.WriteLine($"{authorName} is unable to acquire a lease on the file and cannot continue. Error: {e.Message}");
    }
    ```

    This code modifies the simulated news editor app to acquire a lease on the blob before the reporter starts writing their story. The first reporter to perform this action will successfully acquire the lease. Other users who attempt to acquire a lease while it is already held will fail.

1. Change the `accessCondition` for the `UploadTextAsync` method to use the lease. Remove this line:

    ```csharp
    await blob.UploadTextAsync(story, null, accessCondition: AccessCondition.GenerateIfMatchCondition(currentETag), null, null);
    ```

    and replace it with this line:

    ```csharp
    await blob.UploadTextAsync(story, null, accessCondition: AccessCondition.GenerateLeaseCondition(lease), null, null);
    ```

    Unlike the AccessCondition used to enforce optimistic concurrency, a lease condition with the correct lease ID is *required* for the operation to complete successfully. Any application attempting to modify a leased blob must prove that it "owns" the lease by providing the lease ID with all operations.

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
    Reporter A has acquired a lease on blob storage
    Reporter A begins writing their story...
    Reporter B begins work
    Reporter B loads the file and sees the following content: "[[CHIEF'S STORY NOTES]]"
    Reporter B is unable to acquire a lease on the file and cannot continue. Error: There is already a lease present.
    Reporter A has finished writing their story
    Reporter A has saved their story to Blob storage. New blob contents: "[[REPORTER A'S STORY]]"

    =============================================

    Reporters have finished, here's the story saved to the blob:
    [[REPORTER A'S STORY]]
    ```

    This time, Reporter B is unable to acquire a lease on the blob, and the news editor application prevents him from continuing.

> [!TIP]
> If you have been unable to complete this unit, you can find a fully working version in the PessimisticNewsEditor directory. After adding your Azure blob storage connection string, you run the app with `dotnet run`.