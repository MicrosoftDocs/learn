Let's make one more change to our bot's behavior.

## Open the bot code

With your bot project visible in Visual Studio, open your bot code file, `EchoBot.cs`:

In the previous unit, we modified the `OnMessageActivityAsync` function, which is the primary function in this file. This function is called each time the bot receives a message from the user. We changed the code to make the bot return a capital/major city when a user enters a country/region.

Now we'll reprogram a different function in that file, `OnMembersAddedAsync`. This function is called when a new user enters the chat. We use this function to display the initial welcome message to the user.

## Develop a responsible welcome message

When a user first starts to work with a bot, they don't always know what to say. Students across the world speak multiple languages and come from many different cultures. Although you can design a bot with natural language understanding, its capabilities are still limited. In many cases, all the bot's functionality isn't immediately clear.

Users find it helpful when a bot begins with a brief overview and sample commands. Specifically, a welcome message should provide three important pieces of information:

- Informs the user that they're **talking to a bot**.
- Outlines the **bot's primary purpose**. As an option, shows limitations and typical use cases.
- Explains **what the user can do** with the bot. It might mention the bot's **help** feature. It can also show the **menu** of options and examples of understood phrases.

It's easy to add a meaningful welcome message to a bot. A good welcome helps to build trust with your users. The difficult task is to fit all the information into a single message on a small screen.

## Update your bot code

Let's change our bot behavior in a small way by updating the welcome message. To make this change, we'll edit the `OnMembersAddedAsync` function.

1. With your bot project open in Visual Studio, locate the `OnMembersAddedAsync` function in the `EchoBot.cs` file.

1. Locate the definition of the `welcomeText` variable at the beginning of that method. Try replacing the simple greeting with a longer message. You can start with the following sample.

   ```csharp
   var welcomeText = "Hello. I am a teaching assistant bot that will help you learn geography. If you enter a country/region, I can tell you its capital/major city.";
   ```

1. Save your changes.  

## Test your bot

To see whether your bot works, rebuild your code and run your bot:

1. In the Visual Studio top menu bar, select **Debug** > **Start without debugging**.

   If the bot code compiles correctly, a browser window opens:

   :::image type="content" source="../media/browser-window-endpoint-url.png" alt-text="Screenshot of a browser window showing the bot's default page. Text in the window gives the bot's endpoint U R L.":::

1. The browser window shows the endpoint URL for your bot, such as `https://localhost:<port>/api/messages`. Copy and save this URL value.

1. Start Bot Framework Emulator.

1. On the **Welcome** tab, select **Open Bot**.

   :::image type="content" source="../media/bot-framework-emulator-welcome-tab.png" alt-text="Screenshot of the Welcome tab of Bot Framework Emulator with the Open Bot button called out.":::

1. In the **Bot URL** box, enter the URL value that you copied from the browser window. Then select **Connect**.

   :::image type="content" source="../media/bot-framework-emulator-open-bot-window.png" alt-text="Screenshot of the Open a bot window of Bot Framework Emulator with the Bot U R L box called out.":::

1. Try sending a message to your bot, and see how the bot responds.

   :::image type="content" source="../media/bot-framework-emulator-basic-message-exchange.png" alt-text="Screenshot of the Live Chat tab of Bot Framework Emulator. Messages show that the bot returns a capital/major city when a user enters a country/region.":::

Your bot now greets you with a helpful message. When you enter the name of a country/region, your bot responds with the country's capital/major city.

## Conclusion

In the last two units, we developed our bot into a useful tool. We also applied some principles of responsible AI. Our bot now introduces itself with a helpful welcome message. That introduction includes basic instructions and makes it clear to users that they're interacting with a bot.
