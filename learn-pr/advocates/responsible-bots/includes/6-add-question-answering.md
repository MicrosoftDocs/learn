Our bot can now handle a few specific requests, but it would be nice to give the bot the ability to answer general questions about geography terminology, like a simple encyclopedia. We could use LUIS to create this functionality by creating separate intents, but there's an easier way. We'll use a separate service in Azure Cognitive Services, **[QnA Maker][QAMaker]**, to handle this scenario.

## Train your QnA Maker model

As we did with LUIS, when we add the QnA Maker service to our bot, the first thing we do is train the service by using our specific data. To begin training QnA Maker, go to [https://qnamaker.ai](https://qnamaker.ai?azure-portal=true) and sign in by using your Microsoft account.

Our first step is to create a new knowledge base. Select **Create a new knowledge base** in the top menu.

> [!div class="mx-imgBorder"]
> ![Screenshot of the QnA Maker My knowledge bases pane, with the Create a new knowledge base link in the top menu selected.](../media/qna-maker-create-knowledge-base.png)

For **step 1**, select the **Create a QnA service** button. A new browser window opens in the Azure portal.

In the portal, select or enter the following information for the new QnA Maker service:

1. Enter a name for the service. Our example is **myquestionservice**.
1. For this module, you can select the **F0 (free)** pricing tier.
1. Select the same resource group we have been using for the bot.
1. For the Azure Search pricing tier, select **F (3 indexes)**.
1. Select relevant locations for Azure Search and Azure Web App. Preferably, select the same location you used when you created other bot components.
1. Enter an app name. Our example is **myquestionservice**.
1. For **App insights**, select **Disable**.

> [!div class="mx-imgBorder"]
> ![Screenshot of the QnA Maker Create pane that shows information to select or enter.](../media/qna-maker-create-service.png)  

For **step 2**, return to the browser window that displays QnA Maker and continue to create your QnA Maker service:

1. Select **Refresh** to view your newly created service.
1. Select your existing tenant (Azure Active Directory directory ID), subscription, and Azure QnA Maker service names.
1. For the language to use for information extraction, select **English**.

    > [!NOTE]
    > Some languages that are available in **Language**  support *chit-chat* functionality, which refers to general conversation functionality. For other languages, only information extraction and basic QnA functionality is available. For the purpose of this module, let's select English as the most supported language.

> [!div class="mx-imgBorder"]
> ![Screenshot of the QnA Maker Connect your QnA service to your KB pane that shows options to select](../media/qna-maker-create-2.png)

For **step 3**, enter a name for your database. Our example is **qnadb**.

For **step 4**, you can provide data sources. If you have an FAQ available, either in the form of an electronic document or a page on the web, you can enter the information here and the service can automatically index it. In our case, let's skip this step; we'll manually provide questions and answers later through a web interface.

*Chit-chat*

You can enable chit-chat functionality for your service. However, even without adding chit-chat, the bot supports some general conversation, such as greeting the user and saying goodbye.

> [!NOTE]
> General conversation capability plays an important role in responsible conversational UI because it helps build trust with the user and helps maintain a degree of emotional connection with the user.

*Personality*

We can select among different **personalities** for our general chat. We'll select **enthusiastic** because it corresponds well with our goal and target audience.

In QnA Maker, chit-chat prepopulates our knowledge base with a set of potential common questions and possible answers. Thus, the personality we select affects our initial set of phrases. You can change the personality and the phrases later, if you want to.

> [!NOTE]
> Choosing a bot's personality is an important step. In selecting the personality, we need to keep in mind potential diversity in the target audience. In QnA Maker, the bot can't easily switch personalities during a conversation. If you anticipate that your bot will talk to different audiences and different personalities are required, we recommend that you take a look at [Project Personality Chat][ProjectPersonalityChat].

Select **Create**. The knowledge base editing page opens.

> [!div class="mx-imgBorder"]
> ![Screenshot of the QnA Maker knowledge base editor.](../media/qna-maker-knowledge-base.png)

In the **Knowledge base** pane, you can see a chit-chat knowledge base that's prepopulated by using information from the *qna_chitchat_Enthusiastic.tsv* file. In the UI, you can edit all questions and answers. You can even provide a question (or a set of possible questions) and a corresponding answer.

Let's add some geography terminology to this knowledge base. In the task bar, select **+**:

> [!div class="mx-imgBorder"]
> ![Screenshot of the QnA Maker knowledge base editor, showing how to edit questions and answers, with the plus button highlighted.](../media/qna-maker-add-knowledge-base-host.png)

Let's add questions about definitions of the terms *country* and *capital*. You can provide more specific question-and-answer functionality for the problem domain of geography, but to demonstrate the UI, we'll use just two examples (shown in the following image).

When you've added some data, select **Save and train**. Then, select **Test** to see your model in action. A chat dialog opens, and you can enjoy the conversation right in QnA Maker. To see the detailed QnA Maker response to your query, including the probability of the selected answer, in the dialog pane on the left, select **Inspect**. You also can provide feedback to improve the accuracy of the model.

> [!div class="mx-imgBorder"]
> ![Screenshot of the QnA Maker Edit pane, with a question and answer about the meaning of the word "capital" and the Inspect button highlighted.](../media/qna-maker-test.png)

When you're finished adding data and training the model, select **Publish**. The model is published in the cloud.

> [!div class="mx-imgBorder"]
> ![Screenshot of the QnA Maker Publish tab, with the Publish button highlighted.](../media/qna-maker-publish.png)

When publishing (deployment) is successful, QnA Maker displays details about how to access the service.

> [!div class="mx-imgBorder"]
> ![Screenshot of the QnA Maker Success pane, with details about the deployment and how to access it.](../media/qna-maker-published.png)

> [!NOTE]
> The **Create a Bot** button on this final pane begins the process of creating a bot that is tied to the QnA Maker service. In fact, using QnA Maker probably is the easiest way to get a bot up and running in the cloud. Even a bot without sophisticated functionality can implement responsible UI!

## Add the QnA Maker model to your bot

In our case, we already have a working bot; we just want to add QnA Maker functionality to handle chit-chat and question answering in the bot we already created. This process is  similar to adding a LUIS recognizer.

In the final pane, after publishing your QnA Maker model, QnA Maker displayed these details of the deployed service:

```output
POST /knowledgebases/<knowledge_base_id>/generateAnswer
Host: https://<your_service_name>.azurewebsites.net/qnamaker
Authorization: EndpointKey <endpoint_key>
Content-Type: application/json
{"question":"<Your question>"}
```

From this text, you need the following three parameters:

- **Knowledge base ID**: The sequence of numbers that follow `POST /knowledgebases/`.
- **Endpoint key**: The sequence of numbers after `Authorization: EndpointKey`.
- **Host name**: The URL that follows `Host:`.

You add this information to the *appSettings.json* file. Anywhere in that file, paste the following code, using the values provided on the final pane in QnA Maker:

```json
"QnAKbId": "<your knowledge base id>",
"QnAEndpointKey": "<your qna maker endpoint key>",
"QnAHostname": "<your qna maker url>"
```

Next, we need to make some changes to the application code:

1. In the bot project in Visual Studio, use NuGet to add `Microsoft.Bot.Builder.AI.QnA` to the project, similar to how we added LUIS in the previous unit.
1. Open `Startup.cs`, locate the `ConfigureServices` function, and then insert the following code below the code that adds the LUIS recognizer:

   ```csharp
   services.AddSingleton(sp =>
       {
           return new QnAMaker(
               new QnAMakerEndpoint
               {
                   EndpointKey = Configuration["QnAEndpointKey"],
                   Host = Configuration["QnAHostname"],
                   KnowledgeBaseId = Configuration["QnAKbId"],
               },
               new QnAMakerOptions
               {
                   ScoreThreshold = 0.9f,
                   Top = 1,
               });
       });
   ```

   To make the code compile, add `using Microsoft.Bot.Builder.AI.QnA;` to the top of the file. The easiest way to make this change to the file is to go to parts of code that show errors (`QnAMaker` or `QnAMakerEndpoint`). Select the light bulb icon that appears next to it.
1. Open `Bots\EchoBot.cs` and add the following line to the class to define the local variable for the QnA Maker instance:

   ```csharp
   QnAMaker QnA;
   ```

1. To add the `QnAMaker QnA` parameter to the `EchoBot` constructor, add the following line inside the constructor:

   ```csharp
   this.QnA = QnA;
   ```

1. Finally, let's change our message processing code to use our QnA Maker model if the LUIS recognizer probability isn't high enough:

   ```csharp
   protected override async Task OnMessageActivityAsync(ITurnContext<IMessageActivity> turnContext, CancellationToken cancellationToken)
   {
       var res = await rec.RecognizeAsync(turnContext, cancellationToken);
       var (intent, luis_score) = res.GetTopScoringIntent();
       var ans = await QnA.GetAnswersAsync(turnContext);
       var qna_score = ans == null || ans.Count() == 0 ? 0.0 : ans[0].Score;
       if (luis_score>0.3 && luis_score>qna_score)
       {
           await ProcessLuisResult(turnContext, intent, res.Entities);
       }
       else
       {
           if (ans == null || ans.Count() == 0)
           {
               await turnContext.SendActivityAsync("I am not sure I understand you fully");
           }
           else
           {
               await turnContext.SendActivityAsync(ans[0].Answer);
           }
       }
   }
   ```

   The logic here is clever because we need to understand subtle differences between phrases. For example, the phrase *What is a capital?* should be answered via QnA Maker. The phrase *What is a capital or France?* is answered via LUIS and our bot code. In our code, we call both LUIS and QnA Maker, and then select the service that gives us the higher score. We display the corresponding result.

> [!TIP]
> For help putting the code in the right place in the *appSettings.json* file, you can [view the complete project code][CodeQnA].

At this point, you can run the project and test it by using Bot Emulator.

## Try the bot

The bot we have created so far already seems quite intelligent. Here's a sample conversation I had with the bot I created:

What is a capital?

*A capital is the city or town that functions as the seat of government and administrative center of a country or region.*

What is a capital of Russia?

*The capital of Russia is Moscow.*

How are you?

*Awesome! Thanks for asking.*

## What's next?

We've got a pretty useful, fun bot now! As our final step, let's reexamine some of the responsible conversational AI principles to make sure we're creating a responsible bot!

[QAMaker]: https://docs.microsoft.com/azure/cognitive-services/qnamaker/
[ProjectPersonalityChat]: https://www.microsoft.com/research/project/personality-chat/
[CodeQnA]: https://github.com/MicrosoftDocs/mslearn-responsible-bots/blob/t3-qna/src/Bots/EchoBot.cs?azure-portal=true
