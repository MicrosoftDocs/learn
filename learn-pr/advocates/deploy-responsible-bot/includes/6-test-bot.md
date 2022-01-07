In the previous unit, we deployed our bot to Azure. After the deployment process finishes, it can take a few minutes before the bot is available for testing. 

When your deployed bot is ready, we'll use Web Chat to chat with the bot.

The Web Chat component is a highly customizable web-based client for Bot Framework. Web Chat provides a UI on top of the Direct Line communication channel. You can use Web Chat to exchange messages with your bot.

Follow these steps to start a chat session:

1. Go to the [Azure portal][Azure portal] and sign in to your Azure account.

1. On the Azure portal start page, select **Resource Groups**, and then select the resource group for your bot.

   :::image type="content" source="../media/select-bot-resource-group.png" alt-text="Screenshot of the Resource groups page in the Azure portal. The bot's resource group is called out.":::

1. On the resource group page, select the link for your bot.

   :::image type="content" source="../media/select-bot-resource.png" alt-text="Screenshot of the bot's resource group page in the Azure portal. The bot resource is called out.":::

1. On your bot's **Overview page**, under **Settings**, select **Test in Web Chat**.

   :::image type="content" source="../media/azure-portal-select-test-web-chat.png" alt-text="Screenshot of the bot's overview page in the Azure portal. Settings and Test in Web Chat are called out.":::

1. Try sending a message to your bot, and see how the bot responds.

   :::image type="content" source="../media/azure-portal-test-web-chat-conversation.png" alt-text="Screenshot of the Test in Web Chat window in the Azure portal. The welcome message is visible. Another message shows the bot greeting a user by name.":::

We used the Web Chat client in this unit to exchange messages with our deployed bot. Web Chat uses the Direct Line channel. In the next unit, we'll see how to make our bot available on other communication channels.

<!-- Links -->

[Azure portal]: https://portal.azure.com/