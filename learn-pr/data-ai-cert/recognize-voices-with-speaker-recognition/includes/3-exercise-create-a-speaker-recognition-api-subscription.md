Before you can use the Speaker Recognition API, you need to subscribe to the service and get an API key.

> [!IMPORTANT]
> The Speaker Recognition API is still in preview. Expect changes to some of the functionality before it is finalized.

1. Sign into the [Azure portal](https://portal.azure.com?azure-portal=true).

1. Click **+ Create a resource** in the left-hand sidebar, type in "Speaker Recognition" (without quotation marks) in the "Search the Marketplace" entry, then select **Speaker Recognition** from the search drop-down list.

1. Click **Create**.

1. Enter a name for your Speaker Recognition API subscription, such as "SpeakerRecognition".
1. Choose the **Location** nearest you.

1. Select a **Pricing tier**.

1. Create a new Resource group named **mslearn-speakerapi** to hold the resources.

1. Review and accept the service notice, then click **Create** to create a subscription to the Speaker Recognition API.

After a short delay, your new Speaker Recognition API subscription will be provisioned and available, and new **API keys** will be generated for programmatic use.

> [!NOTE]
> Remember, the terms "subscription key" and "API key" are often used synonymously in Cognitive Services documentation, and therefore both terms may be used in this course.

You can select **Resource groups** in the left sidebar and then click the resource group you created for the Speaker Recognition API to view your new Speaker Recognition subscription.

### View the subscription key

To access your Speaker Recognition subscription, you'll need two pieces of information you can get from the Azure portal.

1. A **Subscription Key** that allows you to access your speaker subscription. This must be passed with every web service call you make to the subscription.
1. The **Endpoint** that exposes your service on the network.

Let's start by getting the subscription key.

1. Click **Resource groups** in the left-hand sidebar of the portal, and then click the resource group you created for the Speaker Recognition API.

1. Click the Speaker Recognition subscription name (such as "SpeakerRecognition"), then select **Keys** under the "Resource Management" group to view your new API keys.

1. Copy the value of **KEY 1** to the clipboard.

    ![Copying the Speaker Recognition API key to the clipboard](../media/3-subscribe-to-speaker-recognition-api-keys.png)

> [!TIP]
> It may be helpful to make note of the location of the keys and paste this value to a text file for use later in the course.

### View the subscription endpoint

Next, let's get the endpoint from the Azure portal.

1. Select **Overview** from the menu group, locate the "Endpoint" label, then copy the value of **Endpoint** to the clipboard.

    ![Copying the Speaker Recognition API endpoint to the clipboard](../media/3-subscribe-to-speaker-recognition-api-endpoint.png)
