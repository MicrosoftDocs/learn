An Azure Stream Analytics job supports three input types:

> [!div class="mx-tableFixed"]
> | Input type | Use case |
> |------------|----------|
> | **Azure Event Hubs** | Azure Event Hubs consumes live streaming data from applications with low latency and high throughput. |
> | **Azure IoT Hub**   | Azure IoT Hub consumes live streaming events from IoT devices. This service enables bidirectional communication so that commands can be sent back to IoT devices. Commands trigger specific actions based on the analyzing streams the devices send to the service. |
> | **Azure Blob storage** | Azure Blob storage serves as the input source to consume files that are persisted in blob storage. |

> [!NOTE]
> This exercise is optional. If you don't have an Azure account or prefer not to do the exercise in your account, you can just read through the instructions. This overview will help you understand the steps to create a Stream Analytics job.

## Create the input source

Let's use an Azure Blob store as the input. 

Azure Blob storage has three components: 

* The Azure Storage account, which provides the globally unique namespace in Azure 
* The container, which acts like a folder 
* The blob itself, which is like a file in a file system

Start by creating an Azure Blob storage account:

1. Go to the [Azure portal](https://portal.azure.com?azure-portal=true).
1. In the pane on the left, select **All services**.
1. In the search field, type **storage** and select **Storage accounts** from the results.
1. Select **Add** to create a new Azure Storage account.
1. On the **Basics** tab, select the new **mslearn-streamanalytics** resource group.
1. Give the Azure Storage account a unique name. Try using the prefix **streamsrc** with your initials or a numeric value. This value has to be unique across all Azure storage accounts, so you might have to try a few combinations to find one that works for you. The portal displays a green check mark next to the name if it's valid.
1. Check the location. To avoid paying to transfer data between regions, set the location to the same one as the job.
    
    > [!TIP]
    > This step isn't absolutely necessary. But it can save costs if a lot of data will flow in or out of your storage account.

1. Leave the default values in the rest of the fields.

    ![Screenshot showing how to create a storage account named "streamsrc"](../media/4-add-storage-account.png)

1. Select **Review + create**.
1. After the request is validated, select **Create** to submit the deployment request.

Wait until a message indicates that the deployment is complete. Then continue to the next step.

## Connect the input source to the Stream Analytics job

Next connect your Stream Analytics job to your new Azure Blob storage account:

1. In the left pane of the Azure portal, select **All services**.
1. In the search box, type **Stream Analytics**. Select **Stream Analytics jobs** from the results.
1. In the list of jobs, select the Stream Analytics job you created earlier (**SimpleTransformer**). Your job's overview page appears.

    ![Screenshot of the job in the Azure portal](../media/4-stream-job-overview.png)

1. Under **Job topology**, select **Inputs**.
1. Select **Add stream input** and select **Blob storage** from the list.
1. In **Input alias** field, type **streaminput**. This display name identifies the input.
1. Select the storage account you created earlier. Remember, it starts with **streamsrc**.
1. Under **Container**, select **Create new**. Give the container a unique name, such as **learn-container**.
1. Under **Path pattern**, enter **input/**.
1. Leave the default values in the rest of the fields.


    > [!TIP]
    > Take note of the date format on this blade.  It may differ in your region and you will need to know the format for the exercise "Write an Azure Stream Analytics transformation query".

    > [!NOTE]
    > If the job and storage account are in different locations, you'll get a warning like the one in the following image.

    ![Screenshot of the interface where you define the input, showing a warning message](../media/4-create-blob-input.png)
    
1. Select **Save** to associate the input.