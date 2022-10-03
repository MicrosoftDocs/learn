System builders have plenty of choices when it comes to which database (or databases) to use in solutions. You may want to use one type of database to store system settings and parameter data and another type to store user data. Many solutions today mix and match. Having options is essential.

Azure offers plenty of options including many open source database solutions. In this unit, we'll cover some of these options and how you can use Azure to deploy them. First, though, let's look at Azure's Cosmos DB as a NoSQL database option.

## Azure Cosmos DB

Azure Cosmos DB is a versatile NoSQL solution.
It supports multiple models and multiple APIs such as MongoDB, Gremlin graph and SQL queries on a document-based database.

It's global in nature and available everywhere Azure has data centers. Replication is straightforward. Automatically replicate data globally for increased availability and to reduce latency.

Azure Cosmos DB is backed by an SLA that includes specific metrics for latency, availability, media operations and resource operations. For demanding workloads that can use a NoSQL data store, Azure Cosmos DB is worth investigating.

## Open source options

Azure also supports popular open source database systems to run on Azure Database. **PostgreSQL** for instance is widely used and on Azure, you'll get the stability, security and high availability cloud computing offers.

**MySQL** is supported on Azure as well. This popular database solution offers simple and flexible pricing. You can use various languages and frameworks with MySQL. MySQL on Azure is MySQL Community Edition (available under the GPLv2 license). In addition, Azure offers MySQL Flexible Server that provides more granular control and flexibility over management functions and configuration settings.

Another OSS database option on Azure is **MariaDB**, which was created as a fork of MySQL. This option can have advantages over MySQL because of its numerous storage engine options such as: cache and index performance, OSS feature and extensions support and ColumnStore storage engine for analytical workloads.

## Azure SQL Database

Azure SQL Database is a fully managed platform as a service. The SLA for availability is 99.99%. Many features of stand-alone SQL Server installations are available. If you need other features, you can choose Azure SQL Managed Instance instead. Azure SQL database is also included in Azure Monitor for monitoring and alerts.

### Elastic pool

Elastic pool is a collection of single databases with a shared set of resources, such as CPU and memory.

Databases can be moved in and out of an elastic pool. Elastic pool is great for databases with unpredictable usage demands. This option helps administrators manage costs and ensure resources are available when needed.

### Azure SQL Managed Instance

This is a new flavor of SQL database that is targeted towards those who are migrating existing SQL databases. It provides all the advantages of a PaaS solutions including automatic backups, availability, and scaling.

It stands out from the other SQL Server options in that it's nearly 100 percent compatible with SQL Server. The solution also offers full isolation and security.

With this offering, Microsoft has introduced new purchasing options that enable you to use your license investments and provides saving opportunities through a cloud billing model.
