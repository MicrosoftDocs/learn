In our last exercise, we implemented a scenario to look up bookmarks in an Azure Cosmos DB database. We configured an input binding to read data from our bookmarks collection. But, we can do more. Let's expand the scenario to include writing. Consider the following flowchart:

![Flow diagram showing the process of finding a bookmark in our Cosmos DB back-end. When the Azure function receives a request with the bookmark id, it first checks whether the request is valid, if not an error response is generated. For valid requests, the function checks if the bookmark id is present in the Cosmos DB, if not present an error response is generated. If the bookmark id is found, a success response is generated.](../media/7-add-bookmark-flow-small.png)

In this scenario, we'll receive requests to add bookmarks to our collection. The requests pass in the desired key, or ID, along with the bookmark URL. As you can see in the flowchart, we'll respond with an error if the key already exists in our back end.

If the key that was passed to us is *not* found, we'll add the new bookmark to our database. We could stop there, but let's do a little more.

Notice another step in the flowchart? So far we haven't done much with the data that we receive in terms of processing. We move what we receive into a database. However, in a real solution, it is possible that we'd probably process the data in some fashion. We can decide to do all processing in the same function, but in this lab we'll show a pattern that offloads further processing to another component or piece of business logic.

What might be a good example of this offloading of work in our bookmarks scenario? Well, what if we send the new bookmark to a QR code generation service? That service would, in turn, generate a QR code for the URL, store the image in blob storage, and add the address of the QR image back into the entry in our bookmarks collection. Calling a service to generate a QR image is time consuming so, rather than wait for the result, we hand it off to a function and let it take care of this asynchronously.

Just as Azure Functions supports input bindings for various integration sources, it also has a set of output bindings templates to make it easy for you to write data to data sources. Output bindings are also configured in the *function.json* file.  As you'll see in this exercise, we can configure our function to work with multiple data sources and services.

> [!IMPORTANT]
> This exercise builds on the previous one. It uses the same Azure Cosmos DB database and input binding. If you haven't worked through that unit, we recommend doing so before you proceed with this one.

## Create an HTTP-triggered function

1. Sign into the [Azure portal](https://portal.azure.com/triplecrownlabs.onmicrosoft.com?azure-portal=true) using the same account you activated the sandbox with.

2. In the portal, navigate to the function app that you created in this module.

3. Expand your function app, then hover over the functions collection and select the Add (**+**) button next to **Functions**. This action starts the function creation process. The following animation illustrates this action.

    ![Animation of the plus sign appearing when the user hovers over the functions menu item.](../media/3-func-app-plus-hover-small.gif)

4. The page shows us the current set of supported triggers. Select **HTTP trigger**, which is the first entry in the following screenshot.

    ![Screenshot of part of the trigger template selection UI, with the TTP trigger displayed first, in the top left of the image.](../media/5-trigger-templates-small.PNG)


5. Fill out the **New Function** pane that's displayed at the right by using the following values:

    |Field  |Value  |
    |---------|---------|
    |Language     | **JavaScript**        |
    |Name     |   [!INCLUDE [func-name-add](./func-name-add.md)]     |
    | Authorization level | **Function** |
    
6. Select **Create** to create your function. This action opens the **index.js** file in the code editor and displays a default implementation of the HTTP-triggered function.

    > [!NOTE]
    > In this exercise, we'll speed up things by using the *code* and *configuration* from the previous unit as a starting point.

7. Replace all code in the **index.js** file with the code from the following snippet, and then select **Save** to save the change: 

   [!code-javascript[](../code/find-bookmark-single.js)]

   If this code looks familiar, that's because it's the implementation of our [!INCLUDE [func-name-find](./func-name-find.md)] function. As you would expect, the function won't work until we define the same bindings.  

1. Open the **function.json** file from the [!INCLUDE [func-name-add](./func-name-add.md)] function.

11. Replace the contents of this file with the following JSON:

    ```json
    {
      "bindings": [
        {
          "authLevel": "function",
          "type": "httpTrigger",
          "direction": "in",
          "name": "req"
        },
        {
          "type": "http",
          "direction": "out",
          "name": "res"
        },
        {
          "type": "documentDB",
          "name": "bookmark",
          "databaseName": "func-io-learn-db",
          "collectionName": "Bookmarks",
          "connection": "unit3test_DOCUMENTDB",
          "direction": "in",
          "id": "{id}"
        }
      ],
      "disabled": false
    }
    ```

12. Make sure to **Save** all changes.

In the preceding steps, you configured bindings for your new function by copying binding definitions from another function. Of course, you could have created a new binding through the UI, but it is good to understand that this alternative is available to you.

## Try it out

1. Select **Get function URL** at the top right, select **default (Function key)**, and then select **Copy** to copy the function's URL.

2. Paste the copied URL into your browser's address bar. Add the query string value `&id=docs` to the end of the URL, and then press Enter to execute the request. If all goes well, you should see a response that includes a URL to that resource.

So, where are we at? Well, so far we've really just replicated what we did in the previous lab. But that's okay. We're copying what we did in the last lab to serve as a starting point for this one. We'll work on the new stuff next. That is, we'll write to our database. For that, we'll need an *output binding*.

## Define Azure Cosmos DB output binding

Rather than define a new output binding by going through the user interface, you'll create this binding by updating the configuration file, *function.json*, by hand. 

1. Make sure the *function.json* file for [!INCLUDE [func-name-add](./func-name-add.md)] is open in the editor.

1. Copy the binding that's named `bookmark` in that file.

1. Place your cursor directly after the closing curly bracket (}), and right before the closing square bracket (]). Add a comma (,), and then paste the copy of the binding here. Your *function.json* config file should now look like the following:

   [!code-json[](../code/config-new-entry.json?highlight=22-31)]

1. Edit the binding you pasted, with the following changes:

    |Property   |Old value  |New value  |
    |---------|---------|---------|
    |name     |   bookmark      |  **newbookmark**       |
    |direction     |   in      |   **out**      |
    |id     |      {id}   |   **delete this property. It does not exist for the output binding.**      |

1. After you've made these changes, your file looks like the following JSON:

    [!code-json[](../code/config-q-complete.json?highlight=22-30)]

That was just a demo of how you can also create bindings directly in the configuration file. In this example, it makes sense because you are reusing the properties from another binding. That is, you're reusing the `databaseName`, `collectionName`, and `connection` that you already configured for your Azure Cosmos DB input binding.

> [!NOTE]
> The actual value of `connection` in the preceding JSON file is whatever name your connection was given when it was created.

Before we update our code, let's add one more binding that will enable us to post messages to a queue.

## Define Azure Queue Storage output binding

Azure Queue storage is a service for storing messages that can be accessed from anywhere in the world. The size of a single message can be as much as 64 KB, and a queue can contain millions of messages&mdash;up to the total capacity of the storage account in which it is defined. The following diagram shows at a high level how a queue is used in our scenario:

![An illustration showing a storage queue and two functions one pushing and the other popping messages onto the queue](../media/7-q-logical-small.png)

Here you can see that the new function, [!INCLUDE [func-name-add](./func-name-add.md)], adds messages to a queue. Another function&mdash;for example, a fictitious function called *gen-qr-code*&mdash;will pop messages from the same queue and process the request.  Since we write, or *push*, messages to the queue from [!INCLUDE [func-name-add](./func-name-add.md)], we'll add a new output binding to your solution. Let's create the binding through the portal UI this time.

1. Select **Integrate** in the left function menu to open the integration tab.

2. Select **New Output** in the **Outputs** column.  
    A list of all possible output binding types is displayed.

3. In the list, select **Azure Queue Storage**, then select **Select**.  
    This action opens the Azure Queue Storage output configuration page.

   Next, we'll set up a storage account connection. This is where our queue will be hosted.

4. To the right of the **Storage account connection** field, select **new**.  
   The **Storage Account** selection pane opens. 

5. When we started this module and you created your function app, a storage account was also created at that time. It's listed in this pane, so select it. The **Storage account connection** field is populated with the name of a connection. If you want to see the connection string value, select **show value**.

6. Although we could keep the default values in all the other fields, let's change the following to lend more meaning to the properties:

    |Property  |Old value  |New value  | Description |
    |---------|---------|---------|---------|
    |Queue name     |    outqueue     |  **bookmarks-post-process**      | The name of the queue where we're placing bookmarks so that they can be processed further by another function. |
    | Message parameter name    |  outputQueueItem       |   **newmessage**      | The binding property we'll use in code. |

7. Remember to select **Save** to save your changes.

## Update function implementation

We now have all our bindings set up for the [!INCLUDE [func-name-add](./func-name-add.md)] function. It's time to use them in our function.

1.  Select your function, [!INCLUDE [func-name-add](./func-name-add.md)], to open the **index.js** file in the code editor.

2. Replace all the code in the *index.js* file with the code from the following snippet:

   [!code-javascript[](../code/add-bookmark.js)]

Let's break down what this code does:

* Because this function changes our data, we expect the HTTP request to be a POST and the bookmark data to be part of the request body.
* Our Azure Cosmos DB input binding attempts to retrieve a document, or bookmark, by using the `id` that we receive. If it finds an entry, the `bookmark` object will be set. The `if(bookmark)` condition checks to see whether an entry was found.
* Adding to the database is as simple as setting the `context.bindings.newbookmark` binding parameter to the new bookmark entry, which we have created as a JSON string.
* Posting a message to our queue is as simple as setting the  `context.bindings.newmessage parameter`.

> [!NOTE]
> The only task you performed was to create a queue binding. You never created the queue explicitly. You are witnessing the power of bindings! As the following callout says, the queue is automatically created for you if it doesn't exist.

![Screenshot calling out that the queue will be auto-created.](../media/7-q-auto-create-small.png)

So, that's it. Let's see our work in action in the next section.

## Try it out

Now that we have multiple output bindings, testing becomes a little trickier. In previous labs we were content to test by sending an HTTP request and a query string, but we'll want to perform an HTTP post this time. We also need to check to see whether messages are making it into a queue.

1. With our function, [!INCLUDE [func-name-add](./func-name-add.md)], selected in the Function Apps portal, select the Test menu item at the far left to expand it.

2. Select the **Test** menu item, and verify that you have the test pane open. The following screenshot shows what it should look like: 

    ![Screenshot showing the function Test Panel expanded.](../media/7-test-panel-open-small.png)

    > [!IMPORTANT]
    > Make sure that **POST** is selected in the HTTP method drop-down list.

3. Replace the content of the request body with the following JSON payload:

    ```json
    {
        "id": "docs",
        "url": "https://docs.microsoft.com/azure"
    }
    ```

4. Select **Run** at the bottom of the test pane. 

5. Verify that the **Output** window displays the "Bookmark already exists" message, as shown in the following diagram: 

    ![Screenshot showing Test Panel and result of a failed test.](../media/7-test-exists-small.png)

6. Replace the request body with the following payload: 

    ```json
    {
        "id": "github",
        "url": "https://www.github.com"
    }
    ```
7. Select **Run** at the bottom of the test pane.

8. Verify the that *Output* box displays the "bookmark added" message as shown in the following diagram.

    ![Screenshot showing Test Panel and result of a successful test.](../media/7-test-success-small.png)

Congratulations! The [!INCLUDE [func-name-add](./func-name-add.md)] works as designed, but what about that queue operation we had in the code? Well, let's go see whether something was written to a queue.

### Verify that a message is written to the queue

Azure Queue Storage queues are hosted in a storage account. You already selected the storage account in this exercise when you created the output binding. 

1. In the main search box in the Azure portal, type **storage accounts**, and in the results list, under **Services**, select **Storage accounts**. 

      ![Screenshot showing search results for Storage Account in the main search box.](../media/7-search-for-sa-small.png)

2. In the list of storage accounts that are returned, select the storage account that you used to create the **newmessage** output binding.  
   The storage account settings are displayed in the main window of the portal.

3. In the **Services** list, select the **Queues** item.  
   A list of queues hosted by this storage account is displayed. Verify that the **bookmarks-post-process** queue exists, as shown in the following screenshot:

      ![Screenshot showing our queue in the list of queues hosted by this storage account](../media/7-q-in-list-small.png)

4. Select **bookmarks-post-process** to open the queue.  
   The messages that are in the queue are displayed in a list. If all went according to plan, the queue includes the message that you posted when you added a bookmark to the database. It should look like the following: 

    ![Screenshot showing our message in the queue](../media/7-message-in-q-small.png)    

   In this example, you can see that the message was given a unique ID, and the **MESSAGE TEXT** field displays your bookmark in JSON string format.

5. You can test the function further by changing the request body in the test pane with new id/url sets and running the function. Watch this queue to see more messages arrive. You can also look at the database to verify that new entries have been added. 

In this lab, we expanded your knowledge of bindings to output bindings, writing data to your Azure Cosmos DB. We went further and added another output binding to post messages to an Azure queue. This demonstrates the true power of bindings to help you shape and move data from incoming sources to a variety of destinations. We haven't written any database code or had to manage connection strings ourselves. Instead, we configured bindings declaratively and let the platform take care of securing connections, scaling our function, and scaling our connections.