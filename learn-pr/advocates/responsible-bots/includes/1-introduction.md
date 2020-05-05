<!-- Add introduction statement - Checkout the published module to use consistent text. -->

## Conversational UI

Over the years, the **user interface** (or UI for short) between human beings and computers has evolved. Starting from punch cards, to command-line interface and windowed applications, to phone applications and web sites - it made using computers easier and more accessible to broad audience. However, regardless of the UI, computer was still regarded as a **tool**, which we need to *learn how to use* to become productive.

Things now may change with the emergence of new type of user experience - **Conversational UI** and **bots**. Instead of knowing which buttons to press, we may just ask a computer what we need, hoping that it will understand us correctly and do the job. In this experience we regard a computer as an **assistant** rather than a tool, and we want to be able to speak to it naturally using **natural language**.

With this paradigm shift, we need to take extra care to make sure that users **are comfortable** when dealing with a computer through conversations. This is important, because people can subconsciously expect a bot to act like a human, for example, attribute some emotions to it, and in general feel more personal involvement. Thus, we need to make sure that we build conversational UI **responsibly**.

## Our Goal: Develop Educational Assistant for Geography

If you come to this course, you probably know some basics of software development. Being able to program, you have a great power to make great things! Suppose, you want to help schools transition to online learning and make it more effective and engaging. Bots can come to the rescue! 

In this course, we will start developing a simple bot which can help  school students learn Geography. We will call it **GeoFriend**. While I will not walk you through developing the complete functionality, I will teach you how to put basic building blocks together. You can later expand on that knowledge to complete this project, or develop similar bots for different subject areas and even for different tasks.

>[!NOTE]
Bot interface is typically more engaging for the user, because he/she often attributes human-like personality to the bot. This can also lead to some frustrations. To avoid that, we need to build **responsible bots**. 

## Responsible Conversational UI

To help developer create responsible bots, Microsoft has outlined [10 guidelines for developers of Conversational UI][Guidelines10]. We will not cover all principles here, but outline the major ones that we will need in this course. You can learn more about responsible conversational UI by viewing [this great interactive demo][InteractiveDemo].

> It is important for developers to be aware of responsible conversational UI principles, because, as one of the principles say, **developers are accountable for the bots they deploy**.

### Ensure bot has a clear goal

When developing a bot, you should clearly understand its purpose, and you should also articulate this purpose to the users. When using a bot, users should be aware of its limitations, so that they do not have higher expectations, which leads to disappointment and/or misuse of the bot.

It is especially important when you are dealing with so-called **consequential outcomes**, when a conversation with a bot can have a significant impact on user's life. Examples include bots in such problem domains as healthcare or education. 

For example, in the case of our **GeoFriend** bot, it is important to articulate that the bot does not replace a teacher, and may only act as an assistant, which may help to learn better. We do not want to end up in the situation when a user trusted the bot to teach him Geography, and later or discovered that his knowledge is not up to standards.

Clear goal also prevents the user from starting general conversation with a bot about unrelated topics. It is much easier to develop a bot that is good at solving specific tasks, than trying to handle general conversation. 

### Make it clear that users talks to a bot

To avoid high expectations, it is advisable to make it clear in the first place that user is talking to a bot, and not a human being. This will help user focus on solving a specific task, and not on the emotional relationship with the bot. The bot should normally support some traditional phrases like greeting and ending a conversation, but not much more than that. Handling general conversation can be implemented using [Project Personality Chat][PersonalityChat], which we will use later in the course to enhance our **GeoFriend** bot.

### Build trust

Also, clearly introducing the bot in the beginning of a conversation helps to **build trust** between a user and a bot. Another useful trick would be using an icon that shows a robot icon instead of a human face, which will remind user of whom he/she is talking to.

Supporting **handoff to a human operator** also helps to build trust, because a user knows that he can get the help from qualified personnel if needed. A common scenario is to use bot dialog to collect initial info from the user, and then involve human operator to take final decision and solve a problem. This we can delegate tedious task to the bot, leaving the most creative part to human operator.

One other aspect of building trust is respecting user's privacy. You should follow the best practices for collecting and handling personal information, and collect only information that is relevant to the problem being solved.

### Fairness, Diversity and Accessibility

Ensuring that AI model acts fairly and does not have any biases is a big problem in AI in general, and it is addressed by [Responsible AI][RespAI] principles. One of the ways to help avoid biases is to include **diversity** on all stages of building a bot, for example, by having team members of different genders and/or nationalities.

We also may target the bot for diverse audience by supporting different languages. This can be simplified by using [translator cognitive service][TranslatorAPI] for automatic translation of incoming and outgoing messages, and by automatically [detecting a language][LangDetect] that user speaks.

In addition to national diversity, there are also important **cultural norms** that we may need to pay attention to. In some cultures, an informal tone would be appropriate for a bot, which others would require more formal communication. Adjusting to appropriate style is a good idea: for example, **personality chat** supports three different conversational styles.

Building **accessibility practices** into a bot may broaden the potential audience. For example, adding **speech support** would make the bot usable by those with vision impairments. It would also make it attractive to the people who would like to avoid typing, for example drivers.

## Learning objectives
<!-- Add more obectives to this list -->

- Learn basic principles to develop responsible conversational experiences for users
- Develop a simple educational assistant with Azure Bot Service and Azure Cognitive Services

## Prerequisites

In this course, we'll be using the [Azure Bot Service][BotService] and [C# Programming Language][CSharp] to build a bot.

Here's what you'll need to complete this course:

- Basic knowledge of C#. You may want to [take this course][CSCourse] if you're not familiar with the language.
- An Azure account. [This module][AzAccount] describes how to get an account.
- We suggest using [Visual Studio 2019][VS] as source code editor. Please, download and install Visual Studio on your computer, selecting "Azure Development". If your computer is not powerful enough, or you do not want to perform the installation - you should be able to use **Visual Studio Online**, though it is not recommended.

## Next steps

Now that we know main principles of building responsible bots, let's try to apply them to building a simple Geography Assistant Bot. 

<!-- Links below this line -->

[Guidelines10]: https://www.microsoft.com/research/publication/responsible-bots/
[InteractiveDemo]: https://aidemos.microsoft.com/responsible-conversational-ai/building-a-trustworthy-bot
[RespAI]: https://www.microsoft.com/ai/responsible-ai
[PersonalityChat]: https://www.microsoft.com/research/project/personality-chat/
[TranslatorAPI]: https://azure.microsoft.com/services/cognitive-services/translator-text-api/
[LandDetect]: https://docs.microsoft.com/azure/cognitive-services/text-analytics/how-tos/text-analytics-how-to-language-detection

[BotService]: https://azure.microsoft.com/services/bot-service/
[CSharp]: https://dotnet.microsoft.com/learn/csharp
[CSCourse]: https://docs.microsoft.com/dotnet/csharp/tutorials/
[AzAccount]: https://docs.microsoft.com/learn/modules/create-an-azure-account/
[VS]: https://www.visualstudio.com/downloads/
