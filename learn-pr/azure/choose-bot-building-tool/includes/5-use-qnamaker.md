In your scenario, the financial services company you work for wants to create a bot to test core functionality for fielding customer support requests and advising customers about new services. If the test is successful, your team will pursue further development to implement more sophisticated features. You have several important factors that will inform your decision-making process:

- The initial development of the bot should be in a low-code designer.
- The test bot should include an existing LUIS app for language understanding that is trained to recognize financial industry terms and phrases.
- The bot will be hosted on the company website.
- After testing, your team will integrate several C# libraries to extend functionality.
- You need to integrate your bot with a pre-existing REST-enabled FAQ application.

## Which service should you choose?

To create a bot With QnA Maker, you must first create a QnA Maker knowledgebase using source documents and websites containing FAQ-type information. After the knowledgebase is published, you can publish a bot based on the knowledgebase to an Azure Bot Service bot. You can connect to the bot using Bot Service channels, or publish the bot to an Azure Web App.

Examining our requirements, a QnA Maker bot can be published to a web page. You can download a QnA Maker bot source code and modify it using your IDE of choice. Since QnA Maker bots can be created using C# source code, your development team could extend bot functionality in many ways, including incorporating the required C# libraries. Code-based design also enables your developers to integrate your both the REST-enabled FAQ application.

## Why not choose QnA Maker?

The QnA Maker portal doesn't offer low-code bot modification possibilities, which violates one of your key requirements. If you needed to modify your bot to meet test requirements, you would have to edit the bot source code. In addition, LUIS integration, while possible with a QnA Maker bot, can only be implemented by modifying the bot source code.
