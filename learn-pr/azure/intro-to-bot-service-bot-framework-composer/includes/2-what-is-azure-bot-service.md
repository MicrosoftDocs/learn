A bot is an app that users interact with in a conversational way, using text, graphics (such as cards or images), or speech. The Azure Bot Service enables you to create bots that use converstational AI to interact with customers and solve business problems. Bots created by using the Azure Bot Service perform three core tasks:

## What does a bot do?

Bots provide an experience that feels less like using a computer and more like dealing with a person - or at least an intelligent robot. They can be used to shift simple, repetitive tasks, such as taking a dinner reservation or gathering profile information, on to automated systems that may no longer require direct human intervention. Users converse with a bot using text, interactive cards, and speech. A bot interaction can be a quick question and answer, or it can be a sophisticated conversation that intelligently provides access to services.

A bot can be thought of as a web application that has a conversational interface. Bots created by using the Azure Bot Service support the following core functionality:

- The bot reasons about input and performs relevant tasks. This can include asking the user for additional information or accessing services on behalf of the user.
- The bot performs recognition on the user's input to interpret what the user is asking for or saying.
- The bot generates responses to send to the user to communicate what the bot is doing or has done.
- Depending on how the bot is configured and how it is registered with the channel, users can interact with the bot through text or speech, and the conversation might include images and video.

## Azure Bot Service components

Azure Bot Service is made up of several components and tools that you can use to build, test, extend, and publish your bots.

### Bot Framework Composer

Bot Framework Composer, built on the Bot Framework SDK, is an open-source IDE for developers to author, test, provision and manage conversational experiences. It provides a powerful visual authoring canvas enabling dialogs, language-understanding models, knowledgebases and language generation responses to be authored from within one canvas and crucially, enables these experiences to be extended with code for more complex tasks such as system integration. Resulting experiences can then be tested within Composer and provisioned into Azure along with any dependent resources. Composer is available as a desktop application for Windows, OSX and Linux as well as a web-based component which can be customized and extended to suit your needs.

Composer offers a visual design experience that makes it easy to model of more sophisticated conversational experiences where context switching, interruption and more natural and dynamic conversation flows are important.

### Bot Framework SDK

The Bot Framework SDK is a modular set of components for building and extending bots. The Bot Framework SDK is available for C#, JavaScript, Typescript, Python, and Java (preview). The SDK includes tools for various stages of bot development to help you design and build bots. More complex activities such as integrating with dependencies such as REST Web Services are best suited towards extending your bot with the Bot Framework SDK and code.

### Bot Framework Emulator

Bot Framework Emulator is a desktop application that allows bot developers to test and debug bots, either locally or remotely. Using the Emulator, you can chat with your bot and inspect the messages that your bot sends and receives. The Emulator displays messages as they would appear in a web chat UI and logs JSON requests and responses as you exchange messages with your bot. Before you deploy your bot to the cloud, run it locally and test it using the Emulator. You can test your bot using the Emulator even if you haven't yet created it with Azure Bot Service or configured it to run on any channels.

### Azure Bot

The Azure Bot resource enables you to register your Bot Framework Composer or SDK bot in the Azure Bot Service. You can build, connect, and manage bots to interact with your users wherever they are, from your app or website to Teams, Messenger and many other channels.

> [!NOTE]
> This course does not cover the Web App Bot and Bot Channels Registration resources will be deprecated 9/1/2021 but existing resources will continue to work. You should use the Azure Bot when creating new resources.
