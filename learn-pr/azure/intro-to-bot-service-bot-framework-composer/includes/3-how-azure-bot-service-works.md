The Azure Bot Service supports the complete bot creation process. This includes design, building, testing, and publishing tasks. You'll focus on the Bot Framework Composer to understand the bot design process. You'll also gain a basic understanding of how to create a bot, extendi bot capabilites, and publish a bot in Azure.

## Design a bot

Before building your bot, make a plan of the bot you want to create. Ensuring a great user experience should be your number one priority when designing a bot. Consider the following questions:

- What your bot is used for? Determine the kind of bot you plan to build. This will help to define the functionalities you want to implement in the bot.
- What problems does your bot intend to solve? Be clear about the problems your bot intends to solve. Solving problems for customers is the top factor you should consider when building bots. You should also consider things such as how to solve the user's problem better, easier, or faster than any of the alternative experiences.
- Who will use your bot? If you are designing a bot, it's safe to assume that you are expecting users to use it. Different customers will expect different user experiences. This will also determine the complexity you should consider in your bot design. Consider what languages to implement for the bot.
- Where will your bot run? You should decide the platforms your bot will run on. For example, a bot designed to run on a mobile device will have more features like sending SMS to implement and the publishing experience will vary from platform to platform.

## Create a bot with the Bot Framework Composer

The *Bot Framework Composer* (Composer) is a visual editing canvas for building bots. You can use it to:

- Create a new bot by using a template. This process directly incorporates the capabilities of Virtual Assistant into Composer and new templates.
- Add natural language understanding capabilities to your bot using LUIS and/or QnA/FAQ type capabilities using QnA Maker.
- Author text and if needed speech variation responses for your Bot using language generation templates.
- Author bots in multiple languages.
- Test directly inside Composer using embedded Web Chat.
- Publish bots to Azure App Service and Azure Functions.
- Extend Power Virtual Agents with Composer (Preview).
- Integrate external services such as QnA Maker knowledge base.

Apps created with Composer uses the Adaptive dialog format, a JSON specification shared by many tools provided by the Bot Framework. The Composer bot projects contain reusable assets in the form of JSON and Markdown files that can be bundled and packaged with a bot's source code. These can be checked into source control systems and deployed along with code updates, such as dialogs, language understanding (LU) training data, and message templates.

### Adaptive dialogs

In Composer, dialogs are functional components offered in a visual interface that do not require you to write code. The dialog system supports building an extensible model that integrates all of the building blocks of a bot's functionality. Composer helps you focus on conversation modeling rather than the mechanics of dialog management. Adaptive dialogs and the event model simplify sophisticated conversation modelling enabling more natural, dynamic conversation flow, interruption, and context switching. They also help you focus on the model of the conversation rather than the mechanics of dialog management.

## Extend a bot with language capabilities

You can use Composer to integrate several out-of-the-box language capabilities that can extend the functionality and improve the conversational capabilities of your bot.

### Language understanding

Language understanding (LU) is a core component of Composer that allows developers and conversation designers to train language understanding models directly in the context of editing a dialog. As dialogs are edited in Composer, developers can continuously add to their bots' natural language capabilities using the .lu file format, a simple Markdown-like format that makes it easy to define new intents, entities and provide sample utterances. In Composer, you can use both Regular Expression, LUIS and Orchestrator. Composer detects changes and updates the bot's cloud-based natural-language understanding (NLU) model automatically so it is always up to date. Read more in the language understanding concept article.

### Language generation

Composer's integrated Language generation (LG) allows developers to create bot replies with a great deal of flexibility using the editor to create grammatically correct, data-driven responses that have a consistent tone and convey a clear brand voice.

### QnA Maker

QnA Maker is a cloud-based service that enables you to extract Question and Answer pairs from existing FAQ-style documents and websites into a knowledgebase that can be manually curated by knowledge experts. QnAMaker once integrated into a bot can be used to find the most appropriate answer for any given natural language input, from your custom knowledgebase (KB) of information.
