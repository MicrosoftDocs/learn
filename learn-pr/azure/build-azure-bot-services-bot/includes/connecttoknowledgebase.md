### Exercise 5: Connect the bot to the knowledge base

In this exercise, you will connect your bot to the QnA Maker knowledge base you built earlier so the bot can carry on an intelligent conversation. Connecting to the knowledge base involves retrieving some information from the QnA Maker portal, copying it into the Azure portal, updating the bot code, and then redeploying the bot to Azure.

1. Return to the [QnA Maker portal](https://www.qnamaker.ai/) and click your name in the upper-right corner. Select **Manage endpoint keys** from the menu that drops down. Click **Show** to show the primary endpoint key, and **Copy** to copy it to the clipboard. Then paste it into a text file so you can easily retrieve it in a moment.

	![Copying the endpoint key](../images/copy-primary-key.png)
	
	_Copying the endpoint key_ 

1. Click **My knowledge bases** in the menu at the top of the page. Then click **View Code** for the knowledge base that you created earlier.

	![Opening the knowledge base](../images/open-knowledge-base.png)

	_Opening the knowledge base_

1. Copy the knowledge base ID from the first line and the host name from the second line and paste them into a text file as well. Then close the dialog. **Do not** include the "https://" prefix in the host name that you copy.

	![Copying the knowledge base ID and host name](../images/copy-endpoint-info.png)
	
	_Copying the knowledge base ID and host name_  

1. Return to the Web App Bot in the Azure portal. Click **Application settings** in the menu on the left and scroll down until you find application settings named "QnAKnowledgebaseId," "QnAAuthKey,", and "QnAEndpointHostName." Paste the knowledge base ID and host name obtained in Step 3 and the endpoint key obtained in Step 1 into these fields. Then click **Save**.

    ![Editing application settings](../images/enter-app-settings.png)

    _Editing application settings_ 
 
1. Return to Visual Studio Code and replace the contents of **app.js** with the code below. Then save the file.

	```JavaScript
	var restify = require('restify');
	var builder = require('botbuilder');
	var botbuilder_azure = require("botbuilder-azure");
	var builder_cognitiveservices = require("botbuilder-cognitiveservices");
	
	// Setup Restify Server
	var server = restify.createServer();
	server.listen(process.env.port || process.env.PORT || 3978, function () {
	   console.log('%s listening to %s', server.name, server.url); 
	});
	  
	// Create chat connector for communicating with the Bot Framework Service
	var connector = new builder.ChatConnector({
	    appId: process.env.MicrosoftAppId,
	    appPassword: process.env.MicrosoftAppPassword     
	});
	
	// Listen for messages from users 
	server.post('/api/messages', connector.listen());
	 
	// Create your bot with a function to receive messages from the user
	var bot = new builder.UniversalBot(connector);
	
	var recognizer = new builder_cognitiveservices.QnAMakerRecognizer({
	    knowledgeBaseId: process.env.QnAKnowledgebaseId, 
	    authKey: process.env.QnAAuthKey,
	    endpointHostName: process.env.QnAEndpointHostName
	});
	
	var basicQnAMakerDialog = new builder_cognitiveservices.QnAMakerDialog({
	    recognizers: [recognizer],
	    defaultMessage: "I'm not quite sure what you're asking. Please ask your question again.",
	    qnaThreshold: 0.3
	});
	
	bot.dialog('basicQnAMakerDialog', basicQnAMakerDialog);
	
	bot.dialog('/',
	[
	    function (session) {
	        session.replaceDialog('basicQnAMakerDialog');
	    }
	]);
	```

	Note the call to create a ```QnAMakerDialog``` instance on line 30. This creates a dialog that integrates a bot built with the Azure Bot Service with a knowledge base built Microsoft QnA Maker.
 
1. Click the **Source Control** button in the activity bar in Visual Studio Code. Type "Connected to knowledge base" into the message box, and click the check mark to commit your changes. Then click the ellipsis and use the **Publish Branch** command to push these changes to the remote repository (and therefore to the Azure Web App).

1. Return to the Web App Bot in the Azure portal and click **Test in Web Chat** on the left to open the test console. Type "What's the most popular software programming language in the world?" into the box at the bottom of the chat window and press **Enter**. Confirm that the bot responds as follows:

    ![Testing the bot](../images/portal-testing-chat.png)

    _Testing the bot_

Now that the bot is connected to the knowledge base, the final step is to test it in the wild. And what could be wilder than testing it with Skype?