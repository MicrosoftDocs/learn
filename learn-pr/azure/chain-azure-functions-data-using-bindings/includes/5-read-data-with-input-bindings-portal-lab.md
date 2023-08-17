Imagine that you want to create a bookmark lookup service. Initially, your service is read-only. If users want to find an entry, they send a request with the ID of the entry, and our function returns the URL. The following flowchart illustrates the logical flow.

:::image type="content" source="../media/5-find-bookmark-flow-small.png" alt-text="Flow diagram showing the logical process of finding a bookmark in an Azure Cosmos DB and returning a response." lightbox="../media/5-find-bookmark-flow.png" border="false":::

When a user sends a request with text, the find bookmark function tries to find an entry in your database that contains a bookmark with the text as a key or ID. The system returns a result that indicates whether you found the entry.

When the Azure function receives a request with a bookmark ID, it first checks whether the request is valid. If it isn't, an error response is generated. If the request is valid, the function checks whether the bookmark ID exists in the Azure Cosmos DB database. If it doesn't exist, an error response is generated. If the bookmark ID is found, a success response is generated.

You need to store the data somewhere. In the previous flowchart, the data store is an Azure Cosmos DB instance. But, how do you connect to a database from a function and read data? In the world of functions, you configure an *input binding* for that job. Configuring an input binding through the Azure portal is straightforward. As you'll see shortly, you don't have to write code or open a storage connection. The Azure Functions runtime and bindings take care of those tasks for you.

## Create an Azure Cosmos DB account

> [!NOTE]
> This exercise is not intended to be a tutorial on Azure Cosmos DB. If you're interested in learning more, see the complete learning path about Azure Cosmos DB at the end of this module.

### Create a database account

A database account is a container for managing one or more databases. Before we can create a database, we need to create a database account.

1. In the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) resource menu, or from the **Home** page, select **Create a resource**. The **Create a resource** pane appears.

1. In the **Create a resource** menu, select **Databases**, and then search for and select **Azure Cosmos DB**. The **Which API best suits your workload?** pane appears.

1. In the **Azure Cosmos DB for NoSQL** option, select **Create** so that we can create a Cosmos DB trigger and input/output bindings. The **Create Azure Cosmos DB Account - Azure Cosmos DB for NoSQL** pane appears.

1. On the **Basics** tab, enter the following values for each setting.

    | Setting | Value | Description |
    |---|---|---|
    | **Project Details** |
    | Subscription | Concierge Subscription | The Azure subscription that works with the resources in the sandbox. |
    | Resource Group | From the dropdown list, select <rgn>[sandbox resource group name]</rgn> | The resource group for your sandbox. |
    | **Instance Details** |
    | Account Name | `globally unique name` | Enter a unique but identifiable name for your Azure Cosmos DB account; `documents.azure.com` is appended to the name that you provide.<br><br>`3 - 50 lowercase characters, numbers, or hyphens (-)`. |
    | Location | `region` | Select the region nearest to you. |

1. Accept the default values for the remaining settings, and select **Review + create** to validate your input. A *Validation Success* notification appears.

1. Select **Create** to provision and deploy a database account.

1. Deployment can take some time. Wait for a **Deployment succeeded** message in the Notifications hub before proceeding.

    :::image type="content" source="../media/5-db-deploy-success.PNG" alt-text="Screenshot of a notification that database account deployment has completed.":::

1. Select **Go to resource** to go to the database account in the portal. The **Quick start** pane for your Azure Cosmos DB account appears.

Next, we'll add a container and then add a database to the Azure Cosmos DB account.

### Add a container

In an Azure Cosmos DB, a *container* is used to store various user-generated entities, also called *items*. We'll create a container called Bookmarks.

Let's use the Data Explorer tool to create a database and container.

1. In your **Azure Cosmos DB account** menu, select **Data Explorer** on the left. The **Data Explorer** pane for your Cosmos DB account appears.

1. Select the **New Container** box. The **New Container** pane appears. You may need to scroll to the right to see it.

1. Enter the following values for each setting.

    | Setting | Value | Description |
    |---|---|---|
    | Database id | Select **Create new**, and enter *func-io-learn-db* for the Database id | Database names can be 1 to 255 characters long, and can't contain /, \\, #, ?, or a trailing space.<br>You can enter whatever you want, but we're using *func-io-learn-db* in this module. |
    | Database Max RU/s | 4000 |Accept the default throughput of 4000 request units per second (RU/s). To reduce latency, you can scale up the performance later. |
    | Container id | *Bookmarks* | Container IDs have the same character requirements as database names. We're using *Bookmarks* in this module.|
    | Partition key | /id  | The partition key specifies how the documents in Azure Cosmos DB collections are distributed across logical data partitions. You'll use the *Partition key* setting as a convenience because you're not concerned with database performance in this module. To learn more about Azure Cosmos DB partition key strategies, explore the Microsoft Learn Azure Cosmos DB modules. |

    Accept the defaults for all the other settings.

1. Scroll to the bottom of the pane and select **OK**. Allow a few minutes for the database and container to be built.

    When complete, the Data Explorer displays **func-io-learn-db** in **DATA** under **SQL API**.

1. Select **func-io-learn-db** to expand it. Notice that your **func-io-learn-db** database contains several child members, including Scale and Bookmarks. 

1. Expand the **Bookmarks** container, and you'll see that it's prepopulated with several child members.

In the next task, you'll add some data, also known as items, to your Bookmarks container.

### Add test data

You want to add data to your **Bookmarks** container. You'll use Data Explorer to store a URL and ID for each item.

1. Expand the **func-io-learn-db** database and the **Bookmarks** container, and then select **Items**. The **Items** tab appears.

1. In the command bar, select **New Item**.

1. Replace the default code of the new item with the following JSON code.

     ```json
     {
         "id": "docs",
         "url": "https://learn.microsoft.com/azure"
     }
     ```

1. In the command bar, select **Save**.

    Notice that more properties than the two lines we added appear. They all begin with an underline `(_rid, _self, _etag, _attachments, _ts)`. These properties, described in the table below, are generated by the system to help manage the items that you add to the container.

    | Property | Description |
    |---|---|
    | `_rid` | Resource ID is a unique identifier that is also hierarchical per the resource stack on the resource model. It's used internally for placement and navigation of the item resource. |
    | `_self` | Unique addressable URI for the resource. |
    | `_etag` | Required for optimistic concurrency control. |
    | `_attachments` | Addressable path for the attachments resource. |
    | `_ts` | Timestamp of the last update of this resource. |

1. Let's add a few more items into the **Bookmarks** container. In the command bar, select **New Item**. Create four more items with the following content. Do this by selecting **New Item**, and then selecting **Save** after copying and pasting each new item. Notice how each item is added to the list of items.

    ```json
    {
        "id": "portal",
        "url": "https://portal.azure.com"
    }
    ```

    ```json
    {
        "id": "learn",
        "url": "https://learn.microsoft.com/training"
    }
    ```

    ```json
    {
        "id": "marketplace",
        "url": "https://azuremarketplace.microsoft.com/marketplace/apps"
    }
    ```

    ```json
    {
        "id": "blog",
        "url": "https://azure.microsoft.com/blog"
    }
    ```

1. When you've finished entering the bookmark data, your container should look like the following image.

    :::image type="content" source="../media/5-db-bookmark-collection-small.png" alt-text="Screenshot of SQL API data showing collection of items in bookmarks container of the func-io-learn-db." lightbox="../media/5-db-bookmark-collection.png":::

Your **Bookmarks** container has five items. In this scenario, if a request arrives with "id=docs", it will look up that ID in your Bookmarks container, and return the URL `https://learn.microsoft.com/azure`. Let's make an Azure function that looks up values in your Bookmarks container.

## Create your function

1. Go to the function app that you created in the preceding unit. In the resource menu, select **Home**, and in the **Recent resources** section, you should see your function app (**Type** equals **Function App**). Select your function app. The **Function App** pane appears.

1. In the **Functions** tab on the **Overview** page, you should have one function, **HttpTrigger1**.

1. Let's create another function. Select **Create** on the **Functions** tab. The **Create function** pane appears, listing templates for supported triggers.

1. In the **Select a template** section, select **HTTP trigger**.

1. Accept all default settings, and select **Create** to create your function.

   The Overview pane for the **HttpTrigger2** function appears.

### Verify the function

You can verify what we've done so far by testing the new function.

1. In the command bar, select **Get Function Url**. The **Get Function Url** dialog box appears.

1. Select **default (function key)** from the dropdown list, then select the *Copy to clipboard* icon, and select **OK**.

1. Paste the function URL you copied into the address bar of a new browser tab. Append the query string value `&name=<your name>` to the end of the URL, replacing `<your  name>` with your name, and then press <kbd>Enter</kbd>. The Azure function should return a personalized response in the browser.

Now that we have our skeletal function working, let's turn our attention to reading data from your Azure Cosmos DB, or in our scenario, from your **Bookmarks** container.

## Add an Azure Cosmos DB input binding

To read data from the database, you need to define an input binding. As you'll see, you can configure a binding that can talk to your database in just a few steps.

1. In the Azure portal, in the *HttpTrigger2* Function menu on the left, select **Integration**. The **Integration** pane for your Function appears.

   You used a template that created an HTTP trigger request with an HTTP output binding. Let's add an Azure Cosmos DB input binding.

1. In the **Inputs** box, select **Add input**. The **Create Input** pane appears.

1. From the **Binding Type** dropdown list, select **Azure Cosmos DB**.

1. In the **Azure Cosmos DB details** section, under the **Cosmos DB account connection** setting, select the **New** link. The **New Cosmos DB connection** dialog box appears.

   If a message appears prompting you to install the Microsoft.Azure.WebJobs.Extensions.CosmosDB extension, select **Install** and wait for it to finish.

1. By default, Azure recognizes the Azure Cosmos DB account you created earlier. Select **OK** to set up a connection to your database. A *new* connection to the database account is configured and appears in the **Cosmos DB account connection** field.

   We want to look up a bookmark with a specific ID, so let's tie the ID that we receive in the query string to the binding.

1. Let's complete the settings in the **Create Input** pane. Enter the following values for each setting. To learn more about the purpose of each setting, select the information icon on that field.

    | Setting | Value | Description |
    |---|---|---|
    | **Document parameter name** | `bookmark` | The name used to identify this binding in your code. |
    | **Database name** | `func-io-learn-db` | The database to work with. This value is the database name we set. |
    | **Collection Name** | `Bookmarks` | The collection from which we'll read data. This setting was defined. |
    | **Document ID** | `id` | Add the Document ID that we defined when we created the _Bookmarks_ Azure Cosmos DB container. |
    | **Partition key** | `/id` | Add the partition key that you defined when you created the _Bookmarks_ Azure Cosmos DB collection. The key entered here (specified in input binding format `<key>`) must match the one in the collection. |
    | **SQL Query (optional)** | _Leave blank_ | You're only retrieving one document at a time based on the ID. So, filtering with the Document ID setting is a better than using a SQL Query in this instance. You could craft a SQL Query to return one entry (`SELECT * from b where b.ID = id`). That query would indeed return a document, but it would return it in a document collection. Your code would have to manipulate a collection unnecessarily. Use the SQL Query approach when you want to get multiple documents. |

    To clarify why we're using these settings, we want to look up a bookmark with a specific ID, so we tied the **Document ID** that our function receives in the query string to the input binding. This syntax is known as a *binding expression*. The function is triggered by an HTTP request that uses a query string to specify the ID to look up. Because IDs are unique in our collection, the binding will return either 0 (not found) or 1 (found) documents.

1. To save this input binding configuration, select **OK**.

## Update the function implementation

Now that your binding is defined, we can use it in your function. You need to make two changes to implement the binding that you just created:

- Your function's language-specific implementation code needs to be modified to determine whether a document was found in the database that matches the ID that is passed to the function.

- Your function's JSON implementation code needs to be modified to accept a parameter that is passed in the query string.

::: zone pivot="javascript"

### Modify your function's JavaScript implementation code

1. In the **Function** menu for your *HttpTrigger2* function, select **Code + Test**. The **Code + Test** pane appears for your *HttpTrigger2* function.

1. Replace all code in the *index.js* file with the following code.

    ```javascript
    module.exports = function (context, req) {

        var bookmark = context.bindings.bookmark

        if(bookmark){
            context.res = {
            body: { "url": bookmark.url },
            headers: {
                'Content-Type': 'application/json'
            }
            };
        }
        else {
            context.res = {
                status: 404,
                body : "No bookmarks found",
                headers: {
                'Content-Type': 'application/json'
                }
            };
        }

        context.done();
    };
    ```

1. In the command bar, select **Save**. Select **Filesystem Logs** in the drop-down at the top center of the logs pane (which displays **App Insights Logs** by default). The **Logs** pane appears, showing you have `Connected!`

Let's examine what this code is doing.

- An incoming HTTP request triggers the function, and an `id` query parameter is passed to the Azure Cosmos DB input binding.

- If the database finds a document that matches this ID, the `bookmark` parameter will be set to the located document.

  In this example, the code constructs a response that contains the URL value that is found in the corresponding document of the database.

- If no document is found matching this key, the request would respond with a payload and status code that tells the user the bad news.

### Modify your function's JSON implementation code

1. Select **function.json** from the dropdown list in your **`<functionapp> \ HttpTrigger2 \`** path.

1. Modify the values for `id` and `partitionKey` so that they accept a parameter of `{id}`. Your **function.json** code should resemble the following example, where `your-database` is replaced with the name of your Cosmos DB database.

    ```json
    {
      "bindings": [
        {
          "authLevel": "function",
          "type": "httpTrigger",
          "direction": "in",
          "name": "req",
          "methods": [
            "get",
            "post"
          ]
        },
        {
          "type": "http",
          "direction": "out",
          "name": "res"
        },
        {
          "name": "bookmark",
          "direction": "in",
          "type": "cosmosDB",
          "connectionStringSetting": "your-database_DOCUMENTDB",
          "databaseName": "func-io-learn-db",
          "collectionName": "Bookmarks",
          "id": "{id}",
          "partitionKey": "{id}"
        }
      ]
    }
    ```

1. In the command bar, select **Save**.

::: zone-end

::: zone pivot="powershell"

### Modify your function's PowerShell implementation code

1. In the **Function** menu for your *HttpTrigger2* function, select **Code + Test**. The **Code + Test** pane appears for your *HttpTrigger2* function, displaying the `run.ps1` file.

1. Replace all code in the `run.ps1` file with following code.

    ```powershell
    using namespace System.Net

    param($Request, $bookmark, $TriggerMetadata)

    if ($bookmark) {
        $status = [HttpStatusCode]::OK
        $body = @{ url = $bookmark.url }
    }
    else {
        $status = [HttpStatusCode]::NotFound
        $body = "No bookmarks found"
    }

    Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
        StatusCode = $status
        Body = $body
    })
    ```

1. In the command bar, select **Save**. Select **Filesystem Logs** in the drop-down at the top center of the logs pane (which displays **App Insights Logs** by default). The **Logs** pane appears, showing you have `Connected!`

Let's examine what this code is doing.

- An incoming HTTP request triggers the function, and an `id` query parameter is passed to the Azure Cosmos DB input binding.

- If the database finds a document that matches this ID, the `bookmark` parameter will be set to the located document.

  In this example, the code constructs a response that contains the URL value that is found in the corresponding document of the database.

- If no document is found matching this key, the request would respond with a payload and status code that tells the user the bad news.

### Modify your function's JSON implementation code

1. Select **function.json** from the dropdown list in your **`<functionapp> \ HttpTrigger2 \`** path.

1. Modify the values for `id` and `partitionKey` so that they accept a parameter of `{id}`. Your **function.json** code should resemble the following example, where `your-database` is replaced with the name of your Cosmos DB database.

    ```json
    {
      "bindings": [
        {
          "authLevel": "function",
          "type": "httpTrigger",
          "direction": "in",
          "name": "Request",
          "methods": [
            "get",
            "post"
          ]
        },
        {
          "type": "http",
          "direction": "out",
          "name": "Response"
        },
        {
          "name": "bookmark",
          "direction": "in",
          "type": "cosmosDB",
          "connectionStringSetting": "your-database_DOCUMENTDB",
          "databaseName": "func-io-learn-db",
          "collectionName": "Bookmarks",
          "id": "{id}",
          "partitionKey": "{id}"
        }
      ]
    }
    ```

1. In the command bar, select **Save**.

::: zone-end

## Try it out

1. You should already be on the **Code + Test** pane for your *HttpTrigger2* function.

1. In the command bar, select **Get function URL**. The **Get function URL** dialog box appears.

1. From the **Key** dropdown list, select **default** under **Function key**, and then select the *Copy to clipboard* icon at the end of the URL.

1. Paste the function key you copied into the address bar of a new browser tab, and then add the query string value `&id=docs` to the end of the URL. The resulting URL should resemble the following example:

    `https://example.azurewebsites.net/api/HttpTrigger2?code=AbCdEfGhIjKlMnOpQrStUvWxYz==&id=docs`

1. Press <kbd>Enter</kbd> to run the request. The response returned by your function should be similar to the following example.

    ```json
    {
      "url": "https://learn.microsoft.com/azure"
    }
    ```

1. Replace `&id=docs` with `&id=missing`, press <kbd>Enter</kbd>, and observe the response. We defined five bookmarks, and created a meaningful error response if the requested bookmark doesn't exist.

In this unit, you created your first input binding manually to read from an Azure Cosmos DB database. The amount of code you wrote to search our database and read data was minimal, thanks to bindings. You did most of your work configuring the binding declaratively, and the platform took care of the rest.

In the next unit, you'll add more data to our bookmarks collection through an Azure Cosmos DB output binding.
