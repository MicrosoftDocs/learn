## What is a channel?

A channel is a connection between the Health Bot and communication apps. You may configure the bot to connect to the channels you want it to be available on, through the Health Bot Management portal. The Health Bot uses the Azure Bot Service to connect your bot to these channels and facilitates communication between your bot and the user. In previous modules, you learned how to connect your Azure Health Bot to the Web Chat channel. In this module, you're going to learn how to connect your Azure Health Bot to the Teams channel.

If you don't have Microsoft Teams, [download and install it](https://www.microsoft.com/microsoft-teams/group-chat-software).

> [!NOTE]
> Microsoft Teams is Organization specific. So, app sharing is allowed within the organization.  

## Launching your bot to channels

A *Trigger* is responsible in order to carry out a specific operation. In the interrupting and breaking scenario, we created a RegEx model to map it to a custom intent that we created. Let’s say the user types `Hello`. We want our Health bot scenario to trigger to this intent. This intent trigger can be made in the **Models** section. Here we use the *Greeting* model that's already present in the Language section. By default, the Greetings intent is linked to default scenario available on the Azure Health Bot portal. We want the scenario that we created to map to the Greetings intent mapping.

## Make the bot available on Teams

1. Select **Models** under **Language** in the left pane.

2. Select the **Greetings** model.

3. Change the **Intent Mapping** to the basic bot you created in the previous module, and then select **Update**.

   :::image type="content" source="../media/2-health-bot-edit-language-model.png" alt-text="Screenshot that shows the Edit model options.":::

4. In the left pane, under **Integration**, select **Channels**. The Channels page opens and shows channels where you can make the health bot available.

   :::image type="content" source="../media/2-health-bot-teams-channel.png" alt-text="Screenshot that shows channels available in Health Bot.":::

5. Under **Active**, enable **Microsoft Teams**. Select **Create** to create the channel.

    :::image type="content" source="../media/2-health-bot-create-teams-channel.png" alt-text="Screenshot that shows the bot ID and Create button for the Teams channel in the Health Bot.":::

6. Select the ellipsis for **Microsoft Teams** under **Actions**, and then select **View**. Copy the Bot ID for later, and then select **Close**.

7. Select the ellipsis again, and then select **Test**.

   :::image type="content" source="../media/2-health-bot-test-teams-channel.png" alt-text="Screenshot that shows the Bot ID for Teams.":::

8. Microsoft Teams opens and connects to the health bot.

The bot works according to the flow you created in previous modules. You've successfully connected your bot to a channel. You can also connect your bot to other channels, like WhatsApp, Facebook, and Telegram. Try connecting it to Telegram or Facebook.

:::image type="content" source="../media/2-health-bot-teams-chat.png" alt-text="Screenshot that shows the bot's chat in Teams.":::

## What's next?

In the next unit, learn how to wrap the bot into a Teams app by using App Studio for Microsoft Teams.
