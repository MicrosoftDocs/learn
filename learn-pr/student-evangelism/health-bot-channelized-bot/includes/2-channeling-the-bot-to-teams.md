You created a bot in the previous module. You'll now implement advanced features like LUIS, connecting data, and making the bot available on channels like Teams and WhatsApp. Let's first connect the bot to Teams.  

## Making the bot available on channels 

1. Select **Models** under **Language** in the left pane.

2. Select edit for the **Greetings** model.

3. Change the **Intent Mapping** to **bot1** (the basic bot you created in the previous module) and then select **Save**.

   :::image type="content" source="../media/2-edit-model.png" alt-text="Screenshot that shows the Edit model options.":::

4. In the left pane, under **Integration**, select **Channels**. The Channels page will open, showing channels where you can make the health bot available:

   :::image type="content" source="../media/2-channels.png" alt-text="Screenshot that shows channels available in Health Bot.":::

5. Under **Active**, enable **Microsoft Teams**. You'll now see options for **View** and **Test**.

6. Select **View** and then copy the **Bot Id**. Paste it into a notepad file. You'll need it later.

   :::image type="content" source="../media/2-teams-channel-id.png" alt-text="Screenshot that shows the Bot Id for Teams.":::

7. Select **Test**. Microsoft Teams will open.

8. In the search box, paste the bot ID and then select **Enter**.

9. Select **People** and then select **HealthCare**.

   :::image type="content" source="../media/2-teams-search-id.png" alt-text="Screenshot that shows searching with the bot ID in Teams.":::

The bot will work according to the flow you created in previous modules. You've successfully connected your bot to a channel. You can also connect your bot to other channels, like WhatsApp, Facebook, and Telegram. Try connecting it to Telegram or Facebook.

:::image type="content" source="../media/2-teams-chat.png" alt-text="Screenshot that shows the bot's chat in Teams.":::

## What's next?

In the next unit, you'll learn how to wrap the bot into a Teams app by using App Studio for Microsoft Teams.
