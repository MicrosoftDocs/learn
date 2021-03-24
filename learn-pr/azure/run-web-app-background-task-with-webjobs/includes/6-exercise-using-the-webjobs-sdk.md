Developers must use the correct packages and code to interact with the WebJobs SDK.

As the senior web developer responsible for the watch dealers website, you have already created a web app with a linked WebJob Project. You now want to use the WebJobs SDK to enhance and simplify the WebJob code.

In this unit, you'll integrate the WebJobs SDK in your implementation, and use a `TimerTrigger` to run it on a schedule.

## Use the SDK to create and configure the WebJob host

The WebJob project template, which you used to create your WebJob in the previous unit, inserts code that uses the WebJob SDK. In the previous unit, you commented out that code to explore how WebJobs can work without the SDK. Here, we're going to create a second WebJob using the SDK that will process the messages from the queue, and write output to blob storage.

1. In Visual Studio, right-click the WatchesWebApp project in Solution Explorer, and select **Add** > **New Azure WebJob Project**. In the panel that appears, name the new WebJob **ConfirmationWebJob**, and select **OK**.

1. In the new WebJob project, open **Functions.cs**. When this WebJob is deployed and starts up, the WebJobs SDK code in Main.cs will analyze all of the `Trigger` input parameters in the methods in this class, and create listeners that will trigger them.

1. Delete the existing `ProcessQueueMessage` method, and replace it with the following code:

    ```csharp
    public static void ConfirmStockCheck([QueueTrigger("stockchecks")] string message, [Blob("confirmations/{id}")] out string output)
    {
        var timestamp = message.Split()[3];
        output = $"{timestamp} stock check successfully processed";
    }
    ```

    This function will process messages on the `stockchecks` queue, and use them to create blobs in the `confirmations` container. The WebJobs SDK will call this function once for every message on the `stockchecks` queue, and the `message` parameter will contain the message contents. The value of `output` will automatically be written to a new blob in the `confirmations` container. The name of the new blob will be the message ID of the message received from the queue that triggered the function.

## Configure the WebJobs connection string

The Azure Storage bindings, such as `QueueTrigger` and `Blob`, use the storage account specified by the `AzureWebJobsStorage` connection string. We need to add this connection string as a setting in our app. Additionally, WebJobs that use the SDK need to have the `AzureWebJobsDashboard` connection string configured to run.

In the [Azure portal](https://portal.azure.com/?azure-portal=true), run the following command in the Cloud Shell to create both connection strings as settings in the web app. We'll use the same connection string as we did for `StorageAccount` in the previous exercise. The new WebJob will read messages from the existing queue, and write blobs to a new container in the same storage account.

```azurecli
az webapp config connection-string set --id $WEB_APP_ID --connection-string-type Custom --settings AzureWebJobsStorage=$STORAGE_ACCOUNT_CONNSTR AzureWebJobsDashboard=$STORAGE_ACCOUNT_CONNSTR
```

## Publish the application

Now that our second WebJob is implemented, we'll publish the application one more time to deploy it.

1. In the Visual Studio **Solution Explorer**, right-click the WatchesWebApp project, and select **Publish**.

1. In the WatchesWebApp window that appears, select **Publish** to publish the web app again.

## Confirm deployment

Now that both WebJobs are published, let's confirm that the new WebJob is working properly.

1. In the [Azure portal](https://portal.azure.com/?azure-portal=true), search for and select the storage account.

1. In the navigation menu, select **Queues**, and then select the **stockchecks** queue. You'll see that the queue is now empty, or nearly empty. The new WebJob is processing all messages that reach the queue and writing new data out to blob storage.

1. Navigate back to the storage account, then use the navigation menu to select **Blobs**. Select the **confirmations** container from the list. Each blob shown in the list is output from the WebJob.
