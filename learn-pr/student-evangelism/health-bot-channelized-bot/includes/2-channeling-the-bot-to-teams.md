Since we created a bot with scenarios in our previous module, we will now be working on implementing advanced features like LUIS, data connect, connecting our bot to channels such as Teams, WhatsApp, etc. Let's first connect the bot we built to the teams channel. Get along with the steps below to connect your bot with Teams channel. 

## Launching the bot on channels

1. Click on *Models* under the Language tab in the left menu bar.

2. Click on edit for the *Greetings* model.

3. Change the intent mapping to **bot1** (which is the Basic Bot created in previous module) and click on *Save*.

   :::image type="content" source="../media/2-edit-model.png" alt-text="Diagram that shows edit model section of healthbot.":::

4. In the side menu bar under Integration, click on **Channels**. This will open the Channels page where we can find different channels to route the health bot.

   :::image type="content" source="../media/2-channels.png" alt-text="Diagram that shows channels of healthbot.":::

5. Enable Microsoft Teams channel on this page. Once it gets enabled, it provides the option to view and test.

6. First click on **view** and copy the Bot Id. Paste it to a notepad file. It will be required later in the process.

   :::image type="content" source="../media/2-teams-channel-id.png" alt-text="Diagram that shows teams channel id.":::

7. Next click on Test. It will redirect to the Microsoft Teams.

8. In the search bar, paste the Bot ID  and then click search.

9. Click on **People** and Select HealthCare Bot.

   :::image type="content" source="../media/2-teams-search-id.png" alt-text="Diagram that shows searching in teams with bot id.":::

The bot will work according to the flow you created in the previous modules. With this you have successfully connected your bot to a channel. Similarly you can connect your bot to other channels like WhatsApp, Facebook, and Telegram. Give it a try with Telegram/Facebook.

:::image type="content" source="../media/2-teams-chat.png" alt-text="Diagram that illustrates bot's chat in teams.":::

## What's next?

In the next unit we shall see how to wrap up the bot into a Teams App using the Microsoft Teams App studio.
