You'll explore using Bot Framework Composer to understand the bot-design process. You'll also gain a basic understanding of how to create a bot, extend bot capabilities, and publish a bot in Azure.

## What is the architecture of a bot package?

The Azure Bot Service supports the complete bot creation process. This includes design, building, testing, and publishing tasks. 

The Azure Bot Service developer tools create a *bot package* that contains the bot logic and details about bot integrations and connections, including input channels and authentication. The bot package also contains any custom bot code. The bot package is hosted in an Azure Web App that provides the primary endpoint for bot interaction. Through the web app, users can interact with the bot and the bot can handle incoming and outgoing REST interactions for external channels and other integrations.

> [!NOTE]
> The bot package is serviced using the development tools discussed in the previous unit, such as Bot Framework Composer or the Bot Framework SDK through Visual Studio or Visual Studio Code.

:::image type="content" source="../media/3-bot-service-architecture.png" alt-text="Azure Bot Service architecture":::

## Make a plan of the bot you want to create

Before building your bot, make a plan of the bot you want to create by considering the following questions:

- What your bot is used for? Determine the kind of bot you plan to build. This will help to define the functionalities you want to implement in the bot.
- What problems does your bot intend to solve? Be clear about the problems your bot intends to solve. Solving problems for customers is a primary factor you should consider when building bots. You should also consider things such as how to solve the user's problem better, easier, or faster than the alternative experiences.
- Who will use your bot? If you are designing a bot, it's safe to assume that you are expecting users to use it. Different customers will expect different user experiences. This will also determine the complexity you should consider in your bot design. Consider what languages to implement for the bot.

    > [!TIP]
    > Ensuring a great user experience should be your number one priority when designing a bot. 

- Where will your bot run? You should decide which platforms on which your bot will run. For example, a bot designed to run on a mobile device might require features such as sending SMS. 
 
    > [!IMPORTANT]
    > The publishing experience varies from platform to platform.
 
## Develop core bot functionality in Bot Framework Composer

You can use *Bot Framework Composer* to design, build, extend, and test a bot. Bot Framework Composer is a visual editing canvas for building bots.  It's typically the starting point for the Azure Bot Service creation process. 

You can use Bot Framework Composer's visual designer to intuitively develop the core functionality for your bot. You can use it to:

- Add natural language understanding capabilities to your bot with QnA Maker. You can use capabilities such as LUIS, QnA, or FAQ.
- Author text and speech variation responses for your Bot using language generation templates.
- Author bots in multiple languages.
- Test directly inside Bot Framework Composer using embedded Web Chat.
- Publish bots to Azure App Service and Azure Functions.
- Integrate external services such as LUIS apps and QnA Maker knowledge bases.

### Adaptive dialog format

Apps created with Bot Framework Composer use the *adaptive dialog* format. This is a JSON specification shared by many tools provided by the Bot Framework. Bot Framework Composer bot projects contain reusable assets in the form of JSON and Markdown files that you can bundle and package with a bot's source code. You can check these components into source control systems and deploy them along with code updates, such as dialogs, language understanding training data, and message templates. Bots created with Bot Framework Composer can be extended and modified by editing the bot source code and using the Bot Framework SDK in a code-based IDE.

> [!NOTE]
> *Bot Framework* is a comprehensive framework for building enterprise-grade conversational AI experiences. All bots built in Bot Framework Composer or the Bot Framework SDK are supported in Azure by the Bot Framework.

### Create dialogs and conversation flow

Dialogs control the conversations that a bot has with its users. Dialogs contain language generation response templates that define bot responses and instructions for how a bot will carry out tasks, such as making dinner reservations at a restaurant, or creating a calendar item in Outlook. 

Many dialogs are linear, with a simple question and response sequence, but dialogs can also include advanced conversation logic. This logic might include branching, looping, and context-based dynamic and adaptive dialogs that use external data, maintain stateful conversation data, and make necessary interruptions in the conversation.

### Include external flows with skills and other bots

You can create more complex conversation flows by importing Bot Framework Composer skills, Nuget packages, and even other Azure Bot Service bots into your bot. You can create a nested series of bots to create a more modular and reusable set of bot functionality. You can combine these smaller, modular components in multiple combinations to provide a set of capabilities for different parent bots.

### Use cards, images, and buttons to enhance conversation

You can use several visual and interactive methods to enhance conversation for your bot's users. Use cards to create rich text, image, and button-based content to provide a more interactive experience that plain text. Bot Framework Composer offers several card types, including thumbnail, sign-in, audio, and video.

### Extend language understanding and intelligence with LUIS and QnA Maker

*LUIS* provides natural language processing with a complete intent and entity management system. You can integrate previously created LUIS apps or create new apps within Bot Framework Composer to add robust natural language understanding capabilities to your bot.

*QnA Maker* is a cloud-based service that enables you to extract Question and Answer pairs from existing FAQ-style documents and websites into a knowledge base that can be manually curated by knowledge experts. You can integrate your bot with a QnA knowledge base to find the most appropriate answer for any given natural language input.

## Test your bot with Web Chat

You can test your bot's functionality right in Bot Framework Composer with *Web Chat*. Web Chat runs your bot in a local bot runtime, which means you can test your bot locally on your development machine without publishing it to Azure. Web Chat has complete debugging, transcript recording, and bot state inspection capabilities for testing all aspects of bot capabilities.

## Add middleware and extend bot functionality with the Bot Framework SDK

You can use Visual Studio, Visual Studio Code, or the supported IDE of your choice and the Bot Framework SDK to edit bot source code and extend bot functionality. You can package and publish bots as Nuget packages which can be imported into Bot Framework Composer for easy integration. You can move seamlessly between Bot Framework Composer and the Bot Framework SDK throughout the bot development lifecycle, so you can always use the most effective tool for any development task.

## Publish your bot to Azure

The Azure Bot Service hosts bot functionality in Azure. You can publish bots directly from the Bot Framework Composer interface, creating an end-to-end development experience within Bot Framework Composer.

Azure Bot Service hosts a bot in an Azure Web App resource, which contains the code, logic, and basic HTTP REST endpoints for standard connectivity to external resources such as databases or REST APIs. Azure Bot Service also provides ready made Bot Service channels that allow built-in integration with Facebook, Slack, Teams, telephony, and others.

When you publish from Bot Framework Composer, the publishing process can also create or import dependent Azure resources, including LUIS, QnA Maker, Azure Cosmos DB, Application Insights, and Blob Storage.
