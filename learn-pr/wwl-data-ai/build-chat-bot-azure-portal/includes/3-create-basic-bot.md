Creating a basic bot is a relatively easy task in the Azure portal. This exercise will demonstrate how to create an echo bot using the Azure portal.  You will test the bot using the web chat test interface.  The web chat test is an easy way to see how a simple text chat interacts with a bot.

There are many activities that are taking place behind the scenes so the exercise will also demonstrate how to download the source code for the bot.  The source code can help to evaluate the activities that are taking place in the bot interaction.  They also offer insight into the activity handling mechanisms.

## Create an echo bot in the Azure portal

This exercise requires that you have an Azure subscription.  If you do not have an existing subscription, you can [create one](https://azure.microsoft.com/free). Once you have you Azure account created, you can begin the exercise steps.

1. Sign in to the Azure portal with your account credentials.
1. On the left toolbar, select the **+ Create a resource** option.
1. In the **Search the Marketplace** text entry field, type in **Bot**.
1. Select the **Web App Bot** option from the list of services.
1. One the **Web App Bot** page, select the **Create** button.
1. Like most Azure resources, bots require unique names.  In this case, you will create a unique **bot handle**.  Choose a unique name that will help you understand the bot's purpose.  For example, **Gerry-Echo-Bot**.
1. When you move to the next field **Subscription**, Azure will check for naming issues.  If you see a check-mark in the **Bot handle** entry, your bot name is acceptable.
1. In the **Subscription** entry, you can select the appropriate subscription from the drop-down menu.  If you only have one subscription, ensure that subscription is selected.
1. Azure uses **Resource Groups** as a means to group related resources for ease of management.  Either select an existing resource group or create a new one if there are no existing groups available.  Ensure that name of the resource groups is meaningful.
1. Azure uses regions to store resources.  The proper selection for your bot should be in a region that is closest to you but that also provides the correct resource access.  Select the location that is closest to your actual location.
1. There are typically two options available in the **Pricing tier**. Ensure you select the link for **View full pricing details** to better understand how an account will be billed for the bot service.

    >[!TIP]
    >If your subscription permits, select the F0 pricing tier. Many subscription levels only support one F0 pricing tier per subscription so you may receive errors during the creation process.  If that is the case, then select the S0 option.

1. Azure picks an **App name** for you.  The name is derived from the **bot handle** you created and you can change this name if you want to, but it is best to leave it as the recommended option to ensure it will be acceptable in the Azure environment.
1. The next step is to choose the **bot template**.  The default is **Echo Bot (C#)**. Select the **Echo Bot (C#)** option to open the **Bot template** page.
1. Currently there are two **SDK language** options available for the Echo bot.  Select your **SDK language** of choice and then select the **OK** button at the bottom of the page.  The SDK language will determine the code that is used in the bot solution that you can download after bot creation.

    >[!NOTE]
    >You can review the various bot types on this page, and select the links to visit information pages for other types of bot integrations but we are only focusing on an Echo bot for this exercise.

1. Leave the **App service plan/Location** option at the default setting.
1. **Application Insights** are not required for this exercise so turn them **Off**.
1. Leave the **Microsoft App ID and password** option at its default.
1. Select the **Create** button to create your echo bot.
1. Once your bot resource is created, selected the **Go to resource**  button.  Your Echo bot opens in a new page.

## Test your bot with web chat

Azure provides a simple web chat interface to test your bot.  With an echo bot, there isn't a lot going on but you can at least see how the bot responds with your chat messages.

1. Locate the **Bot management** section in the toolbar to the left of the bot overview section.
1. Select **Test in Web Chat**.
1. Wait until the web chat bot panel opens and you see the message **Hello and welcome**.
1. Enter a message of your choice and press Enter on your keyboard, or select the arrow in the chat dialog, to send the message to the bot service.
1. Your message should be relayed back to you in the chat window.
1. When you are finished with your testing, select the **Overview** option to return to close the test window.

## Download and review the bot source code

In the following exercise, you will download the source code for the echo bot you created and evaluate the code. The intent is to familiarize you with the events and activity handling in the bot source code.

1. Ensure you are still signed in to the Azure portal.
1. Locate the echo bot you created earlier in the unit.
1. Select the **Build** option that is under the **Bot management** section.
1. Select the **Download Bot source code** button.
1. A dialog will display asking if you want to include the app settings in zip file, choose **Yes**. It will create the necessary app settings file in your source code and include the **MicrosoftAppId** and **MicrosoftAppPassword** that are necessary for the code to connect to the bot resource on Azure.
1. A message will display indicating that a zip file is being created.  When completed, another message displays with a **Download Bot source code** button.  Select that button to download the source code locally.
1. If you chose the C# template during bot creation, your download will include a complete C# solution that you can open in Visual Studio.
1. If you chose the node.js template, the downloaded source code will contain the environment and JavaScript files for the bot.
1. If you don't have Visual Studio or node installed on your computer, the main points to cover are explained here, showing the key files that contain the activities for the basic echo bot.

:::zone pivot="csharp"

```csharp
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License.

using System.Collections.Generic;
using System.Threading;
using System.Threading.Tasks;
using Microsoft.Bot.Builder;
using Microsoft.Bot.Schema;

namespace Microsoft.BotBuilderSamples.Bots
{
    public class EchoBot : ActivityHandler
    {
        protected override async Task OnMessageActivityAsync(ITurnContext<IMessageActivity> turnContext, CancellationToken cancellationToken)
        {
            var replyText = $"Echo: {turnContext.Activity.Text}";
            await turnContext.SendActivityAsync(MessageFactory.Text(replyText, replyText), cancellationToken);
        }

        protected override async Task OnMembersAddedAsync(IList<ChannelAccount> membersAdded, ITurnContext<IConversationUpdateActivity> turnContext, CancellationToken cancellationToken)
        {
            var welcomeText = "Hello and welcome!";
            foreach (var member in membersAdded)
            {
                if (member.Id != turnContext.Activity.Recipient.Id)
                {
                    await turnContext.SendActivityAsync(MessageFactory.Text(welcomeText, welcomeText), cancellationToken);
                }
            }
        }
    }
}

```

:::zone-end

:::zone pivot="javascript"

```javascript

// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License.

const { ActivityHandler, MessageFactory } = require('botbuilder');

class EchoBot extends ActivityHandler {
    constructor() {
        super();
        // See https://aka.ms/about-bot-activity-message to learn more about the message and other activity types.
        this.onMessage(async (context, next) => {
            const replyText = `Echo: ${ context.activity.text }`;
            await context.sendActivity(MessageFactory.text(replyText, replyText));
            // By calling next() you ensure that the next BotHandler is run.
            await next();
        });

        this.onMembersAdded(async (context, next) => {
            const membersAdded = context.activity.membersAdded;
            const welcomeText = 'Hello and welcome!';
            for (let cnt = 0; cnt < membersAdded.length; ++cnt) {
                if (membersAdded[cnt].id !== context.activity.recipient.id) {
                    await context.sendActivity(MessageFactory.text(welcomeText, welcomeText));
                }
            }
            // By calling next() you ensure that the next BotHandler is run.
            await next();
        });
    }
}

module.exports.EchoBot = EchoBot;
```

:::zone-end

The key takeaways from this source code are two activities that are responsible for the basic operation of the bot. When a user connects to the bot, either through the web test, bot emulator, or any of the supported channels, the **Members Added** activity is engaged.  In C#, this method is **OnMembersAddedAsync()** and in node.js, it is **onMembersAdded()**. Notice that a message is prepared (Hello and welcome). The send activity event is initiated and the message is sent to the bot interface or channel.

The other activity that is present in this source code is the **OnMessageActivitySync** for C# or the **onMessage()** for node.js. If you investigate the code in these methods, you will see that a **context** object is used to get the **activity text**.  The **activity text** is the phrase that the user enters into the chat dialog. The method will then perform string interpolation and add the word **Echo:** at the beginning, and appending the user text.  The **send activity** method will then respond to the user with this concatenated text.

When you want to have more control over your bot conversations and interactions, you will need to understand these activity and event handlers. This module is designed to introduce the creation of basic bots using the Azure portal to provide a basic understanding of bots and the interactions with them. It will lay a foundation for more advanced bot development in later training courses.
