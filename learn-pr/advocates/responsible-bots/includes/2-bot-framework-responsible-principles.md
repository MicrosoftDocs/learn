Before we build our **GeoFriend** bot, let's quickly review the basics of how bots work. We'll also look at ways to make bots responsible.

## Basic bot operation

A conversational experience involves two basic actions:

- A user sends messages to the bot.
- The bot responds to the user.

The conversation can happen in different _channels_:

- A chatbot on a website
- A messenger application like Facebook Messenger or Telegram

Each _messaging platform_ has its own principles and APIs for creating chatbots. To build a bot for Facebook, you use different skills than to create a web chat.

## Local bot development

Microsoft supports the tasks for bot operation in Bot Framework. This framework provides a set of core libraries that standardize bot development. You can develop a bot as a web API function that can be called over the internet. The user provides the input, and Bot Framework figures out the necessary output for the bot.

Bot Framework also helps structure bot logic by offering useful developer abstractions. Complex conversations are difficult to program in basic request–response patterns. The Bot Framework provides abstractions like dialogs and form filling. You can use the abstractions to support complex conversational behavior from the building blocks.

For our **GeoFriend** bot, we'll develop and test the code locally. Programming and debugging locally on your machine is faster than rebuilding in the cloud.

We'll also run the bot locally, meaning we won't call it over the internet. We'll use Bot Framework Emulator to chat with our bot. With this tool, we'll inspect the messages that our bot sends and receives. Bot Framework Emulator displays the messages that would appear in a web chat UI. So we can simulate the experience of calling our bot over the internet.

## Responsible bot development

As part of the broader category of conversational AI, bots should interact in a professional way. To help developers create responsible bots, Microsoft has outlined guidelines for developers of conversational AI. These principles present goals that bots should meet:

- Have a clear purpose. When your bot is specific about which problems it can solve, users are less likely to engage in conversation about unrelated issues.
- Be transparent about abilities and limitations. When a bot introduces itself as a bot and displays a bot picture, users know what to expect. Being honest about a bot's limitations helps to reduce user frustration.
- Transfer complex tasks to humans. By providing access to a human operator when needed, you prevent users from losing trust in your technology and your organization.
- Respect cultural norms. Some cultures use an informal tone, while others use more formal communication. By programming your bot to adjust the conversational style based on user input, you show appreciation for cultural differences.
- Be reliable. If your bot interacts with users in an efficient and consistent manner, it communicates a sense of stability. This behavior helps build user trust in your organization.
- Treat people fairly. When your bot demonstrates support for various nationalities and genders, it comes across as respectful and unbiased.
- Respect privacy. By collecting only relevant data and by handling that data responsibly, bots uphold privacy standards.
- Handle data securely. Bots should follow standard security practices. Then users know their personal information is safe.
- Be accessible. If you add features like speech support to your bot, users perceive it as being accessible. Even if you have visual impairment, you can use the bot.

One further guideline focuses not on bots, but on developers. It states that developers are accountable for their bots. You're responsible for how your bots interact with people and affect people.

We'll create our **GeoFriend** bot in the next unit. In later units, we'll add features to make the bot responsible. For instance, we need to make it clear to our students that the bot doesn't replace their teacher. The bot is only acting as an assistant to help the students learn. We don't want a user to rely solely on the bot to teach them geography. They might discover later that their knowledge isn't up to standards.
