Azure Speech-to-text API allows us to transcribe voice audio to text accurately without the need to implement our own model.

In order to use the Azure Speech-to-text API in the amusement park application, we must have an Azure Speech Resource as well as a subscription key to access the API from the code.

Here, you will create an Azure Speech Resource in the Azure portal and retrieve the subscription key from there.

<!-- Taken from Mixed Reality Module, still needs to be modified -->

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

<!-- 5. Validation chunk -------------------------------------------------------------------------------------

    Goal: Helps the learner to evaluate if they completed the exercise correctly.

    Structure: Break the steps into 'chunks' where each chunk has three things:
        1. A heading of "## Check your work"
        2. An introductory paragraph describing how they'll validate their work at a high level
        3. Numbered steps (when the learner needs to perform multiple steps to verify if they were successful)
        4. Video of an expert performing the exact steps of the exercise (optional)

    Example:
        Heading:
            "Examine the results of your Twitter trigger"
        Introduction:
             "At this point, our logic app is scanning Twitter every minute for tweets containing the search text. To verify the app is running and working correctly, we'll look at the Runs history table."
        Steps:
             "1. Select Overview in the navigation menu.
              2. Select Refresh once a minute until you see a row in the Runs history table.
              ...
              6. Examine the data in the OUTPUTS section. For example, locate the text of the matching tweet."
-->

## Check your work
<!-- Introduction paragraph -->
1. <!-- Step 1 (if multiple steps are needed) -->
1. <!-- Step 2 (if multiple steps are needed) -->
1. <!-- Step n (if multiple steps are needed) -->
Optional "exercise-solution" video

<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

<!-- Do not add a unit summary or references/links -->
