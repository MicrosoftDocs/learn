Let's start by creating a new Azure Stream Analytics job in the Azure portal.

> [!NOTE]
> This exercise is optional. If you don't have an Azure account, or prefer not to do the exercise in your account, you can read through the instructions to understand the steps involved in creating a new Azure Stream Analytics job.

1. Open the [Azure portal](https://portal.azure.com?azure-portal=true) and sign into your account.
1. Select **All services** in the left pane.
1. In the search box, type in "**Stream Analytics**" and select **Stream Analytics jobs** from the results.
1. On the Stream Analytics jobs page, click **Add** to add a new job.

    ![Screenshot of Adding Stream Analytics Jobs using Azure portal](../media/3-add-jobs.png)

1. Enter a Job name such as "SimpleTransformer".
1. Create a new Resource group - name it "mslearn-streamanalytics".
1. Take note of the Location setting. Ideally we'll create our job in the same location as any storage account(s) used for as a source or destination.
1. Ensure that the Hosting environment is **Cloud**.
1. Set the Streaming units to "1" to minimize the cost since we're just doing a simple test.
1. Select **Create** to create the new job.

    ![Screenshot of New Stream Analytics job](../media/3-create-new-job.png)

1. After a few moments, click **Refresh** to see your new Stream Analytics job.

    ![Screenshot of Successfully Creating Stream Analytics Jobs using Azure portal](../media/3-created-jobs.png)

Now that we have a Stream Analytics job, we're ready to configure the job to serve a streaming workload. We'll start with the input.