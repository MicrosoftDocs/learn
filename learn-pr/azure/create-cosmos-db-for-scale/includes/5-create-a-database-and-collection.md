Now that you understand how request units are used to determine database throughput, and how the partition key creates the scale out strategy for your database, you're ready to create your database and collection.

1. Back in the Azure portal, click **Data Explorer** > **New Collection**.
    
    The **Add Collection** area is displayed on the far right, you may need to scroll right to see it.

    ![The Azure portal Data Explorer, Add Collection blade](../media/5-create-a-database-and-collection/azure-cosmosdb-data-explorer.png)

    ![The Azure portal Data Explorer, Add Collection blade](../media/5-create-a-database-and-collection/azure-cosmosdb-data-explorer-90.png)

2. In the **Add collection** page, enter the settings for the new collection.

    Setting|Suggested value|Description
    ---|---|---
    Database id|Users|Enter *Users* as the name for the new database. Database names must contain from 1 through 255 characters, and they cannot contain /, \\, #, ?, or a trailing space.
    Collection id|WebCustomers|Enter *WebCustomers* as the name for your new collection. Collection ids have the same character requirements as database names.
    Storage capacity| Unlimited |Use the default value of **Unlimited**. This value is the storage capacity of the database, and enables your database to scale out as needed.
    Throughput|1000 RU|Change the throughput to 1000 request units per second (RU/s). 1000 is the RU/s value you can set to enable partitioning. 
    
    For now, do not check the Provision database throughput option and do not add any unique keys to the collection. 
    
    Click **OK**.

    Data Explorer displays the new database and collection.

    ![The Azure portal Data Explorer, showing the new database and collection](../media/5-create-a-database-and-collection/azure-cosmos-db-new-collection.png)

    ![The Azure portal Data Explorer, showing the new database and collection](../media/5-create-a-database-and-collection/azure-cosmos-db-new-collection-90.png)

<!--TODO: Do I need an end of unit wrap up? Do I need to clean up resources?-->