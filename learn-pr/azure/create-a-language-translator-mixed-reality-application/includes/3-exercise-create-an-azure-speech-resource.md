To complete the exercises in this module, you must have a Speech resource created in Azure. The following steps outline how to create a Speech resource and access your subscription keys and endpoint. Creating the Speech resource on Azure is required for the speech translation service to work.

## Create a speech resource

Sign into the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you used to activate the sandbox.

1. On the Azure portal menu or from the **Home** page, select **Create a resource**. Everything you create on Azure is a resource.
1. The portal navigates you to the **Marketplace** page. In the **Search the Marketplace** box, type **speech** and press Enter.
1. Select **Speech** from the results.

    :::image type="content" source="../media/marketplace-results.PNG" alt-text="A screenshot of the Marketplace results. There is a red box around the Speech service.":::

1. On the Speech resource page, click **Create**.
1. Fill out the wizard with the following values:

    |Field  |Value  |Details  |
    |---------|---------|---------|
    |**Name**     |    Enter a unique name     |   Choose a globally unique name for the resource. For example, you could name the resource mr-speech-xxx, where the x's could be replaced with your initials. If this isn't globally unique, you could try any other combination. Valid characters are a-z, 0-9 and -.      |
    |**Subscription**    |   Concierge Subscription      |    The resource you are creating must belong to a resource group. Here, you select the Azure subscription to which the resource group belongs (or will belong, if you are creating the resource group within the wizard).     |
    |**Location**     |    Geographical location near you     |   The geographical location from which your app will be used.      |
    |**Pricing tier**     |     Free F0    |    The pricing tier of the plan being created. The selected tier corresponds to the usage of the resource. The Free F0 tier currently provides 5 audio hours free per month for Speech Translation.    |
    |**Resource group**     |   <rgn>[Sandbox resource group]</rgn>      |    The resource group to which the Speech service will belong. All Azure resources must belong to a resource group.     |

   :::image type="content" source="../media/create-speech-resource.PNG" alt-text="A screenshot of the values provided for the Create Speech resource wizard.":::

1. Select **Create** to create the Speech resource.

> [!NOTE]
> It can take a few seconds to get your Speech resource created and ready for use.

A notification will be provided once deployment is complete. Once deployment is complete, your new Speech resource and API keys will be available for use.

## View the subscription keys and endpoint

1. On the Azure portal menu or from the **Home** page, select **All resources**.
1. Select the Speech resource from the list.

    :::image type="content" source="../media/all-resources.PNG" alt-text="A screenshot of the list of all resources. There is a red box around the mr dash speech dash a a s resource.":::

1. In the **Resource Management** section, select **Keys and Endpoint**.

    :::image type="content" source="../media/select-keys-and-endpoint.PNG" alt-text="A screnshot of the speech resource page. There is a red box around the menu item Keys and Endpoint.":::

In later exercises, you will need the values for **KEY 1**, the **ENDPOINT** and **LOCATION** as you set up the SpeechTranslation.cs script in Unity.

:::image type="content" source="../media/key-endpoint-location.PNG" alt-text="A screenshot of the key and endpoints for the speech service. There is a red box around Key 1, the Endpoint and the Location.":::
