Let's update our function implementation to call the Text Analytics API service and get back a sentiment score.

1. Select our function, [!INCLUDE [func-name-discover](./func-name-discover.md)], in our function app in the portal.

1. From the QueueTrigger1 dropdown, select **index.js** to open the code file in the editor.

1. Replace the entire content of **index.js** with the following JavaScript, and select **Save**.

    [!code-javascript[](../code/discover-sentiment-sort.js?highlight=7)]

1. Update the value of `accessKey` in the code you pasted with the access key for the Text Analytics API that you saved earlier in this module. 

1. Update the `uri` value with the region from which you obtained your access key.

Let's look at what's happening in this code:

- Each call to the Text Analytics service, needs the access key, which we add as the `Ocp-Apim-Subscription-Key` header. 
- Each call is made to a region-specific endpoint, defined by `uri` in our code.
- At the bottom of the code file, we've defined a `documents` array. This array is the payload we send to the Text Analytics service.
- The `documents` array has a single entry in this case, which is the queue message that triggered our function. Although we only have one document in our array, it doesn't mean that our solution can only handle one message at a time. The Azure Functions runtime retrieves and processes messages in batches, calling several instances of our function *in parallel*. Currently, the default batch size is 16 and the maximum batch size is 32.
- The `id` must be unique within the array. The `language` property specifies the language of the document text.
- We then call our method `get_sentiments`, which uses the HTTPS module to make the call to Text Analytics API. Notice that we pass our subscription, or access, key in the header of every request.
- When the service returns, our `response_handler` is called, and we log the response to the console using `context.log`

## Try it out

Before we look at sorting into queues, let's take what we have for a test run.

1. With our function, [!INCLUDE [func-name-discover](./func-name-discover.md)], selected in the Function Apps area of the portal, select **Test/Run**, and verify that you have the test panel open.

1. From the **Input** tab, add a string of text into the request body as shown in the screenshot.

    ![Screenshot showing the function Test Panel expanded.](../media/test-panel-open-small.png)

1. Select **Run** at the bottom of the test panel.

1. Make sure the **Logs** tab is expanded at the bottom left of the main screen, under the code editor.

1. Verify that the **Logs** tab displays log information that the function completed. The window will also display the response from the Text Analytics API call.

    ![Screenshot showing Test Panel and result of a successful test.](../media/sentiment-response-log1.png)

Congratulations! The [!INCLUDE [func-name-discover](./func-name-discover.md)] works as designed. In this example, we passed in a very upbeat message and received a score of over 0.98. Try changing the message to something less optimistic, rerun the test, and note the response.

## Add a message to the queue

Let's repeat the test. This time, instead of using the Test window of the portal, we'll actually place a message into the input queue and watch what happens.

1. Navigate to your resource group in the **Resource groups** section of the portal.

1. Select <rgn>[sandbox resource group name]</rgn>, the resource group used in this lesson.

1. In the **Resource group** panel that appears, locate the Storage Account entry, and select it.

    ![Screenshot storage account selected in the Resource Group window](../media/select-storage-account.png)

1. Select **Storage Explorer (preview)** from the left menu of the Storage Account main window. This action opens the Azure Storage Explorer inside the portal.

    ![Screenshot of Storage Explorer showing our storage account, with no queues currently.](../media/sa-no-queue.png)

    As you can see, we don't have any queues in this storage account yet, so let's add one.

1. If you remember from earlier in this lesson, we named the queue associated with our trigger **new-feedback-q**. Right-click the **QUEUES** in the Storage Explorer, and select *Create queue*.

1. In the **Queue** dialog that opens, in the **Queue name** field, enter **new-feedback-q**, and then select **OK**. We now have our input queue.

1. Select the new queue in the left-hand menu to see the data explorer for this queue. As expected, the queue is empty. Let's add a message to the queue using the **Add message** command at the top of the window.

1. In the **Add Message to queue** dialog, enter "This message came from our input queue, new-feedback-q" into the **Message text** field, and select **OK** at the bottom of the dialog.

1. Observe the message, similar to the message in the following screenshot, in the data explorer.
    ![Screenshot of Storage Explorer showing our storage account, with the message we created in the queue.](../media/message-in-input-queue.png)

1. After a few seconds, select **Refresh** to refresh the view of the queue. Observe that the queue is **empty** once again. Something must have read the message from the queue.

1. Navigate back to our function in the portal, and open the **Monitor** tab. Select the newest message in the list. Observe that our function processed the queue message we had posted to the new-feedback-q. Results may be delayed in this log, so you might have to wait a few minutes and hit *Refresh*.

    ![Screenshot of Monitor dashboard showing an entry that tells us that our function processed the queue message that we posted to new-feedback-q.](../media/message-in-monitor.png)

    In this test, we did a complete round trip of posting something into our queue and then seeing the function process it.

We're making progress with our solution! Our function is now doing something useful. It's receiving text from our input queue and then calling out to the Text Analytics API service to get a sentiment score. We've also learned how to test our function through the Azure portal and the Storage Explorer. In the next exercise, we'll see how easy it is to write to queues using output bindings.
