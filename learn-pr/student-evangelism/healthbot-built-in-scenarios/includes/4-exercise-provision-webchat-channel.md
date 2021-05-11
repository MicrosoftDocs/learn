# Exercise

The webchat is a simple web page that allows users to communicate with your Health Bot instance. It is a popular channel that can easily be embedded in your web assets. Alternative channels can be enabled for you bot on request.

## Creating the WebChat Channel

1. Sign-in to the Health Bot Management Portal. In the left menu blade, click **Secrets** under **Integration**.

    :::image type="content" source="../media/4-A.png" alt-text="Azure Health Bot secrets":::

2. Secrets allow you to connect the bot to a web page. Copy the **WEBCHAT_SECRET** and the **APP_SECRET**.

    :::image type="content" source="../media/4-B.png" alt-text="Web chat and App secret":::

3. Navigate to [Webchat container sample repository](https://github.com/Microsoft/HealthBotContainerSample/tree/live_agent_handoff), and click the **Deploy to Azure** button.

4. You will be redirected to your Azure portal. Sign in using your Azure credentials and provide the details required for the deployment.

    - **Subscription**: The Azure subscription that will be charged.
    - **Resource group**: Create a new group or use an existing group.
    - **App Secret**: Use the App Secret copied in previous step.
    - **Webchat secret**: Use the Web Chat secret copied in previous step.

    :::image type="content" source="../media/4-C.png" alt-text="Web chat deployment window on Azure Portal":::

5. Click **Review + Create**.

6. Click on the Resource group that you created in previous step and select the new App Service.

7. In the **Overview** page, open the **URL**.

    :::image type="content" source="../media/4-D.png" alt-text="Web chat overview page on Azure Portal":::

8. Test the connection to your bot instance by typing a few commands into the web chat.

    :::image type="content" source="../media/4-E.png" alt-text="Web chat user experience":::

## Deploying the Agent WebChat

The agent web chat is an additional channel that is connected to your bot instance.  

1. In the management portal for your Health Bot instance navigate to **Configuration > Conversation > Human Handoff** and enable the human handoff feature and click **Save**.

    :::image type="content" source="../media/4-F.png" alt-text="Activate Human Handoff feature":::

2. To access the sample web chat, you should open the web chat URL that you created in previous step and request the */agent.html* path. This will load a simple login page that illustrates the agent experience (you can provide any values to access the agent portal. Within the agent portal you can issue agent commands to interact with end users that are talking with your bot.

    :::image type="content" source="../media/4-G.png" alt-text="Agent web chat":::

## End user experience - Connecting to live agent

If there are online agents, the end user and agent go through a connection sequence before the live chat begins.

1. The end user says something that triggers the handoff connection sequence.

2. The end user is advised that they will soon be connected to an agent.

3. The end user is added to the queue and the agents receive a notification.

4. The agent uses a "Connect" command to talk to the end user that has been in the queue the longest.

5. A connection is established between the agent and end user.

6. The end user receives a notification they are talking with an agent.

7. The live chat continues until the agent ends the interaction.

    :::image type="content" source="../media/4-H.png" alt-text="User - Agent interaction through the web chat channel":::
