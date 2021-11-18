Imagine that you want to create a simple bookmark lookup service. Initially, your service is read-only. If users want to find an entry, they send a request with the ID of the entry, and our function return the URL. The following flowchart illustrates the logical flow.

:::image type="content" source="../media/5-find-bookmark-flow-small.png" alt-text="Flow diagram showing the logical process of finding a bookmark in an Azure Cosmos DB and returning a response." border="false":::

When a user sends a request with text, the find bookmark function tries to find an entry in your database that contains a bookmark with the text as a key or ID. The system returns a result that indicates whether you found the entry.

When the Azure function receives a request with a bookmark ID, it first checks whether the request is valid. If it isn't, an error response is generated. If the request is valid, the function checks whether the bookmark ID exists in the Azure Cosmos DB database. If it does not exist, an error response is generated. If the bookmark ID is found, a success response is generated.

You need to store the data somewhere. In the previous flowchart, the data store is an Azure Cosmos DB instance. But, how do you connect to a database from a function and read data? In the world of functions, you configure an *input binding* for that job. Configuring an input binding through the Azure portal is straightforward. As you'll see shortly, you don't have to write code or open a storage connection. The Azure Functions runtime and bindings take care of those tasks for you.

## Create an Azure Cosmos DB account

> [!NOTE]
> This exercise is not intended to be a tutorial on Azure Cosmos DB. If you're interested in learning more, see the complete learning path about Azure Cosmos DB at the end of this module.

### Create a database account

A database account is a container for managing one or more databases. Before we can create a database, we need to create a database account.

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account that you used to activate the sandbox.

1. On the Azure portal menu, or from the **Home** page, select **Create a resource**. The **Create a resource** pane appears.

1. In the  **Create a resource** menu, select **Databases**, and then search for and select **Azure Cosmos DB**. The **Select API option** pane appears. 
 
1. In the **Core (SQL) - Recommended** option, select **Create** so that we can create a Cosmos DB trigger and input/output bindings. The **Create Azure Cosmos DB Account - Core (SQL)** pane appears.

1. On the **Basics** tab, enter the following values for each setting.

    | Setting | Value | Description |
    |---|---|---|
    | **Project Details** |
    | Subscription | Concierge Subscription | The Azure subscription that works with the resources in the sandbox. |
    | Resource Group | From the dropdown list, select <rgn>[sandbox resource group name]</rgn> | The resource group for your sandbox. |
    | **Instance Details** |
    | Account Name | *globally unique name* | Enter a unique but identifiable name for your Azure Cosmos DB account; `documents.azure.com` is appended to the name that you provide.<br><br>`3 - 50 lowercase characters, numbers, or hyphens (-)`. |
    | Location | *region* | Select the region nearest to you. |

1. Accept the default values for the remaining settings, and select **Review + create** to validate your input. A *Validation Success* notification appears.

1. Select **Create** to provision and deploy a database account.

1. Deployment can take some time. Wait for a **Deployment succeeded** message in the Notifications hub before proceeding.

    :::image type="content" source="../media/5-db-deploy-success.PNG" alt-text="Screenshot of a notification that database account deployment has completed.":::

1. Select **Go to resource** to go to the database account in the portal. The **Quick start** pane for your Azure Cosmos DB account appears.

Next, we'll add a container to the database.

### Add a container

In Azure Cosmos DB, a *container* holds arbitrary user-generated entities. Inside a container, we store documents.

Let's use the Data Explorer tool in the Azure portal to create a database and container.

1. In the menu, select **Data Explorer**. The **Data Explorer** pane appears.

1. Select the **New Container** box. The **New Container** pane appears. To see it, you may need to scroll to the right.

1. Enter the following values for each setting.

    | Setting | Value | Description |
    |---|---|---|
    | Database id | Select **Create new**, and enter *func-io-learn-db* in the field | Database names can be 1 to 255 characters long, and cannot contain /, \\, #, ?, or a trailing space.<br><br>You're free to enter whatever you want here, but we suggest _func-io-learn-db_ as the name for the new database, and that's what we'll use in this unit. |
    | Database Max RU/s | 4000 |Leave the throughput at 4000 request units per second (RU/s). If you want to reduce latency, you can scale up the performance later. |
    | Container id | Bookmarks | Container IDs have the same character requirements as database names. |
    | Partition key | /id  | The partition key specifies how the documents in Azure Cosmos DB collections are distributed across logical data partitions. You'll use the *Partition key* setting as a convenience because you're not concerned with database performance in this module. If you would like to learn more about Azure Cosmos DB partition key strategies, explore the Microsoft Learn Azure Cosmos DB modules. |

1. Select **OK**. The Data Explorer displays the new database and container under the **SQL API** section. Inside the database, you've defined a container. Next, you'll add some data, also known as items.

### Add test data

You've defined a container in our database called **Bookmarks**. You want to store a URL and ID in each item, like a list of web page bookmarks.

You'll add data to the new container using Data Explorer.

1. In the **Data Explorer** pane, the new database, *func-io-learn-db*, appears under the **SQL API** section. Expand the **func-io-learn-db** database, then expand the **Bookmarks** container, and select **Items**. The **Items** tab appears.

1. In the command bar, select **New Item**.

1. Replace the default code of the new item with the following JSON code, and in the command bar, select **Save**.

     ```json
     {
         "id": "docs",
         "url": "https://docs.microsoft.com/azure"
     }
     ```

    Notice that there are more properties than the ones we added. They all begin with an underline (_rid, _self, _etag, _attachments, _ts). These are properties generated by the system to help manage the document.

    | Property | Description |
    |---|---|
    | `_rid` | Resource ID is a unique identifier that is also hierarchical per the resource stack on the resource model. It is used internally for placement and navigation of the item resource. |
    | `_self` | Unique addressable URI for the resource. |
    | `_etag` | Required for optimistic concurrency control. |
    | `_attachments` | Addressable path for the attachments resource. |
    | `_ts` | Timestamp of the last update of this resource. |

1. To add a few more items into the container, in the command bar, select **New Item**. Create four more items with the following content. Do this by selecting **New Item**, and then selecting **Save** after copying and pasting each new item.

    ```json
    {
        "id": "portal",
        "url": "https://portal.azure.com"
    }
    ```

    ```json
    {
        "id": "learn",
        "url": "https://docs.microsoft.com/learn"
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

    :::image type="content" source="../media/5-db-bookmark-collection-small.png" alt-text="Screenshot of SQL API UI showing the list of entries in bookmarks container." lightbox="../media/5-db-bookmark-collection.png":::

You now have a few entries in your **Bookmarks** container. Your scenario will work as follows. If a request arrives with, for example, "id=docs", you'll look up that ID in your Bookmarks container, and return the URL `https://docs.microsoft.com/azure`. Let's make an Azure function that looks up values in this container.

## Create your function

1. Go to the function app that you created in the preceding unit. In the resource menu, select **Home**, and in the **Recent resources** section, you should see your app with **Function App** identified in the **Type** column. Select your app. The **Function App** pane appears.

1. In the Function App menu, under **Functions**, select **Functions**. The **Functions** pane appears.

1. To start the function creation process, from the command bar, select **Create**. The **Create function** pane appears, showing the complete set of supported triggers.

1. In the **Select a template** section, select **HTTP trigger**.

1. Accept all default settings, and select **Create** to create your function.

    The **HttpTrigger2** pane for your function appears, displaying a default implementation of your HTTP-triggered function.

### Verify the function

You can verify what we have done so far by testing our new function.

1. In the command bar of your function, select **Get Function Url**. The **Get Function Url** dialog box appears.

1. Select **default (function key)** from the dropdown list, then select the *Copy to clipboard* icon, and select **OK**.

1. Paste the function URL you copied into the address bar of a new browser tab. Append the query string value `&name=<your function name>` to the end of the URL, replacing `<your function name>` with the name of your function, and then press <kbd>Enter</kbd>. You should get a response from the Azure Function in the browser.

Now that we have our skeletal function working, let's turn our attention to reading data from Azure Cosmos DB, or in our scenario, your **Bookmarks** container.

## Add an Azure Cosmos DB input binding

To read data from the database, you need to define an input binding. As you'll see, you can configure a binding that can talk to your database in just a few steps.

1. Return to the portal, and in the *HttpTrigger2* function menu, under **Developer**, select **Integration**. The **Integration** pane for your *Function* appears.

    You used a template that created an HTTP trigger and an HTTP output binding. Let's add an Azure Cosmos DB input binding.

1. In the **Inputs** box, select **Add input**. The **Create Input** pane appears, showing a list of all possible input binding types.

1. From the **Binding Type** dropdown list, select **Azure Cosmos DB**.

1. In the **Azure Cosmos DB details** section, under the **Cosmos DB account connection** setting, select the **New** link. The **New Cosmos DB connection** dialog box appears.

    Next, you'll set up a connection to your database.

    > [!NOTE]
    > If the following message appears in the **Azure Cosmos DB input** configuration, prompting you to install an extension, select **Install**. It can take a while to install an extension, so you will need to wait for the installation to complete before proceeding with this exercise.
    
     :::image type="content" source="../media/extension-not-installed.png" alt-text="Screenshot of error message that the integration requires the Microsoft.Azure.WebJobs.Extensions.CosmosDB extension to be installed.":::
    
1. To create your connection, select **OK**.

    A new connection to the database is configured and appears in the **Cosmos DB account connection** dropdown list in the **Create Input** pane.

    We want to look up a bookmark with a specific ID, so let's tie an ID that we receive in the query string to the binding.

1. Enter the following values for each setting. To learn more about the purpose of each setting, select the information icon on that field.

    | Setting | Value | Description |
    |---|---|---|
    | **Document parameter name** | `bookmark` | The name used to identify this binding in your code. |
    | **Database name** | `func-io-learn-db` | The database to work with. This value is the database name we set. |
    | **Collection Name** | `Bookmarks` | The collection from which we'll read data. This setting was defined. |
    | **Document ID** | `id` | Add the Document ID that we defined when we created the _Bookmarks_ Azure Cosmos DB container. |
    | **Partition key** | `/id` | Add the partition key that you defined when you created the _Bookmarks_ Azure Cosmos DB collection. The key entered here (specified in input binding format `<key>`) must match the one in the collection. |
    | **SQL Query (optional)** | _Leave blank_ | You are only retrieving one document at a time based on the ID. So, filtering with the Document ID setting is a better than using a SQL Query in this instance. You could craft a SQL Query to return one entry (`SELECT * from b where b.ID = id`). That query would indeed return a document, but it would return it in a document collection. Your code would have to manipulate a collection unnecessarily. Use the SQL Query approach when you want to get multiple documents. |

    To clarify why we are using these settings, we want to look up a bookmark with a specific ID, so we tied the **Document ID** that our function receives in the query string to the binding. This syntax is known as a *binding expression*. The function is triggered by an HTTP request that uses a query string to specify the ID to look up. Because IDs are unique in our collection, the binding will return either 0 (not found) or 1 (found) documents.

1. To save all changes to this binding configuration, select **OK**.

Now that your binding is defined, we can use it in your function.

## Update the function implementation

You need to make two changes to implement the binding that you just created:

- Your function's language-specific implementation code needs to be modified to determine if a document was found in the database that matches the ID that is passed to the function.

- Your function's JSON implementation code needs to be modified to accept a parameter that is passed in the query string.

::: zone pivot="javascript"

### Modify your function's JavaScript implementation code

1. In the menu of the **Integration** pane  for your *HttpTrigger2* function, select **Code + Test**. The **Code + Test** pane appears for your *HttpTrigger2* function.

1. Replace all code in the *index.js* file with the following code, and then, in the command bar, select **Save**. The **Logs** pane appears, showing your connection.

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

::: zone-end

::: zone pivot="powershell"

### Modify your function's PowerShell implementation code

1. In the **Integration** menu, select **Code + Test**. The **Code + Test** pane appears for your *HttpTrigger2* function.

1. Replace all code in the `run.ps1` file with following code, and then, in the command bar, select **Save**. The **Logs** pane appears, showing your connection.

    ```powershell
    using namespace System.Net

    param($Request, $bookmark, $TriggerMetadata)

    if ($bookmark) {
        $status = [HttpStatusCode]::OK
        $body = @{ url = $bookmark.url }
	ContentType = "application/json"
    }
    else {
        $status = [HttpStatusCode]::NotFound
        $body = "No bookmarks found"
	ContentType = "text/plain"
    }

    Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
        StatusCode = $status
        Body = $body
    })
    ```

::: zone-end

Let's examine what this code is doing.

- An incoming HTTP request triggers the function, and an `id` query parameter is passed to the Azure Cosmos DB input binding.

- If the database finds a document that matches this ID, the `bookmark` parameter will be set to the located document.

    In this example, the code constructs a response that contains the URL value that is found in the corresponding document of the database.

- If no document is found matching this key, you would respond with a payload and status code that tells the user the bad news.

### Modify your function's JSON implementation code

1. Select **function.json** from your HttpTrigger2 function's dropdown list.

1. Modify the values for `id` and `partitionKey` so that they accept a parameter of `{id}`. Your **function.json** code should resemble the following example, where `your-database_DOCUMENTDB` is replaced with the name of your Cosmos DB database.

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

## Try it out

1. In the Function menu, under **Developer**, select **Code + Test**. The **Code + Test** pane appears for your *HttpTrigger2* function.

1. In the command bar, select **Get function URL**. The **Get function URL** dialog box appears.

1. From the **Key** dropdown list, select **default** under **Function key**, and then select the *Copy to clipboard* icon at the end of the URL.

1. Paste the function key you copied into the address bar of a new browser tab.

1. Add the query string value `&id=docs` to the end of the URL. The resulting URL should resemble the following example:

    `https://example.azurewebsites.net/api/HttpTrigger2?code=AbCdEfGhIjKlMnOpQrStUvWxYz==&id=docs`

1. Press <kbd>Enter</kbd> to run the request. The response returned by your function should be similar to the following example.

    ```json
    {
      "url": "https://docs.microsoft.com/azure"
    }
    ```

1. Replace `&id=docs` with `&id=missing`, press <kbd>Enter</kbd>, and observe the response.

In this unit, you created your first input binding manually to read from an Azure Cosmos DB database. The amount of code you wrote to search our database and read data was minimal, thanks to bindings. You did most of your work configuring the binding declaratively, and the platform took care of the rest.

In the next unit, you'll add more data to our bookmarks collection through an Azure Cosmos DB output binding.
