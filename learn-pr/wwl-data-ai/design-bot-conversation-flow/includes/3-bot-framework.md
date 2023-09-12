Bot solutions on Microsoft Azure are supported by the following technologies:

- **Azure AI Bot Service**. A cloud service that enables bot delivery through one or more channels, and integration with other services.
- **Bot Framework Service**. A component of Azure AI Bot Service that provides a REST API for handling bot activities.
- **Bot Framework SDK**. A set of tools and libraries for end-to-end bot development that abstracts the REST interface, enabling bot development in a range of programming languages.

:::image type="content" source="../media/azure-bot-technologies.png" alt-text="Azure AI Bot Service, Bot Framework, and Bot SDK":::

## Developing a Bot with the Bot Framework SDK

The Bot Framework SDK provides an extensive set of tools and libraries that software engineers can use to develop bots. The SDK is available for multiple programming languages, including Microsoft C# (.NET Core), Python, and JavaScript (Node.js)

### Bot templates

The easiest way to get started with the Bot Framework SDK is to base your new bot on one the templates it provides:

- **Empty Bot** - a basic bot skeleton.
- **Echo Bot** -  a simple "hello world" sample in which the bot responds to messages by echoing the message text back to the user.
- **Core Bot** - a more comprehensive bot that includes common bot functionality, such as integration with the Language Understanding service.

### Bot application classes and logic

The template bots are based on the **Bot** class defined in the Bot Framework SDK, which is used to implement the logic in your bot that receives and interprets user input, and responds appropriately. Additionally, bots make use of an **Adapter** class that handles communication with the user's channel.

Conversations in a bot are composed of *activities*, which represent events such as a user joining a conversation or a message being received. These activities occur within the context of a *turn*, a two-way exchange between the user and bot. The Bot Framework Service notifies your bot's adapter when an activity occurs in a channel by calling its **Process Activity** method, and the adapter creates a context for the turn and calls the bot's **Turn Handler** method to invoke the appropriate logic for the activity.

### Testing with the Bot Framework Emulator

Bots developed with the Bot Framework SDK are designed to run as cloud services in Azure, but while developing your bot, you'll need a way to test it before you deploy it into production.

The Bot Framework Emulator is an application that enables you to run your bot local or remote web applications and connect to it from an interactive web chat interface that you can use to test your bot. Details of activity events are captured and shown in the testing interface, so you can monitor your bots behavior as you submit messages and review the responses.
