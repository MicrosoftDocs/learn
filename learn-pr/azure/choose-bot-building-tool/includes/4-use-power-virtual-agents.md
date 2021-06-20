To choose the right service to create a test bot, you need to examine your company's requirements for the bot creation tool. Based on these requirements, you'll then consider if Power Virtual Agents is the appropriate bot-creation tool to use.

## Examine the criteria for a test bot

Your company wants to create a test bot. This bot will perform the core functions of fielding customer support requests and advising customers about new services. If the test bot is successful, your team will pursue further development to implement more sophisticated features. 

Your company has important criteria for creating the bot you need to consider. The following requirements should inform your decision-making process:

- The initial development of a test bot should be in a low-code designer.
- The test bot should include an existing LUIS app for language understanding. It should be trained to recognize financial industry terms and phrases.
- The bot will be hosted on the company website.
- After testing the bot, your team needs to integrate into it several C# libraries to extend its functionality.
- After testing, you need to integrate the bot with a pre-existing REST-enabled FAQ application.

## Consider factors to choose a service

To choose the service you will use, consider these three factors:

- What informs conversational flow?
- Where do you publish the bot?
- Where do you perform development?

## Consider Power Virtual Agents

To examine Power Virtual Agents as a possible bot-building tool, consider its capabilities with the three factors just mentioned.

### What informs conversational flow?

Power Virtual Agents bots use topics to inform conversational flow. You can create and edit topics that provide responses to user input, based on one or more trigger phrases associated with a topic.

### Where do you publish the bot?

Power Virtual Agents chatbots can be published to a website or the Power Apps portal. You can add Power Virtual Agents bots to Azure Bot Service channels, Microsoft Teams, Facebook, or to mobile or custom apps.

### Where do you perform development?

For the test bot, all development must be performed in a low-code designer that Power Virtual Agents supports. Power Virtual Agent also supports connection to REST APIs through Power Automate connectors.

> [!NOTE]
> To connect to REST APIs through Power Automate Connectors, you would likely need to create a custom connector. This depends on the FAQ application that's being used.

## Why Power Virtual Agents isn't a good choice

The second requirement for the test bot involves integration with a LUIS app. Although Power Virtual Agents does have its own natural language understanding capabilities, it doesn't support direct integration with LUIS in its low-code designer. This is one reason why it's not an appropriate service to use.

A second reason Power Virtual Agents isn't appropriate is because it doesn't fulfill the requirement for code-based integration of the C# libraries your development team requires. 

> [!IMPORTANT]
> Although you can import skills created using the Bot Framework SDK, you can't work directly with the source code of a Power Virtual Agents bot.
