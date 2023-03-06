Continue comparing bot-creation service options by examining QnA Maker functionality.

## Review your company's criteria

Recall the criteria for creating the bot that should inform your decision-making process:

- The initial development of a test bot should be in a low-code designer.
- The test bot should include an existing LUIS app for language understanding. It should be trained to recognize financial industry terms and phrases.
- The bot will be hosted on the company website.
- After your team tests the bot, they need to integrate several C# libraries into it, to extend its functionality.
- After your testing is complete, you need to integrate the bot with a pre-existing REST-enabled FAQ application.

## Consider the QnA Maker service

One tool you're considering using to build your bot is the QnA Maker service. Use the previous list of criteria and the following factors to examine building a bot using QnA Maker.

### What informs conversational flow?

The first step when you create a bot using QnA Maker is to create a QnA Maker knowledge base. You do this using source documents and websites containing FAQ-type information. QnA Maker doesn't offer much control over conversation flow. Conversation is dictated primarily by the knowledge base content.

### Where do you publish the bot?

After publishing the knowledge base, you can publish a bot based on it to an Azure Bot Service bot. You can connect your bot using Bot Service channels or publish it to an Azure Web App.

One of your company's requirements is that the bot can be hosted on the company website. A bot created with QnA Maker fulfills this requirement, because you can publish it to a webpage.

### Where do you perform development?

You can download a QnA Maker bot's source code and modify it using an IDE. QnA Maker bots support C# source code. Your development team can use C# to extend bot functionality in many ways. For example, they can incorporate the C# libraries that the criteria require. The bot's code-based design also enables your developers to integrate your bot with the REST-enabled FAQ application, which fulfills another criteria.

## Why QnA Maker isn't a good choice

A bot created with QnA would meet some of the criteria. However, several criteria aren't met:

- The QnA Maker portal doesn't offer low-code bot-modification options. This capability is one of your key requirements. If you must modify your bot to meet test requirements, you'd have to edit the bot source code.
- You can't integrate an existing LUIS app for language understanding. You can only implement LUIS by modifying the bot source code.
