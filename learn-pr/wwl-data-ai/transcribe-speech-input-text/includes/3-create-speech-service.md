Before you can begin performing your speech-to-text translation, you need to create an Azure Speech resource.  You can do this by using the Azure portal, the Azure CLI, or the Cloud Shell.  This exercise will use the Azure portal.

1. Sign in to the [Azure portal](https://portal.azure.com?azure-portal=true).

1. Select **+ Create a resource**. In the **Search the Marketplace** box, type **speech** and press Enter.

1. In the **Results** list, select **Speech**. In the **Speech** pane, select **Create**.
1. Enter a unique name for your Speech Service resource.
1. Select an appropriate subscription.
1. Choose a location to host the resource.  This is typically the region where the resource will be used.
1. For **Pricing tier**, select a tier.  The tiers may change but currently, you can selects F0 or S0.  For testing, we selected F0.
1. Create a new resource group (RG) named **mslearn-speechapi** to hold your resources.  You can also choose an existing RG if you wish
1. Select **Create** to create a subscription to the Speech Translation API.

After a short delay, your new Speech Translation API subscription will be available, and new API keys will be generated for programmatic use.  

> [!TIP]
> If you miss the notification that your resource is published, select the notification icon in the top bar of the portal, and then select **Go to resource**, as shown in the following figure:

   ![Selecting "Go to resource" from the notification icon](../media/3-subscribe-speech-translation-go-resource.png)

With a Speech Service resource created, you're now able to access your API endpoint and subscription keys.
