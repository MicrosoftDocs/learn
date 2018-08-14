### Exercise 6: Test the bot with Skype

Once deployed, bots can be connected to channels such as Skype, Slack, Microsoft Teams, and Facebook Messenger, where you can interact with them the way you would with a person. In this exercise, you will add the bot to your Skype contacts and carry on a conversation with it in Skype.

1. If Skype isn't already installed on your computer, please install it now. You can download Skype for Windows, macOS, and Linux from https://www.skype.com/en/download-skype/skype-for-computer/.

1. Return to your Web App Bot in the Azure Portal and click **Channels** in the menu on the left. Click the **Skype** icon. Then click **Cancel** at the bottom of the blade.

    ![Editing the Skype channel](../images/portal-edit-skype.png)

    _Editing the Skype channel_
 
1. Click **Skype**. Then click **Add to Contacts** to add the bot as a Skype contact and launch Skype.

	![Connecting to Skype](../images/portal-click-skype.png)
	
	_Connecting to Skype_
 
1. Start a conversation with by typing "hi" into the Skype window. Then converse with the bot by asking it questions and seeing how it responds. Refer to the **Factbot.tsv** file that you used to populate the knowledge base in [Exercise 2](#Exercise2) for examples of questions to ask.
 
    ![Chatting with the bot in Skype](../images/skype-responses.png)

    _Chatting with the bot in Skype_

You now have a fully functional bot created with the Azure Bot Service, infused with intelligence by Microsoft QnA Maker, and available for anyone in the world to interact with. Feel free to plug your bot into other channels and test it in different scenarios. And if you would like to make the bot smarter, consider expanding the knowledge base with additional questions and answers. For example, you could use the [online FAQ](https://docs.microsoft.com/azure/bot-service/bot-service-resources-bot-framework-faq?view=azure-bot-service-3.0) for the Bot Framework to train the bot to answer questions about the framework itself.