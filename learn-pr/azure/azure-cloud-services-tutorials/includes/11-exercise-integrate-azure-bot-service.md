In this module, you'll learn how to use **Azure Bot Service** in the **HoloLens 2** demo application to add Language Understanding (LUIS), which allows the Bot to assist the user when searching for **Tracked Objects**. This module is a two-part module. In the first part, you'll create the Bot with the [Bot Composer](/composer/introduction) as a code-free solution and take a quick look in the Azure Function that feeds the Bot with the needed data. In the second part, you use the **BotManager (script)** in the Unity project to use the hosted Bot Service.

## Understand Azure Bot Service

The **Azure Bot Service** empowers developers to create intelligent bots that can maintain natural conversation with users thanks to **LUIS**. A conversational Bot is a great way to expand the ways a user can interact with your application. A Bot can act as a knowledge base with a [QnA Maker](/Azure/bot-service/bot-builder-howto-qna?preserve-view=true&tabs=cs&view=Azure-bot-service-4.0) to maintaining sophisticated conversation with the power of [Language Understanding (LUIS)](/Azure/bot-service/bot-builder-howto-v4-luis?preserve-view=true&tabs=csharp&view=Azure-bot-service-4.0).

Learn more about [Azure Bot Service](/Azure/bot-service/bot-service-overview-introduction?preserve-view=true&view=Azure-bot-service-4.0).

## Part 1 - Create the bot

Before you can use the bot in the Unity application, you need to develop it, provide it with data and host it on **Azure**.

The goal of the bot is to have the ability to tell how many *Tracked Objects* are stored in the database, find a *Tracked Object* by its name, and tell the user some basic information about it.

### A quick look into tracked objects Azure function

You're about to start creating the Bot, but to make it useful, you need to provide a resource from which it can pull data. Since the Bot can count the amount of **Tracked Objects**, find specific ones by name, and provide object details, you'll use an Azure Function that has access to **Azure Table Storage**.

Download the Tracked Objects Azure Function project: [AzureFunction_TrackedObjectsService.zip](https://github.com/microsoft/MixedRealityLearning/releases/download/azure-cloud-services-v2.4.0/AzureFunction_TrackedObjectsService.zip). Extract it to your computer.

This Azure Function has two actions, **Count** and **Find**, which can be invoked via basic *HTTP* *GET* calls. You can inspect the code in **Visual Studio**.

Learn more about [Azure Functions](/Azure/Azure-functions/functions-overview).

The **Count** function queries from the **Table storage** all **TrackedObjects** from the table. The **Find** function takes a *name* query parameter from the *GET* request and queries the **Table storage** for a matching **TrackedObject** and returns a DTO as JSON.

1. To deploy this **Azure Function** directly from **Visual Studio**, open the downloaded `AzureFunction_TrackedObjectsService` folder and open the present **.sln** file with Visual Studio.

    :::image type="content" source="../media/azure-track-object.png" alt-text="Screenshot of AzureFunction_TrackedObjectsService folder." lightbox="../media/azure-track-object.png":::

2. Right-click **Tracked object service** in the solution explorer and Select **Publish**.

    :::image type="content" source="../media/publish-track-object.png" alt-text="Screenshot of Publish Tracked object service." lightbox="../media/publish-track-object.png":::

3. The publish pop up will ask for a target platform. Select **Azure**, then select the **Next** button.

    :::image type="content" source="../media/select-target-platform.png" alt-text="Screenshot of Select target platform." lightbox="../media/select-target-platform.png":::

4. Select **Azure Function App(Windows)**, then select the **Next** button.

    :::image type="content" source="../media/select-target-host.png" alt-text="Screenshot of Select target host." lightbox="../media/select-target-host.png":::

5. If you're not logged in to Azure, log in through Visual Studio as below:

    :::image type="content" source="../media/create-azure-function.png" alt-text="Screenshot of Select or create Azure Function." lightbox="../media/create-azure-function.png":::

6. Select the **Pulse** button to create a new Function App in your Azure account:

    :::image type="content" source="../media/create-new-function-app.png" alt-text="Screenshot of Create new Function App." lightbox="../media/create-new-function-app.png":::

    * For **Name**, enter a suitable name for the service, for example, *TrackedObjectsService*
    * For **Plan Type**, choose consumption
    * For **Location**, choose a location close to your app users' physical location, for example *(US) West US*
    * For **Resource Group** and **Storage**, choose the resource group and storage accounts you created earlier in this module.

7. Once the Function App is created, select the **Finish** button.

    :::image type="content" source="../media/finish-create-function-app.png" alt-text="Screenshot of Finish creating Function App." lightbox="../media/finish-create-function-app.png":::

8. To update the connection string, select the **More options** (three dots) on the **Hosting** tab and select **Manage Azure App Service settings**.

    :::image type="content" source="../media/update-connection-string.png" alt-text="Screenshot of update connection string." lightbox="../media/update-connection-string.png":::

9. In the **Application Settings** window, replace the current `AzureStorageConnectionString` for both **Local** and **Remote** with your `AzureStorageConnectionString`. Select **OK**.

    :::image type="content" source="../media/replace-conncection-string.png" alt-text="Screenshot of replace connection string." lightbox="../media/replace-conncection-string.png":::

10. Select the **Publish** button to publish the function. Wait for the publish to complete.

11. When publishing completes, select **Manage in Azure portal** in the Actions section, then select **Configuration** in the *Settings* section. In **Application Settings**, provide the *Connection string* to the **Azure Storage** where the **Tracked Objects** are stored. Select **New Application setting**, enter *AzureStorageConnectionString* for the name, then enter your *Connection string* as the value. Select **Save**.

12. Select **Functions** in the *Functions* section. Select the **Count** function at the top of the screen, then select the *Get Function Url* button.

Follow the same procedure to get the **Find** function Url.

### Create a conversation bot

There are several ways to develop a Bot-Framework-based conversational bot. In this lesson, you'll use the [Bot Framework Composer](/composer/) desktop application, which is a visual designer that is perfect for rapid development.

You can download the latest releases from the [GitHub repository](https://github.com/microsoft/BotFramework-Composer/releases) for Windows, Mac, and Linux.

1. Once the **Bot Framework Composer** is installed, start the application and you should have this interface:

    :::image type="content" source="../media/bot-frame-work-composer.png" alt-text="Screenshot of Bot Framework Composer Home." lightbox="../media/bot-frame-work-composer.png":::

2. We have prepared a bot composer project, which provides the needed dialogues and triggers for this tutorial. Download the Bot Framework Composer project: [BotComposerProject_TrackedObjectsBot.zip](https://github.com/microsoft/MixedRealityLearning/releases/download/azure-cloud-services-v2.4.0/BotComposerProject_TrackedObjectsBot.zip) and extract it to your computer.

3. Select **Open** on the top navigation bar, then select the **TrackedObjectsBot** Bot Framework project. The project will load.

    :::image type="content" source="../media/track-object-bot.png" alt-text="Screenshot of Bot Framework Composer with TrackedObjectsBot project opened." lightbox="../media/track-object-bot.png":::

    Let's focus on the **Dialogs Panel** on the left side. You will have one dialog named **TrackedObjectsBot**, under which you can see several **Triggers**.

    Learn more about [Bot Framework concepts](/composer/concept-dialog).

    Let's take a look at these triggers and their functionalities.

#### Greeting

* Greeting is the entry point of the chat bot when ever a user initiates a conversation.

    :::image type="content" source="../media/track-object-bot-greet.png" alt-text="Screenshot of TrackedObjectsBot project dialog trigger Greeting." lightbox="../media/track-object-bot-greet.png":::

#### AskingForCount

* This dialog is triggered when the user asks for a count of all **Tracked Objects**.
The trigger phrases are:

    >* count me all
    >* how many are stored

    :::image type="content" source="../media/ask-count.png" alt-text="Screenshot of TrackedObjectsBot project dialog trigger AskForCount." lightbox="../media/ask-count.png":::

    Thanks to [LUIS](/composer/how-to-add-luis) the user doesn't have to ask the phrases in that exact way, which allows for more natural conversation.

    In this dialog, the bot will also talk to the **Count** Azure Function, which we will cover more later.

#### Unknown intent

* This dialogue is triggered if the input from the user doesn't fit any other trigger condition, so the dialog asks the user to try their question again.

    :::image type="content" source="../media/unknown-intent.png" alt-text="Screenshot of TrackedObjectsBot project dialog trigger Unknown Intent." lightbox="../media/unknown-intent.png":::

#### FindEntity

* The last dialogue is more complex, with branching and storing data in the bot's memory.
It asks the user for the *name* of the **Tracked Object** they want to know more information about, performs a query to the **Find** Azure Function, and uses the response to proceed with the conversation.

    :::image type="content" source="../media/find-entity.png" alt-text="Screenshot of TrackedObjectsBot project dialog trigger FindEntity." lightbox="../media/find-entity.png":::

    If the **Tracked Object** isn't found, the user is informed and the conversation ends. When the **Tracked Object** in question is found, the bot will check what properties are available and report on them.

### Adapt the bot

1. The **AskingForCount** and **FindEntity** trigger need to talk to the backend, so you will need to add the **Azure Function** URL you deployed previously.

2. Select **AskingForCount** on the **Dialog** pane, then locate the *Send an HTTP request* action. Enter the URL for the *Count* function endpoint in the **URL** field.

    :::image type="content" source="../media/ask-count-end-point.png" alt-text="Screenshot of TrackedObjectsBot project AskingForCount dialog trigger endpoint configuration." lightbox="../media/ask-count-end-point.png":::

3. Select the **FindEntity** trigger, then locate the *Send an HTTP request* action. Enter the URL for the *Find* function endpoint in the **URL** field.

    :::image type="content" source="../media/find-entity-end-point.png" alt-text="Screenshot of TrackedObjectsBot project FindEntity dialog trigger endpoint configuration." lightbox="../media/find-entity-end-point.png":::

    You're now ready to deploy the Bot. Since you have the Bot Framework composer installed, you can publish it directly from there.

    Learn more about [Publish a bot from Bot Composer](/composer/how-to-publish-bot).

    > [!TIP]
    > Feel free to experiment with the Bot by adding more trigger phrases, new responses, or conversation branching.

## Part 2 - Put everything together in Unity

### Prepare the scene

1. In the Project window, navigate to the **Assets** > **MRTK.Tutorials.AzureCloudServices** > **Prefabs** > **Manager** folder.

    :::image type="content" source="../media/chat-bot-manager-prefab.png" alt-text="Screenshot of Unity Project window with ChatBotManager prefab selected." lightbox="../media/chat-bot-manager-prefab.png":::

2. Drag the prefab **ChatBotManager** into the scene Hierarchy.

3. Once you add the ChatBotManager to the scene, select the **Chat Bot Manager** component.
In the Inspector, enter your secret key in the **Direct Line Secret Key** field.

    > [!TIP]
    > You can retrieve the *secret key* from the Azure portal by looking for the **Bot Channels Registration** resource you created in the first part of this tutorial.

    :::image type="content" source="../media/add-chat-bot-manager.png" alt-text="Screenshot of Unity with newly added ChatBotManager prefab still selected." lightbox="../media/add-chat-bot-manager.png":::

4. Now you'll connect the **ChatBotManager** object with the **ChatBotController** component that is attached to the **ChatBotPanel** object. In the Hierarchy, select the **ChatBotPanel** and drag the **ChatBotManager** object from the Hierarchy into the empty **Chat Bot Manager** field.

    :::image type="content" source="../media/chat-bot-panel-configure.png" alt-text="Screenshot of Unity with ChatBotPanel configured." lightbox="../media/chat-bot-panel-configure.png":::

5. Next, you need a way to open the **ChatBotPanel** so  the user can interact with it. From the Scene window, locate the *Chat Bot* side button on the **MainMenu** object. You'll use this to open the chat bot.

6. In the Hierarchy, locate **RootMenu** > **MainMenu** > **SideButtonCollection** > **ButtonChatBot** and locate in the Inspector the *ButtonConfigHelper* script. Drag and drop the **ChatBotPanel** to the empty slot on the **OnClick()** event callback. From the dropdown list, select *GameObject*, then select in the sub menu *SetActive (bool)* and enable the checkbox.

    :::image type="content" source="../media/button-chat-bot-configure.png" alt-text="Screenshot of Unity with ButtonChatBot configured." lightbox="../media/button-chat-bot-configure.png":::

    Now, your user can start the chat bot from the main menu. The scene is now ready for use.

### Test the bot

#### Ask about the quantity of tracked objects

First, let's test the bot by asking how many **Tracked Objects** are stored in the database.

> [!NOTE]
> Run the application from the HoloLens 2, as services like *Text to speech* may not be available on your system.

Run the application on your HoloLens 2 and select the *Chat Bot* button next to the main menu.
After the bot greets you, ask **how many objects do we have?**
The note should tell you the object quantity and end the conversation.

> [!Note]
> Building and testing on HoloLens 2 is not mandatory. You can test on the [HoloLens 2 Emulator](/windows/mixed-reality/develop/advanced-concepts/using-the-hololens-emulator) if you don't have a HoloLens device. You can purchase devices at [HoloLens.com](http://hololens.com/).

#### Ask about a tracked object

Now, run the application again. This time, ask **find me a tracked object**. the bot will ask you the name, to which you should respond with the **car** (or the name of another *Tracked Object* you know exists in the database). The bot will give you details, like description and if the object has a spatial anchor assigned.

> [!TIP]
> Try asking for a **Tracked Object** that doesn't exist and note how the bot responds.
