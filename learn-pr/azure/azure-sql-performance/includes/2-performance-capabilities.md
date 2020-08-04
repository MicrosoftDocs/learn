Let's start by looking at some of the performance capabilities of Azure SQL as compared to SQL Server.

Since Azure SQL Database and Managed Instance are based on the SQL Server database engine, most of the capabilities that come with SQL Server are also available with Azure SQL. There are a few capabilities that have an impact on the performance of your databases that you should consider when deploying and configuring Azure SQL including maximum capacities, indexes, In-Memory OLTP, partitions, SQL Server 2019 enhancements, and Intelligent Performance capabilities.

## Memory, CPU, and I/O capacities

Choosing the right deployment and service tier for Azure SQL Database or Managed Instance can be important for performance. In the second Module you learned about the various deployment options for Azure SQL. Consider these important maximum capacities as part of your deployment:

- Azure SQL Database can support up to 128 vCores, 4TB Memory, and a 4TB Database size.
- The Hyperscale deployment option supports up to 100TB databases.
- Azure SQL Managed Instance can support up to 80 vCores, 400Gb Memory, and a 8TB Database size.
- The # of vCores and service tier also affects other resource capacities (Ex. maximum transaction log rates, IOPS, I/O latency, memory, ...)
- Windows Job Objects are used to support certain resource limits such as memory. Use **sys.dm_os_job_object** to find true capacities for your deployment.

## Indexes

Indexes are often critical to query performance for SQL Server and that is not different for Azure SQL. Here are important points to consider about indexes and Azure SQL:

- All index types, clustered and non-clustered, are supported across Azure SQL.
- Online and resumable indexes are fully supported. Online and resumable indexes can be critical for maximum availability.
- Columnstore indexes are available in almost all service tiers. Check the documentation for any exceptions.

## In-memory OLTP

In-memory OLTP is a capability for transaction latency sensitive applications, such as applications that involve a high number of concurrent users modifying data. Here are important points related to In-memory OLTP and Azure SQL:

- Memory optimized tables are only available in Business Critical Tiers.
- The memory optimized FILEGROUP is pre-created in Azure SQL Database and Managed Instance when a database is created (even for General Purpose tiers).
- The amount of memory for memory optimized tables is a percentage of the vCore dependent memory limit.

## Partitions

Partitions are often used with SQL Server for tables with a large number of rows to improve performance by sub-dividing data by a column in the table. Consider these points for partitions and Azure SQL:

- Partitions are supported for Azure SQL Database and Managed Instance.
- You can only use filegroups with partitions with Azure SQL Managed Instance.

## SQL Server 2019 performance enhancements

Many of the new enhancements for performance in SQL Server 2019 such as Intelligent Query Processing are available in Azure SQL. However, not all specific improvements are yet in Azure SQL. For example, Tempdb Metadata Optimization is still planned for Azure SQL but not available yet.

## Intelligent performance

Intelligent performance covers capabilities in Azure SQL that include intelligent query processing, automatic plan correction, and automatic tuning (including indexes). You will learn more about these features in a later unit.