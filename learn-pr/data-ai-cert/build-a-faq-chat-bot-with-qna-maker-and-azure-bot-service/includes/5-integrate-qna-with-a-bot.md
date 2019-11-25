Now that you've created and published your QnA knowledge base, it's time to learn how to integrate it with a bot. In this exercise, you'll create a chatbot on the Azure to integrate with the QnA Maker knowledge base you created earlier.

1. In the QnA Maker portal, go to the Publish page, and publish your knowledge base, if it is not already published. 
1. Select Create Bot.  The Azure portal opens with the bot creation configuration.
1. Enter the settings to create the bot:
    1. Give your bot an appropriate name
    1. Choose the Subscription service you have been using for this course
    1. Select the proper Resource Group
    1. Choose the location for the bot.  Remember that it's best to use the same location as your other services
    1. Select **F0** pricing tier
    1. The app name should auto-populate
    1. Choose **C#** as the SDK language
    1. Leave the remaining fields at their default.
1. Click Create.  In a few minutes, your bot should be created.

## Chat with the Bot

1. In the Azure portal, open the new bot resource from the notification.
1. From Bot management, select Test in Web Chat and test the QnA by asking the bot questions