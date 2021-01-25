
We're now ready to train our model. In this exercise, you will perform a simple training operation in order to test your model.  The testing will take place using the built-in testing panel in the LUIS portal.

1. In the top bar, select **Train**. During training, LUIS builds a model to map utterances to intents based on the training data you’ve provided.

    > [!TIP]
    > Training is not always immediate. Sometimes it gets queued and can take several minutes.

## Create a public endpoint for the LUIS service

1. After training is finished, select **Manage** in the top toolbar. The following options will appear on the left toolbar:

    > [!NOTE]
    > The categories on the left pane may change as the portals are updated.  As a result, the keys and endpoints may fall under a different category than the one listed here.
    
    - **Settings**
    - **Publish settings**
    - **Azure Resources**
    - **Versions**

1. Select **Azure Resources**. This screen is used to manage the URL endpoints used to access the LUIS service.

    > [!NOTE]
    > An endpoint named **Starter_Key** is automatically created for testing purposes, and you could use that here - however to use the service in a production environment or inside of an application, you will always want to tie it to a real Language Understanding resource created in Azure.

1. You should see a **Prediction Resource** with the name of the resource you created in the Azure portal, along with two keys.  If you see the **Prediction Resource**, advance to the next section on **Publish the app**.
1. If you do not see an existing **Prediction Resource**, select **Add prediction resource**. The **Tenant** will already be selected.
1. Select your subscription, and the resource you created in the Azure portal earlier and then select **Done** to connect the Language Understanding resource to the LUIS service.

## Publish the app

1. In the top toolbar, select **Publish**.

   > [!NOTE]
   > You can publish to your **Production** or **Staging** endpoint. Select **Production**, and read about the reasons for the two endpoints.

1. Under **Choose your publishing slot and settings**, select **Production Slot** and then select **Done**.

    Publishing creates an endpoint to call the LUIS model. The endpoint URL will be displayed. Copy the endpoint URL and add it to your list of keys for future use.

1. In the top bar, select **Test**. Try typing a few utterances and see which intents are returned. Here are some examples you can try:

   | Utterance | Result | Score meaning |
   |---------|---------|---------|
   | **Show me pictures of a local beach** | Returns the **SearchPics** intent with a score | Positive match |
   | **Hello** | Returns the **Greeting** intent with a score | Fairly positive match |
   | **Send to Tom** | Returns an with a low score | Needs retraining or doesn't match any intents |

To retrain the model for utterances with low scores, take the following steps:

1. Beside the low-scoring utterance (in this case, **Send to Tom**), select **Inspect**.
1. Beside **Top-scoring intent**, select the drop-down and choose **SharePic** from the list.
1. Close the **Test** panel.
1. Select the **Train** button to retrain your model.
1. Test the **Send to Tom** utterance again. It should now return the **SharePic** intent with a higher score.

Your LUIS app is now ready to be used by client applications, tested in a browser through the listed endpoint, or integrated into a bot.
