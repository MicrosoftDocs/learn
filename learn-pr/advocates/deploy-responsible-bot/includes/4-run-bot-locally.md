Before we deploy our bot, we'll make one more change to the code. Then we'll run our bot in a local environment to test its new behavior.

In the previous unit, we edited our bot's `EchoBot.cs` file. Specifically, we updated the `OnMessageActivityAsync` function to make the bot greet users by name. Now we'll reprogram the other function in that file, `OnMembersAddedAsync`. Remember that this function is called when a new user enters the chat. The initial welcome message that the user sees is part of this function.

## Develop a responsible welcome message

When users first start to work with a bot, they don't always know what to say. In many cases, the bot's functionality isn't immediately clear.

Users find it helpful when a bot begins with a brief overview and sample commands. Specifically, a welcome message should provide three important pieces of information:

- A statement to inform the user that they're **talking to a bot**.
- An outline of the **bot's primary purpose**. As an option, it shows limitations and typical use cases.
- An explanation of **what the user can do** with the bot. It might mention the bot's **help** feature. It can also show the **menu** of options and examples of understood phrases.

For example, a train reservation bot might welcome users with a message like this one:

`Hello! I'm a bot, and I can help you book a train ticket. You can ask me for train schedules and destinations. You can also look up fares and purchase tickets. To get started, enter HELP or MENU.`

In this example, the bot provides the following information:

- A statement that clearly tells the user they're interacting with a bot: `I'm a bot.`
- An outline of the bot's purpose: `I can help you book a train ticket.`
- An explanation of how to use the bot: `You can ask me for train schedules and destinations. You can also look up fares and purchase tickets. To get started, enter HELP or MENU.`

It's easy to add a meaningful welcome message to a bot. A good welcome helps to build trust with your users. The difficult task is to fit all the information into a single message on a small screen.

## Update your bot code

Let's change our bot behavior in a small way by updating the welcome message.

1. Open your bot project in Visual Studio.

1. Locate the `OnMembersAddedAsync` function in the `EchoBot.cs` file.

1. Locate the definition of the `welcomeText` variable at the beginning of that function. Try replacing the simple greeting with a longer message. You can start with the following sample.

   ```csharp
   var welcomeText = "Hello. I am a customer service bot that can help you book a hotel. If you enter your first name, I will get started with your reservation.";
   ```

1. Save your changes.  

## Run your bot locally

Let's start our bot to see how our changes have altered the bot's behavior.

Follow these steps to test the bot locally:

1. With your bot project open, in the Visual Studio top menu bar, select **Debug** > **Start without debugging**.

   :::image type="content" source="../media/visual-studio-run-bot-first-time.png" alt-text="Screenshot of the Visual Studio CustomerFriend project. The Debug menu is visible, with Debug and Start without debugging called out.":::

   This step builds the application and deploys it locally. If the bot code compiles correctly, a browser window opens:

   :::image type="content" source="../media/browser-window-endpoint-url.png" alt-text="Screenshot of a browser window showing the bot's default page. Text in the window gives the bot's endpoint U R L.":::

1. The browser window shows the endpoint URL for your bot, such as `https://localhost:<port>/api/messages`. Copy and save this URL value.

## Interact with your bot

Next we'll run our bot in Bot Framework Emulator so we can chat with it. The bot will still run locally. But Bot Framework Emulator displays the messages that would appear in a web chat UI.

1. Start Bot Framework Emulator.

1. On the **Welcome** tab, select **Open Bot**.

   :::image type="content" source="../media/bot-framework-emulator-welcome-tab.png" alt-text="Screenshot of the Welcome tab of Bot Framework Emulator with the Open Bot button called out.":::

1. In the **Bot URL** box, enter the URL value that you copied earlier from the browser window. Then select **Connect**.

   :::image type="content" source="../media/bot-framework-emulator-open-bot-window.png" alt-text="Screenshot of the Open a bot window of Bot Framework Emulator with the Bot U R L box called out.":::

1. Try sending a message to your bot, and see how the bot responds.

   :::image type="content" source="../media/bot-framework-emulator-initial-message-exchange.png" alt-text="Screenshot of the Live Chat tab of Bot Framework Emulator. The welcome message is visible. Another message shows the bot greeting a user by name.":::

In the next unit, we'll deploy our bot.
