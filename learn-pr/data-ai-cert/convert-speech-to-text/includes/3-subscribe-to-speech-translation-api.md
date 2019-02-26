Let's create a speech translation subscription using the Azure portal.

1. Sign into the [Azure portal](https://portal.azure.com?azure-portal=true).

1. Click **+ Create a resource**, type in "Translation" (without quotation marks) in the "Search the Marketplace" entry and press Enter.

1. Once search results are returned, select **Translator Text** from the "Results" panel, then, in the subsequent "Translator Text" panel, click **Create**.

    ![Selecting Speech Translation API](../media/3-subscribe-to-speech-translation-resource.png)

1. Enter a name for your Speech Translation API subscription, such as "TranslatorSpeech".
1. Select a **Pricing tier**.
1. Create a new Resource Group named **mslearn-speechapi** to hold your resources.
1. Click **Create** to create a subscription to the Speech Translation API.

After a short delay, your new Speech Translation API subscription will be provisioned and available, and new **API keys** will be generated for programmatic use.  

> [!TIP]
> If you miss the notification that your resource is published, you can simply click the notification icon in the top bar of the portal and select Go To Resource as shown here.

    ![Selecting Go To Resource from the notification icon](../media/3-subscribe-to-speech-translation-go-to-resource.png)

With a Speech Translation API subscription created you're now able to access your API **endpoint** and **subscription keys**.