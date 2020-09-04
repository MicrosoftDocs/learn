Using the Bot Framework Composer presents some advantages when compared to creating a bot with the SDK and coding.

- Use of Adaptive Dialogs allow for Language Generation (LG), which can simplify interruption handling and give bots character.
- Visual design surface in Composer eliminates the need for boilerplate code and makes bot development more accessible.
- Time saved with fewer steps to set up your environment.
- The Composer bot projects contain reusable assets in the form of JSON and Markdown files that can be bundled and packaged with a bot's source code. The files can be checked into source control systems and deployed along with code updates, such as dialogs, language understanding (LU) training data, and message templates.

>[!TIP]
>Keep up-to-date with the releases of the Composer in the [GitHub repo](https://github.com/microsoft/BotFramework-Composer/releases)

## Install the Composer

Before you can begin to work with the Bot Framework Composer, you will need to install the correct desktop application for your operating system. The Composer is available for [Windows](https://aka.ms/bf-composer-download-win), [macOS](https://aka.ms/bf-composer-download-mac), and [Linux](https://aka.ms/bf-composer-download-linux).

You will also need to install the [Bot Framework Emulator](https://github.com/microsoft/BotFramework-Emulator/releases/latest) and ensure that you have [.NET Core SDK 3.1](https://dotnet.microsoft.com/download/dotnet-core/3.1) or later installed as well.

## Explore the Bot Framework Composer

Once you have the prerequisites installed, and have downloaded and installed the Bot Framework Composer, start the application. You will review some of the key features of the interface to get familiar with how to use it. When you first start the Composer, you will see the Home screen where you begin creating your bot.

[![Bot Framework Composer Home screen](../media/home-new-create.png)](../media/home-new-create.png#lightbox)

The first time you run the application, the product tour is displayed in the lower right corner. Take some time to run through that tour and get a basic understanding of some of the components of the interface. When you have completed all the steps, select the Done button to close it.

After reviewing the product tour, you have some knowledge of the different aspects of the interface of the Composer. We will go over a few more items here.

### Home Screen

On the Home screen, you can create a new bot, open an existing bot on your computer, view some tutorial videos, and also examine some example bots created using the Composer. The Home screen can be accessed at any time by selecting **Home** from the left navigation bar. Selecting the three lines, or hamburger menu, will expand or collapse the **Navigation** menu.

The **Navigation** menu provides options for designing and working on your bot. The **Design** option opens up the visual designer where you will lay out the conversation and navigation flow of your bot. If you have a bot project open, selecting *Navigation** will open the designer for that bot.

**Bot Responses** is the option where you can view and select the various options that the Composer provides for responding to users.  Here you will find common response types such as single or multi-line text options as well as some language generation options that allow you to integrate variables in the response.

**User Input** provides options for prompting and accepting input from the user as they interact with your bot.

**Notifications**  you can manage the notifications for the bot here.

**Publish** allows you to manage publishing profiles. Currently, the Composer supports publishing to Azure Functions or Azure Web Apps, both in Preview at this time.

**Skills** you configure any skills that you want your bot to use.  Skills require a Microsoft App ID and a host endpoint.

**Settings**  an editor for the **Bot settings**, **Application settings**, and **Runtime config** options. For example, under **Bot settings**, you would configure the necessary authoring key and endpoint information for LUIS integration. Perhaps you want to log your bot conversations to a CosmosDB instance on Azure so you would edit the CosmosDB section to include the password, app ID, CosmosDB authKey, collectionId, endpoint, and database ID.

The Application settings portion allows you to configure Composer-specific behaviors. You can select a custom runtime option as well in the **Settings** for the Composer. We will not cover custom runtime configs.

## Create a basic bot with Composer

1. Ensure that you have installed the prerequisites and the Bot Framework Composer.
1. Start the Bot Framework Composer.
1. On the **Home** screen, select **New**.
1. Select the radio button for **Create from scratch**.
1. Select **Next**.
1. In the **Define conversation objective** dialog, change the default **Name** to **MyFirstBot**, or a name of your choosing.
1. Select the **Location** on your computer to store the bot.
1. Provide a **Description** of the bot.
1. Select **OK**.
1. The Composer will generate some framework aspects of your bot and then open the bot in the interface.

    [![New bot with Composer](../media/new-bot.png)](../media/new-bot.png#lightbox)

1. Under **Filter Dialog**, select **Greeting**.
1. The designer opens in the middle of the Composer interface with some content already populated. This content in the designer, represents the *ConversationUpdate** activity that is called when a user joins a conversation with the bot. The designer shows that the bot will loop for each item (members added), includes a branch segment that will handle recipient IDs, and then a response item.
1. You can edit the title of **Greeting** by selecting the word **Greeting** in the properties pane on the right and typing in a new value.  Select the **Greeting** text and change it to **WelcomeUsers**.

    :::image type="content" source="../media/change-greeting.png" alt-text="Editing Greeting text in properties pane":::

1. In the designer pane, select the **Send a response** component.
1. In the **Properties** pane on the right, change the default text *${WelcomeUser()}*  to **Welcome to our basic bot.**
1. In the **Designer** pane, locate the **+** symbol just above the circle in the bottom of the diagram and select it.

    :::image type="content" source="../media/plus-symbol.png" alt-text="plus symbol at bottom of designer diagram":::

1. A list of components is displayed.  Select **Ask a question** from the list.
1. In the designer, select the **Bot Asks (Text)** component.
1. In the **Properties** pane on the right, enter the text, **Enter your first name** in the **Prompt for text** section.
1. In the **Properties** pane, select the **User Input** option next to **Bot Asks** and enter **user.name**. The option will set up a variable that you can access later in the bot conversation.

    :::image type="content" source="../media/user-input.png" alt-text="User input option with user.name entered":::

1. Back in the **Designer** pane, select the **+** symbol under the **User Input(Text)** component.
1. Select the **Send a response** option.
1. In the **Designer** pane, select the newly added **Send a response** component.
1. In the **Properties** pane, enter the following text, **Hello ${user.name}, nice to meet you**.
1. Your simple bot is complete so now let's test it.
1. Select the **Start Bot** button in the upper right-hand corner of Composer.
1. You will notice **Reloading** indicated next to the button as the bot is compiled and started.
1. When it completes, a **Test in Emulator** option is available next to the button. 
1. A Windows Firewall dialog may display. Select both check boxes on the **Windows Firewall** dialog and select **OK**.
1. In the Bot Framework Composer, select **Test in Emulator**.
1. Wait for the Bot Emulator to start and watch the log window.  You will notice the URL and port that the bot is listening on.
1. After a short pause, you will see the welcome message and the prompt to enter your first name.  Enter you first name and press **Enter**.
1. The bot should respond with the **Hello *firstname*, nice to meet you**.
1. You have created your first simple bot with the Bot Framework Composer and tested it with the Bot Framework Emulator.
