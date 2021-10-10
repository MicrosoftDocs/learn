In this module, you'll learn how to use **Azure Bot Service** in the **HoloLens 2** demo application to add Language Understanding (LUIS) and letting the Bot assist the user when searching for **Tracked Objects**. This module is a two-part module where in the first part, you create the Bot with the [Bot Composer](/composer/introduction) as a code-free solution and take a quick look in the Azure Function that feeds the Bot with the needed data. Then, in the second part, you use the **BotManager (script)** in the Unity project to consume the hosted Bot Service.

## Understand Azure Bot Service

The **Azure Bot Service** empowers developers to create intelligent bots that can maintain natural conversation with users thanks to **LUIS**. A conversational Bot is a great way to expand the ways a user can interact with your application. A Bot can act as a knowledge base with a [QnA Maker](/Azure/bot-service/bot-builder-howto-qna?preserve-view=true&tabs=cs&view=Azure-bot-service-4.0) to maintaining sophisticated conversation with the power of [Language Understanding (LUIS)](/Azure/bot-service/bot-builder-howto-v4-luis?preserve-view=true&tabs=csharp&view=Azure-bot-service-4.0).

Learn more about [Azure Bot Service](/Azure/bot-service/bot-service-overview-introduction?preserve-view=true&view=Azure-bot-service-4.0).

## Part 1 - Create the bot

Before you can use the bot in the Unity application, you need to develop it, provide it with data and host it on **Azure**.
The goal of the bot is to have the abilities to tell how many *Tracked Objects* are stored in the database, find a *Tracked Object* by its name, and tell the user some basic information about it.

### A quick look into tracked objects Azure function

You're about to start creating the Bot, but to make it useful you need to give it a resource from which it can pull data. Since the *Bot* can count the amount of **Tracked Objects**, find specific ones by name and tell details, you'll use a Azure Function that has access to the **Azure Table storage**.

Download the Tracked Objects Azure Function project: [AzureFunction_TrackedObjectsService.zip](https://github.com/microsoft/MixedRealityLearning/releases/download/azure-cloud-services-v2.4.0/AzureFunction_TrackedObjectsService.zip) and extract it to your hard drive.

This Azure Function has two actions, **Count** and **Find** which can be invoked via basic *HTTP* *GET* calls. You can inspect the code in **Visual Studio**.

Learn more about [Azure Functions](/Azure/Azure-functions/functions-overview).

The **Count** function queries from the **Table storage** all **TrackedObjects** from the table, simple. On the other hand, the **Find** function takes a *name* query parameter from the *GET* request and queries the **Table storage** for a matching **TrackedObject** and returns a DTO as JSON.

1. To deploy this **Azure Function** directly from **Visual Studio**, open the downloaded AzureFunction_TrackedObjectsService folder and open the present **.sln** file with visual studio

    :::image type="content" source="../media/azure-track-object.png" alt-text="Screenshot of AzureFunction_TrackedObjectsService folder." lightbox="../media/azure-track-object.png":::

2. Once file loaded in visual studio, Right click over **Tracked object service** in solution explorer and select publish

    :::image type="content" source="../media/publish-track-object.png" alt-text="Screenshot of Publish Tracked object service." lightbox="../media/publish-track-object.png":::

3. The publish pop up will be displayed and ask for target platform
Select Azure and click on **Next** button

    :::image type="content" source="../media/select-target-platform.png" alt-text="Screenshot of Select target platform." lightbox="../media/select-target-platform.png":::

4. In specific target, select **Azure Function App(Windows)** and click on **Next** button

    :::image type="content" source="../media/select-target-host.png" alt-text="Screenshot of Select target host." lightbox="../media/select-target-host.png":::

5. If you're not logged in to Azure, login through visual studio and the window look like

    :::image type="content" source="../media/create-azure-function.png" alt-text="Screenshot of Select or create Azure Function." lightbox="../media/create-azure-function.png":::

6. Click on pulse button to create new Function App in Azure account

    :::image type="content" source="../media/create-new-function-app.png" alt-text="Screenshot of Create new Function App." lightbox="../media/create-new-function-app.png":::

    * For **Name**, enter a suitable name for the service, for example, *TrackedObjectsService*
    * For **Plan Type**, choose consumption
    * For **Location**, choose a location close to your app users' physical location, for example *(US) West US*
    * For **Resource Group** and **Storage**, choose respective Azure group and storage account have been created in pervious chapters.

7. Once Function App created click on **Finish** button

    :::image type="content" source="../media/finish-create-function-app.png" alt-text="Screenshot of Finish creating Function App." lightbox="../media/finish-create-function-app.png":::

8. To update the connection string click on **3 dots** on **hosting** tab and select **Manage Azure App Service settings**

    :::image type="content" source="../media/update-connection-string.png" alt-text="Screenshot of update connection string." lightbox="../media/update-connection-string.png":::

9. this opens the **Application Settings** window hear replace your AzureStorageConnectionString for both **Local** and **Remote** with your AzureStorageConnectionString. once replaced click on ok.

    :::image type="content" source="../media/replace-conncection-string.png" alt-text="Screenshot of replace connection string." lightbox="../media/replace-conncection-string.png":::

10. Now click on **Publish** button to publish the function and wait for publish.

11. Once completion of publish click on **Manage in Azure portal** under Actions section, it's take you to specific function in Azure portal and click on **Configuration** which is under the *Settings* section. There on **Application Settings** you need to provide the *Connection string* to the **Azure Storage** where the **Tracked Objects** are stored. Click on **New Application setting** and use for name: **AzureStorageConnectionString** and for value provide the correct *Connection string*. After that click on **Save** and the **Azure Function** is ready to server the *Bot*, which you'll create next.

12. To get URL of count and Find, select **Functions** which is under the *Functions* section. here you can find both Count and Find function, select Count function on top side you can find the *Get Function Url* button.

Follow the same procedure to get Find function Url.

### Create a conversation bot

There are several ways to develop a Bot Framework based conversational bot. In this lesson, you'll use the [Bot Framework Composer](/composer/) desktop application, which is a visual designer that is perfect for rapid development.

You can download the latest releases from the [GitHub repository](https://github.com/microsoft/BotFramework-Composer/releases). It's available for Windows, Mac, and Linux.

1. Once the **Bot Framework Composer** is installed, start the application and you should see this interface:

    :::image type="content" source="../media/bot-frame-work-composer.png" alt-text="Screenshot of Bot Framework Composer Home." lightbox="../media/bot-frame-work-composer.png":::

2. We have prepared a bot composer project, which provides the needed dialogues and triggers for this tutorial. Download the Bot Framework Composer project: [BotComposerProject_TrackedObjectsBot.zip](https://github.com/microsoft/MixedRealityLearning/releases/download/azure-cloud-services-v2.4.0/BotComposerProject_TrackedObjectsBot.zip) and extract it to your hard drive.

3. On the top bar click on **Open** and select the Bot Framework project you've downloaded which is named **TrackedObjectsBot**. After the project is fully loaded, you should see the project ready.

    :::image type="content" source="../media/track-object-bot.png" alt-text="Screenshot of Bot Framework Composer with TrackedObjectsBot project opened." lightbox="../media/track-object-bot.png":::

    Let's focus on the left side where you can see the **Dialogs Panel**. There you've one dialog named **TrackedObjectsBot** under which you can see several **Triggers**.

    Learn more about [Bot Framework concepts](/composer/concept-dialog).

    These triggers do the following functionalities:

#### Greeting

* Greeting is the entry point of the chat *bot* when ever a *user* initiates a conversation.

    :::image type="content" source="../media/track-object-bot-greet.png" alt-text="Screenshot of TrackedObjectsBot project dialog trigger Greeting." lightbox="../media/track-object-bot-greet.png":::

#### AskingForCount

* This dialog is triggered when the *user* asks for counting all **Tracked Objects**.
These are the trigger phrases:

    >* count me all
    >* how many are stored

    :::image type="content" source="../media/ask-count.png" alt-text="Screenshot of TrackedObjectsBot project dialog trigger AskForCount." lightbox="../media/ask-count.png":::

    Thanks to [LUIS](/composer/how-to-add-luis) the *user* doesn't have to ask the phrases in that exact way, which allows a natural conversation for the *user*.

    In this dialog the *bot* will also talk to the **Count** Azure Function, more about that later.

#### Unknown intent

* This dialogue is triggered if the input from the *user* doesn't fit any other trigger condition and responses the user with trying his question again.

    :::image type="content" source="../media/unknown-intent.png" alt-text="Screenshot of TrackedObjectsBot project dialog trigger Unknown Intent." lightbox="../media/unknown-intent.png":::

#### FindEntity

* The last dialogue is more complex with branching and storing data in the *bots* memory.
It asks the user for the *name* of the **Tracked Object** it wants to know more information about, performs a query to the **Find** Azure Function, and uses the response to proceed with the conversation.

    :::image type="content" source="../media/find-entity.png" alt-text="Screenshot of TrackedObjectsBot project dialog trigger FindEntity." lightbox="../media/find-entity.png":::

    If the **Tracked Object** isn't found, the user is informed and the conversation ends. When the **Tracked Object** in question is found, the boot will check what properties are available and report on them.

### Adapt the bot

1. The **AskingForCount** and **FindEntity** trigger need to talk to the backend, this means you've to add the correct URL of the **Azure Function** you deployed previously.

2. On the dialog panel click on **AskingForCount** and locate the *Send an HTTP request* action, here you can see the field **URL** which you need to change the correct URL for the **Count** function endpoint.

    :::image type="content" source="../media/ask-count-end-point.png" alt-text="Screenshot of TrackedObjectsBot project AskingForCount dialog trigger endpoint configuration." lightbox="../media/ask-count-end-point.png":::

3. Finally, look for the **FindEntity** trigger and locate the *Send an HTTP request* action, in the **URL** field change the URL to the **Find** function endpoint.

    :::image type="content" source="../media/find-entity-end-point.png" alt-text="Screenshot of TrackedObjectsBot project FindEntity dialog trigger endpoint configuration." lightbox="../media/find-entity-end-point.png":::

    With everything set you're now ready to deploy the Bot. Since you've Bot Framework composer installed, you can publish it directly from there.

    Learn more about [Publish a bot from Bot Composer](/composer/how-to-publish-bot).

    > [!TIP]
    > Feel free playing around with Bot by adding more trigger phrases, new responses or conversation branching.

## Part 2 - Put everything together in Unity

### Prepare the scene

1. In the Project window, navigate to **Assets** > **MRTK.Tutorials.AzureCloudServices** > **Prefabs** > **Manager** folder.

    :::image type="content" source="../media/chat-bot-manager-prefab.png" alt-text="Screenshot of Unity Project window with ChatBotManager prefab selected." lightbox="../media/chat-bot-manager-prefab.png":::

2. From there move the prefab **ChatBotManager** into the scene Hierarchy.

3. Once you add the ChatBotManager to the scene, click on the **Chat Bot Manager** component.
In the Inspector, you'll see that there is an empty **Direct Line Secret Key** field, which you need to fill out.

    > [!TIP]
    > You can retrieve the *secret key* from the Azure portal by looking for the resource of type **Bot Channels Registration** you've created in the first part of this tutorial.

    :::image type="content" source="../media/add-chat-bot-manager.png" alt-text="Screenshot of Unity with newly added ChatBotManager prefab still selected." lightbox="../media/add-chat-bot-manager.png":::

4. Now you'll connect the **ChatBotManager** object with the **ChatBotController** component that is attached to the **ChatBotPanel** object. In the Hierarchy select the **ChatBotPanel** and you'll see an empty **Chat Bot Manager** field, drag from the Hierarchy the **ChatBotManager** object into the empty **Chat Bot Manager** field.

    :::image type="content" source="../media/chat-bot-panel-configure.png" alt-text="Screenshot of Unity with ChatBotPanel configured." lightbox="../media/chat-bot-panel-configure.png":::

5. Next you need a way to open the **ChatBotPanel** so that the user can interact with it. From the Scene window, you may have noticed that there is a *Chat Bot* side button on the **MainMenu** object, you'll use it to solve this problem.

6. In the Hierarchy locate **RootMenu** > **MainMenu** > **SideButtonCollection** > **ButtonChatBot** and locate in the Inspector the *ButtonConfigHelper* script. There you'll see an empty slot on the **OnClick()** event callback. Drag and drop the **ChatBotPanel** to the event slot, from the dropdown list navigate *GameObject*, then select in the sub menu *SetActive (bool)* and enable the checkbox.

    :::image type="content" source="../media/button-chat-bot-configure.png" alt-text="Screenshot of Unity with ButtonChatBot configured." lightbox="../media/button-chat-bot-configure.png":::

    Now the chat bot can be stared from the main menu and with that the scene is ready for use.

### Put the bot to a test

#### Ask about the quantity of tracked objects

First you test asking the bot how many **Tracked Objects** are stored in the database.

> [!NOTE]
> This time you must run the application from the HoloLens 2 because services like *text-to-speech* may not be available on your system.

Run the application on your HoloLens 2 and click on the *Chat Bot* button next to the main menu.
The bot will be greeting you, now ask **how many objects do we have?**
It should tell you the quantity and end the conversation.

#### Ask about a tracked object

Now run the application again and this time ask **find me a tracked object**, the bot will be asking you the name to which you should respond with the "car" or the name of another *Tracked Object* you know exists in the database. The bot will tell you details like description and if it has a spatial anchor assigned.

> [!TIP]
> Try out asking for an **Tracked Objects** that doesn't exist and hear how the bot responds.
