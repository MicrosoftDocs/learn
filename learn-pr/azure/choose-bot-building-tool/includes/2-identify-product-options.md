You must choose a bot-building tool that meets your company's technical requirements. You'll explore three options your company could use for building bots.

## What is a bot?

A *bot* provides a conversational interface in websites and applications. They're used to shift simple, repetitive tasks to automated systems that don't require human interaction. For instance, a bot could make travel arrangements or gather user information. At its core, a bot is a web application with a conversational interface. A user connects to a bot through a channel such as Microsoft Teams. The bot receives user input and performs relevant tasks based on internal reasoning logic. Examples of tasks it can perform include asking users for additional information or accessing services for users.

### Conversing with a bot

Bots often are able to understand natural language. This ability allows them to interpret a user's input and recognize what a user is asking for or saying. The bot responds to a user and communicates what it's doing or has done. Bots typically support many configurations and publishing channels, including Teams, telephony, and voice assistants.

> [!NOTE]
> Depending on the bot's configuration, you can converse with it by using text, interactive cards, speech, or a combination of these. Bots can have quick question-and-answer interactions and guided conversation flows. They also can conduct sophisticated conversations that integrate with external capabilities and AI systems.

## Bot-creation tools to consider

There are three bot-creation tools examined in this module. Although you can use any of them to create bots, they vary in requirements and capabilities. The bot-creation tools are:

- Power Virtual Agents
- QnA Maker
- Bot Framework Composer and Azure Bot Service

### Power Virtual Agents

You can create powerful chat bots that can answer questions in conversational form by using Power Virtual Agents. The *Power Virtual Agents* web app has a guided, no-code graphical interface you can use to create chat bots. The interface eliminates the need for code-based or developer expertise.

Topics guide a bot's conversation in Power Virtual Agents. Each topic contains a dialog tree that guides conversation flow. Each topic also has trigger phrases that a user is likely to enter. These phrases are matched to a specific topic using built-in natural language understanding. For instance, consider that a user enters "Open hours" into your bot. The bot's AI can match that to a topic named Store hours and then begin a conversation with the user to ask which store they're asking about. Ultimately, the bot then provides that store's hours of operation.

> [!TIP]
> You can extend Power Virtual Agents bot capability with advanced AI features, prebuilt and custom entities, variables, authentication, Power Automate flows for more task automation, and skills created using Bot Framework Composer and/or Bot Framework SDK. (These tools are discussed next.)

### QnA Maker

*QnA Maker* is an Azure-based question-and-answer service. It uses Natural Language Processing to create an elegant conversational layer over your data. Use QnA Maker to find the most appropriate answer for any input from your custom knowledge base of information.

The QnA Maker portal provides the complete knowledge base authoring experience. You can import documents in their current form to your knowledge base. These documents might include an FAQ, product manual, spreadsheet, or webpage. The documents are converted into question and answer pairs. Each pair is analyzed for follow-up prompts and connected to other pairs.

>[!NOTE]
> The final markdown format supports rich presentation including images and links.

Once your knowledge base is edited, you can publish the knowledge base to a working Azure Web App bot without writing any code. You can test your bot in the Azure portal or download it and continue development.

### Bot Framework Composer and Azure Bot Service

*Bot Framework Composer*, or Composer, is an open-source, visual integrated development environment (IDE) for developers to author, test, provision, and manage conversational experiences. Composer is built on the Bot Framework SDK. It provides a robust visual authoring canvas with built-in dialog and conversation flow functionality. Composer also integrates directly with Azure services for language understanding, knowledge bases, and the like. You then can build your logic and configure common integrations from a single design canvas.

> [!NOTE]
> Composer is available as a desktop application for Windows, macOS and Linux. It's also available as a web-based component that you can customize and extend to suit your needs.

Composer's visual-design experience provides greater design efficiency. You can model more sophisticated conversational experiences that include context switching, interruption, and more natural and dynamic conversation flows.

Bot Framework Composer and Bot Framework SDK provide the IDE and development-time environment. This environment pairs with Azure Bot Service, which provides hosting and runtime services like authentication and connections to services such as chat clients and telephony.

>[!TIP]
> Accomplish more complex activities, such as integrating with dependencies including REST API, by directly modifying your bot's code by using Visual Studio Code or another IDE.
