To optimize database storage, you should consider proportional fill and tempdb configuration.

## Describe proportional fill

When inserting 1 gigabyte of data into a SQL Server database with two data files, you might expect each file to increase by approximately 512 megabytes. However, this isn't always the case. SQL Server distributes data based on the size of each file. For instance, if both data files are 2 gigabytes, the data would be evenly distributed. But if one file is 10 gigabytes and the other is 1 gigabyte, around 900 MB would go into the larger file and 100 MB into the smaller one. This behavior is common in any database, but in the write-intensive tempdb, an uneven write pattern can create a bottleneck in the largest file, as it handles more writes.

## Tempdb configuration in SQL Server

SQL Server detects the number of available CPUs during setup and configures the appropriate number of files, up to eight, with even sizing. Additionally, the behaviors of trace flags 1117 and 1118 are integrated into the database engine, but only for tempdb. For tempdb-heavy workloads, it may be beneficial to increase the number of tempdb files beyond eight, matching the number of CPUs on your machine.

SQL Server uses tempdb for various tasks beyond just storing user-defined temporary tables. It's used for work tables that store intermediate query results, sorting operations, and the version store for row versioning, among other purposes. Due to this extensive utilization, it's crucial to place tempdb on the lowest latency storage available and to properly configure its data files.

Before SQL Server 2016, tempdb defaulted to a single data file, leading to contention when multiple processes tried to access system pages. To address this issue, enabling trace flag 1118 was a common solution, as it changed the way extents were allocated. Another best practice was to create multiple tempdb data files. Since SQL Server uses a proportional fill algorithm for databases with multiple data files, it was crucial to ensure these files were the same size and grew at the same rate. To support this, many database administrator used trace flags 1117, which forced all databases with multiple data files to grow at the same rate.
