In this section you will learn about common configuration and maintenance tasks for performance for Azure SQL as it compares to SQL Server.

## Configuring Tempdb

Consider these differences with regards to tempdb configurtion from Azure SQL and SQL Server.

- Tempdb files are always automatically stored on local SSD drives so I/O perfornance shouldn't be an issue.
- For Azure SQL Database, the number of files are scaled with the number of vCores (2 vCores=4 files,…) with a max of 16. The number of files is not configurable. The maximum size of tempdb is scaled per number of vCores.
- You get 12 files with Azure SQL Managed Instance independent of vCores but you can increase # files with T-SQL
- The options MIXED_PAGE_ALLOCATION = OFF and AUTOGROW_ALL_FILES = ON and cannot be configured.
- Tempdb Metadata Optimization not supported (but in the plans for the future)
- 
## Database Configuration

Database configuration is most commonly done with the T-SQL ALTER DATABASE statement. Many of the configuration options for performance are available for Azure SQL. Consult the ALTER DATABASE T-SQL reference for the differences between SQL Server, Azure SQL Database, and Azure SQL Managed Instance.

For performance, one option that is not available to change is the recovery model of the database. The default is full recovery and cannot be modified. Therefore, minimal logging for bulk operations is not supported. Minimal logging for bulk operations is supported for tempdb.

## Files and Filegroups

- Azure SQL Database does not support any modification or creation of files or filegroups.
- Azure SQL Managed Instance supports adding files and sizes but not physical placement.
- The number of files and file sizes for Azure SQL Managed Instance can be used to turn I/O performance.
- User defined filegroups are supported for Azure SQL Managed Instance.

## Configuring MAXDOP

Degree of parallelism works exactly the same in the engine for Azure SQL as SQL Server. You can configure max degree of parallelism (MAXDOP) similar to SQL Server:

- ALTER DATABASE SCOPED CONFIGURATION to configure MAXDOP is supported for Azure SQL
- sp_configure for 'max degree of parallelism' is supported for Managed Instance.
- MAXDOP Query hints fully supported
- Configuring MAXDOP with Resource Governor is supported only for Managed Instance

## Resource Governor

Resource Governor is supported for Azure SQL Managed Instance for user defined workload groups and pools.

## Maintaining Indexes

Index creation and maintenance for Azure SQL is exactly the same as SQL Server.
For example, rebuilding and reorganization of indexes is fully supported as with SQL Server. This includes online and resumable indexes.

## Maintaining Statistics

Statistics are the same for Azure SQL as with SQL Server. Automatic statistics options for databases are available for Azure SQL just like SQL Server.