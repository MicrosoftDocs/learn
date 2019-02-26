Let's start by creating a new QnA Maker knowledge base (KB).

1. Navigate to the [QnA Maker portal](https://www.qnamaker.ai/?azure-portal=true).
1. Click the "Sign in" button in the top-right corner and sign in with your Azure credentials.
1. Assuming you have no existing knowledge bases, the portal will indicate you have no existing knowledge bases yet

    ![Web portal for QnA Maker with no existing knowledge bases](../media/3-exercise-create-qna-kb-portal.png)

1. In the top nav bar, click **Create a knowledge base**
1. Click the **Create a QnA service** button. This will navigate into the Azure portal using your same credentials to create the QnA Maker service and associated Azure App Service that will host it.

> [!NOTE]
> You can create a QnA Service in the Microsoft Azure Portal prior to creating a knowledge base as well.

## Fill in the QnA Maker service details

Fill out the details to create the Qn Maker service.

1. Enter a unique name for your QnA Service.
1. Choose your subscription.
1. Select the **F0** _pricing tier_ for this service.
1. Select a location for this service.
1. Create a new Resource Group called **LearnRG**.
1. Select **F (three Indexes)** for the _Search pricing tier_.
1. Choose the same location for the _search location_.
1. Verify the App name is unique (has a green check mark).
1. Select the location for the Website.
1. You won't be making use of App Insights for this test so disable **App insights**.
1. Click **Create**.

After a brief deployment process, your resource should be created for this service.

## Connect the QnA Service to the KB

1. Go back to the QnA web portal tab and refresh the page.
1. The page will refresh but the entries under **Step 2** won't be filled in, only a link to the account information has been populated.
1. Select your Azure Directory ID, subscription name, and Azure QnA Service (your newly created service name).
1. In **Step 3**, give your knowledge base a name.  In this case, we will use the Microsoft Bot FAQ so you can name it **BotFAQ**.

We need some data for our QnA service. We'll use an existing FAQ as a sample.

1. Download the Microsoft Bot FAQ [zip file](https://github.com/MicrosoftDocs/mslearn-work-with-vision-cognitive-services/blob/master/Microsoft%20Bot%20FAQ.zip?raw=true) and extract it to your local computer.
1. In **Step 4** of the QnA web portal process, click **+ Add file**, locate your extracted Word document from the previous step, and add it as a source to populate your KB.
1. Select **The Professional** under _Chit-chat_ to add a pre-defined personality to your KB.
1. Click **Create your KB**.

After a short time, your KB will be created and the Edit page will load.

## Test your KB

1. To get an idea as to how a Bot may respond to questions, click **Test** in the upper right corner.
1. A test panel opens waiting for you to enter a question.
1. Type "Hello" and press Enter. 
    1. QnA should respond with Hello.
1. Type "when will v3 retire?" and press Enter.
    1. QnA responds with a message regarding Vs updates and release information.
1. Type in "what is included in v4?" and press Enter and see how it responds.

You can continue to test the interaction by asking questions and evaluating the responses to get an idea as to how the QnA KB is being polled for answers.