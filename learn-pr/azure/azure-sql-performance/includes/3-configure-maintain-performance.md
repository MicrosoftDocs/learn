Understanding the capabilities of Azure SQL is important for delivering consistent performance. It is also important to understand what options and restrictions you have to configure Azure SQL Managed Instance and Databases that can impact performance. This includes topics of the tempdb database, configuring databases, configuring files and filegroups, configuring max degree of parallelism, using Resource Governor, and maintaining indexes and statistics.

## Tempdb

Tempdb is an important shared resource used by applications. Ensuring the right configuration of tempdb can affect your ability to deliver consistent performance. Tempdb is used the same with Azure SQL like SQL Server but your ability to configure tempdb is different including placement of files, the number and size of files, and tempdb configuration options.

Tempdb files are always automatically stored on local SSD drives so I/O performance shouldn't be an issue.

SQL Server professionals often use more than one database file to partition allocations for tempdb tables.  For Azure SQL Database, the number of files are scaled with the number of vCores (Ex. 2 vCores=4 files,…) with a max of 16. The number of files is not configurable through T-SQL against tempdb but by changing the deployment option. The maximum size of tempdb is scaled per number of vCores. You get 12 files with Azure SQL Managed Instance independent of vCores and at the current time you cannot change this number.

Database options MIXED_PAGE_ALLOCATION is set to OFF and AUTOGROW_ALL_FILES is set to ON. This cannot be configured but they are the recommended defaults as with SQL Server.

Currently, the Tempdb Metadata Optimization feature in SQL Server 2019, which can alleviate heavy latch contention, is not available in Azure SQL.

## Database configuration

Database configuration is most commonly done with the T-SQL ALTER DATABASE and ALTER DATABASE SCOPED CONFIGURATION statements. Many of the configuration options for performance are available for Azure SQL. Consult the ALTER DATABASE and ALTER DATABASE SCOPED CONFIGURATION T-SQL reference for the differences between SQL Server, Azure SQL Database, and Azure SQL Managed Instance.

For performance, one option that is not available to change is the recovery model of the database. The default is full recovery and cannot be modified. This ensures your database can meet Azure service level agreements (SLAs). Therefore, minimal logging for bulk operations is not supported. Minimal logging for bulk operations is supported for tempdb.

## Files and filegroups

SQL Server professionals often use files and filegroups to improve I/O performance through physical file placement. Azure SQL does not allow users to place files on specific disk systems. However, Azure SQL has resource commitments for I/O performance with regards to rates, IOPS, and latencies so abstracting the user from physical file placement can be a benefit.

Azure SQL Database only has one database file (Hyperscale typically has several) and the maximum size is configured through Azure interfaces. There is no functionality to create additional files.

Azure SQL Managed Instance supports adding database files and configuring sizes but not physical placement of files. The number of files and file sizes for Azure SQL Managed Instance can be used to improve I/O performance. In addition, user defined filegroups are supported for Azure SQL Managed Instance for manageability purposes.

## MAXDOP configuration

Max degree of parallelism (MAXDOP), which can affect the performance of individual queries, works exactly the same in the engine for Azure SQL as SQL Server. The ability to configure MAXDOP may be important to delivering consistent performance in Azure SQL. You can configure MAXDOP in Azure SQL similar to SQL Server using the following techniques:

- ALTER DATABASE SCOPED CONFIGURATION to configure MAXDOP is supported for Azure SQL
- sp_configure for 'max degree of parallelism' is supported for Managed Instance.
- MAXDOP query hints are fully supported
- Configuring MAXDOP with Resource Governor is supported for Managed Instance

## Resource Governor

Resource Governor is a feature in SQL Server that can be used to control resource usage for workloads through I/O, CPU, and memory. While Resource Governor is used behind the scenes for Azure SQL Database, Resource Governor is only supported for Azure SQL Managed Instance for user defined workload groups and pools.

## Index maintenance

Index creation and maintenance for Azure SQL is exactly the same as SQL Server. For example, creating, rebuilding and reorganization of indexes is fully supported as with SQL Server. This includes online and resumable indexes.

## Statistic maintenance

Statistics are the same for Azure SQL as with SQL Server. Automatic statistics options for databases are available for Azure SQL just like SQL Server.

Now that you have learned some of the configuration and maintenance options for performance for Azure SQL, complete the following knowledge check before proceeding to the next unit.