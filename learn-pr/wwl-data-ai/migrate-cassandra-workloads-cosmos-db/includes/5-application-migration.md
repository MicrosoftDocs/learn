When the data migration is complete, you must reconfigure your client software to connect to Azure. You should also optimize the new database to ensure you get the most from Cosmos DB.

In your video camera manufacturer, the new Cassandra DB database in Azure Cosmos DB is populated and ready to respond to client requests. You must reconfigure the video sharing web application to use the new database. You have also been asked to demonstrate that the performance of the new database is not impacted by poorly configure indexes or its physical distance from users.

Here, you'll learn how to finalize your migration, by configuring connection strings and optimizing performance.

## Update connection strings

After you've migrated your data to Cosmos DB, you'll need to update your applications that access the data. After you've updated the connection strings in your application, consider tuning your database.

> [!NOTE]
> It's possible to migrate a Cassandra database to the Cosmos DB SQL API. Tools such as the Azure Cosmos DB data migration tool and Azure Data Factory can help you with this migration. However, this migration would require extensive recoding in any client applications that you have created for Cassandra. By migrating to the Cosmos DB Cassandra API, you can get all the advantages of Cosmos DB in the Azure cloud, without much redevelopment of client apps. Often, only the connection string must be changed.

In the Azure portal, open your Cosmos DB account and select **Quickstart**.
Select the platform for your application.
Copy the connection string for your application and review the sample code snippet.

For more options than the quickstart settings, in **Settings**, select **Connection String**. You can then provide security information and receive a specific connection string for your settings.

## Tune database for application use

To tune your database for optimum performance, perform the following steps:

### 1) Optimize indexes

By default, all fields are indexed, which is optimum for a system with predominantly read requests. If you have a system with predominantly write requests, you might want to remove some indexes. You should consider that some write operations involve both a read and a write action. For example, an order might involve a read to check a credit limit before an order is written.

### 2) Select consistency level

The default consistency level is **Session**, but you can change this in **Settings**.

### 3) Distribute your data

In **Settings** for your Azure Cosmos DB account, you can replicate data globally. To improve availability, consider having data in at least two regions even if all of your users are in one location.
