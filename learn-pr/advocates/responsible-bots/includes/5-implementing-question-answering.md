# Implementing Question Answering

Now out bot can handle a few specific requests, but it would also be nice to give it the ability to answer general questions on geography terminology, eg. act like a simple encyclopedia. We definitely could create this functionality using LUIS by creating separate intents, but there is an easier way. There is a special cognitive service to handle this type of scenarios called **[QnA Maker][QAMaker]**.

# Training Q&A Maker Model

Similar to LUIS, when adding QnA Maker to our bot, the first thing we need to do is to train QnA Maker on our specific data. To start, go to http://qnamaker.ai and sign in with your Microsoft Account:
![QnA Maker](../media/QnAMakerCreate.png)

Next step is to create a new knowledge base by clicking on the link at the top:
![QnA Maker Create KB](../media/QnAMakerCreateKB.png)

When you click **Create QnA Service** you are taken (in a separate browser tab) to Azure Portal, where you need to fill in the parameters for newly created service:
  - Chose appropriate name for the service (I will use `myquestionservice`)
  - You can select **F0** (free) pricing tier for demo purposes
  - Select the same resource group we have been using for the bot
  - Select **F** pricing tier for Azure Search
  - Chose appropriate locations for Azure Search service and for Azure Web App. Those should preferably be the same as the location of all other bot components.
  - Chose some reasonable web app name (I will again use `myquestionservice`)
  - Disable application insights
![QnA Maker Properties](../media/QnAMakerCreateService.png)  

Go back to the browser tab with QnA Maker, and complete **Step 2** of setup:
  - Click **Refresh** button to make sure your newly created service is visible
  - Chose correct subscription, tenant and service name
  - Select the language to be used for the information extraction among those available in the dropdown boxes. Go ahead and select **English**
![QnAMaker Step 2](../media/QnAMakerCreate2.png)

>[!NOTE]
>Some languages available in the dropdown will support **chit-chat** functionality, meaning that QnA Maker will also automatically support general conversation functionality. For other languages, only information extraction and basic QnA functionality will be available. For the purpose of this module, let's select English as the most supported language.

In **Step 3**, provide a name for your database. I will use `qnadb`.

In **Step 4**, you are asked to provide data sources. If you have a FAQ availabe, either in the form of an electronic document or a page on the web, you can enter the information here and have it automatically indexed by the service. In our case, we will prefer to skip this step and provide questions and answers later on manually through web interface.

You can also enable **chit-chat** functionality to your service. It will automatically support some level of general conversation, such as greeting the user, saying goodbye's, etc. 

>[!NOTE]
>General conversation capability plays an important role in Responsible Conversational UI, because it helps to build trust with the user, as well as maintain some degree of emotional connection.

We can select among different **personalities** for our general chat. We will go ahead and select **enthusiastic**, because that corresponds well to our goal and target audience.

The way chit-chat works in QnA Maker is by pre-populating our knowledge base with a set of potential common questions and possible answers. Thus, chosen personality would affect the initial set of phrases, and we would be able to change that later on according to our liking.

>[!NOTE]
>Chosing bot's personality is an important step, because we need to keep in mind potential diversity of the target audience. In QnA Maker, it is not easy to change personality "on the fly" during conversation. If you anticipate that your bot will be talking to different audiences, and different personalities are required, I recommend having a look at [Project Personality Chat][ProjectPersonalityChat]. 

Once we finish filling all the fields and click **Create** button, we will be taken to the knowledge base editing page:
![QnA Maker KB Editor](../media/QnAMakerKB.png)

Here you can see chit-chat knowledgebase being pre-populated as `qna_chitchat_Enthusiastic.tsv` file, and you have the interface to edit all questions and answers.

Let's add some geography terminology to this knowledge base. To do this, click on **+** button located in the task bar (see it highlighted in the picture below):
![QnA Maker Add Term](../media/QnAMakerAddKBH.png)
You will see the placeholder for a new question being added, and you can provide a question (or a set of possible questions) and a corresponding answer.

Let's add questions about definition of terms *country* and *capital*. You can also provide more specific Q&A functionality for the problem domain of geography, but for the sake of demonstration I will limit myself to two examples.

Once the data has been added, click **Save and train**. After that, you can click **Test** to see your model in action. You will see a chat dialog, and can enjoy the conversation right from the browser:
![QnA Maker Test](../media/QnAMakerTest.png)

If you click on **Inspect** link (highlighted in the picture above) you will see the detailed QnA Maker response to your query, including the probability of the selected answer, and you can also provide feedback.

[QAMaker]: https://docs.microsoft.com/azure/cognitive-services/qnamaker/
[ProjectPersonalityChat]: https://www.microsoft.com/en-us/research/project/personality-chat/