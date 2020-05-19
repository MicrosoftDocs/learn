After you've migrated your data to Cosmos DB, you'll need to update your applications that access the data. After you've updated the connection strings in your application, consider tuning your database.

## Update connection strings

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
