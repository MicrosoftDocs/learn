Web Chat is a simple web page that allows users to communicate with your Azure Health Bot instance. It's a popular channel that you can easily embed in your web assets. Alternative channels can be enabled for your bot on request.

## Create the Web Chat channel

1. Sign in to the Health Bot management portal. On the left menu, under **Integration** select **Secrets**.

   :::image type="content" source="../media/4-secrets.png" alt-text="Screenshot that shows Azure Health Bot Secrets.":::

1. You use secrets to connect the bot to a web page. Copy the values for **APP_SECRET** and **WEBCHAT_SECRET**.

   :::image type="content" source="../media/4-webchat-app-secret.png" alt-text="Screenshot that shows APP_SECRET and WEBCHAT_SECRET.":::

1. Go to the [Web Chat container sample repository](https://github.com/Microsoft/HealthBotContainerSample/tree/live_agent_handoff), and select **Deploy to Azure**.

1. You're redirected to your Azure portal. Sign in by using your Azure credentials, and enter the details required for the deployment:

   - **Subscription**: The Azure subscription that will be charged.
   - **Resource group**: Create a new group or use an existing group.
   - **App Secret**: Use the APP_SECRET value copied in step 2.
   - **Webchat Secret**: Use the WEBCHAT_SECRET value copied in step 2.

   :::image type="content" source="../media/4-webchat-deployment.png" alt-text="Screenshot that shows the Webchat deployment window in the Azure portal.":::

1. Select **Review + create**.

1. Select the resource group that you created in step 4, and select the new App Service.

1. On the **Overview** page, open the **URL**.

   :::image type="content" source="../media/4-webchat-overview.png" alt-text="Screenshot that shows the Web Chat overview page in the Azure portal.":::

1. Test the connection to your bot instance by entering a few commands in Web Chat.

   :::image type="content" source="../media/4-webchat-ux.png" alt-text="Screenshot that shows the Web Chat user experience.":::

## Deploy the Agent Webchat

The **Agent Webchat** is another channel that's connected to your bot instance.

1. In the management portal for your Health Bot instance, go to **Configuration** > **Conversation** > **Human Handoff**. Enable the human handoff feature, and select **Save**.

   :::image type="content" source="../media/4-human-handoff.png" alt-text="Screenshot that shows the Human Handoff tab.":::

1. To access the sample Web Chat, open the Webchat URL that you created in step 7 and request the */agent.html* path. A sign-in page loads that illustrates the agent experience. You can enter any values to access the agent portal. Within the agent portal, you can issue agent commands to interact with users who are talking with your bot.

   :::image type="content" source="../media/4-agent-webchat.png" alt-text="Screenshot that shows the Agent Webchat.":::

## User experience: Connect to a live agent

If there are online agents, the user and agent go through a connection sequence before the live chat begins.

1. The user says something that triggers the handoff connection sequence.

1. The user is advised that they'll soon be connected to an agent.

1. The user is added to the queue, and the agents receive a notification.

1. The agent uses a **connect** command to talk to the user who's been in the queue the longest.

1. A connection is established between the agent and the user.

1. The user receives a notification they're talking with an agent.

1. The live chat continues until the agent ends the interaction.

   :::image type="content" source="../media/4-webchat-interaction.png" alt-text="Screenshot that shows the user and agent interaction through the Web Chat channel.":::
