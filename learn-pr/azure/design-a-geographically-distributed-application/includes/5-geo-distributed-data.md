The final part of the application to consider is the data storage tier. You want to make sure that data is both readable and writable for full functionality after a region-wide failure.

In the shipment tracking portal, you have chosen to use Azure Front Door to send all requests to App Services in East US. If East US fails, Front Door detects the failure and sends requests to duplicate App Services components in West US. In your original, single-region architecture, you stored relational data in Azure SQL Database and semi-structured data in Cosmos DB. Now, you want to understand how you can ensure that both databases remain available if East US fails. 

Here, you will learn how to replicate data between regions and how to ensure that failover can occur quickly if necessary.

<!-- TODO: The design team should recreate this diagram in MSLearn style -->

![Multi-region architecture databases](../media/5-multi-region-web-app-data.png)

## Azure SQL Database

To create a mult-region implementation of Azure SQL Database to store relational data, you can use either:

- **Active geo-replication**
- **Auto-failover groups**

<!-- Note for reviewers: Acrolinx suggests no hyphen in "Auto-failover" but all SQL Database documentation includes one. -->

Let's examine these options in more detail:

### Active geo-replication

Azure SQL Database can automatically replicate a database and all its changes from one database to another with the active geo-replication feature. Only the primary logical server hosts a writable copy of the database. You can create up to four other logical servers that host read-only copies of the database. 

For the shipment tracking portal, create a secondary database in West US and configure geo-replication from East US. When a regional failure occurs, Front Door redirects user requests to App Services in West US. App Services and Azure Functions can get access the relational data because a copy has already been replicated to West US.

This change is automatic but remember that the secondary database in West US is read-only. If a user tries to modify data, for example by creating a new shipment, errors may arise. You can manually initiate a failover to West US as soon as you notice the problem in that Azure portal. If you want to automate this process, your developers can write code that calls the `failover` method in the Azure SQL Database REST API.

> [!NOTE]
> Active geo-replication is not supported by managed instances of Azure SQL Database. Managed instances are designed to make it simple to migrate data from an on-premises SQL Server while maintaining security. If you're using a managed instance, consider using failover groups instead. 

### Auto-failover groups

An auto-failover group is a group of databases where data is automatically replicated from a primary to one or more secondary servers. This design is much like active geo-replication and uses the same data replication method. However, you can automate the response to a failure by defining a policy. 

For the shipping portal, create a secondary database in West US. Add a policy that fails over the primary replica of the database to West US if a catastrophic failure occurs in East US. If that happens, the West US replica automatically becomes the writable primary database and full functionality is maintained.  

Consider using an auto-failover group if you want to automate the failover of the writeable database without writing custom code to trigger it. Also use auto-failover groups if your database runs in a managed instance of Azure SQL Database.

> [!IMPORTANT]
> The replication that underlies both active geo-replication and auto-failover groups is asynchronous. When a change is applied to the primary replica, an acknowledgement is sent to the client and the transaction is considered complete. After that, replication occurs. If a failure occurs, the latest changes made in the primary database, may not have replicated to the secondary. Remember that, after a disaster, the most recent database changes may have been lost.

## Cosmos DB

Things are easier with Cosmos DB, which is a multi-model database, able to store relational data, semi-structured data, and other forms of data. That's because Cosmos DB was designed from the ground up as a multi-regional cloud database system. Even if you run Cosmos DB in a single region, data is replicated to multiple instances across different fault-domains for the best availability. 

When you make a Cosmos DB account multi-region, you can choose from these modes:

- **Multi-region accounts with multiple write regions.** All copies of the database are writable at all times. If a region fails, no failover is necessary.
- **Multi-region accounts with a single write region.** Only the primary region contains writable databases. Data is replicated to secondary regions but data here is read-only. By default, if the primary region fails, updates are disabled but you can select **enable automatic failover**, so that Cosmos DB automatically detects a regional outage and fails over the primary, writable copy of the database to another region. 

> [!IMPORTANT]
> In Cosmos DB, data replication is synchronous. When a change is applied, the transaction is not considered complete until it has been replicated to a quorum of replicas. Then an acknowledgement is sent to the client. When a failure occurs, no recent changes are lost because replication has already occured.