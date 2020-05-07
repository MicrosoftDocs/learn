Before we start building out our **GeoFriend** bot, let's review the main principles of bot operation.

A conversational experience involves:

- User sends messages to a bot
- Bot responds to the user.

These conversations can happen in different **channels**:

- A chat bot on a web site
- A messenger application such as Facebook Messenger or Telegram.

Each **messaging platform** has their own principles and APIs for creating chat bots. Building a bot for Facebook requires different skills than creating a web chat.

Microsoft unifies this process with **[Bot Framework][BotFW]** - a set of core libraries that standardize bot development. With this framework, we can develop a bot as **Web API**, which is essentially a function that we call over the internet. We'll give it the user input, and it figures out the desired output of the bot.

To connect this function to actual channels, we'll use the **[Azure Bot Service][BotService]**. This service allows us to define connections to those channels through a web interface on the Azure portal. Once we have developed a bot, we can connect exactly the same code to several channels, and provide an **inclusive omnichannel experience**.

Bot Framework also helps structure the bot logic by offering some useful developer abstractions. Complex conversations are difficult to program as simple request-response pattern. Bot Framework provides abstractions such as **dialogs**, **form filling**, and others. By using these abstractions, we can compose complex conversational behavior from more simple building blocks.

![Bot Framework Diagram](../media/bot-framework-diagram.png)

## Cognitive Services

To make bots intelligent, we'll need to use some AI techniques. For example, **natural language understanding** can help figure out what a user wants without requiring them to use an exact phrase. Intelligent tasks can be handled using **[Azure Cognitive Services][CoServ]** - a set of pre-trained, neural network models that are available in the cloud.

To build our bot, we'll use **[Language Understanding Intelligent Service][LUIS]** (LUIS). LUIS can be trained on a set of phrases by specifying some input phrases and their **intent** or meaning. The service tries to automatically figure out the best intent for each user's input phrase. We'll also use [**QnA Maker Service**][QnAMaker] to add question answering functionality and general chat support.

## Create a bot

Let's start to create our **GeoFriend** Assistant chat bot. The easiest way to start is with a new Azure Bot Service:

1. Go to the [Azure portal][azure-portal-] and sign in to your Azure account.

   ![The Azure portal](../media/azure-portal.png)

1. Select **Create a Resource** (large +), type "Bot" in the search box, and choose **Web App Bot**.

   ![Create Bot](../media/azure-portal-create.png)

   On the new page, select **Create**.

1. Fill in the bot parameters:

   - **Bot Handle** - enter *GeoFriend*
   - **Resource group** - select **Create New** and enter a name.
   - **Location** - select the data center location closest to you.
   - **Pricing Tier** - *F0*, which is the free tier.
   - **App Name** - keep at the default value.

   ![Bot Parameters](../media/azure-portal-bot-form.png)

1. Select the **Bot Template** field, then select a template.

   For our bot, we'll use the **C#** SDK language and the **Echo Bot** template.

   ![Select Template](../media/azure-portal-select-template.png)

   Options in this pane:

   - Programming language (**C#** or **Node.js**).
   - **Echo Bot** - the simplest bot. It echoes back any message typed by a user. We'll start with this one because it's the easiest to understand.
   - **Basic Bot** - a traditional template that includes language understanding service and bot analytics.
   - **Virtual Assistant** - a very complex example of enterprise-level bot that can integrate different **skills** and provides integration of many different services.
   - **Language Understanding Bot** - a bot that connects to an existing **LUIS** language model.
   - **Q&A Maker Bot** - a bot that answers simple questions based on a questions and answers table.

1. Now we'll create an **App Service Plan**.
   1. Select "App Service Plan/Location".
   1. Select **Create New**
   1. Type in a suitable name for App Service Plan. This plan determines how much of compute resources would be allocated to your bot.

   ![App Service Plan](../media/azure-portal-app-service-plan.png)

   > [!TIP]
   >The **S1** plan is the default. It's  not free so you might want to change your plan afterwards. See [Manage an App Service plan in Azure][AdjustServicePlan] for details.

1. Fine tune the settings for **Application Insights** which is useful for monitoring the behavior of your bot. For now, you can turn application insights off or specify the Azure datacenter location closest to you.

1. Select **Create** when all fields are filled in.

It takes some time for all bot resources to be created. When you get the notification that deployment is complete, look at the resource group to see what's there.

## Bot page on the Azure portal

From the Azure portal start page, select **Resource Groups**. Then select the group you created earlier.

![Bot Resource Group](../media/azure-portal-bot-resource-group.png)

Take note of these important components:

- **GeoFriend** - a web app bot that connects your bot code to the different communication channels. This resource also gives you access to bot code and lets you test the bot in web chat.
- **geofriend** - an application service that contains the code for your bot. We'll choose this later when we deploy the bot code from Visual Studio.

Also shown are the application insights instance and the bot app service plan. The latter might need adjustment if you want to scale the bot to handle more requests or move it to a free plan.

Select the **GeoFriend** link. You'll see the bot page on the portal:

![Azure portal bot page](../media/azure-portal-bot-page.png)

This page is the main starting point for configuring the bot. On the **Overview** tab you can see the typical sequence of steps for completing the bot project. The first stage is the idea or **Plan**. It's followed by the **Build** stage which is where we are now. We'll discuss how to build the bot in the next unit.

## Running the bot

Right from bot page, we can try our newly created bot in action. Select **Test in Web Chat** tab on the left pane, and you'll see a chat box that you can use to converse with the bot.

![Web Chat](../media/azure-portal-web-chat.png)

Try typing in some text, and see how the bot responds.

Next we'll learn how to alter the bot's behavior.

<!-- links -->

[BotFW]: https://dev.botframework.com/
[BotService]: https://azure.microsoft.com/services/bot-service/
[CoServ]: https://microsoft.com/cognitive
[azure-portal-]: https://portal.azure.com
[AdjustServicePlan]: https://docs.microsoft.com/azure/app-service/app-service-plan-manage
[LUIS]: https://docs.microsoft.com/azure/cognitive-services/luis/
[QnAMaker]: https://docs.microsoft.com/azure/cognitive-services/qnamaker/
