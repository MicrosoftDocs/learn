Stream Analytics jobs support various output sinks such as Azure Blob storage, Azure SQL Database, and Event Hub. There's a full list of output types in the documentation. In this exercise, we will use Blob storage as the output sink for our Stream Analytics job.

> [!NOTE]
> This exercise is optional. If you don't have an Azure account, or prefer not to do the exercise in your account, you can read through the instructions to understand the steps involved in creating an input source for a Azure Stream Analytics job.

The steps will be very similar to what we just did to create the input. Let's start by creating a second Blob Storage account to hold the output.

1. In the [Azure portal](https://portal.azure.com?azure-portal=true), create a new storage account - just like you did in the prior exercise.
1. In the **Basics** tab, select your new **mslearn-streamanalytics** Resource group.
1. Use the prefix **streamsink** for the account name with a numeric suffix. Remember you might need to try a few combinations to find a unique name in Azure.
1. Use default values for all other fields.

    ![Screenshot of Adding Storage Account Name "streamsink"](../media/5-add-storage-account.png)

1. Select **Review + create**.
1. Once the request has been validated, select **Create** to run the deployment step.

Wait a few moments for the deployment to complete, once you receive the message "Your deployment is complete", move onto the next step.

## Connect an output sink to a Stream Analytics job

Next, let's connect the storage account as the destination for our Azure Stream Analytics job.

1. Select **All services** in the left pane.
1. In the search box, type in **Stream Analytics** and select **Stream Analytics job** from the results.
1. Select the Stream Analytics job you created.
1. Under **Job topology**, select **Outputs**.
1. Click **Add** and select **Blob storage** from the drop-down list.
1. Type **streamoutput** in **Output alias** field - remember this is your own name for the output.
1. Select the storage account (**streamsink**) you created in the previous section.

> [!NOTE]
> If your account doesn't appear in the dropdown, it likely just needs to be refreshed - just quit the Azure portal by closing the browser and then re-open the portal and try again.

1. Select **Create New** for Container field and give it a unique name such as **learn-container**.
1. Enter **output/** for Path pattern.
1. Leave the rest of the fields as default.
1. Select **Save**.