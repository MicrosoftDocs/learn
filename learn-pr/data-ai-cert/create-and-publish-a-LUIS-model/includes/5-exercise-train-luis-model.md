We're now ready to train our model. 

1. Click **Train** in the top-right bar. This action builds a model to do utterance –> intent mapping with the training data you’ve provided. 

    > [!TIP]
    > Training is not always immediate. Sometimes, it gets queued and can take several minutes.
    
1. Once training is complete, click on **Manage** in the top bar. You’ll have several options on the left side of the window (Application Information, Keys, and Endpoints, Publish Settings, Versions, Collaborators).
1. Click **Keys and Endpoints**.

1. Notice there's a **Starter_Key** available for you to use for testing. If you want to use your LUIS service created in the Optional Exercise earlier, choose **+ Assign Resource** and follow the steps to assign the key from that service.

1. Leave the endpoint slot as **Production**. Then click **Publish** in the top bar. You can publish to your "Production" or "Staging" endpoint - select "Production", and read about the reasons for the two endpoints.

1. Click **Publish**.

    ![Publish the LUIS model to Production](../media/5-exercise-train-luis-model-publish.png)

    Publishing creates an endpoint to call the LUIS model. The URL will be displayed. For now, you can copy the Endpoint URL and add it to your list of keys for future use if needed.

1. Click on **Test** in the top-right bar. Try typing a few utterances and see the intents returned.
    - Show me pictures of a local beach - returns SearchPics intent with a score of 0.989, which means a positive match
    - Hello - returns Greeting with a score of 0.970 for a fairly positive match there
    - Send to Tom - returns SearchPics with a lower score of 0.113.   Seems like an issue has been identified.
    
1. Click **Inspect** next to the utterance "Send to Tom".
1. Click **Edit** next to Top scoring Intent.
1. From the **Assign to Intent** drop-down, select **OrderPic**.
1. Click the **Train** button to retrain your model.
1. Notice that the utterance of Send to Tom has now been changed to show the Intent of OrderPic with a score of 0.901.

Your LUIS app is now ready to be consumed by client applications, tested in a browser through the endpoint listed, or integrated into a Bot.