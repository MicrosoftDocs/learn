In this exercise, you'll create a Face API subscription and access the keys and endpoint for that new subscription.

## Create a Face API Subscription

Subscribing to the Face API (and accessing your subscription keys) is a simple process:

1. Navigate to the [Azure portal](https://portal.azure.com?azure-portal=true) and sign in with an active Microsoft Azure subscription.

1. Click **+ Create a resource**, followed by **AI + Machine Learning** and **Face** and click **Create**.

1. Enter a unique name for your Face API subscription, then choose the **Location** nearest you.

1. Select the free or lowest cost **Pricing tier**.

1. Create a new Resource group named **mslearn-faceapi**. We will delete these resources at the end.

1. Click **Create** to create a subscription to the Face API.

After a short delay, your new Face API subscription will be provisioned and available, and new **API keys** will be generated for programmatic use.

> [!NOTE]
> Remember, the terms "subscription key" and "API key" are often used synonymously in Cognitive Services documentation.

You can select **Resource groups** in the left sidebar, and then select the resource group created for the Face API to view your new Face subscription.

## Accessing Subscription Keys and Endpoints

With a Face API subscription created, you're almost ready to start experimenting with the Face API.

Since all Microsoft Cognitive Service Computer Vision APIs are REST-based, you simply need to provide a **Subscription Key** (or API Key) to the Computer Vision API **Endpoint** (or URL) via your language of choice. However, you may be wondering what these values are, and how to access them easily.

### Obtain the Subscription Keys

To view the Subscription Keys and Endpoint for your Computer Vision subscription:

1. Click **Resource groups** in the left sidebar and then click the resource group created for the Computer Vision API.

1. Click the Face subscription name (such as "Face"), then select **Keys** under the "Resource Management" group to view your new API keys.

1. Copy the value of **KEY 1** to the clipboard.

    ![Copying the Face API key to the clipboard](../media/6-subscribe-to-face-api-keys.png)

1. Select **Overview** from the menu group, locate the "Endpoint" label, then copy the value of **Endpoint** to the clipboard.

    ![Copying the Face API endpoint to the clipboard](../media/6-subscribe-to-face-api-endpoint.png)

With the location and values of your Face subscription Endpoint and API Key available, you'll be ready when it's time to start writing some code or test the API with an image.