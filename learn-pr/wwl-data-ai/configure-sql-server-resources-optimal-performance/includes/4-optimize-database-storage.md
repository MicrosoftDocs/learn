To optimize database storage, you should consider proportional fill and tempdb configuration.

## What is proportional fill?

If you are inserting one gigabyte of data into a SQL Server database with two data files, you would expect the size of each of your data files to increase by roughly 512 megabytes. However, this equal growth is not necessarily the case, as SQL Server will insert data into data files in different volumes based on the size of the data file. In the above example, if your data files were both two gigabytes in size, you would expect the even distribution of data. However, if one of your data files was 10 gigabytes, and the other was one gigabyte, roughly 900 MB would go into the ten-gigabyte file, and 100 MB into the one-gigabyte file. While this behavior occurs in any database, with the write-intensive nature of tempdb, an uneven write pattern could cause a bottleneck on the largest file, as more of the writes would happen there.

## Tempdb configuration in SQL Server

SQL Server 2016 changed this behavior, by detecting the number of CPUs available at setup, and configuring the proper number of files, up to 8, and sizing the data files evenly. Additionally, the behaviors of trace flags 1117 and 1118 are built in to the database engine, but only for tempdb. For tempdb heavy workloads, there may be benefits to increasing the number of tempdb files beyond eight, to the number of CPUs on your machine.

SQL Server uses tempdb for much more than storing user-defined temporary tables. Work tables that are used to store intermediate query results, sorting operations, and the version store for row versioning are among just a few of the uses for tempdb. Because of this utilization, it is important both to place tempdb on the lowest latency storage possible, and to properly configure its data files.

Prior to SQL Server 2016, tempdb defaulted to having only one data file. This single file meant that there could be contention for multiple processes trying to access system pages of the tempdb database. One common solution to this contention problem was to enable trace flag 1118, which changed the way extents were allocated. Another common best-practice recommendation was to create multiple tempdb data files. Because SQL Server uses a proportional fill algorithm for databases with multiple data files, it was also important to ensure that those files were the same size and grew at the same rate. To support this many DBAs used trace flag 1117, which forced all databases with multiple data files to grow them at the same rate.
