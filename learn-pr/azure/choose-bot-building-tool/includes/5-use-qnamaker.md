

## Which service should you choose?

To create a bot With QnA Maker, you must first create a QnA Maker knowledge base using source documents and websites containing FAQ-type information. After the knowledge base is published, you can publish a bot based on the knowledge base to an Azure Bot Service bot. You can connect to the bot using Bot Service channels, or publish the bot to an Azure Web App.

Examining our requirements, a QnA Maker bot can be published to a web page. You can download a QnA Maker bot source code and modify it using your IDE of choice. Since QnA Maker bots can be created using C# source code, your development team could extend bot functionality in many ways, including incorporating the required C# libraries. Code-based design also enables your developers to integrate your both the REST-enabled FAQ application.

## Why not choose QnA Maker?

The QnA Maker portal doesn't offer low-code bot modification possibilities, which violates one of your key requirements. If you needed to modify your bot to meet test requirements, you would have to edit the bot source code. In addition, LUIS integration, while possible with a QnA Maker bot, can only be implemented by modifying the bot source code.
