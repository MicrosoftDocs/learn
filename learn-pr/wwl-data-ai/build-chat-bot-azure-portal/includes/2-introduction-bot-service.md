The Azure Bot Service provides the core components for creating bots, including the Bot Framework SDK, for developing bots. The service also provides the necessary services for connecting bots to channels. Channels refer to the "connection" between a bot and a communication application.  Some common examples of bot channels are:

- Email - you can interact with a bot through an email channel via Microsoft Office 365. When a bot is configured for an email account, the bot receives a message when a new email arrives. The bot can then respond as indicated by its business logic.
- Cortana - the virtual assistant from Microsoft, Cortana is a speech-enabled channel that interacts with a bot through speech or text conversations.  Adding a Cortana channel for voice interaction will require your bot to be designed to use speech and text.  You can integrate the Azure Speech cognitive services to handle the speech portion of a Cortana channel.
- Amazon Alexa - Alexa devices that support custom skills, can be used as a channel for bot communications.
- Facebook - your bot can connect to Facebook Messenger and Facebook Workplace as channel for communication.
- Microsoft Teams - if your organization uses Microsoft Teams for collaboration, you can integrate Teams with a bot.
- Additional channels and more information can be found on the [channels article](https://docs.microsoft.com/azure/bot-service/bot-service-manage-channels?view=azure-bot-service-4.0) for the Azure Bot Service.

The bot service also provides the interaction functionality for your bot.  An example of a user interaction with a simple echo bot can offer some insight into the interaction between a bot, the Bot Framework Service, and a bot channel.

:::image type="content" source="../media/bot-builder-activity.png" alt-text="Interaction diagram showing bot channel, framework service, and interaction steps":::

The diagram depicts the concept of activities in the bot interaction.  The two activities depicted are a conversation update and a message. The conversation activity typically handles conversation updates.  A conversation update would include activities such as a user or bot joining a conversation.  For example, using the Bot Framework Emulator for a conversation with a bot would include two initial activities.  The first activity is the user joining the conversation and the second is when the bot joins the conversation.  Message activities are responsible for carrying the conversation content between the user and the bot.

Creating your bot with the Bot Framework and the Bot Service will require the use of activity handlers, perhaps some middleware, and your bot resources. The various components help to manage state in your bot and to process the messages and activities.
