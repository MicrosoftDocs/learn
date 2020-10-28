Understanding the capabilities of Azure SQL is important for delivering consistent performance. It's also important to understand the options and restrictions you have to configure in Azure SQL Managed Instance and Azure SQL Database that can affect performance. This includes the following:

- Topics of the tempdb database.
- Configuring databases.
- Configuring files and filegroups.
- Configuring max degree of parallelism.
- Using Resource Governor.
- Maintaining indexes and statistics.

## Tempdb

Tempdb is an important shared resource used by applications. Ensuring the right configuration of tempdb can affect your ability to deliver consistent performance. You use tempdb in the same way for both SQL Server and Azure SQL. Note, however, that your ability to configure tempdb is different, including the placement of files, the number and size of files, and tempdb configuration options.

Tempdb files are always automatically stored on local SSD drives, so I/O performance shouldn't be an issue.

SQL Server professionals often use more than one database file to partition allocations for tempdb tables. For Azure SQL Database, the number of files are scaled with the number of vCores (for example, 2 vCores = 4 files) with a maximum of 16. The number of files isn't configurable through T-SQL against tempdb, but you can do so by changing the deployment option. The maximum size of tempdb is scaled per number of vCores. You get 12 files with SQL Managed Instance, independent of vCores.

The database option MIXED_PAGE_ALLOCATION is set to OFF, and AUTOGROW_ALL_FILES is set to ON. This can't be configured, but, as with SQL Server, they are the recommended defaults.

Currently, the tempdb metadata optimization feature in SQL Server 2019, which can alleviate heavy latch contention, isn't available in Azure SQL.

## Database configuration

Commonly, you configure a database with the T-SQL ALTER DATABASE and ALTER DATABASE SCOPED CONFIGURATION statements. Many of the configuration options for performance are available for Azure SQL. Consult the ALTER DATABASE and ALTER DATABASE SCOPED CONFIGURATION T-SQL reference for the differences between SQL Server, Azure SQL Database, and Azure SQL Managed Instance.

For performance, one option that you can't change is the recovery model of the database. The default is full recovery. This ensures your database can meet Azure service-level agreements (SLAs). Therefore, minimal logging for bulk operations isn't supported. Minimal logging for bulk operations is supported for tempdb.

## Files and filegroups

SQL Server professionals often use files and filegroups to improve I/O performance through physical file placement. Azure SQL doesn't allow users to place files on specific disk systems. However, Azure SQL has resource commitments for I/O performance with regard to rates, IOPS, and latencies. In this way, abstracting the user from physical file placement can be a benefit.

Azure SQL Database only has one database file (Hyperscale typically has several), and the maximum size is configured through Azure interfaces. There's no functionality to create additional files.

Azure SQL Managed Instance supports adding database files and configuring sizes but not physical placement of files. The number of files and file sizes for SQL Managed Instance can be used to improve I/O performance. In addition, user-defined filegroups are supported for SQL Managed Instance for manageability purposes.

## MAXDOP configuration

Max degree of parallelism (MAXDOP) can affect the performance of individual queries. SQL Server and Azure SQL handle MAXDOP in the same way. You can configure MAXDOP in Azure SQL, similar to SQL Server, by using the following techniques:

- ALTER DATABASE SCOPED CONFIGURATION to configure MAXDOP is supported for Azure SQL.
- The stored procedure sp_configure for "max degree of parallelism" is supported for SQL Managed Instance.
- MAXDOP query hints are fully supported.
- Configuring MAXDOP with Resource Governor is supported for SQL Managed Instance.

## Resource Governor

Resource Governor is a feature in SQL Server that you can use to control resource usage for workloads through I/O, CPU, and memory. Note that for user-defined workload groups and pools, Resource Governor is supported for SQL Managed Instance, but not supported for Azure SQL Database.

## Index maintenance

Index creation and maintenance for Azure SQL is exactly the same as that for SQL Server. For example, creating, rebuilding, and reorganizing indexes is fully supported, as with SQL Server. This includes online and resumable indexes.

## Statistics maintenance

SQL Server and Azure SQL handle statistics in the same way. Automatic statistics options for databases are available for both.

Now that you have learned some of the configuration and maintenance options for performance for Azure SQL, complete the following knowledge check before proceeding to the next unit.
