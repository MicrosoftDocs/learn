After you complete the migration of data to Azure SQL Database, it's important to assess and optimize the configuration of your new database to give the best service to your users.

You've completed the migration of all databases to Azure for your bicycle manufacturer. Now, you want to make sure that the new databases are resilient, robust, and able to handle the load that you expect users to place on them.

In this unit, you'll explore the post migration steps required to ensure service continuity of your database in backup, high availability, disaster recovery, and scalability.

## Define backup and recovery options for Azure SQL Database

In Azure SQL Database, backups are taken automatically and kept for between 7 and 35 days.  With the DTU model, a database under the Basic tier benefits from seven-day retention. Standard and Premium databases have 35 days retention. Under the vCore purchasing model, the default retention period is seven days, which can be increased up to 35 days.

Backups are stored on Azure read-access geo-redundant storage (RA-GRS) to ensure they're still available during a data center outage. To provide a point-in-time restore (PITR) capability, Azure SQL Database does transaction log backups every 5-10 minutes. There are differential backups every 12 hours. Alongside PITR, geo-restore is used to restore databases to another geographical region during a region-wide outage.

Backups are kept for longer than 35 days by using the long-term retention capability. You can keep weekly, monthly, or full backups in this capability for up to 10 years in RA-GRS storage containers. This backup retention is ideal for organizations that have to meet legislative or regulatory requirements.

## Define high availability options for Azure SQL Database

Azure SQL Database high availability is provided out of the box to guarantee that your database keeps running 99.99% of the time. You won't have the worry of maintenance operations and outages. When the underlying SQL instance fails over, downtime isn't noticeable if you use retry logic within your application.

There's a choice of two high-availability architectural models used in Azure SQL Database, depending on the service tier you've selected:

### Basic, Standard, and General Purpose service tier availability

On this tier, high availability is achieved by using the high availability and reliability of the remote premium storage tier. You can transfer the compute from the active node to other nodes.

### Premium and Business Critical service tier availability

High availability on this tier is achieved by using a technology similar to Always On availability groups. Both compute and storage are replicated to additional nodes.

## Define disaster recovery options for Azure SQL Database

Azure SQL Database provides the following business continuity capabilities:

- **Active geo-replication**: provides a readable secondary replica for a given database in the same or different Azure region. Active-geo replication asynchronously replicates data by using the same technology as Always On availability groups. Up to four secondary replicas are permitted, and can be used for read-only workloads. You invoke the failover process using the application or via manual procedures with the Azure CLI, PowerShell, Transact-SQL, or the REST API.  
- **Auto failover groups**: builds on the capabilities of active geo-replication by replicating and failing over a group of databases on an Azure SQL Database server.  Grouping the databases enables you to recover multiple databases if there's an outage.
- **Geo-restore**: uses geo-redundant backups to recover a database to any Azure SQL Database server, in any region. Backups are stored on geo-replicated storage, which means there's a delay between when the backup is taken, and when it's replicated to the other region.
- **Zone-redundant databases**: by default, replicas in the premium availability model are located in the same physical data center.  Azure availability zones allow different replicas to be hosted in different zones (data centers) within the same region.

## Define service scalability options for Azure SQL Database

Azure SQL Database supports vertical scaling, known as scale-up, and scale-down, and horizontal scaling (scaling out), known as sharding (an architectural design pattern).

Single and elastic pool databases can be scaled up and down to accommodate increases in application workload. Scaling might occur at a particular point in the day, month, or year when the workload peaks or troughs. When you scale a database up or down, the performance objective of the database will increase or decrease.  

Single and elastic pool databases can be *sharded*. Sharding is where data is distributed across multiple databases, known as shards. Each shard is an individual database that contains data relevant to the shard. Relevance is decided by the sharding key, which is used to distribute the data via data-dependent routing. This sharding is useful when parts of the data are only available in different regions, or where the connections should be load balanced.

Vertical scaling can be done via the Azure portal, PowerShell, T-SQL, Azure CLI, or the REST API.  Horizontal scaling is done using the Elastic Database Client Library.  You can use the Elastic Database Split-Merge tool to split and merge sharded databases.