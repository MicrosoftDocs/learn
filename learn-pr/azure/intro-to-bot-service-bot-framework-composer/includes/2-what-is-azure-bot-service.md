A bot is an app that users interact with in a conversational way, using text, graphics (such as cards or images), or speech. By using the Azure Bot Service you can create conversational bots that interact with customers and solve business problems using AI and other cognition capabilities.

## What does a bot do?

Bots provide a conversational experience that can be used to shift simple, repetitive tasks, such as taking a dinner reservation or gathering profile information, on to automated systems that may no longer require direct human intervention. Users converse with a bot using text, interactive cards, and speech. A bot interaction can be a quick question and answer, or it can be a sophisticated conversation that intelligently provides access to services.

A bot can be thought of as a web application that has a conversational interface. Bots created by using the Azure Bot Service support the following core functionality:

- The bot receives user input and provides a response. This can include asking the user for additional information or performing tasks on behalf of the user.
- The bot recognizes on the user's input to determine what the user is asking for or saying.
- The bot creates responses to communicate to the user what the bot is doing or has done.
- Depending on how the bot configuration, users can interact with the bot through text, speech, images, or video.

:::image type="content" source="../media/bot-service.png" alt-text="Basic bot components":::

## Azure Bot Service components

Azure Bot Service is made up of several components and tools that you can use to build, test, extend, and publish your bots.

### Bot Framework Composer

Bot Framework Composer, built on the Bot Framework SDK, is an open-source IDE for developers to author, test, provision and manage conversational experiences. It provides a powerful visual authoring canvas enabling you to create dialogs, language-understanding models, knowledgebases and language generation responses from a single design canvas. You can also extend bots with code for more complex tasks such as integration with external services and apps. These bots  can then be tested within Bot Framework Composer and provisioned into Azure along with any dependent resources. Bot Framework Composer is available as a desktop application for Windows, macOS and Linux as well as a web-based component which can be customized and extended to suit your needs.

Composer offers a visual design experience that makes it easy to model sophisticated conversational experiences where context switching, interruption and more natural and dynamic conversation flows are important.

### Bot Framework SDK

The Bot Framework SDK is a modular set of components for building and extending bots. The Bot Framework SDK is available for C#, JavaScript, Typescript, Python, and Java (preview). The SDK includes tools for various stages of bot development to help you design and build bots. More complex activities such as integrating with dependencies such as REST Web Services are best suited towards extending your bot with the Bot Framework SDK and code.

### Bot Framework Emulator

Bot Framework Emulator is a desktop application that allows bot developers to test and debug bots, either locally or remotely. Using the Emulator, you can chat with your bot and inspect the messages that your bot sends and receives. The Emulator displays messages as they would appear in a web chat UI and logs JSON requests and responses as you exchange messages with your bot. Before you deploy your bot to the cloud, run it locally and test it using the Emulator. You can test your bot using the Emulator even if you haven't yet created it with Azure Bot Service or configured it to run on any channels.

### Azure Bot

The Azure Bot resource enables you to register your Bot Framework Composer or SDK bot in the Azure Bot Service. You can build, connect, and manage bots to interact with your users wherever they are, from your app or website to Teams, Messenger and many other channels.

### Other bot building tools

You can use other bot building tools in Azure to create bots.

Power Virtual Agents lets you create powerful chatbots that can answer questions posed by your customers, other employees, or visitors to your website or service. The You can use the Power Virtual Agents web app to create chatbots using a guided, no-code graphical interface, removing the need for code-based or developer expertise. Power Virtual Agents provides full testing and publishing capabilities for your bot.

QnA Maker is a Azure-based Natural Language Processing (NLP) service that allows you to create a natural conversational layer over your data. It is used to find the most appropriate answer for any input from your custom knowledge base (KB) of information. Once your knowledge base is edited, you can publish the knowledge base to a bot hosted in an Azure Web App bot without writing any code. You can test your bot in the Azure portal or download it and continue development.

> [!NOTE]
> This course does not cover the Web App Bot and Bot Channels. Registration of these resources are deprecated as of 9/1/2021, but existing resources will continue to work beyond that date. You should use the Azure Bot when creating new resources.
