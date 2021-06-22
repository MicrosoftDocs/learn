You must choose a bot-building tool that meets your company's technical requirements. You'll explore three options your company could use for building bots.

## What is a bot?

A *bot* provides a conversational interface in websites and applications. You can use a bot to shift simple, repetitive tasks, such as arranging travel or gathering user information, to automated systems that don’t require direct human intervention. At its core, a bot can be thought of as web application with a conversational interface. A user connects to a bot though a channel such as Facebook, Slack, or Microsoft Teams. The bot receives user input and performs relevant tasks based on internal reasoning logic. Task examples include asking the user for additional information or accessing services on behalf of the user.

### Conversing with a bot

Bots often have natural language understanding capabilities to interpret the user's input to  recognize what the user is asking for or saying. The bot responds to the user to communicate what the bot is doing or has done. Bots typically support numerous configurations and publishing channels like Teams, telephony, and voice assistants. 

> [!NOTE]
> Depending on the bot's configuration, you can converse with it using text, interactive cards, speech, or a combination of these. Bot interactions can be quick questions and answers, guided conversation flows, or a sophisticated conversation that integrates with external capabilities and AI systems.

## Bot-creation tools to consider

There are three bot-creation tools examined in this module. Although you can use any of them to create bots, they vary in requirements and capabilities. The bot-creation tools are:

- Power Virtual Agents
- QnA Maker
- Bot Framework Composer and Azure Bot Service

### Power Virtual Agents

You can create powerful chat bots that can answer questions in conversational form by using Power Virtual Agents. The *Power Virtual Agents* web app has a guided, no-code graphical interface you can use to create chat bots. This interface eliminates the need for code-based or developer expertise.

Topics inform the bot conversation in Power Virtual Agents. Each topic contains a dialog tree that guides conversation flow. Each topic also has trigger phrases that a user is likely to type. These phrases are matched to a specific topic using built-in natural language understanding. For example, if a user types "Open hours" into your bot, the AI will be able to match that to a topic named Store hours, begin a conversation that asks which store the customer is interested in, and then provide information about the store's hours of operation.

> [!TIP]
> You can extend Power Virtual Agents bot capability with advanced AI features, prebuilt and custom entities, variables, authentication, Power Automate flows for more task automation, and skills created using Bot Framework Composer and/or Bot Framework SDK. (These tools are discussed next.)

### QnA Maker

*QnA Maker* is an Azure-based question-and-answer service that uses Natural Language Processing to create an elegant conversational layer over your data. It is used to find the most appropriate answer for any input from your custom knowledge base of information.

The QnA Maker portal provides the complete knowledge base authoring experience. You can import documents in their current form to your knowledge base. These documents might include an FAQ, product manual, spreadsheet, or web page. The documents are converted into question and answer pairs. Each pair is analyzed for follow-up prompts and connected to other pairs.

>[!NOTE]
> The final markdown format supports rich presentation including images and links.

Once your knowledge base is edited, you can publish the knowledge base to a working Azure Web App bot without writing any code. You can test your bot in the Azure portal or download it and continue development.

### Bot Framework Composer and Azure Bot Service

*Bot Framework Composer* is an open-source, visual IDE for developers to author, test, provision, and manage conversational experiences. It's built on the Bot Framework SDK. It provides a robust visual authoring canvas with built-in dialog and conversation flow functionality. It can also integrate directly with Azure services for language understanding, knowledge bases, and the like. You then can build your logic and configure common integrations from a single design canvas.

> [!NOTE]
> Composer is available as a desktop application for Windows, macOS and Linux. It's also available as a web-based component which you can customize and extend to suit your needs.

Composer offers a visual design experience. This gives you greater design efficiency. This can make it easier for you to model more sophisticated conversational experiences where context switching, interruption, and more natural and dynamic conversation flows are important.

>[!TIP]
> More complex activities such as integrating with dependencies such as REST API can be accomplished by directly modifying the code of the bot using Visual Studio Code or another IDE.
