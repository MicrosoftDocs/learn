To justify a SQL Server migration to budget holders, it helps to know what features of SQL Server can provide a competitive advantage for your systems.

Suppose that, after researching what SQL Server on Linux is, you want to ensure that the current features available meet the Wide World Importers' requirements for existing and future data processing.

Here, you will learn about the principal features of SQL Server on Linux.

## Performance

SQL Server on Linux supports the competing needs of fast transactional throughput, and responsive analytics, by offering a Hybrid Transactional Analytical Processing (HTAP) solution. HTAP makes use of some of SQL Server's core performance technologies:

### In-Memory Online Transaction Processing (OLTP)

Combining memory-optimized tables and compiled stored procedures, Wide World Importers could see substantial performance gains on its transactional tables, for example writing and reading session state for the e-commerce website.

### Columnstore Index

SQL Server supports both row-data and compressed columnar data. Transactional tables can also have a columnstore index that can be used instead of the row-store when writing analytical queries. The use of columnstore indexes would allow the current analytical suite to preserve transactional performance while also running real-time reporting queries over the operational data.

### Query Store

Your DBA team completes a monthly performance tuning task to ensure that the correct query plans are being used. They monitor query performance, revert query plans where changes in execution plans have impacted performance, report on the top 10 longest running queries to the development lead, and check on any resource locks. The Query Store supports all these tasks, and you can enable it with Transact-SQL:

```sql
ALTER DATABASE <database name>
SET QUERY_STORE (OPERATION_MODE = READ_WRITE);
```

### Automatic Tuning and Adaptive Query Processing

You can enable automatic plan choice correction after the Query Store is enabled. With Automatic Tuning enabled, SQL Server monitors query performance, and if a new query plan performs worse than the previous version, it can replace the new plan with the better performing previous version. The option is available at the database level, with an `ALTER` statement:

```sql
ALTER DATABASE <database name>
SET AUTOMATIC_TUNING ( FORCE_LAST_GOOD_PLAN = ON );
```

Adaptive Query Processing is a term that encompasses three approaches to improving query performance:

- Batch mode memory feedback
- Batch mode adaptive joins
- Interleaved execution

## Security

SQL Server on Linux supports advanced security features such as Always Encrypted, row-level security and dynamic data masking to protect data on disk, in memory, or in transit:

- **Always Encrypted** ensures that those users who own data can view and process it, and those users who manage it, like the DBA team, cannot view it. Encryption and decryption take place in the client driver, making the process transparent to client applications. In the database, you can encrypt the columns that contain your company's sensitive information. The data is secure because it is encrypted before being transmitted and stored in its encrypted form in the database.
- **Row-level security** controls access to specific rows within a table based on who is executing the query. You can control who has access to the data, for example, by group membership or execution context.
- **Dynamic data masking** masks a portion of the data. Four different kinds of masks are available; masking all the data in a column, masking email addresses, random number masking for numerical data, and custom string masking. You could use custom string masking, for example, to mask all but the last four digits in a Social Security Number.

## SQL Server Agent

SQL Server Agent runs scheduled, automated tasks, and maintenance jobs. SQL Server Agent supports the following three workloads:

- Transact-SQL jobs
- DB mail
- Log shipping

By default SQL Server Agent is disabled, but it is installed and can be enabled using the command line `mssql-conf` utility.

```bash
sudo /opt/mssql/bin/mssql-conf set sqlagent.enabled true
sudo systemctl restart mssql-server
```

## High availability

SQL Server has many ways to specify the level of fault tolerance that is acceptable. SQL Server on Linux supports Always On availability groups and Always On failover cluster instances. Both of these options require the **mssql-server-ha** package installed on each server. Linux supports clustering via **Pacemaker**, which is an equivalent to Windows Server Failover Clustering (WSCF), albeit not as tightly integrated into the host operating system.

If there is more flexibility in what is acceptable for downtime, Log Shipping via SQL Agent can provide warm standbys, which you can use to recover from server loss.

Another solution for SQL Server on Linux is its ability to be run in Docker containers orchestrated with Kubernetes. Kubernetes ensures that there is always a node running SQL Server. If that node fails, another instance is bootstrapped automatically. If more robust availability is required, an Always On availability group can be run in containers.

## Other notable features

### Graph Support

SQL Server has native support for storing and querying graph-based data. SQL Server stores data as a series of entities (nodes) and the relationships (edges) between them.

### Full-text search

Full-text searches enable users to run queries against text data that respect linguist rules. For example, when you search for the word "run", a full-text search returns results that include forms of the word "run", such as "ran" and "running".

This feature is not installed by default. On Linux, you enable it by installing the `mssql-server-fts` package.

### ETL workloads

SQL Server Integration Services (SSIS) packages can run on SQL Server on Linux. They are not restricted to running only against SQL Server on Linux. They can also connect to Microsoft SQL Server running on Windows on-premises or in the cloud, or SQL Server running in Docker.

You must write and maintain SSIS packages on a Windows machine running SQL Server Data Tools.