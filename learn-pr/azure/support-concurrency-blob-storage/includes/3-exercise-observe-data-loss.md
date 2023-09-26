Your news organization has a web app that  financial reporters use to submit stories to their newsroom chief. The app uses Azure Blob storage to store stories for the chief to review prior to publication.

The newsroom chief first uses the editing application to create notes for the new stories they want to be written. When they're finished, they save their changes. Saving them uploads the notes to a new blob. Stories are then assigned to a pool of reporters. The reporters assigned to a story load the notes, make changes in their areas of expertise, and save the changes once they're finished.

Now imagine two reporters are assigned to the same story. Reporter A begins work quickly, retrieving the notes and writing a lengthy section of the story. Reporter B begins soon after, makes an edit to the story, and finishes their work first. Reporter B saves their changes, committing them to the blob. Later, Reporter A finishes their story and saves it.

The newsroom chief has been receiving complaints from their reporters that stories are being lost. On executing the app, you notice Reporter A is unaware of the previous completed work of Reporter B, and only Reporter A's work is seen by the newsroom chief.

In this exercise, you deploy the app and observe the last writer wins issues created by concurrent updates.

## Create an Azure storage account and store the connection string

To experiment with Blob storage concurrency code, we start by creating a Blob storage account using the Cloud Shell.

1. Run the commands below to create a new storage account:

    ```azurecli
    storage=mediastorage$RANDOM
    az storage account create --name $storage --kind StorageV2 -g <rgn>[sandbox resource group name]</rgn> --allow-blob-public-access false
    ```

1. Next enter `az storage account show-connection-string` to get the connection string and store it into an environment variable named `STORAGE_CONNECTION_STRING`. 

    ```azurecli
    export STORAGE_CONNECTION_STRING=$(az storage account show-connection-string --name $storage --query connectionString -o tsv)
    ```

## Download and review the sample code

[!include[](../../../includes/azure-cloudshell-copy-paste-tip.md)]

1. In the Cloud Shell, clone your app from GitHub.

    ```console
    git clone https://github.com/MicrosoftDocs/mslearn-support-concurrency-blob-storage.git
    cd mslearn-support-concurrency-blob-storage/src/NewsEditor
    ```

    The above commands move you into the NewsEditor app folder. There are other folders that contain completed code for units in the rest of the module.

1. Open the **Program.cs** file in the code editor.

    ```console
    code Program.cs
    ```

1. Scroll down to the `SimulateReporter` method. This method simulates the activities of a reporter working in a version of the news editing application that doesn't perform any kind of active concurrency management.

    ```csharp
    private static async Task SimulateReporter(BlobContainerClient containerClient, string authorName, TimeSpan writingTime)
    {
        BlobClient blobClient = containerClient.GetBlobClient(blobName);

        // First, the reporter retrieves the current contents
        Console.WriteLine($"{authorName} begins work");

        var contents = await blobClient.DownloadContentAsync();
        Console.WriteLine($"{authorName} loads the file and sees the following content: \"{contents.Value.Content}\"");

        // Next, the author writes their story. This takes some time.
        Console.WriteLine($"{authorName} begins writing their story...");
        await Task.Delay(writingTime);
        Console.WriteLine($"{authorName} has finished writing their story");

        // Finally, they save their story back to the blob.
        var story = $"[[{authorName.ToUpperInvariant()}'S STORY]]";
        await blobClient.UploadAsync(BinaryData.FromString(story), true);
        Console.WriteLine($"{authorName} has saved their story to Blob storage. New blob contents: \"{story}\"");
    }
    ```

    In the simulation, two instances of this method run simultaneously with different timings. Both reporters observe the same contents when they first download the file from Blob storage. The reporter that takes longer to write their story and save it back to the blob overwrites the content placed there by the first author without knowing it.

1. Close the Code editor (CTRL+Q).

## Execute the test app

1. In the Cloud Shell, build and run the app with this command.

    ```console
    dotnet run
    ```

1. The output is:

    ```console
    The newsroom chief has saved story notes to the blob mslearn-blob-concurrency-demo/newsStory.txt

    Reporter A begins work
    Reporter A loads the file and sees the following content: "[[CHIEF'S STORY NOTES]]"
    Reporter A begins writing their story...
    Reporter B begins work
    Reporter B loads the file and sees the following content: "[[CHIEF'S STORY NOTES]]"
    Reporter B begins writing their story...
    Reporter B has finished writing their story
    Reporter B has saved their story to Blob storage. New blob contents: "[[REPORTER B'S STORY]]"
    Reporter A has finished writing their story
    Reporter A has saved their story to Blob storage. New blob contents: "[[REPORTER A'S STORY]]"

    =============================================

    Reporters have finished, here's the story saved to the blob:
    [[REPORTER A'S STORY]]
    ```

    These console messages allow you to follow the flow of the app. In this example, Reporter B has lost their work.
