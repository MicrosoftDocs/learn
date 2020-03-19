You now understand how request units are used to determine database throughput. You also know how to use partition keys to create a scale-out strategy for your database. 

Now you're ready to create your database and container. In this exercise, you'll create an Azure Cosmos DB Database named **"Products"** and Container named **"Clothing"** and set your partition key and throughput values.

::: zone pivot="csharp"

## TODO: C# content goes here

::: zone-end

::: zone pivot="java"

## TODO: Java content goes here

::: zone-end

::: zone pivot="cli"

## Creating your database and container

1. In the Azure portal, select **Data Explorer** from your Cosmos DB resource and then click the **New Container** button in the toolbar.

    The **Add Container** area is displayed on the far right. You may need to scroll right to see it.

    ![The Azure portal Data Explorer, Add Container pane](../media/5-azure-cosmosdb-data-explorer.png)

1. In the **Add Container** page, enter the settings for the new container.

    Setting | Suggested value | Description
    --------|-----------------|-------------
    Database id    | Products   | Enter *Products* as the name for the new database. Database names must be 1 to 255 characters in length, and must not contain /, \\, #, ?, or a trailing space.
    Container id  | Clothing   | Enter *Clothing* as the name for your new container. Container ids have the same character requirements as database names.
    Partition key  | productId  | productId is a good partition key for an online retail scenario, as so many queries are based around the product ID.
    Throughput     | 1000 RU    | Change the throughput to 1000 request units per second (RU/s). 
    
    For now, don't check the **Provision database throughput** option, and don't add any unique keys to the container.
    
1. Click **OK**. The Data Explorer displays the new database **Products** and the container **Clothing**.

    ![The Azure portal Data Explorer, showing the new database and container](../media/5-azure-cosmos-db-new-collection.png)

::: zone-end

## Summary

In this unit, you used your knowledge of partition keys and request units to create a database and container with throughput and scaling settings appropriate for your business needs.
