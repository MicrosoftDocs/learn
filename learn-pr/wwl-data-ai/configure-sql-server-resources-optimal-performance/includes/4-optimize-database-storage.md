To optimize database storage, you should consider proportional fill and tempdb configuration.

## Understand I/O performance

I/O performance can be critical to a database application. Azure SQL abstracts you from physical file placement, but there are methods to ensure you get the I/O performance you need.

Input/output per second (IOPS) might be important to your application. Be sure you've chosen the right service tier and vCores for your IOPS needs. Understand how to measure IOPS for your queries on-premises if you're migrating to Azure. If you have restrictions on IOPS, you might see long I/O waits. In the vCore purchasing model, you can scale up vCores or move to Business Critical or Hyperscale if you don't have enough IOPS.  For production workloads, when using DTU, we recommend moving to the Premium tier.

I/O latency is another key component for I/O performance. For faster I/O latency for Azure SQL Database, consider Business Critical or Hyperscale. For faster I/O latency for SQL Managed Instance, move to Business Critical or increase the file size or the number of files for the database. Improving transaction log latency might require you to use multistatement transactions.

### Files and filegroups

SQL Server professionals often use files and filegroups to improve I/O performance through physical file placement. Azure SQL doesn't allow users to place files on specific disk systems. However, Azure SQL has resource commitments for I/O performance regarding rates, IOPS, and latencies. In this way, abstracting the user from physical file placement can be a benefit.

Azure SQL Database only has one database file (Hyperscale typically has several), and the maximum size is configured through Azure interfaces. There's no functionality to create more files.

Azure SQL Managed Instance supports adding database files and configuring sizes, but not physical placement of files. You can use the number of files and file sizes for SQL Managed Instance to improve I/O performance. In addition, user-defined filegroups are supported for SQL Managed Instance for manageability purposes.

## Describe proportional fill

When inserting 1 gigabyte of data into a SQL Server database with two data files, you might expect each file to increase by approximately 512 megabytes. However, this isn't always the case. SQL Server distributes data based on the size of each file. For instance, if both data files are 2 gigabytes, the data would be evenly distributed. But if one file is 10 gigabytes and the other is 1 gigabyte, around 900 MB would go into the larger file and 100 MB into the smaller one. This behavior is common in any database, but in the write-intensive tempdb, an uneven write pattern can create a bottleneck in the largest file, as it handles more writes.

## Configure Tempdb in SQL Server

SQL Server detects the number of available CPUs during setup and configures the appropriate number of files, up to eight, with even sizing. Additionally, the behaviors of trace flags 1117 and 1118 are integrated into the database engine, but only for `tempdb`. For tempdb-heavy workloads, it may be beneficial to increase the number of tempdb files beyond eight, matching the number of CPUs on your machine. 

You use `tempdb` in the same way for both SQL Server and Azure SQL. Note, however, that your ability to configure `tempdb` is different, including the placement of files, the number and size of files, and `tempdb` configuration options.

SQL Server uses tempdb for various tasks beyond just storing user-defined temporary tables. It's used for work tables that store intermediate query results, sorting operations, and the version store for row versioning, among other purposes. Due to this extensive utilization, it's crucial to place tempdb on the lowest latency storage available and to properly configure its data files.

The database files of `tempdb` are always automatically stored on local SSD drives, so I/O performance shouldn't be an issue.

SQL Server professionals often use more than one database file to partition allocations for `tempdb` tables. For Azure SQL Database, the number of files is scaled with the number of vCores (for example, two vCores equals four files) with a maximum of 16. The number of files isn't configurable through T-SQL against `tempdb`, but you can configure it by changing the deployment option. The maximum size of `tempdb` is scaled per number of vCores. You get 12 files with SQL Managed Instance, independent of vCores.

The database option `MIXED_PAGE_ALLOCATION` is set to *OFF*, and `AUTOGROW_ALL_FILES` is set to *ON*. You can't configure this, but, as with SQL Server, these are the recommended defaults.

The `tempdb` metadata optimization feature introduced in SQL Server 2019, which can alleviate heavy latch contention, isn't currently available in Azure SQL Database or Azure SQL Managed Instance.

## Database configuration

Commonly, you configure a database with the T-SQL `ALTER DATABASE` and `ALTER DATABASE SCOPED CONFIGURATION` statements. Many of the configuration options for performance are available for Azure SQL. Consult the [ALTER DATABASE](/sql/t-sql/statements/alter-database-transact-sql) and [ALTER DATABASE SCOPED CONFIGURATION](/sql/t-sql/statements/alter-database-scoped-configuration-transact-sql) T-SQL reference for the differences between SQL Server, Azure SQL Database, and Azure SQL Managed Instance.

In Azure SQL Database, the default recovery model is full recovery, which ensures that your database can meet Azure service-level agreements (SLAs). This means that minimal logging for bulk operations isn't supported, except for `tempdb`, where minimal logging is allowed.

### MAXDOP configuration

Max degree of parallelism (MAXDOP) can affect the performance of individual queries. SQL Server and Azure SQL handle `MAXDOP` in the same way. When `MAXDOP` is set to a higher value, more parallel threads are used per query, potentially speeding up query execution. However, this increased parallelism requires extra memory resources, which can lead to memory pressure and affect storage performance. For example, when compressing rowgroups into a columnstore, parallelism requires more memory, which can result in memory pressure and rowgroup trimming.

Conversely, setting MAXDOP to a lower value can reduce memory pressure, allowing the storage system to perform more efficiently. This is important in environments with limited memory resources or high storage demands. By carefully configuring MAXDOP, you can balance query performance and storage efficiency, ensuring optimal use of both CPU and storage resources.

You can configure MAXDOP in Azure SQL, similar to SQL Server, by using the following techniques:

- `ALTER DATABASE SCOPED CONFIGURATION` to configure `MAXDOP` is supported for Azure SQL.
- The stored procedure `sp_configure` for "max degree of parallelism" is supported for SQL Managed Instance.
- `MAXDOP` query hints are fully supported.
- Configuring `MAXDOP` with Resource Governor is supported for SQL Managed Instance.
