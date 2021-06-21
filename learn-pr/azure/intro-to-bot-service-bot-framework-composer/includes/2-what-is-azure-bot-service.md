You need to begin exploring methods to provide chat support to your company's customers. You'll start by learning about bots and what they do. You'll examine Azure Bot Service and its components, including using Bot Framework Composer to create bots.

## What is a bot and what does it do?

A *bot* is an app that users interact with in a conversational way, using text, graphics (such as cards or images), or speech. Bots provide a conversational experience that can be used to shift simple, repetitive tasks, such as taking a dinner reservation or gathering profile information, on to automated systems that may no longer require direct human intervention. A bot can be thought of as a web application that has a conversational interface. 

> [!NOTE]
> A bot interaction can be a quick question and answer, or it can be a sophisticated conversation that intelligently provides access to services.

## What is Azure Bot Service?

*Azure Bot Service* is a collection of tools that you can use to create enterprise-grade conversational AI experiences. You can use Azure Bot Service to create conversational bots that interact with customers and provide them with an enriched, interactive chat experience. Bots can also solve business problems using AI and other cognition capabilities. You can use Azure Bot Service components, including the Bot Framework Composer and the Bot Framework SDK, to design, build, test, and deploy bot functionality.

### Core bot functionality

Bots created using Azure Bot Service have the following core functionalities:

1. The bot receives user input.

    > [!NOTE]
    > Depending on how the bot is configured, users can interact with the bot through text, speech, images, or video.

1. The bot provides a response. This can include asking the user for additional information or performing tasks on behalf of the user.
1. The bot performs reasoning on the user's input to determine what the user is asking for or saying.
1. The bot generates responses to communicate to the user what the bot is doing or has done.

:::image type="content" source="../media/2-overview.png" alt-text="Azure Bot Service scenario diagram":::

## Components of Azure Bot Service

Azure Bot Service is made up of several components and tools. You can use these tools to build, test, extend, and publish your bots.

### Bot Framework Composer

Bot Framework Composer, built on the Bot Framework SDK, is an open-source IDE for developers to author, test, provision, and manage conversational experiences. It provides a powerful visual authoring canvas enabling you to create dialogs, language-understanding models, knowledge bases and language generation responses from a single design canvas. You can also extend bots with code for more complex tasks such as integration with external services and apps. These bots  can then be tested within Bot Framework Composer and provisioned into Azure along with any dependent resources. Bot Framework Composer is available as a desktop application for Windows, macOS and Linux as well as a web-based component which can be customized and extended to suit your needs.

Composer offers a visual design experience that makes it easy to model sophisticated conversational experiences where context switching, interruption and more natural and dynamic conversation flows are important.

### Bot Framework SDK

The Bot Framework SDK is a modular set of components for building and extending bots. The Bot Framework SDK is available for C#, JavaScript, Typescript, Python, and Java (preview). The SDK includes tools for various stages of bot development to help you design and build bots. More complex activities such as integrating with dependencies such as REST Web Services are best suited towards extending your bot with the Bot Framework SDK and code.

### Bot Framework Emulator

Bot Framework Emulator is a desktop application that allows bot developers to test and debug bots, either locally or remotely. Using the Emulator, you can chat with your bot and inspect the messages that your bot sends and receives. The Emulator displays messages as they would appear in a web chat UI and logs JSON requests and responses as you exchange messages with your bot. Before you deploy your bot to the cloud, run it locally and test it using the Emulator. You can test your bot using the Emulator even if you haven't yet created it with Azure Bot Service or configured it to run on any channels.

### Azure Bot

The Azure Bot resource enables you to register your Bot Framework Composer or SDK bot in the Azure Bot Service. You can build, connect, and manage bots to interact with your users wherever they are, from your app or website to Teams, Messenger and many other channels.

### Other bot-building tools

You can use other bot-building tools in Azure to create bots. Two of these bot-building tools are Power Virtual Agents and QnA Maker:

- *Power Virtual Agents* is a web app you can use to create chat bots. Using its guided, no-code graphical interface eliminates the need for code-based or developer expertise. The chat bots you create can answer questions posed by your customers, other employees, or visitors to your website or service. Power Virtual Agents also provides full testing and publishing capabilities for your bot.

- *QnA Maker* is an Azure-based Natural Language Processing service you can use to create a natural conversational layer over your data. It's used to find the most appropriate answer for any input from your custom knowledge base of information. Once your knowledge base is edited, you can publish the knowledge base to a bot hosted in an Azure Web App bot without writing any code. You can test your bot in the Azure portal or download it and continue development.

    > [!NOTE]
    > This course does not cover the Web App Bot and Bot Channels. Registration of these resources are deprecated as of 9/1/2021, but existing resources will continue to work beyond that date. You should use the Azure Bot when creating new resources.
