Imagine that you want to create a simple bookmark lookup service. Your service is read-only initially. If users want to find an entry, they send a request with the ID of the entry and you return the URL. The following flowchart explains the flow:

![Flow diagram showing the process of finding a bookmark in our Cosmos DB back-end. When the Azure function receives a request with the bookmark id, it first checks whether the request is valid, if not an error response is generated. For valid requests, the function checks if the bookmark id is present in the Cosmos DB, if not present an error response is generated. If the bookmark id is found, a success response is generated.](../media/5-find-bookmark-flow-small.png)

When users send you a request with some text, you try to find an entry in your back-end database that contains this text as a key or ID. You return a result that indicates whether you found the entry.

You need to store the data somewhere. In this flowchart, the data store is an Azure Cosmos DB instance. But how do you connect to a database from a function and read data? In the world of functions, you configure an *input binding* for that job.  Configuring a binding through the Azure portal is straightforward. As you'll see shortly, you don't have to write code for such tasks as opening a storage connection. The Azure Functions runtime and bindings take care of those tasks for you.

## Create an Azure Cosmos DB account

> [!NOTE]
> This unit is not intended to be a tutorial on Azure Cosmos DB. There is a complete learning path on Cosmos DB if you are interested in learning more after finishing this module.

### Create a database account

A database account is a container for managing one or more databases. Before we can create a database, we need to create a database account.

1. Make sure you are signed into the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you activated the sandbox with.

1. Select the **Create a resource** button found on the upper left-hand corner of the Azure portal, then select **Databases** > **Azure Cosmos DB**.

1. In the **Create Azure Cosmos DB Account** page, enter the settings for the new Azure Cosmos DB account.

    |Setting  |Value  |Description  |
    |---------|---------|---------|
    |Subscription     |  Concierge subscription       |  The Azure subscription that you want to use for this Azure Cosmos DB account.       |
    |Resource Group     |   <rgn>[sandbox resource group name]</rgn>      |  This field is pre-populated with the resource group from your sandbox.       |
    |Account Name     | *Enter a unique name*        |  Enter a unique name to identify this Azure Cosmos DB account. Because `documents.azure.com` is appended to the name that you provide to create your URI, use a unique but identifiable name.<br><br>The account name can contain only lowercase letters, numbers, and the hyphen (-) character, and it must contain 3 to 50 characters.       |
    |API     | SQL        |  The API determines the type of account to create. Azure Cosmos DB provides five APIs to suit the needs of your application: SQL (document database), Gremlin (graph database), MongoDB (document database), Azure Table, and Cassandra, each of which currently require a separate account. <br><br>Select **SQL**. At this time, the Azure Cosmos DB trigger, input bindings, and output bindings only work with SQL API and Graph API accounts.        |
    |Location     | Select from the list        | Choose the nearest one to you that is also one of the allowed *Sandbox regions* listed below.        |

     Leave all other fields in the **New account** blade at their default values.

    ### Sandbox regions
    [!include[](../../../includes/azure-sandbox-regions-first-mention-note-friendly.md)]


1. Select **Review + create** to review and validate the configuration. 

1. On the next screen, select **Create** to provision and deploy the database account.

1. Deployment can take some time. So, wait for a **Deployment succeeded** message in the Notification Hub before proceeding.

    ![Notification that database account deployment has completed](../media/5-db-deploy-success.PNG)

1. Select **Go to resource** to navigate to the database account in the portal. We'll add a collection to the database next.

### Add a collection

In Cosmos DB, a *container* holds arbitrary user-generated entities. For SQL and MongoDB API accounts, a container maps to a *collection*. Inside a collection, we store documents.

Let's use the Data Explorer tool in the Azure portal to create a database and collection.

1. Select **Data Explorer** > **New Collection**.

2. Under **Add collection**, enter the settings for the new collection.

    >[!TIP]
    >The **Add Collection** area is displayed on the far right. You may need to scroll right to see it.

    |Setting|Suggested value|Description
    |---|---|---|
    |Database ID|[!INCLUDE [cosmos-db-name](./cosmos-db-name.md)]| Database names must contain from 1 through 255 characters, and they cannot contain /, \\, #, ?, or a trailing space.<br><br>You are free to enter whatever you want here, but we suggest [!INCLUDE [cosmos-db-name](./cosmos-db-name.md)] as the name for the new database, and that's what we'll refer to in this unit. |
    |Collection ID|[!INCLUDE [cosmos-coll-name](./cosmos-coll-name.md)]|Enter [!INCLUDE [cosmos-coll-name](./cosmos-coll-name.md)] as the name for our new collection. Collection IDs have the same character requirements as database names.|
    |Partition key|**/id**| The partition key specifies how the documents in Cosmos DB collections are distributed across logical data partitions. We will use the `id` field as a convenience, as we are not concerned with database performance in this module. If you would like to learn more about Cosmos DB partition key strategies, please explore the Microsoft Learn Cosmos DB modules.|
    |Throughput|1000 RU|Change the throughput to 1000 request units per second (RU/s). If you want to reduce latency, you can scale up the performance later.|

3. Click **OK**. The Data Explorer displays the new database and collection. So, now we have a database. Inside the database, we've defined a collection. Next, we'll add some data, also known as documents.

### Add test data

We've defined a collection in our database called [!INCLUDE [cosmos-coll-name](./cosmos-coll-name.md)]. We want to store a URL and ID in each document, like a list of web page bookmarks.

You'll add data to your new collection using Data Explorer.

1. In Data Explorer, the new database appears in the Collections pane. Expand the [!INCLUDE [cosmos-db-name](./cosmos-db-name.md)] database, expand the [!INCLUDE [cosmos-coll-name](./cosmos-coll-name.md)] collection, select **Documents**, and then select **New Document**.

2. Replace the default content of the new document with the following JSON.

     ```json
     {
         "id": "docs",
         "URL": "https://docs.microsoft.com/azure"
     }
     ```

3. After you've added the JSON to the **Documents** tab, select **Save**.

    Notice that there are more properties than the ones we added. They all begin with an underline (_rid, _self, _etag, _attachments, _ts). These are properties generated by the system to help manage the document.

    |Property  |Description  |
    |---------|---------|
    | `_rid`     |     The resource ID is a unique identifier that is also hierarchical per the resource stack on the resource model. It is used internally for placement and navigation of the document resource.    |
    | `_self`     |   The unique addressable URI for the resource.      |
    | `_etag`     |   Required for optimistic concurrency control.     |
    | `_attachments`     |  The addressable path for the attachments resource.       |
    | `_ts`     |    The time stamp of the last update of this resource.    |

4. Let's add a few more documents into the collection. Create four more documents with the following content. Remember to save your work.

    ```json
    {
        "id": "portal",
        "URL": "https://portal.azure.com"
    }
    ```

    ```json
    {
        "id": "learn",
        "URL": "https://docs.microsoft.com/learn"
    }
    ```

    ```json
    {
        "id": "marketplace",
        "URL": "https://azuremarketplace.microsoft.com/marketplace/apps"
    }
    ```

    ```json
    {
        "id": "blog",
        "URL": "https://azure.microsoft.com/blog"
    }
    ```

1. When you've finished, your collection should look like the following:

    ![The SQL API UI in the portal, showing the list of entries you added to your bookmarks collection](../media/5-db-bookmark-coll.PNG)

You now have a few entries in your bookmark collection. Our scenario will work as follows. If a request arrives with, for example, "id=docs", you'll look up that ID in your bookmarks collection and return the URL `https://docs.microsoft.com/azure`. Let's make an Azure function that looks up values in this collection.

## Create your function

1. Navigate to the function app that you created in the preceding unit.

1. Select the **Add** (**+**) button next to **Functions** to start the function creation process. 
   The page displays the complete set of supported triggers.

1. Select **HTTP trigger**

1. Fill out the **New Function** dialog that appears to the right using the following values.

    | Field | Value |
    |----------|--------|
    | Name     | [!INCLUDE [func-name-find](./func-name-find.md)] |
    | Authorization level | **Function** |

1. Select **Create** to create your function.
    This action opens the *index.js* file in the code editor and displays a default implementation of the HTTP-triggered function.

### Verify the function

You can verify what we have done so far by testing our new function as follows:

1. In your new function, click **Get function URL** at the top right, select **default (Function key)**, and then click **Copy**.

1. Paste the function URL you copied into your browser's address bar. Add the query string value `&name=<yourname>` to the end of the URL and press **Enter** to execute the request. You should get a response from the Azure Function right in the browser.

Now that we have our bare-bones function working, let's turn our attention to reading data from our Azure Cosmos DB, or in our scenario, our [!INCLUDE [cosmos-coll-name](./cosmos-coll-name.md)] collection.

## Add an Azure Cosmos DB input binding

To read data from the database, you need to define an input binding. As you'll see, you can configure a binding that can talk to your database in just a few steps.

1. Select **Integrate** in the left pane to open the integration tab.
   The template you used created an HTTP trigger and an HTTP output binding. Now add your new Azure Cosmos DB input binding.

1. Select **New Input** in the **Inputs** column.
   A list of all possible input binding types is displayed.

1. In the list, select **Azure Cosmos DB**, and then select **Select**.
   This action opens the Azure Cosmos DB input configuration page. Next, you'll set up a connection to your database.

1. If the following message appears in the **Azure Cosmos DB input** configuration UI telling you that you must install an extension, select **Install**. 

    ![The default JavaScript implementation of an HTTP-triggered Azure function](../media/extension-not-installed.png)

    > [!NOTE]
    > It can take a while to install an extension, so please wait for installation to complete before proceeding to the next step.

1. Next to the **Azure Cosmos DB account connection** box, select **new**.
   This action opens the **Connection** window, which already has **Azure Cosmos DB account** and your Azure subscription selected. The only thing left to do is to select a database account ID.

1. In the "Create a database account" section, you had to supply an ID value. Find that value in the **Database Account** drop-down list, and then click **Select**.

1. A new connection to the database is configured and is shown in the **Azure Cosmos DB account connection** field. If you're curious about what is actually behind this abstract name, click *show value* to reveal the connection string.

You want to look up a bookmark with a specific ID, so let's tie the ID we receive to the binding.

1. In the **Document ID (optional)** field, enter `{id}`. This syntax is known as a *binding expression*. The function is triggered by an HTTP request that uses a query string to specify the ID to look up. Since IDs are unique in our collection, the binding will return either 0 (not found) or 1 (found) documents.

1. Carefully fill out the remaining fields on this page using the values in the following table. At any time, you can click on the information icon to the right of each field name to learn more about the purpose of each field.

    |Setting  |Value  |Description  |
    |---------|---------|---------|
    |Document parameter name     |  **bookmark**       |  The name used to identify this binding in your code.      |
    |Database name     |  [!INCLUDE [cosmos-db-name](./cosmos-db-name.md)]       | The database to work with. This value is the database name we set earlier in this lesson.        |
    |Collection Name     |  [!INCLUDE [cosmos-db-name](./cosmos-coll-name.md)]        | The collection from which we'll read data. This setting was defined earlier in the lesson. |
    |SQL Query (optional)    |   leave blank       |   We are only retrieving one document at a time based on the ID. So, filtering with the Document ID field is a better than using a SQL Query in this instance. We could craft a SQL Query to return one entry (`SELECT * from b where b.ID = {id}`). That query would indeed return a document, but it would return it in a document collection. Our code would have to manipulate a collection unnecessarily. Use the SQL Query approach when you want to get multiple documents.   |
    |Partition key (optional) | **{id}** |  Add the partition key that we defined when we created the [!INCLUDE [cosmos-coll-name](./cosmos-coll-name.md)] Cosmos DB collection earlier.  The key entered here (specified in input binding format `{<key>}`) must match the one in the collection.|

9. Select **Save** to save all changes to this binding configuration.

Now that you have your binding defined, it's time to use it in your function.

## Update function implementation

1. Select your function, [!INCLUDE [func-name-find](./func-name-find.md)], to open *index.js* in the code editor. You've added an input binding to read from your database, so update the logic to use this binding.

2. Replace all code in *index.js* with the code from the following snippet and hit **Save**.

   [!code-javascript[](../code/find-bookmark-single.js)]

An incoming HTTP request triggers the function, and an `id` query parameter is passed to the Cosmos DB input binding. If the database finds a document that matches this ID, then the `bookmark` parameter will be set to the located document. In that case, we construct a response that contains the URL value found in the bookmarked document. If no document is found matching this key, we would respond with a payload and status code that tells the user the bad news.

## Try it out

1. Select **Get function URL** at the top right, select **default (Function key)**, and then select **Copy** to copy the function's URL.

2. Paste the function URL you copied into your browser's address bar. Add the query string value `&id=docs` to the end of this URL and press the `Enter` key on your keyboard to execute the request. You should see a response that includes a URL to that resource.

3. Replace `&id=docs` with `&id=missing`, and observe the response.

    >[!TIP]
    >You can also test the function using the **Test** tab in the function portal UI. You can add a query parameter or supply a request body to get the same results as described in the preceding steps.

In this unit, we created our first input binding manually to read from an Azure Cosmos DB database. The amount of code we wrote to search our database and read data was minimal, thanks to bindings. We did most of our work configuring the binding declaratively, and the platform took care of the rest.

In the next unit, we'll add more data to our bookmark collection through an Azure Cosmos DB output binding.