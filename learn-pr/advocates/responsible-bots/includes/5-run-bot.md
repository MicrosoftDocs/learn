Let's start chatting with our **GeoFriend** assistant bot. In the previous unit, we used a template to create our bot in Visual Studio. The template provides code for a basic bot that echoes user input. We don't need any additional code to run our bot.

## Run your bot locally

With your bot project open in Visual Studio, follow these steps to run your bot:

1. In the Visual Studio top menu bar, select **Debug** > **Start without debugging**.

   :::image type="content" source="../media/visual-studio-run-bot-first-time.png" alt-text="Screenshot of the Visual Studio GeoFriend project. The Debug menu is visible, with Debug and Start without debugging called out.":::

   This step builds the application and deploys it locally. If the bot code compiles correctly, a browser window opens:

   :::image type="content" source="../media/browser-window-endpoint-url.png" alt-text="Screenshot of a browser window showing the bot's default page. Text in the window gives the bot's endpoint U R L.":::

1. The browser window shows the endpoint URL for your bot, such as `https://localhost:<port>/api/messages`. Copy and save this URL value.

## Run your bot in Bot Framework Emulator

Next we'll run our bot in Bot Framework Emulator. As we chat with our bot, the bot will still run locally. But Bot Framework Emulator will display the messages that would appear in a web chat UI.

1. Install [Bot Framework Emulator][BotEmulator].

1. Start Bot Framework Emulator.

1. On the **Welcome** tab, select **Open Bot**.

   :::image type="content" source="../media/bot-framework-emulator-welcome-tab.png" alt-text="Screenshot of the Welcome tab of Bot Framework Emulator with the Open Bot button called out.":::

1. In the **Bot URL** box, enter the URL value that you copied earlier from the browser window. Then select **Connect**.

   :::image type="content" source="../media/bot-framework-emulator-open-bot-window.png" alt-text="Screenshot of the Open a bot window of Bot Framework Emulator with the Bot U R L box called out.":::

1. Try sending a message to your bot, and see how the bot responds.

   :::image type="content" source="../media/bot-framework-emulator-initial-message-exchange.png" alt-text="Screenshot of the Live Chat tab of Bot Framework Emulator. A few messages show that the bot echoes any text that users enter.":::

In the next unit, we'll learn how to change your bot's behavior.

<!-- Links -->

[BotEmulator]: https://aka.ms/abs/build/emulatordownload?azure-portal=true
