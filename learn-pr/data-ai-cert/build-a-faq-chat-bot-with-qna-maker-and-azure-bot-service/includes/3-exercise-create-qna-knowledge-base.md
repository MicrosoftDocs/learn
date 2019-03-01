Let's create a QnA Maker knowledge base (KB).

1. Go to the [QnA Maker portal](https://www.qnamaker.ai/?azure-portal=true).
1. Select **Sign in** in the upper-right corner and sign in with your Azure credentials.
1. Unless you already have a knowledge base, the portal will point out that you don't have any.

    ![QnA Maker portal with no existing knowledge bases](../media/3-exercise-create-qna-kb-portal.png)

1. In the menu at the top of the portal, select **Create a knowledge base**.
1. Select **Create a QnA service**. Selecting this button takes you to the Azure portal and signs you in with the credentials you used earlier. You create the QnA Maker service and the associated Azure app service that will host it in this portal.

> [!NOTE]
> You can also create a QnA Maker service in the Azure portal before you create a knowledge base.

## Provide the QnA Maker service details

Provide these details to create the QnA Maker service:

1. Enter a unique name for your QnA Maker service.
1. Select your subscription.
1. Select the **F0** pricing tier for the service.
1. Select a location for the service.
1. Create a resource group called **LearnRG**.
1. Select **F (three Indexes)** for the search pricing tier.
1. For the search location, select the location you used earlier.
1. Verify that the app name is unique. (If it is, it'll be marked with a green check mark.)
1. Select the location for the website.
1. You won't be using Application Insights for this test, so disable **App insights**.
1. Select **Create**.

After a brief deployment process, your resource will be created for the service.

## Connect the QnA Maker service to the KB

1. Go back to the QnA Maker web portal tab and refresh the page.
1. The page will refresh. The entries under **Step 2** won't be filled in, but a link to the account information will be populated.
1. Select your Azure Directory ID and subscription name and the name of the new QnA service.
1. In **Step 3**, give your knowledge base a name. We'll use the Microsoft Bot FAQ, so you can name it **BotFAQ**.

We need some data for the QnA service. We'll use an existing FAQ as a sample.

1. Download the Microsoft Bot FAQ [zip file](https://github.com/MicrosoftDocs/mslearn-work-with-vision-cognitive-services/blob/master/Microsoft%20Bot%20FAQ.zip?raw=true) and extract it to your local computer.
1. In **Step 4** of the QnA web portal process, select **Add file**, locate the Word document that you extracted in the previous step, and add the document as a source to populate your KB.
1. Under **Chit-chat**, select **The Professional** to add a predefined personality to your KB.
1. Select **Create your KB**.

After a short time, your KB will be created and the Edit page will load.

## Test your KB

1. To get an idea of how a bot might respond to questions, select **Test** in the upper-right corner.
1. A test panel opens, ready for a question.
1. Enter **Hello** and select the Enter key. QnA will respond with "Hello."
1. Enter **when will v3 retire?** and select Enter. QnA will respond with a message about v3 updates and release information.
1. Enter **what is included in v4?** and press Enter. Read the response.

You can continue to test the interaction by asking questions and evaluating the responses to get an idea of how the QnA KB is polled for answers.