After you've migrated your data to Cosmos DB, you'll need to update your applications that access the data. After you've updated the connection strings in your application, you should consider tuning your database.

In this unit, you'll use the Azure portal to find the connection details for your new Cosmos DB database. Then you'll tune Cosmos DB, choose the appropriate consistency level, and think about how to distribute your data geographically. 
## Update connection strings

To view the new connection string for your application, perform the following steps:

1. In the Azure portal, open your Cosmos DB account and select **Quick start**.
1. Select the platform for your application.
1. Copy the connection string for your application and review the sample code snippet.

For more options than the quick start settings, in **Settings**, select **Connection String**. You can then provide security information and receive a specific connection string for your settings.

For more information, see [Connect a MongoDB application to Azure Cosmos DB](https://aka.ms/AA56f9a)

## Tune database for application use

To tune your database for best performance, you should perform the following steps:
Optimize Indexes
By default, all fields are indexed. Indexing all fields is ideal for a system with predominantly read requests. If you have a system with predominantly write requests, you might want to remove some indexes. Consider that some write operations involve both a read and a write action. For example, an order might involve a read to check a credit limit before an order is written.

### Select consistency level

The default consistency level is Session, but you can change this in **Settings**.

### Distribute your data

In the **Settings** for your Azure Cosmos DB account, you can replicate data globally. To improve availability, you should consider having data in at least two regions even if all of your users are in one location.

For more information on tuning your database, see [Post-migration optimization steps when using Azure Cosmos DB's API for MongoDB](https://aka.ms/AA56wz9)
