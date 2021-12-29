We've now seen some of the main principles for building responsible bots. Let's apply these concepts as we build a simple geography assistant bot. The easiest way to start is with a Visual Studio bot template.

## Create your bot

The Microsoft Bot Builder V4 Templates include templates for different levels of bots. You can use them to build basic bots. But you can also use them for advanced conversational-AI bots that use language understanding.

We'll use the **Echo Bot** template. The bot that we'll create can receive messages from a user. As its name suggests, the bot processes those messages by echoing them back to the user.

Follow these steps to create your bot:

1. From the Visual Studio start window, select **Create a new project**.

1. On the **Create a new project** page, in the project list, choose **AI Bots** to show only bot templates.

   :::image type="content" source="../media/visual-studio-select-ai-bots-project.png" alt-text="Screenshot of the Create a new project window in Visual Studio. A I Bots is selected in the project list.":::

1. Select the **Echo Bot (Bot Framework v4 - .NET Core 3.1)** template, and then select **Next**.

   :::image type="content" source="../media/visual-studio-new-project-select-echo-bot.png" alt-text="Screenshot of the Create a new project window in Visual Studio. The Bot Framework v4 S D K for Visual Studio extension and the Next button are called out.":::

1. Give your project a name like **GeoFriend**, select a location for the code, and then select **Create**.

   :::image type="content" source="../media/visual-studio-configure-project.png" alt-text="Screenshot of the Configure your new project window in Visual Studio. The Project name and Location boxes are called out.":::

Visual Studio uses the template to create a new project for your bot. In the next unit, we'll run your bot in Bot Framework Emulator.
