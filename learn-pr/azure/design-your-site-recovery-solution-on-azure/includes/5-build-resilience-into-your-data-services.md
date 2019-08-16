There are different measures you can take to to build resilience for your data.

Your organization has multiple workloads spread across different environments. All of your workloads rely on data that is kept safe and timely.

In this unit, you will learn how Always On Availability Groups can help you replicate your data. You will learn how automated backups and auto-failover in Azure SQL Database can help you keep your data safe. You will also learn how you can use Azure Cosmos DB's geo-replication feature to transparently replicate data to other regions and have it accessible for reading and writing.

## Replicate databases with Always On Availability Groups

Always On Availability Groups can help you achieve high availability for your SQL databases running on SQL Server.

You can store specified groups of your databases in an availability replica. Always On Availability groups incorporates the concept of a primary replica and a secondary replica. Your primary replica holds your primary databases. Your secondary replica holds synchronized secondary copies of each of your primary databases, and can be used in the event of a failure as a failover target. You can have up to 8 secondary replicas. Your primary replica is readable and writeable. Your data is synchronized between each of your primary databases and each associated secondary databases.

You can set your secondary replicas to be readable as well. This way, clients can access your data from multiple databases and your clients' increased demand can be shared between multiple replicas.

Always On Availability Groups run on top of a Windows Server Failover Cluster. A Windows Server Failover Cluster consists of a group of machines that work in unison to provide you with high availability for the workloads that are run on those machines. With Always On Availability Groups, each node (machine) in your cluster hosts a replica, whether primary or secondary, and each replica holds a group of databases.

![Availability Group example](../media/5-availability-group-example.png)

You can configure Always On Availability Groups in Azure. You create two availability sets. You create one availability set for your Windows Server Failover Cluster nodes, and one for the domain controllers. Each availability set must be in its own subnet, but both sharing one single virtual network. You must also configure an internal load balancer between the two availability sets. You must have at least 3 machines in your Windows Server Failover Cluster. You must have one SQL machine for the primary replica, and another one for the secondary replica in the cluster. You must also have a third machine as a file share witness server.

## Automate backups with Azure SQL Database

Azure SQL Database is capable of making backups of your databases that are each stored from 7 to 35 days for you. Azure SQL database uses geo-redundant storage to store your backups and provides read-access to your data in a different region. This means that your databases are safe even if something happens to a data center. You can extend the retention of your backups for up to 10 years by setting up long-term retention policies on single databases or elastic pools. All of the backups of your databases in Azure SQL Database are encrypted at-rest. This is because all Azure SQL databases you create will automatically have transparent data encryption enabled on them by default

Azure SQL Database can perform backups automatically for you in the background. Azure SQL Database can create full backups of your databases, on different intervals depending on the type of backups. For example, Azure SQL Database can create backups for your transaction logs at an interval of 5-10 minutes. It can also create full backups of your databases every week, and differential backups (any data that has changed since the last full backup) every 12 hours. Your first full backup happens as soon as your database is created. How long it takes to perform your full backup depends on the size of your database. The backups are stored in storage blobs that provide read-access, and they are then copied over into a paired data center.

You can restore your databases to a version of itself that was backed up in the past. This backup can be up to 10 years if you have configured long-term retention. You can restore deleted databases back to the time before their deletion and up to the limit of the retention period in your retention policy. Azure SQL Database can restore your databases to a different geographical region for you. It does this through geo-restore, which makes it possible for you to recover your databases from one region to another region case something happens to an entire region.

## Auto-failover your SQL Databases

SQL Database auto-failover groups make it possible for you to configure the failover and replication of groups of databases in a SQL Database server. You can put together defined policies that can perform failovers for you based on your needs. You can also manually trigger failovers yourself if you needed to. SQL Database auto-failover can automatically failover your databases to a secondary server in a secondary region if a failure occurs. SQL Database auto-failover secondary databases can be used as readable secondary databases. This means that you can use them to service read access to data for any connecting clients and you can spread usage and demand between your primary and secondary databases.

If you are using automatic failover policies, and a failure occurs on at least one database in your primary database group, an automatic failover is triggered to failover to your secondary databases. Your endpoints remain the same during failover. Once the issue that has caused the failure has been addressed and you are ready, you can failback to your original location. You can perform a manual failover of your groups back to their original location yourself.

You can include all of your databases that are in one database server, in one single auto-failover group. All of your databases in an elastic pool can also be put into a single failover group. When your primary databases are part of an elastic pool, then your secondary databases themselves are also provisioned in an elastic pool. This pool will also have the same name as your primary elastic pool.

## Geo-replicate with Cosmos DB

Azure Cosmos DB is a low-latency, multi-model database service that will allow you to distribute your data globally and easily scale elastically and rapidly.

In Azure Cosmos DB, all of your data is replicated transparently in the regions you have set for your Cosmos DB account. Azure Cosmos DB saves your data inside of containers which make up your database, and all of your containers are partitioned.

Each of your partitions are replicated across each of your regions. Your regions will contain all of your data that is in the partitions of your Cosmos DB containers. Inside of a every single region, your partitions are copied and each copy is then distributed between different fault domains.

All of your data is replicated at least 4 times. This means that you can decide to, for example set up a Cosmos DB account, and configure your Cosmos DB database to be distributed across 5 regions. Because you have configured your Cosmos DB database for 5 regions, Cosmos DB will guarantee you that you will have at least 4 x 5 copies of all of your data.

You should configure your Cosmos DB database to span at least 2 regions. The more regions you have, the more resilient your data becomes. You should also explicitly set your Cosmos DB database to have multiple-write regions. This means all of your regions will make it possible for you to perform read and write operations.

In addition, you can configure zone redundancy for some regions. This feature makes it possible for Azure Cosmos DB to put replicas of your data across multiple different availability zones in any single region and so provide you with additional resiliency within each single region.
