Before we build our **CustomerFriend** bot, let's review the basics of how bots work. We'll also look at ways to make bots responsible.

## Basic bot operation

A conversational experience involves a few basic actions:

- A user sends a message to the bot.
- The bot receives the message and analyzes it to determine what the user needs.
- The bot responds to the user. The response might include information that the user requested. It also might ask the user for more input.

The conversation can take place in different *channels*:

- A bot on a website
- A messenger application like Facebook Messenger or Telegram

## Azure Bot Service

Microsoft supports bot development and deployment tasks in Azure Bot Service. This collection of services provides:

- An environment for hosting and running your bot.
- Mechanisms for authenticating users and creating security tokens for protected resources.
- Endpoints that your bot can use to connect with users.

For our **CustomerFriend** bot, we'll use the Web Apps feature of Azure App Service to deploy our bot to a web app. We'll also use this resource to test our bot in Web Chat and connect our bot to a communication channel.

## Responsible bot development

Bots belong to the broader category of conversational AI. Microsoft has outlined guidelines for developers of conversational AI. By following these principles, you can create bots that act responsibly:

- Are accessible. If you add features like speech support to your bot, users perceive it as being accessible. Even if you have visual impairment, you can use the bot.
- Treat users fairly. When your bot demonstrates support for various nationalities and genders, it comes across as respectful and unbiased.
- Respect cultural differences. Some cultures use an informal tone, while others use more formal communication. By programming your bot to adjust the conversational style based on user input, you show appreciation for cultural norms.
- Have a clear purpose. When your bot is specific about which problems it can solve, users are less likely to engage in conversation about unrelated issues.
- Are upfront about limitations and abilities. When a bot introduces itself as a bot and displays a bot picture, users know what to expect. Being honest about a bot's limitations helps to reduce user frustration.
- Hand off complex tasks to humans. By providing access to a human operator when needed, you prevent users from losing trust in your technology and your organization.
- Act reliably. If your bot interacts with users in an efficient and consistent manner, it communicates a sense of stability. This behavior helps build user trust in your organization.
- Keep data secure. Bots should follow standard security practices. Then users know their personal information is safe.
- Respect privacy. By collecting only relevant data and by handling that data responsibly, bots uphold privacy standards.

One further guideline states that developers are accountable for their bots. You're responsible for how your bots interact with people and affect people.

We'll create our **CustomerFriend** bot in the next unit. In later units, we'll deploy the bot and add features to make it responsible.
