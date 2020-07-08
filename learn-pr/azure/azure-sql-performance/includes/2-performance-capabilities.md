Let's start by looking at some of the performance capabilities of Azure SQL as compared to SQL Server.

Since Azure SQL Database and Managed Instance are based on the SQL Server database engine, most of the capabilities that come with SQL Server are also available with Azure SQL. There are a few capabilities that have an impact on the performance of your databases that you should consider when configuring and managing Azure SQL.

## Memory, CPU, and I/O capacities

Choosing the right deployment and service tier for Azure SQL Database or Managed Instance can be important for SQL performance. Consider these important capacities:

- Azure SQL Database can support up to 128 vCores, 4TB Memory, and 4TB Database size.
- The Hyperscale deployment option supports up to 100TB databases.
- Azure SQL Managed Instance can support 80 vCores, 400Gb Memory, and 8TB Database size.
- The # of vCores and service tier also affects other resource capacities (Ex. Log Rates)
- Windows Job Objects are used to support certain resource limits such as memory. Use sys.dm_os_job_object to find true capacities.

## Indexes

Indexes are often critical to performance. Here are important points to consider about indexes and Azure SQL:

- All index types are supported across Azure SQL.
- Online and resumable indexes are fully supported.
- Columnstore indexes are available in almost all service tiers. Check the documentation for any exceptions.

## In-Memory OLTP

In-Memory OLTP is a capability for transaction latency sensitive applications, such as applications that involve a high number of concurrent users modifying data. Here are important points related to In-Memory OLTP and Azure SQL:

- Memory optimized tables are only available in Business Critical Tiers.
- The Memory Optimized FILEGROUP is pre-created in Azure SQL Database and Managed Instance when a database is created.
- The amount of memory for memory optimized tables is a percentage of the vCore dependent memory limit.

## Partitions

Partitions are often used for tables with a large number of rows to improve performance by sub-dividing data by a column in the table. Consider these points for partitions and Azure SQL:

- Partitions are supported for Azure SQL Database and Managed Instance
- You can only use filegroups with Partitions with Managed Instance.

## SQL Server 2019 performance enhancements

Many of the new enhancements for performance such as Intelligent Query Processing are available in Azure SQL. However, not all specific improvements are yet in Azure SQL. For example, Tempdb Metadata Optimization is still planned for Azure SQL but not available yet.

## Intelligent performance

Intelligent performance covers capabilities in Azure SQL that include intelligent query processing, automatic plan porrection, and automatic tuning (including indexes).