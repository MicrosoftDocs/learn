You'll continue your comparison of bot creation service options by examining the functionality of QnA Maker.

## Review your company's criteria

Recall the criteria for creating the bot that should inform your decision-making process:

- The initial development of a test bot should be in a low-code designer.
- The test bot should include an existing LUIS app for language understanding. It should be trained to recognize financial industry terms and phrases.
- The bot will be hosted on the company website.
- After testing the bot, your team needs to integrate into it several C# libraries to extend its functionality.
- After testing, you need to integrate the bot with a pre-existing REST-enabled FAQ application.

## Consider the QnA Maker service

One of the options you are considering to build the bot is the Bot Framework Composer service. Use the previous list of criteria and the following factors to examine building a bot using QnA Maker.

### What informs conversational flow?

The first step when you create a bot using QnA Maker is to create a QnA Maker knowledge base. You do this using source documents and websites containing FAQ-type information. QnA Maker doesn't offer much control over conversation flow. Conversation is dictated primarily by the knowledge base content.

### Where do you publish the bot?

After the knowledge base is published, you can publish a bot based on the knowledge base to an Azure Bot Service bot. You can connect to the bot using Bot Service channels, or publish the bot to an Azure Web App.

One of your company's requirements is that the bot can be hosted on the company website. A bot created with QnA Maker fulfills this requirement, because you can publish it to a web page.

### Where do you perform development?

You can download the source code of a QnA Maker bot and modify it using your IDE of choice. Since QnA Maker bots can be created using C# source code, your development team could extend the bot functionality in many ways. These might include incorporating the C# libraries that the criteria requires. The bot's code-based design also enables your developers to integrate your bot with the REST-enabled FAQ application. This fulfills another criteria.

## Why QnA Maker isn't a good choice

A bot created with QnA would meet some of the criteria. However, several criteria aren't met:

- The QnA Maker portal doesn't offer low-code bot modification possibilities, which violates one of your key requirements. If you needed to modify your bot to meet test requirements, you would have to edit the bot source code.
- You can't integrate an existing LUIS app for language understanding. Although this is possible with a QnA Maker bot, you can only implement LUIS by modifying the bot source code.
