You created a bot in the previous module. You'll now implement advanced features like LUIS, connecting data, and connecting the bot to channels like Teams and WhatsApp. Let's first connect the bot to Teams.  

## Connecting the bot to channels 

1. Select **Models** under **Language** in the left pane.

2. Click on edit for the **Greetings** model.

3. Change the intent mapping to **bot1** (which is the Basic Bot created in previous module) and click on **Save**.

   :::image type="content" source="../media/2-edit-model.png" alt-text="Diagram that shows edit model section of healthbot.":::

4. In the side menu bar under Integration, click on **Channels**. This will open the Channels page where we can find different channels to route the health bot.

   :::image type="content" source="../media/2-channels.png" alt-text="Diagram that shows channels of healthbot.":::

5. Enable Microsoft Teams channel on this page. Once it gets enabled, it provides the option to view and test.

6. First click on **view** and copy the **Bot Id**. Paste it to a notepad file. It will be required later in the process.

   :::image type="content" source="../media/2-teams-channel-id.png" alt-text="Diagram that shows Teams channel ID.":::

7. Next click on **Test**. It will redirect to the Microsoft Teams.

8. In the search bar, paste the **Bot Id**,  and then click search.

9. Click on **People** and Select HealthCare Bot.

   :::image type="content" source="../media/2-teams-search-id.png" alt-text="Diagram that shows searching in Teams with Bot Id":::

The bot will work according to the flow you created in the previous modules. With this you have successfully connected your bot to a channel. Similarly you can connect your bot to other channels like WhatsApp, Facebook, and Telegram. Give it a try with Telegram/Facebook.

:::image type="content" source="../media/2-teams-chat.png" alt-text="Diagram that illustrates the bot's chat in Teams.":::

## What's next?

In the next unit we shall see how to wrap up the bot into a Teams App using the Microsoft Teams App studio.
