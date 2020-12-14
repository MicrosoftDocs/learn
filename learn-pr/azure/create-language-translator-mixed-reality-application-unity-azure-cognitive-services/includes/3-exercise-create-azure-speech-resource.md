A Speech service resource must be created in Azure to integrate the Azure Cognitive Services Speech Translation service into a mixed reality app. The Speech service resource will later be used to translate speech and return a string to the app's UI. Here, you'll learn how to create a Speech service resource and locate the subscription keys and endpoint.

## Create a Speech service resource

Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) by using the same account that you used to activate the sandbox.

1. On the Azure portal menu or from the **Home** page, select **Create a resource**. Everything you create on Azure is a resource.
1. The portal takes you to the **Marketplace** page. In the **Search the Marketplace** box, type **speech** and press the Enter key.
1. Select **Speech** from the results.

    :::image type="content" source="../media/marketplace-results.png" alt-text="A screenshot of the Azure Marketplace results. There's a red box around the Speech service.":::

1. On the page for the Speech service resource, select **Create**.
1. Fill out the wizard with the following values:

    |Field  |Value  |Details  |
    |---------|---------|---------|
    |**Name**     |    Enter a unique name     |   Choose a globally unique name for the resource. For example, you might name the resource *mr-speech-xxx*, where the x's are replaced with your initials. If the name isn't globally unique, you can try any other combination. Valid characters are a-z, 0-9, and -.      |
    |**Subscription**    |   Concierge subscription      |    The resource you're creating must belong to a resource group. Here, you select the Azure subscription to which the resource group belongs or will belong, if you're creating the resource group within the wizard.     |
    |**Location**     |    Geographical location near you     |   The geographical location where your app will be used.      |
    |**Pricing tier**     |     Free F0    |    The pricing tier of the plan being created. The selected tier corresponds to the usage of the resource. The Free F0 tier currently provides five audio hours free per month for Speech Translation.    |
    |**Resource group**     |   <rgn>[Sandbox resource group]</rgn>      |    The resource group to which the Speech service will belong. All Azure resources must belong to a resource group.     |

   :::image type="content" source="../media/create-speech-resource.png" alt-text="A screenshot of the values provided for the Create Speech Resource wizard.":::

1. Select **Create**.

> [!NOTE]
> It can take a few seconds to get your Speech service resource created and ready for use.

A notification will appear after deployment is complete. Your new Speech service resource and API keys will then be available for use.

## View the subscription keys and endpoint

1. On the Azure portal menu or from the **Home** page, select **All resources**.
1. Select the Speech service resource from the list.

    :::image type="content" source="../media/all-resources.png" alt-text="A screenshot of the list of all resources. There's a red box around the M R dash speech dash A A S resource.":::

1. In the **Resource Management** section, select **Keys and Endpoint**.

    :::image type="content" source="../media/select-keys-and-endpoint.png" alt-text="A screenshot of the Speech service resource page. There's a red box around the menu item Keys and Endpoint.":::

In later exercises, you'll need the values for **KEY 1**, **ENDPOINT**, and **LOCATION** as you create the SpeechTranslation.cs script in Unity.

:::image type="content" source="../media/key-endpoint-location.png" alt-text="A screenshot of the key and endpoints for the speech service. There's a red box around KEY 1, ENDPOINT, and LOCATION.":::
