---
title: Understand ways to build a bot
durationInMinutes: 5
---

Microsoft provides three ways to author a bot, each providing a different authoring experience. Regardless of which method you choose, the published bot at the end will interact with users in a similar fashion; each bot can handle a range of requests and engage in complex conversations.

## Power Virtual Agents

Power Virtual Agents (PVA) is built on the Microsoft Power Platform, and enables users to build a chatbot without requiring any code. PVA lets users use an interface to build conversations, send messages, publish, monitor, and configure your bot all within the PVA app. This PVA app is tailored for individuals who prefer not to write any code and use a graphical interface to build their bot, or for teams made up of both subject matter experts and developers working together.

Some features of the Azure Bot service aren't available in the PVA app, and require using Bot Framework Composer (which can be launched directly from the PVA web app) to integrate those features.

> [!NOTE]
> Terminology of concepts between PVA and Composer is different, so if you are planning to use the PVA app check out the correlation of [concepts for Composer users](/power-virtual-agents/composer-concepts-preview)

For the AI Engineer course, PVA as an authoring tool isn't covered. If you'd like to learn or build with PVA, take a look at their [documentation pages](/power-virtual-agents/fundamentals-what-is-power-virtual-agents).

## Bot Framework Composer

Bot Framework Composer is an app for developers to build, test, and publish your bot via an interactive interface. Composer is built on the Bot Framework SDK, and supports extending your bot with code for more complex interactions. Composer enables use of all of the Azure Bot service features.

Composer will be the focus of the rest of this module, where you'll get experience using the visual canvas for building your bot conversation flow. Composer is best for developers who want to use both a visual interface and code to author a bot.

Further details on Composer are covered in this module, and can be explored on their [documentation page](/composer/introduction)

## Bot Framework SDK

The Bot Framework SDK is a collection of libraries and tools to build, test, publish, and manage conversational bots. The SDK can connect to other AI services, covers end-to-end bot development, and offers the most authoring flexibility.

Bot Framework SDK is for use by developers comfortable with only code, and is available for C#, Java, JavaScript, TypeScript, and Python. Developers can use their favorite development environment to build and enhance their bot, and then connect the bot to various channels through the Azure Bot service.

The Bot Framework SDK is covered in a future module in this course, or can be explored on their [documentation page](/azure/bot-service/bot-service-overview).
