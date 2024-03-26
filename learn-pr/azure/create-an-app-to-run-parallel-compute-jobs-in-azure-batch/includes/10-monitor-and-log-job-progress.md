The Batch client API allows an app to monitor the current status of pools, nodes, jobs, and tasks.

To complete your company's console app to convert videos, you want to have the app monitor and report on the status of the file conversions. You'd also like to reduce the costs your Batch will incur by adding the ability for the app to delete the jobs and pool once the videos are converted. To reduce the file storage costs, you'd also like to remove the uploaded video files.

The app checks for an existing pool and creates one if it doesn't exist. The job and tasks are started, then monitored. Once the tasks have completed successfully, the app presents the option to delete the created job and pool. The app automatically deletes the uploaded videos to save on blob storage costs.

## Add monitoring

1. In the Cloud Shell, edit the `Program.cs` file in the editor:

    ```bash
    code Program.cs
    ```

1. Add the following method, `MonitorTasksAsync()` to **Program.cs** to monitor job tasks.

    ```csharp
    private static async Task<bool> MonitorTasksAsync(BatchClient batchClient, string jobId, TimeSpan timeout)
    {
        bool allTasksSuccessful = true;
        const string completeMessage = "All tasks reached state Completed.";
        const string incompleteMessage = "One or more tasks failed to reach the Completed state within the timeout period.";
        const string successMessage = "Success! All tasks completed successfully. Output files uploaded to output container.";
        const string failureMessage = "One or more tasks failed.";

        Console.WriteLine("Monitoring all tasks for 'Completed' state, timeout in {0}...", timeout.ToString());

        // We use a TaskStateMonitor to monitor the state of our tasks. In this case, we will wait for all tasks to
        // reach the Completed state.
        IEnumerable<CloudTask> addedTasks = batchClient.JobOperations.ListTasks(JobId);

        TaskStateMonitor taskStateMonitor = batchClient.Utilities.CreateTaskStateMonitor();
        try
        {
            await taskStateMonitor.WhenAll(addedTasks, TaskState.Completed, timeout);
        }
        catch (TimeoutException)
        {
            await batchClient.JobOperations.TerminateJobAsync(jobId);
            Console.WriteLine(incompleteMessage);
            return false;
        }
        await batchClient.JobOperations.TerminateJobAsync(jobId);
        Console.WriteLine(completeMessage);

        // All tasks have reached the "Completed" state, however, this does not guarantee all tasks completed successfully.
        // Here we further check for any tasks with an execution result of "Failure".

        // Obtain the collection of tasks currently managed by the job. 
        // Use a detail level to specify that only the "id" property of each task should be populated. 
        // See https://learn.microsoft.com/azure/batch/batch-efficient-list-queries
        ODATADetailLevel detail = new ODATADetailLevel(selectClause: "executionInfo");

        // Filter for tasks with 'Failure' result.
        detail.FilterClause = "executionInfo/result eq 'Failure'";

        List<CloudTask> failedTasks = await batchClient.JobOperations.ListTasks(jobId, detail).ToListAsync();

        if (failedTasks.Any())
        {
            allTasksSuccessful = false;
            Console.WriteLine(failureMessage);
        }
        else
        {
            Console.WriteLine(successMessage);
        }
        return allTasksSuccessful;
    }
    ```

    The `TaskStateMonitor` object is called and will return when the state of all the tasks is (`TaskState.Completed`). The app will time out if it has to wait longer than the `timeout` value.

    This method makes use of `batchClient.JobOperations.ListTasks` to get the current state of tasks on the Batch account. We can filter these calls to only return the information we need by passing a `ODATADetailLevel` parameter. Once all the tasks have completed, the code needs to check that all of them completed successfully, so using a filter of `"executionInfo/result eq 'Failure'"` with the `ListTasks` call returns all the tasks that failed.

1. Add a call to the new `MonitorTasksAsync()` method inside the using block in `Main()`, and store the task list returned from the `AddTaskAsync` call.

    ```csharp
    using (BatchClient batchClient = BatchClient.Open(sharedKeyCredentials))
    {
        // Create the Batch pool, which contains the compute nodes that execute the tasks.
        await CreatePoolIfNotExistAsync(batchClient, PoolId);

        // Create the job that runs the tasks.
        await CreateJobAsync(batchClient, JobId, PoolId);

        // Create a collection of tasks and add them to the Batch job. 
        // Provide a shared access signature for the tasks so that they can upload their output
        // to the Storage container.
        List<CloudTask> runningTasks = await AddTasksAsync(batchClient, JobId, inputFiles, outputContainerSasUrl);

        // Monitor task success or failure, specifying a maximum amount of time to wait for
        // the tasks to complete.
        await MonitorTasksAsync(batchClient, JobId, TimeSpan.FromMinutes(30));
    }
    ```

## Clean up

1. Inside the using block, bellow the call to the `MonitorTasks` method call, add this clean up code.

    ```csharp
    // Delete input container in storage
    Console.WriteLine("Deleting container [{0}]...", inputContainerName);
    CloudBlobContainer container = blobClient.GetContainerReference(inputContainerName);
    await container.DeleteIfExistsAsync();

    // Clean up the job (if the user so chooses)
    Console.WriteLine();
    Console.Write("Delete job? [yes] no: ");
    string response = Console.ReadLine().ToLower();
    if (response != "n" && response != "no")
    {
        await batchClient.JobOperations.DeleteJobAsync(JobId);
    }

    // Clean up the pool (if the user so chooses - do not delete the pool if new batches of videos are ready to process)
    Console.Write("Delete pool? [yes] no: ");
    response = Console.ReadLine().ToLower();
    if (response != "n" && response != "no")
    {
        Console.WriteLine("Deleting pool ...");
        await batchClient.PoolOperations.DeletePoolAsync(PoolId);
        Console.WriteLine("Pool deleted.");
    }
    ```

    The preceding code deletes the input container, which contains all the uploaded videos.

    Then, the terminal prompts the user to choose to delete the job and pool. The `batchClient` enables the app to delete these components.

## Test the console app

1. In the code editor, right-click and select **Save**, and then select **Quit**.

1. Build and run the app.

    ```bash
    dotnet run
    ```

1. You should get output that resembles the following:

    ```output
    Creating container [input].
    Creating container [output].
    Uploading file ~\cutifypets\InputFiles\3.mp4 to container [input]...
    Uploading file ~\cutifypets\InputFiles\2.mp4 to container [input]...
    Uploading file ~\cutifypets\InputFiles\4.mp4 to container [input]...
    Uploading file ~\cutifypets\InputFiles\1.mp4 to container [input]...
    Uploading file ~\cutifypets\InputFiles\5.mp4 to container [input]...
    Uploading file ~\cutifypets\InputFiles\6.mp4 to container [input]...
    Creating pool [WinFFmpegPool]...
    Creating job [WinFFmpegJob]...
    Adding 6 tasks to job [WinFFmpegJob]...
    Monitoring all tasks for 'Completed' state, timeout in 00:30:00...
    All tasks reached state Completed.
    Success! All tasks completed successfully. Output files uploaded to output container.
    Deleting container [input]...

    Delete job? [yes] no: y
    Delete pool? [yes] no: y

    Sample complete, hit ENTER to exit...
    ```

1. However, the app will fail if the job from the previous run still exists, because the previous app didn't have the job clean up code. You can delete the job in the Azure portal, or in the Cloud Shell with:

    ```azurecli
    az batch job delete --job-id WinFFmpegJob \
    --account-name $BATCH_NAME \
    --account-key $BATCH_KEY \
    --account-endpoint $BATCH_URL

    Are you sure you want to perform this operation? (y/n):
    ```

    At the prompt, type **y**.

1. The console app will run much faster this time as the nodes (three virtual machines running Windows 2012) will be idle and waiting for a job to run.

> [!TIP]
> There's a [fully commented and working version of the app on GitHub](https://github.com/MicrosoftDocs/mslearn-apps-and-batch).

<!-- https://github.com/PhilStollery/learn-pr/tree/NEW-Create-an-application-that-runs-parallel-compute-jobs-with-azure-batch/learn-pr/azure/create-an-app-to-run-parallel-compute-jobs-in-azure-batch/resources/cutifypets
Git code repo updated -->
