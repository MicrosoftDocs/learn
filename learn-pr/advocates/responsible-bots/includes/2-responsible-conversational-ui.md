To help developers create responsible bots, Microsoft has outlined [10 guidelines for developers of conversational UI][Guidelines10]. In this course, we'll cover the major principles that you'll need to develop a simple bot. You can learn more about all of the principles in [this interactive demo][InteractiveDemo].

**Developers are accountable for the bots they deploy**. This major principle is the foundation for responsible bot creation. It's important for developers to be aware of responsible conversational UI principles so they can create the best experience possible for their users.

## Give your bot a clear goal

Before you start to build your bot, take time to clearly define its purpose. As you develop, carefully consider how to communicate the purpose to your users. When a bot expresses its purpose and limitations in a responsible way, you can reduce frustration and unmet expectations for your users.

Exercise careful planning for bots that have _consequential outcomes_. When a bot has a conversation with the user, it can have a significant impact on the user's life. Bots that are used in healthcare or education need to be carefully designed for this consideration.

In our **GeoFriend** bot, we'll need to make it clear to our students that the bot doesn't replace their teacher. The bot is only acting as an assistant to help the students learn. We don't want a user to rely solely on the bot to teach them geography. They might discover later that their knowledge isn't up to standards.

When the bot clearly communicates its goal, the user is discouraged from engaging in conversation about unrelated issues. Also, it's easier to build a bot to solve specific tasks, than it is to provide support for general conversation.

## Tell users they're talking to a bot

From the start of the conversation, make it clear that the user is talking to a bot and not a human being. This approach helps the user to focus on solving a specific task. The user is less likely to expect emotional support. The bot should recognize some traditional phrases for greetings and endings of a conversation. General conversation can be implemented by [Adding chit-chat to a knowledge base][AddChitChat]. We'll use the information in that article to enhance our **GeoFriend** bot.

## Build trust with the user

There are some useful tactics you can use to build trust between your user and the bot.

- **Clear introduction**: Clearly introduce the bot as a technology assistant at the beginning of the conversation.
- **Robot picture**: Use a picture of a robot instead of a human face. The picture reminds users "who" they're talking to.
- **Human hand-off**: Configure the bot to support _handoff to a human operator_. A common scenario is to use a bot dialog to collect initial information from the user. The information and conversation is then _handed off_ to an operator to make expert decisions and provide problem-solving. This structure delegates tedious tasks to the bot and leaves the most creative part to a human operator.
- **Respect privacy**: Follow standard safe practices for collecting and handling personal information from the user. Collect only information that's relevant to solving the problem.

## Support diversity and accessibility

A complex problem in AI is how to ensure fair and unbiased treatment for your users. This issue is addressed by [responsible AI][ResponsibleAI] principles.

One way you can avoid bias is to include _diversity_ in all stages of bot development. When you include different genders and nationalities on your development team, you achieve stronger support for diversity.

Bots become accessible to a diverse audience when you support different languages. This task can be simplified with the [Azure Cognitive Services Translator Text API][TranslatorAPI]. You can use the API for automatic translation of incoming and outgoing messages, and to automatically [detect a user's language][LangDetect].

_Cultural norms_ are important to consider when designing your bot. Some cultures use an informal tone, while others use more formal communication. Try to design your bot so it can adjust the conversational style to meet the culture. In this lesson, we'll add support for multiple conversational styles.

Build _accessibility practices_ into your bot to broaden the potential audience. When you include _speech support_, you make the bot usable for users with visual impairment. Your bot also becomes more attractive to users who don't want to type.

Now that we know some of the main principles for building responsible bots, let's apply them as we build a simple geography assistant bot.


<!-- Links -->

[AddChitChat]: https://docs.microsoft.com/azure/cognitive-services/qnamaker/how-to/chit-chat-knowledge-base?tabs=v1?azure-portal=true
[Guidelines10]: https://www.microsoft.com/research/publication/responsible-bots/?azure-portal=true
[InteractiveDemo]: https://aidemos.microsoft.com/responsible-conversational-ai/building-a-trustworthy-bot?azure-portal=true
[LangDetect]: https://docs.microsoft.com/azure/cognitive-services/text-analytics/how-tos/text-analytics-how-to-language-detection?azure-portal=true
[ResponsibleAI]: https://www.microsoft.com/ai/responsible-ai?azure-portal=true
[TranslatorAPI]: https://azure.microsoft.com/services/cognitive-services/translator-text-api/?azure-portal=true
