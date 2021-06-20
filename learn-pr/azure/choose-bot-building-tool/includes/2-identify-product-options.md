You must choose a bot-building tool that meets your company's technical requirements. You'll explore three options your company could use for building bots.

## What is a bot?

A *bot* provides a conversational interface in websites and applications. You can use a bot to shift simple, repetitive tasks, such as arranging travel or gathering user information, to automated systems that don’t require direct human intervention. At its core, a bot can be thought of as web application with a conversational interface. A user connects to a bot though a channel such as Facebook, Slack, or Microsoft Teams. The bot receives user input and performs relevant tasks based on internal reasoning logic. Task examples include asking the user for additional information or accessing services on behalf of the user.

### Conversing with a bot

Bots typically have natural language understanding capabilities to interpret the user's input to  recognize what the user is asking for or saying. The bot responds to the user to communicate what the bot is doing or has done. Bots typically support numerous configurations and channel publishing options that enable users to interact through text, speech, or even images and video.

> [!NOTE] 
> You can converse with a bot using text, interactive cards, and speech. Bot interactions can be quick questions and answers, guided conversation flows, or a sophisticated conversation that integrates with external capabilities and AI systems.

## Power Virtual Agents

You can create powerful chatbots that can answer questions in conversational form by using Power Virtual Agents. The *Power Virtual Agents* web app has a guided, no-code graphical interface you can use to create chatbots. This interface eliminates the need for code-based or developer expertise.

Topics inform the bot conversation in Power Virtual Agents. Each topic contains a dialog tree that guides conversation flow. Each topic also has trigger phrases that a user is likely to type. These phrases are matched to a specific topic using built-in natural language understanding. For example, if a user types "Open hours" into your bot, the AI will be able to match that to a topic named Store hours, begin a conversation that asks which store the customer is interested in, and then provide information about the store's hours of operation.

You can extend Power Virtual Agents bot capability with advanced AI features, prebuilt and custom entities, variables, authentication, Power Automate flows for more task automation, and skills created using the Bot Framework SDK.

## QnA Maker

*QnA Maker *is a Azure-based Natural Language Processing (NLP) service that allows you to create a natural conversational layer from existing data based on question and answer pairs. It is used to find the most appropriate answer for any input from your custom knowledge base (KB) of information.

The QnA Maker portal provides the complete knowledge base authoring experience. You can import documents, in their current form, to your knowledge base. These documents, such as an FAQ, product manual, spreadsheet, or web page, are converted into question and answer pairs. Each pair is analyzed for follow-up prompts and connected to other pairs. The final markdown format supports rich presentation including images and links.

Once your knowledge base is edited, publish the knowledge base to a working Azure Web App bot without writing any code. You can test your bot in the Azure portal or download it and continue development.

## Bot Framework Composer and Azure Bot Service

*Bot Framework Composer* (Composer), built on the Bot Framework SDK, is an open-source, visual IDE for developers to author, test, provision and manage conversational experiences. It provides a robust visual authoring canvas with integrated dialog, language-understanding models, knowledgebases and language generation functionality. All of these features can be implemented from a single design canvas. Resulting experiences can then be tested within Composer and provisioned into Azure along with any dependent resources. Composer is available as a desktop application for Windows, macOS and Linux as well as a web-based component which can be customized and extended to suit your needs.

Composer offers a visual design experience that makes it easy to model of more sophisticated conversational experiences where context switching, interruption and more natural and dynamic conversation flows are important. Using a visual designer to author dialog experiences enables greater design efficiency and easier modeling of more sophisticated conversational experiences where context switching, interruption, and dynamic conversation flows are important. More complex activities such as integrating with dependencies such as REST API can be accomplished my directly modifying the code of your Composer-authored bot using Visual Studio Code or another IDE.
