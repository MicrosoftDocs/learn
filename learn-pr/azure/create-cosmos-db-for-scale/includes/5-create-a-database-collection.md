You now understand how request units are used to determine database throughput. You also know how to use partition keys to create a scale-out strategy for your database.

Now you're ready to create a database and container. You can use the Azure portal to create an Azure Cosmos DB database or you can create an Azure Cosmos DB database programmatically. You learn how to do both in this learning module.

In this exercise, you use the Azure portal to create an Azure Cosmos DB database named **Products** and a container named **Clothing**. You also set your partition key and throughput values.

In the next exercise, learn how to create an identical database and container programmatically.

## Create a database and container in the Azure portal

1. You should already be signed in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true). This exercise will be using the Cosmos DB account you created in a previous lesson.  

1. In the Azure portal menu, select **All services** > **Databases** > **Azure Cosmos DB**. Select the account that you created in the previous exercise.

    > [!NOTE]
    > If your sandbox session expired, you'll need to go back to that lesson to reactivate the sandbox and re-create your Azure Cosmos DB account.

1. In the menu for your Azure Cosmos DB account, select **Data Explorer**.

   :::image type="content" source="../media/select-data-explorer.png" alt-text="Screenshot that shows the Data Explorer option in the Cosmos DB menu bar.":::

1. On the Data Explorer toolbar or in the Data Explorer pane, select **New Container**.  
  
    :::image type="content" source="../media/azure-cosmos-db-data-explorer.png" alt-text="Screenshot that shows Data Explorer and the Add Container pane in the Azure portal.":::

1. In the **New Container** pane, enter the following settings for the new container:

    | Setting | Suggested value | Description |
    |---|---|---|
    | Database ID | *Products* | Select **Create new**, and then enter **Products** as the name for the new database. Database names must be 1 to 255 characters in length, and must not contain `/`, `\`, `#`, `?`, or a trailing space. Leave **Share throughput across containers** selected. |
    | Database throughput | Autoscale is selected | Leave **Database Max RU/s** set to 4000 request units per second. |
    | Container ID | *Clothing* | Enter **Clothing** as the name for your new container you create by using the Azure portal. Container IDs have the same character requirements as database names. |
    | Partition key | */productId* | productId is a good partition key for an online retail scenario because many queries are based on the product ID. |
  
1. Scroll down, accept the defaults for any remaining options, and then select **OK**.

    It might take a while for the database and container to be created. The Data Explorer displays the new database **Products** and the container **Clothing**.

    :::image type="content" source="../media/azure-cosmos-db-new-collection.png" alt-text="Screenshot that shows Data Explorer and the new database and container in the Azure portal.":::

In this exercise, you used the Azure portal with your knowledge of partition keys and request units to create a database and container, with throughput and scaling settings that are appropriate for your business needs.
