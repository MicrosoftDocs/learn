After you create a bot, you'll probably want to share it through some common communication channels. A channel is a connection between a communication application and a bot. When you register a bot with Azure, you can use channels to help the bot communicate with users. You can connect a bot to a channel by using the Azure portal.

Follow these steps to connect your bot to Telegram, a messaging system:

1. Go to the [Azure portal][Azure portal] and sign in to your Azure account.

1. On the Azure portal start page, select **Resource Groups**, and then select the resource group for your bot.

   :::image type="content" source="../media/select-bot-resource-group.png" alt-text="Screenshot of the Resource groups page in the Azure portal. The bot's resource group is called out.":::

1. On the resource group page, select the link for your bot.

   :::image type="content" source="../media/select-bot-resource.png" alt-text="Screenshot of the bot's resource group page in the Azure portal. The bot resource is called out.":::

1. On your bot's **Overview** page, in the left menu under **Settings**, select **Channels**.

   :::image type="content" source="../media/azure-portal-select-channels.png" alt-text="Screenshot of the bot's overview page in the Azure portal. Settings and Channels are called out.":::

1. Select **Telegram** from the list of channels.

   :::image type="content" source="../media/azure-portal-select-telegram.png" alt-text="Screenshot of the bot's Channels page in the Azure portal. The Telegram channel is called out.":::

1. In the **Configure Telegram** page, select **Step-by-step instructions to add the bot to Telegram.** Follow the steps in the linked article to create a new Telegram bot.

   :::image type="content" source="../media/azure-portal-create-new-telegram-bot.png" alt-text="Screenshot of the bot's Configure Telegram page in the Azure portal. The link to the instructions is called out.":::

1. Copy the access token you receive from **@BotFather**. Paste the token into the **Access Token** box in the Azure portal.

   :::image type="content" source="../media/azure-portal-paste-telegram-access-token.png" alt-text="Screenshot of the bot's Configure Telegram page in the Azure portal. The Access Token box is called out.":::

1. Select **Save**.

The bot will be functional in Telegram. You can share the link with users who want to chat with your bot.

<!-- Links -->

[Azure portal]: https://portal.azure.com/