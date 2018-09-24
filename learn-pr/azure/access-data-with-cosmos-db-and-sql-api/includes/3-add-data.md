Adding data to your Azure Cosmos DB database is simple. You open the Azure portal, navigate to your database, and use the Data Explorer to add JSON documents to the database. There are more advanced ways to add data, but we'll start here because the Data Explorer is a great tool to get you acquainted with the inner workings and functionality provided by Azure Cosmos DB.

## What is the Data Explorer?
The Azure Cosmos DB Data Explorer is a tool included in the Azure portal that is used to manage data stored in an Azure Cosmos DB. It provides a UI for viewing and navigating data collections, as well as for editing documents within the database, querying data, and creating and running stored procedures.

## Add data using the Data Explorer

1. Sign into the [Azure portal for sandbox](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you activated the sandbox with.

    > [!IMPORTANT]
    > Login to the Azure portal and the sandbox with the same account.
    >
    > Login to the Azure portal using the link above to ensure you are connected to the sandbox, which provides access to a Concierge Subscription.

1. Click **All services** > **Databases** > **Azure Cosmos DB**. Then select your account, click **Data Explorer**, and then click **Open Full Screen**.

   ![Create new documents in Data Explorer in the Azure portal](../media/3-azure-cosmosdb-data-explorer-full-screen.png)

2. In the **Open Full Screen** box, click **Open**.

    The web browser displays the new full-screen Data Explorer, which gives you more space and a dedicated environment for working with your database.

3. To create a new JSON document, in the SQL API pane, expand **Clothing**, click **Documents**, then click **New Document**.

   ![Create new documents in Data Explorer in the Azure portal](../media/3-azure-cosmosdb-data-explorer-new-document.png)

4. Now, add a document to the collection with the following structure. Just copy and paste the following code into the **Documents** tab, overwriting the current content:

     ```json
    {
        "id": "1",
        "productId": "33218896",
        "category": "Women's Clothing",
        "manufacturer": "Contoso Sport",
        "description": "Quick dry crew neck t-shirt",
        "price": "14.99",
        "shipping": {
            "weight": 1,
            "dimensions": {
            "width": 6,
            "height": 8,
            "depth": 1
           }
        }
    }
     ```

5. Once you've added the JSON to the **Documents** tab, click **Save**.

    ![Copy in JSON data and click Save in Data Explorer in the Azure portal](../media/3-azure-cosmosdb-data-explorer-save-document.png)

6. Create and save one more document clicking **New Document** again, and copying the following JSON object into Data Explorer and clicking **Save**.

     ```json
    {
        "id": "2",
        "productId": "33218897",
        "category": "Women's Outerwear",
        "manufacturer": "Contoso",
        "description": "Black wool pea-coat",
        "price": "49.99",
        "shipping": {
            "weight": 2,
            "dimensions": {
            "width": 8,
            "height": 11,
            "depth": 3
           }
        }
    }
     ```

7. Confirm the documents have been saved by clicking **Documents** on the left-hand menu.

    Data Explorer displays the two documents in the **Documents** tab.

In this unit, you added two documents, each representing a product in your product catalog, to your database by using the Data Explorer. The Data Explorer is a good way to create documents, modify documents, and get started with Azure Cosmos DB.
