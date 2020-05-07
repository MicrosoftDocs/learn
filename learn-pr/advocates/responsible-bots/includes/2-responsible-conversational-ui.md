To help developers create responsible bots, Microsoft has outlined [10 guidelines for developers of Conversational UI][Guidelines10]. We'll only cover the major principles you'll need for this course, but we encourage you to learn more about responsible conversational UI by viewing [this interactive demo][InteractiveDemo].

"Developers are accountable for the bots they deploy" is one of the major principles of responsible bot creation. It's important for developers to be aware of responsible conversational UI principles.

## Give your bot a clear goal

When developing a bot, you should clearly understand its purpose and communicate this purpose to users. When they interact with a a bot, users who know its limitations won't have overly high expectations, that understanding can help avoid disappointment and misuse of the bot.

It's especially important when with **consequential outcomes** - when a conversation with a bot can have a significant impact on user's life. For example, bots used healthcare or education.

In the case of our **GeoFriend** bot, we'll need to make it clear that the bot does not replace a teacher. It's only acting as an assistant to help students learn. We don't want a user to rely solely on the bot to teach them Geography, then discover later that their knowledge might not be up to standards.

A clear goal also discourages users from engaging in conversations with a bot about unrelated topics. It's much easier to develop a bot that's adept at solving specific tasks as opposed to general conversation.

## Tell users that they're talking to a bot

To avoid high expectations, you should make it clear upfront that the user is talking to a bot and not a human being. This helps the user focus on solving a specific task, and not engaging the bot on an emotional level. The bot should normally support some traditional phrases like greeting and ending a conversation, but not much more than that. Handling general conversation can be implemented using [Project Personality Chat][PersonalityChat], which we will use later in the course to enhance our **GeoFriend** bot.

## Build trust

Also, clearly introducing the bot in the beginning of a conversation helps to **build trust** between a user and a bot. Another useful trick is to use a robot icon instead of a human face to help remind the user what they're talking to.

A bot that supports **handoff to a human operator** also helps to build trust, because the user knows that they can get the help from qualified personnel if needed. A common scenario is to use bot dialog to collect initial user information, and then hand the conversation over to a human to make expert decisions and solve any problems. This structure delegates tedious tasks to the bot and leaves the most creative part to human operator.

One other aspect of building trust is respecting user's privacy. You should follow the best practices for collecting and handling personal information. Collect only information that is relevant to solving the problem.

## Fairness, diversity and accessibility

A big problem in AI is to ensure fair and unbiased treatment. This issue is addressed by [Responsible AI][RespAI] principles. One way to help avoid bias is to include **diversity** in all stages of building a bot. For example, by including different genders and nationalities on the development team.

Bots can also be made accessible to a diverse audience by supporting different languages. This can be simplified by using [translator cognitive service][TranslatorAPI] for automatic translation of incoming and outgoing messages, and by automatically [detecting a language][LangDetect] that user speaks.

There are also important **cultural norms** to pay attention to. In some cultures, an informal tone would be appropriate for a bot. In others, more formal communication is required. Adjusting to the appropriate style is a good idea. For example, **personality chat** supports three different conversational styles.

Building **accessibility practices** into a bot can broaden the potential audience. For example, the inclusion of **speech support** would make the bot usable by visually impaired users. It's also more attractive to users who don't want to type, like drivers.

## Next steps

Now that we know main principles of building responsible bots, let's apply them as we build a simple Geography Assistant Bot.

<!-- Links -->

[Guidelines10]: https://www.microsoft.com/research/publication/responsible-bots/
[InteractiveDemo]: https://aidemos.microsoft.com/responsible-conversational-ai/building-a-trustworthy-bot
[PersonalityChat]: https://www.microsoft.com/research/project/personality-chat/
[RespAI]: https://www.microsoft.com/ai/responsible-ai
[TranslatorAPI]: https://azure.microsoft.com/services/cognitive-services/translator-text-api/
[LandDetect]: https://docs.microsoft.com/azure/cognitive-services/text-analytics/how-tos/text-analytics-how-to-language-detection
