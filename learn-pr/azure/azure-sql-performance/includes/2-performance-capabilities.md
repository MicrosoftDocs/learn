Let's start by looking at some of the performance capabilities of Azure SQL as compared to SQL Server.

Because Azure SQL Database and Azure SQL Managed Instance are based on the SQL Server database engine, most of the capabilities that come with SQL Server are also available with Azure SQL. There are a few capabilities that have an impact on the performance of your databases that you should consider when you're deploying and configuring Azure SQL. These include maximum capacities, indexes, in-memory OLTP, partitions, SQL Server 2019 enhancements, and intelligent performance capabilities.

## Memory, CPU, and I/O capacities

Choosing the right deployment and service tier for Azure SQL Database or SQL Managed Instance can be important for performance. In the second module, you learned about the various deployment options for Azure SQL. Consider these important maximum capacities as part of your deployment:

- Azure SQL Database can support up to 128 vCores, 4 TB memory, and a 4 TB database size.
- The Hyperscale deployment option supports up to 100 TB of database size.
- Azure SQL Managed Instance can support up to 80 vCores, 400 GB memory, and an 8 TB database size.
- The number of vCores and the service tier also affects other resource capacities, such as maximum transaction log rates, IOPS, I/O latency, and memory.
- Windows job objects are used to support certain resource limits, such as memory. Use **sys.dm_os_job_object** to find true capacities for your deployment.

## Indexes

Indexes are often critical to query performance for both SQL Server and Azure SQL. Here are important points to consider about indexes and Azure SQL:

- All index types, clustered and non-clustered, are supported across Azure SQL.
- Online and resumable indexes are fully supported. Online and resumable indexes can be critical for maximum availability.
- Columnstore indexes are available in almost all service tiers. Check the documentation for any exceptions.

## In-memory OLTP

In-memory OLTP is a capability for transaction latency sensitive applications, such as applications that involve a high number of concurrent users who are modifying data. Here are important points related to in-memory OLTP and Azure SQL:

- Memory optimized tables are only available in Business Critical tiers.
- The memory optimized FILEGROUP is pre-created in Azure SQL Database and SQL Managed Instance when a database is created (even for general purpose tiers).
- The amount of memory for memory optimized tables is a percentage of the vCore dependent memory limit.

## Partitions

With SQL Server, you often use partitions for tables with a large number of rows, to improve performance by sub-dividing data by a column in the table. Consider these points for partitions with Azure SQL:

- Partitions are supported for Azure SQL Database and SQL Managed Instance.
- You can only use filegroups with partitions with SQL Managed Instance.

## SQL Server 2019 performance enhancements

Many of the performance features in SQL Server 2019, such as intelligent query processing, are also available in Azure SQL. However, there are some exceptions. For example, tempdb metadata optimization isn't yet available for Azure SQL.

## Intelligent performance

Intelligent performance covers capabilities in Azure SQL that include intelligent query processing, automatic plan correction, and automatic tuning (including indexes). You will learn more about these features in a later unit.