To choose the right service to create a test bot, you need to examine the criteria for the bot creation tool. You'll consider if Power Virtual Agents is the appropriate bot-creation tool.

## Criteria to create a test bot

Your company wants to create a test bot. This bot will perform the core functions of fielding customer support requests and advising customers about new services. If the test bot is successful, your team will pursue further development to implement more sophisticated features. 

You have important criteria to consider for creating the bot. The following factors should inform your decision-making process:

- The initial development of the bot should be in a low-code designer.
- The test bot should include an existing LUIS app for language understanding that is trained to recognize financial industry terms and phrases.
- The bot will be hosted on the company website.
- After testing, your team will integrate several C# libraries to extend functionality.
- You need to integrate your bot with a pre-existing REST-enabled FAQ application.

## Consider factors to choose a service

To choose the service you will use, consider these factors:

- What informs conversational flow. Power Virtual Agents bots use topics to inform conversational flow. You can create and edit topics that provide responses to user input, based on one or more trigger phrases associated with a topic. 

- Where you publish. Power Virtual Agents chatbots can be published to a website or the Power Apps portal. You can add Power Virtual Agents bots to Azure Bot Service channels, Microsoft Teams, Facebook, or to mobile or custom apps.

- Where development is performed. For the test bot, all development must be performed in a low-code designer that Power Virtual Agents supports. Power Virtual Agent also supports connection to REST APIs through Power Automate connectors.

    > [!NOTE] 
    > To connect to REST APIs through Power Automate Connectors, you would likely need to create a custom connector. This depends on the FAQ application that's being used.

## Evaluate Power Virtual Agents

The second requirement for the test bot involves integration with a LUIS app. Although Power Virtual Agents does have its own natural language understanding capabilities, it doesn't support direct integration with LUIS in the low-code designer. This is one reason why it's not an appropriate service to use. 

A second reason Power Virtual Agents isn't appropriate is because it doesn't fulfill the requirement for code-based integration of the C# libraries your development team requires. 

> [!IMPORTANT] 
> Although you can import skills created using the Bot Framework SDK, you can't work directly with the source code of a Power Virtual Agents bot.
