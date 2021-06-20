In your scenario, the financial services company you work for wants to create a bot to test core functionality for fielding customer support requests and advising customers about new services. If the test is successful, your team will pursue further development to implement more sophisticated features. You have several important factors that will inform your decision-making process:

- The initial development of the bot should be in a low-code designer.
- The test bot should include an existing LUIS app for language understanding that is trained to recognize financial industry terms and phrases.
- The bot will be hosted on the company website.
- After testing, your team will integrate several C# libraries to extend functionality.
- You need to integrate your bot with a pre-existing REST-enabled FAQ application.

## Which service should you choose?

Power Virtual Agents bots use topics to inform conversational flow. You can create and edit topics that provide responses to user input, based on one or more trigger phrases associated with a topic. Power Virtual Agents chatbots can be published to a website or the Power Apps portal. You can add Power Virtual Agents bots to Azure Bot Service channels, Microsoft Teams, Facebook, or to mobile or custom apps.

For the test bot, all development must be performed in a low-code designer, which Power Virtual Agents supports. Power Virtual Agent also support connection to REST APIs through Power Automate connectors, though you would likely need to create a custom connector, depending on the FAQ application that's being used.

## Why not choose Power Virtual Agents?

The second requirement for the test bot involves integration with a LUIS app. While Power Virtual Agents does have its own natural language understanding capabilities, it doesn't support direct integration with LUIS in the low-code designer. Power Virtual Agents also doesn't fulfill the requirement for code-based integration of the C# libraries our development team requires. While you can import skills created using the Bot Framework SDK, you can't work directly with the source code of a Power Virtual Agents bot.
