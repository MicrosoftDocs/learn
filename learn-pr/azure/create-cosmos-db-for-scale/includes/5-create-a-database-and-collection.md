Now that you understand how request units are used to determine database throughput, and how the partition key creates the scale out strategy for your database, you're ready to create your database and collection.

1. Back in the Azure portal, click **Data Explorer** > **New Collection**.
    
    The **Add Collection** area is displayed on the far right, you may need to scroll right to see it.

    ![The Azure portal Data Explorer, Add Collection blade](../media/5-create-a-database-and-collection/azure-cosmosdb-data-explorer.png)

2. In the **Add collection** page, enter the settings for the new collection.

    Setting|Suggested value|Description
    ---|---|---
    Database id|Users|Enter *Users* as the name for the new database. Database names must contain from 1 through 255 characters, and they cannot contain /, \\, #, ?, or a trailing space.
    Collection id|WebCustomers|Enter *WebCustomers* as the name for your new collection. Collection ids have the same character requirements as database names.
    Storage capacity| Unlimited |Use the default value of **Unlimited**. This value is the storage capacity of the database, and enables your database to scale out as needed.
    Partition key|/UserId|UserID is a good partition key for an online retail scenario as so many queries are based around the customers ID.
    Throughput|1000 RU|Change the throughput to 1000 request units per second (RU/s). 1000 is the minimum RU/s value you can set to enable automatic scaling.
    
    For now, do not check the Provision database throughput option and do not add any unique keys to the collection. 
    
3. Click **OK**.

    Data Explorer displays the new database and collection.

    ![The Azure portal Data Explorer, showing the new database and collection](../media/5-create-a-database-and-collection/azure-cosmos-db-new-collection.png)

## Clean up

If you plan to continue working on the modules in this learning path, skip to the [Summary](#summary).

If you do not plan on completing additional modules in this learning path, use the following steps to delete your resources to avoid incurring charges for use of the service.:

1. In the Azure portal, select **Resource groups** on the far left, and then select the resource group you created.  

    If the left menu is collapsed, click ![Expand button](../media/5-create-a-database-and-collection/expand.png) to expand it.

   ![Metrics in the Azure portal](../media/5-create-a-database-and-collection/delete-resources-select.png)

2. In the new window select the resource group, and then click **Delete resource group**.

   ![Metrics in the Azure portal](../media/5-create-a-database-and-collection/delete-resources.png)

3. In the new window, type the name of the resource group to delete, and then click **Delete**.

## Summary

This module has shown you how to create an Azure Cosmos DB account that you can use for real world scenarios like online retail apps. By creating a database with a smart partition key, you'll be able to scale horizontally as your need for data storage grows. You've also learned about request unit needs for your application, and how to set them during account creation so that you can scale up your throughput later, when user demand increases.