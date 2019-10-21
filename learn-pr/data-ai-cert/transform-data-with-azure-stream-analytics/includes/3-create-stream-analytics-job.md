Let's start by creating a new Azure Stream Analytics job in the Azure portal.

> [!NOTE]
> This exercise is optional. If you don't have an Azure account or prefer not to do the exercise in your account, you can just read through the instructions. This overview will help you understand the steps to create a Stream Analytics job.

1. Open the [Azure portal](https://portal.azure.com?azure-portal=true) and sign in to your account.
1. In the left pane, select **All services**.
1. In the search box, type **Stream Analytics** and select **Stream Analytics jobs** from the results.
1. On the **Stream Analytics jobs** page, select **Add**.

    ![Screenshot showing the Stream Analytics jobs page in the Azure portal](../media/3-add-jobs.png)

1. Enter a job name, such as **SimpleTransformer**.
1. Create a new resource group named **mslearn-streamanalytics**.
1. Note the **Location** setting. Ideally, you should create your job in the same location as any storage accounts you use as a source or destination.
1. Ensure that the hosting environment is **Cloud**.
1. Set the streaming units to **1** to minimize the cost for this test.
1. Select **Create** to create the new job.

    ![Screenshot of the new Stream Analytics job](../media/3-create-new-job.png)

1. After a few moments, select **Refresh** to see your new Stream Analytics job.

    ![Screenshot of a newly created Stream Analytics job on the Stream Analytics jobs page](../media/3-created-jobs.png)

Now that we have a Stream Analytics job, we're ready to set up the job to serve a streaming workload. We'll start with the input.