We're now ready to train our model. 

1. In the top bar, select **Train**. During training, LUIS builds a model to map utterances to intents based on the training data you’ve provided.

    > [!TIP]
    > Training is not always immediate. Sometimes it gets queued and can take several minutes.

1. After training is finished, select **Manage** in the top bar. The following options will appear on the left side of the window:

   - **Application information**
   - **Keys and endpoints**
   - **Publish settings**
   - **Versions**
   - **Collaborators**

1. Select **Keys and endpoints**.
1. A **Starter_Key** is available for you to use for testing. To use the LUIS service resource that you created in the optional exercise earlier, select **+ Assign Resource**. Follow the steps to assign the subscription key from that resource.
1. Leave the endpoint slot set to **Production**. In the top bar, select **Publish**.

   > [!NOTE]
   > You can publish to your **Production** or **Staging** endpoint. Select **Production**, and read about the reasons for the two endpoints.

1. Under **Publish this app**, select **Publish**.

    ![Publish the LUIS model to the Production endpoint](../media/5-exercise-train-luis-model-publish.png)

    Publishing creates an endpoint to call the LUIS model. The endpoint URL will be displayed. Copy the endpoint URL and add it to your list of keys for future use.

1. In the top bar, select **Test**. Try typing a few utterances and see which intents are returned. Here are some examples you can try:

   | Utterance | Result | Score meaning |
   |---------|---------|---------|
   | **Show me pictures of a local beach** | Returns the **SearchPics** intent with a score of 0.989 | Positive match |
   | **Hello** | Returns the **Greeting** intent with a score of 0.970 | Fairly positive match |
   | **Send to Tom** | Returns the **SearchPics** intent with a score of 0.113 | Needs retraining |

To retrain the model for utterances with low scores, take the following steps:

1. Beside the low-scoring utterance (in this case, **Send to Tom**), select **Inspect**.
1. Beside **Top-scoring intent**, select **Edit**.
1. From the **Assign to intent** list, select **SharePic**.
1. Select the **Train** button to retrain your model.
1. Test the **Send to Tom** utterance again. It should now return the **SharePic** intent with a score of 0.901.

Your LUIS app is now ready to be used by client applications, tested in a browser through the listed endpoint, or integrated into a bot.