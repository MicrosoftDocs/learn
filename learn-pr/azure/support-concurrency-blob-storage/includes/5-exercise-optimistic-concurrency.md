In the previous exercise, you saw how the newsroom chief only saw Reporter A's edit. The app allowed reporters to overwrite Reporter B's story. In this exercise, you implement the optimistic approach to resolving concurrency so that Reporter B doesn't lose their work.

In this exercise you will:
- Change the `SimulateReporter` method to use an ETag
- Test the updated app

## Add optimistic concurrency to the existing code

[!include[](../../../includes/azure-cloudshell-copy-paste-tip.md)]

1. Open **Program.cs**: 

    ```console
    code Program.cs
    ```

1. In the code editor, add the code to capture the current ETag value. Scroll down to the `SimulateReporter` method and find the line of code that reads `Console.WriteLine($"{authorName} begins writing their story...");`. Immediately before this line, insert the following code:

    ```csharp
    // Store the current ETag
    var currentETag = downloadResult.Details.ETag;
    Console.WriteLine($"\"{contents}\" has this ETag: {currentETag}");
    ```

    This code modifies the simulated news editor application to record the ETag of the blob at the time it's read.

1. In `SimulateReporter`, change the call to `UploadAsync` to set a request condition as part of a `BlobUploadOptions` instance. When passed to the upload method, this condition confirms the ETag before saving the changes. This change modifies the simulated news editor application to enforce optimistic concurrency.
    
    **Remove** the following code from the method:

    ```csharp
    // Finally, they save their story back to the blob.
    var story = $"[[{authorName.ToUpperInvariant()}'S STORY]]";
    await blobClient.UploadAsync(BinaryData.FromString(story), true);
    Console.WriteLine($"{authorName} has saved their story to Blob storage. New blob contents: \"{story}\"");
    ```

    and replace it with this code:

    ```csharp
    try 
    {
        // Finally, they save their story back to the blob.
        var story = $"[[{authorName.ToUpperInvariant()}'S STORY]]";

        // Set the If-Match condition to the current ETag
        BlobUploadOptions blobUploadOptions = new()
        {
            Conditions = new BlobRequestConditions()
            {
                IfMatch = currentETag
            }
        };
        await blobClient.UploadAsync(BinaryData.FromString(story), blobUploadOptions);

        Console.WriteLine($"{authorName} has saved their story to Blob storage. New blob contents: \"{story}\"");
    }
    catch (RequestFailedException e) when (e.Status == (int)HttpStatusCode.PreconditionFailed)
    {
        // Catch error if the ETag has changed it's value since opening the file
        // This error indicates to the client that another process has updated the blob since the client first retrieved it.
        // The client should fetch the blob again to get the updated content and properties.
        Console.WriteLine($"{authorName}: Sorry, cannot save the file as server returned an error: {e.Message}");
    }
    ```

    The `IfMatch = currentETag` condition asks Blob storage to check the current value of the ETag for the report. If the two values match, the write operation succeeds. If some other process has updated the blob, then the value for the ETag on the server is different and an exception is raised.

1. Save your changes (CTRL+S) and close the code editor (CTRL+Q).

## Test the new app

1. In the Cloud Shell, build and run the app with this command.

    ```bash
    dotnet run
    ```

    The results are similar to the following output:

    ```console
    The newsroom chief has saved story notes to the blob mslearn-blob-concurrency-demo/newsStory.txt

    Reporter A begins work
    Reporter A loads the file and sees the following content: "[[CHIEF'S STORY NOTES]]"
    "[[CHIEF'S STORY NOTES]]" has this ETag: "0x8D6B6DEEC7DED54"
    Reporter A begins writing their story...
    Reporter B begins work
    Reporter B loads the file and sees the following content: "[[CHIEF'S STORY NOTES]]"
    "[[CHIEF'S STORY NOTES]]" has this ETag: "0x8D6B6DEEC7DED54"
    Reporter B begins writing their story...
    Reporter B has finished writing their story
    Reporter B has saved their story to Blob storage. New blob contents: "[[REPORTER B'S STORY]]"
    Reporter A has finished writing their story
    Reporter A Sorry, cannot save the file as server returned an error: The condition specified using HTTP conditional header(s) is not met.

    =============================================

    Reporters have finished, here's the story saved to the blob:
    [[REPORTER B'S STORY]]
    ```

    This time, when Reporter A has finished writing the story and tries to save their changes, the app doesn't let them. The save fails because the file was changed by Reporter B since the last time they viewed it.

> [!TIP]
> If you have been unable to complete this unit, you can find a fully working version in the OptimisticNewsEditor directory. You can run the app with `dotnet run`.