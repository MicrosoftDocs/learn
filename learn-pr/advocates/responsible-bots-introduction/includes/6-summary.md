In this course, you found out what makes a bot responsible. A responsible bot:

- Introduces itself and makes it clear to the user that it's a bot.
- Speaks with the user in natural language and tries to answer the user's questions.
- Welcomes and supports diverse users. For instance, the bot adapts to communication styles. It also supports different means of communication like text and speech.

You also saw why it's important for bots to be responsible. Then you learned about specific technologies that can make bots responsible:

- [Azure AI services][CogServ] provides services that support AI functionality.
- [LUIS][Language Understanding (LUIS) documentation] adds language understanding capabilities.
- [Azure AI Translator Text API][TranslatorAPI] supports multiple languages. This API offers:

  - [Language detection][LangDetection]
  - [Translation services][Translation]

- [QnA Maker][QnA Maker documentation] provides simple question-answering and chit-chat functionality.
- [Azure Text Analytics][TextAnalytics] detects user sentiment.
- [Azure Speech Service][SpeechSDK] adds a speech interface to your bot.
- A meaningful welcome message and a help feature enhance bot interactions.

You were introduced to resources for implementing this functionality:

- The [Microsoft Bot Framework][BotFW] provides a set of core libraries that standardize bot development.
- The steps in [Add chit-chat to a knowledge base][AddChitChat] explain how to add chit-chat capabilities.
- The [Bot Framework Middleware][Middleware] can pre-process and post-process messages to and from users.
- Code for translation middleware is available in the [Microsoft > BotBuilder-Samples > Multilingual bot][BotTranslateSample] GitHub repository.
- An API is available for [adding speech to messages][AddSpeech].

Finally, you discovered how to determine which responsible features to add to your bot. For help with this process, you looked at these factors:

- The cost and availability of developer resources
- The cost and availability of AI services
- Scheduling constraints

At the start of the module, you considered making a bot to help students learn geography. This module showed you how to make that bot useful and engaging.

This course has provided a foundation for developing responsible, personal, and enjoyable bots. We hope it inspires you to build bots that help people solve real-life problems.

[AddChitChat]: /azure/cognitive-services/qnamaker/how-to/chit-chat-knowledge-base?tabs=v1?azure-portal=true
[AddSpeech]: /azure/bot-service/rest-api/bot-framework-rest-connector-text-to-speech?view=azure-bot-service-4.0?azure-portal=true&preserve-view=true
[BotFW]: https://dev.botframework.com/?azure-portal=true
[BotTranslateSample]: https://github.com/microsoft/BotBuilder-Samples/tree/master/samples/csharp_dotnetcore/17.multilingual-bot?azure-portal=true
[CogServ]: https://microsoft.com/cognitive?azure-portal=true
[LangDetection]: /azure/cognitive-services/Face/quickstarts/csharp?azure-portal=true
[Language Understanding (LUIS) documentation]: /azure/cognitive-services/luis/
[MiddleWare]: /azure/bot-service/bot-builder-concept-middleware?view=azure-bot-service-4.0?azure-portal=true&preserve-view=true
[QnA Maker documentation]: /azure/cognitive-services/qnamaker/
[SpeechSDK]: /azure/cognitive-services/speech-service/?azure-portal=true
[TextAnalytics]: /azure/cognitive-services/text-analytics/?azure-portal=true
[Translation]: /azure/cognitive-services/translator/quickstart-translator?azure-portal=true
[TranslatorAPI]: https://azure.microsoft.com/services/cognitive-services/translator-text-api/?azure-portal=true
