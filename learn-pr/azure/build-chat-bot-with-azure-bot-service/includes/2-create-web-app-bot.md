The first step in creating a bot is to provide a location for the bot to be hosted in Azure. The Web Apps feature of Azure App Service is perfect for hosting bot applications, and the Azure Bot Service is designed to provision them for you. In this unit, you will use the Azure portal to provision an Azure web app bot.


[!include[](../../../includes/azure-sandbox-activate.md)]

1. Sign into the [Azure portal for sandbox](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you activated the sandbox with.

    > [!IMPORTANT]
    > Login to the Azure portal using the link above to ensure you are connected to the sandbox, which provides access to a Concierge Subscription.

1. Select **+ Create a resource**, followed by **AI + Machine Learning**, then **Web App Bot**.

    ![Screenshot of the Azure portal showing the Create a resource blade with the Web App Bot resource type highlighted.](../media/2-new-bot-service.png)

1. On the **New Web App Bot** page, enter the following settings for the new Web App Bot, including the location.

    [!INCLUDE[](../../../includes/azure-sandbox-regions-first-mention-note-friendly.md)]

    Setting|Value|Description
    ---|---|---
    Bot name|*choose a unique name*|This name must be unique within Azure, so make sure a green check mark appears next to it.
    Subscription|*Concierge Subscription*|Select the Concierge Subscription. If you do not see the Concierge Subscription listed, you have multiple tenants enabled on your subscription, and you need to change tenants. To do so, login again using the following portal link: [Azure portal for sandbox](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true).
    Resource Group|Use existing **<rgn>[sandbox resource group name]</rgn>**|Here you would either create a new resource group, or select an existing one in your subscription.
    Location|*Select the region closest to you from the list above*|Select the location where the database should be located.
    Pricing tier| S1 | A basic tier for this app.
    App name|*Leave default*|Feel free to leave the default which is populated based on your bot name.

    > [!NOTE]
    > If you see a resource policy error when you create the Web App Bot, then check that its location is set to one of the options above.

1. Then, select **Bot template**. Select **SDK v3** as the version, **Node.js** as the SDK language, and **Question and Answer** as the template type. Then, select **Select** at the bottom of the blade.

    ![Screenshot of the Azure portal showing the Bot template blade of the bot creation process with the Node.js SDK language and Question and Answer template options highlighted.](../media/2-portal-select-template.png)

1. Now, select **App service plan/Location**, followed by **Create New**, then create an App Service plan named "qa-factbot-service-plan" or something similar in the same region that you selected in the prior step. Once that's done, select **Create** at the bottom of the "Web App Bot" blade to start the deployment.

    ![Screenshot of the Azure portal showing a sample configuration blade for a new Web App Bot.](../media/2-portal-start-bot-creation.png)

    > [!NOTE]
    > Deployment generally requires two minutes or less.

1. After your deployment completes, select **Resource groups** in the ribbon on the left side of the portal.
1. Select the resource group pre-created for this group to open the resource group where we deployed the Azure web app bot.

You should now see several resources created for your Azure web app bot. Behind the scenes, a lot happened when the Azure web app bot was deployed. A bot was created and registered, an [Azure web app](https://azure.microsoft.com/services/app-service/web/) was created to host it, and the bot was configured to work with [Microsoft QnA Maker](https://www.qnamaker.ai/). The next step is to use QnA Maker to create a knowledge base of questions and answers to infuse the bot with intelligence.
