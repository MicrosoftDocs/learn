## What is a channel?

A channel is a connection between the Health Bot and communication apps. You may configure the bot to connect to the channels you want it to be available on, through the Health Bot Management portal. The Health Bot leverages Azure Bot Service to connect your bot to these channels and facilitates communication between your bot and the user. In previous modules you learned how to connect your Azure Health Bot to the Webchat Channel. In this module you will learn how to connect your Azure Health Bot to the Teams channel. 

> [!NOTE]
> Microsoft Teams is Organization specific. So, app sharing is allowed within the organization.  

## Launching your bot to channels

A “Trigger” is responsible in order to carry out a specific operation. In the interrupting and breaking scenario, we created a RegEx model to map it to a custom intent that we created. Let’s say the user types “Hello”, Now, We want our Health bot scenario to “Trigger” to this intent. This can be done in the “Models” section. Here we will use the “Greeting” model which is already present in the Language section. By default, the Greetings intent is linked to default scenario available on the Azure Health Bot portal. We want the scenario that we created to map to the Greetings intent mapping. 

## Make the bot available on Teams

1. Select **Models** under **Language** in the left pane.

2. Select the **Greetings** model.

3. Change the **Intent Mapping** to **bot1** (the basic bot you created in the previous module) and then select **Save**:

   :::image type="content" source="../media/2-edit-model.png" alt-text="Screenshot that shows the Edit model options." lightbox="../media/2-edit-model.png":::

4. In the left pane, under **Integration**, select **Channels**. The Channels page will open, showing channels where you can make the health bot available:

   :::image type="content" source="../media/2-channels.png" alt-text="Screenshot that shows channels available in Health Bot." lightbox="../media/2-channels.png":::

5. Under **Active**, enable **Microsoft Teams**. You'll now see options for **View** and **Test**.

6. Select **View** and then copy the **Bot Id**. Paste it into a Notepad file. You'll need it later.

   :::image type="content" source="../media/2-teams-channel-id.png" alt-text="Screenshot that shows the Bot Id for Teams." lightbox="../media/2-teams-channel-id.png":::

7. Select **Test**. Microsoft Teams will open.

8. In the search box, paste the bot ID and then select **Enter**.

9. Select **People** and then select **HealthCare**:

   :::image type="content" source="../media/2-teams-search-id.png" alt-text="Screenshot that shows searching with the bot ID in Teams." lightbox="../media/2-teams-search-id.png":::

The bot will work according to the flow you created in previous modules. You've successfully connected your bot to a channel. You can also connect your bot to other channels, like WhatsApp, Facebook, and Telegram. Try connecting it to Telegram or Facebook.

:::image type="content" source="../media/2-teams-chat.png" alt-text="Screenshot that shows the bot's chat in Teams." lightbox="../media/2-teams-chat.png":::

## What's next?

In the next unit, you'll learn how to wrap the bot into a Teams app by using App Studio for Microsoft Teams.
