Now that you've created and published your QnA knowledge base, it's time to learn how to integrate it with a bot. In this exercise, you'll create a web-based chatbot on the Azure portal and integrate it with the QnA Maker knowledge base you created earlier.

## Search for Web App Bot

1. Sign in to the [Azure portal](https://portal.azure.com?azure-portal=true).
1. Select **Create a resource** in the sidebar.
1. In the Azure Marketplace search box, enter **bot**, and then select Enter.
1. Select **Web App Bot**. This will create both a web site for your bot and register your bot with Azure Bot Service.

    ![Search for bot in Marketplace and select Web App Bot](../media/5-integrate-qna-with-bot-webappbot.png)

1. Select **Create**.
1. Provide the details for the new bot, giving it a unique name, such as *yourname-bot*.
1. Select a subscription.
1. Select the resource group you used previously, such as *LearnRG*.
1. Select the **S1** pricing tier, which is the Standard tier.
1. Select **Bot Template**, select **SDK v3**, and then select **C#** for the language.

    ![Select SDK v3 and C# for the language](../media/5-integrate-qna-with-bot-sdk-choice.png)

1. Choose the **Question and Answer** template, then select the **Select** button.
1. Turn off Application Insights.
1. Use the default settings for the remaining options.
1. Select **Create**.

The Web App Bot will be ready in a few minutes. After the bot app resource is published, open the Application Settings.

![Application settings for the bot](../media/5-integrate-qna-with-bot-appsettings.png)

## Connect the bot to your QnA service

Now let's connect your bot to the QnA Maker service that you created in the previous exercises.

1. Open a new browser tab and sign in to your QnA Maker account, or open the tab where your QnA Maker service was published.
1. In the first line of the Postman sample, locate the GUID that represents the knowledge base ID and copy it.

    ![Getting the ID, endpoint, and key for the QnA service](../media/5-integrate-qna-with-bot-ID.png)

1. Switch back to the bot tab. In the Application Settings, locate **QnAKnowledgebaseId**.
1. Select **Hidden value** and paste the ID that you copied from the Postman sample.
1. Copy and paste the **QnAEndpointHostName** and **QnAAuthKey** values from the sample in the same way.
1. Select **Save**.
1. Under **Bot Management** on the left side of the window, select **Test** in Web Chat.
1. The bot should connect to your QnA Maker service.
1. Enter **What is new in v4** and press Enter. The bot should return a valid response.

![A response from the QnA Maker service](../media/5-integrate-qna-with-bot-response.png)

You've now created a QnA Maker service, published it on Azure, and created a web chatbot. You've also integrated the bot with the QnA Maker service to provide a chat-based experience that lets users interact with the Microsoft Bot Framework FAQ.