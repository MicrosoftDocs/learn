You now understand how request units are used to determine database throughput. You also know how to use partition keys to create a scale-out strategy for your database.

Now you're ready to create your database and container. You can use the Azure portal to create an Azure Cosmos DB database, or you can create an Azure Cosmos DB database programmatically.

In this exercise, you'll use the Azure portal to create an Azure Cosmos DB database named **"Products"** with a container named **"Clothing"**, and set your partition key and throughput values.

However, if you would rather create an Azure Cosmos DB database and container programmatically, you can use the next exercise.

## Creating your database and container

1. Sign into the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the account you activated the sandbox with. 

1. On the Azure portal menu, select **All services**.

1. Select **Databases** > **Azure Cosmos DB**. Select your account, and then click **Data Explorer**.

1. Click the **New Container** button in the toolbar.
    
    The **Add Container** area is displayed on the far right. You may need to scroll right to see it.

    ![The Azure portal Data Explorer, Add Container pane](../media/5-azure-cosmosdb-data-explorer.png)

1. In the **Add Container** page, enter the following settings for the new container.

    | Setting | Suggested value | Description |
    |---|---|---|
    | Database id  | Products | Enter *Products* as the name for the new database. Database names must be 1 to 255 characters in length, and must not contain /, \\, #, ?, or a trailing space. |
    | Throughput | 1000 RU | Change the throughput to 1000 request units per second (RU/s). |
    | Container id | Clothing | Enter *Clothing* as the name for your new container. Container IDs have the same character requirements as database names. |
    | Partition key | /productId | productId is a good partition key for an online retail scenario, as so many queries are based around the product ID. |
    
1. Accept the defaults for any remaining options, and then click **OK**. The Data Explorer displays the new database **Products** and the container **Clothing**.

    ![The Azure portal Data Explorer, showing the new database and container](../media/5-azure-cosmos-db-new-collection.png)

## Summary

In this exercise, you used the Azure portal with your knowledge of partition keys and request units to create a database and container, with throughput and scaling settings that are appropriate for your business needs.
