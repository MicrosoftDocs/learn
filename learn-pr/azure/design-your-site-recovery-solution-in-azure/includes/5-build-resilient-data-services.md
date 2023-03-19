You can take different measures to build resilience for your data.

Your organization has multiple workloads spread across different environments. All workloads rely on data that's kept safe and timely.

In this unit, you learn how Always On Availability Groups help replicate your data. You see how automated backups and auto failover in Azure SQL Database helps keep data safe. You also learn about the Azure Cosmos DB geo-replication feature. How you can use it to transparently replicate data to other regions, and have the data accessible for reading and writing.

## Replicate databases with Always On Availability Groups

Always On Availability Groups help you achieve high availability for SQL Server databases running on virtual machines.

You can store specified groups of your databases in an availability replica. Always On Availability Groups incorporate the concept of a primary replica and a secondary replica. Your primary replica holds primary databases; your secondary replica holds synchronized secondary copies of your primary databases. If there's a failure, the secondary replica is used as a failover target. Your primary replica is readable and writeable. Data is synchronized between each primary database and each associated secondary database.

You can also set secondary replicas to be readable. This way, clients can access your data from multiple databases and increased demand is between multiple replicas.

Always On Availability Groups run on top of a Windows Server Failover Cluster that consists of a group of machines working in unison. This architecture gives you high availability for the workloads that run on those machines. With Always On Availability Groups, each node (machine) in your cluster hosts a replica, whether primary or secondary, and each replica holds a group of databases.

![Availability Group example.](../media/5-availability-group-example.png)

Always On Availability Groups can be configured in Azure by creating two availability sets. Create one availability set for your Windows Server Failover Cluster nodes, and another for the domain controllers. The Windows Server Failover Cluster needs to contain at least three machines. There should be one SQL machine for the primary replica, and another for the secondary replica in the cluster. There should be a third machine as a file share witness server, or you can use an Azure file share as a witness.

## Failover for Azure SQL Databases

You can use SQL Database auto failover groups to configure the failover and replication of groups of databases on a SQL Database server. You put together defined policies that can perform failovers based on your needs. If necessary, you could also manually trigger failovers. SQL Database auto failover can automatically fail over your databases to a secondary server in a secondary region if a failure occurs. SQL Database auto failover secondary databases can be used as readable secondary databases. You can use these secondary databases to service read access to data for any connecting clients and spread usage and demand between primary and secondary databases.

If you're using automatic failover policies, and a failure occurs on at least one database in your primary database group. An automatic failover is triggered to the secondary databases. Your endpoints remain the same during failover. When the issue that caused the failure has been addressed and you're ready, you can fail back to your original location. You can manually fail over your groups back to their original location.

Databases in one database server can be included in a single auto failover group. You could also put all databases in an elastic pool in a single failover group. When primary databases are part of an elastic pool, your secondary databases are also provisioned in an elastic pool. This pool has the same name as the primary elastic pool.

## Automated backup for Azure SQL Database

Azure SQL Database can make backups of your databases that are stored between 7 and 35 days. SQL Database uses geo-redundant storage to store backups and provides read access to your data in a different region. Your databases are safe, even if something happens to a data center. You can extend the retention of backups for up to 10 years by establishing long-term retention policies on single databases or elastic pools. All database backups in SQL Database are encrypted at rest and all SQL databases you create automatically have transparent data encryption enabled by default.

SQL Database does backups automatically for you in the background. It creates backups of your databases at different intervals, depending on the type of backup. For example, SQL Database creates backups for transaction logs at an interval of 5-10 minutes. SQL Database also creates full backups of your databases every week, and differential backups for any data that has changed since the last full backup, every 12 hours. The first full backup happens as soon as your database is created. How long it takes to complete a full backup depends on the size of your database. Backups are kept in storage blobs that provide read access, and are then copied into a paired data center.

Databases can be restored to a version that's been backed up. If you've configured long-term retention, this backup might be for up to 10 years. You can restore deleted databases back to the time before their deletion, and up to the retention limit in your retention policy. SQL Database can restore databases to a different geographical region. This process is done through geo-restore, which makes it possible to recover databases from one region to another in case something happens to an entire region.

## Geo-replicate with Azure Cosmos DB

Azure Cosmos DB is a low-latency, multi-model database service that enables you to distribute data globally and easily scale, elastically and rapidly.

In Azure Cosmos DB, all data is replicated transparently in the regions you've set for your Azure Cosmos DB account. Azure Cosmos DB saves data inside containers that make up your database, and all your containers are partitioned.

All your partitions are replicated across each region. Inside every region, your partitions are copied before each copy is distributed between different fault domains.

Your data is replicated at least four times. You can set up an Azure Cosmos DB account, and configure your Azure Cosmos DB database to be distributed across five regions. Because you've configured this database for five regions, Azure Cosmos DB guarantees that you have at least 4 x 5 copies of all your data.

You should configure your Azure Cosmos DB database to span at least two regions. The more regions you have, the more resilient your data becomes. You should also explicitly set your Azure Cosmos DB database to have multiple write regions, so that you can perform read and write operations from all your regions.

You can also configure zone redundancy for some regions. With this feature, Azure Cosmos DB puts replicas of data across multiple different availability zones in any single region, providing extra resiliency.
