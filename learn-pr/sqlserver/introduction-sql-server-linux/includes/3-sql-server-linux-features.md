To justify a SQL Server migration to budget holders, it helps to know what features of SQL Server can provide a competitive advantage for your systems.

After researching what SQL Server on Linux is, you want to ensure that the current available features meet the requirements of Wide World Importers for existing and future data processing.

Here, you learn about the principal features of SQL Server on Linux.

## Performance

SQL Server on Linux supports the competing needs of fast transactional throughput, and responsive analytics, by offering a Hybrid Transactional Analytical Processing (HTAP) solution. HTAP uses some of SQL Server's core performance technologies:

### In-Memory Online Transaction Processing (OLTP)

If they combined memory-optimized tables and compiled stored procedures, Wide World Importers could see substantial performance gains on its transactional tables; for example, writing and reading session state for the e-commerce website.

### Columnstore index

SQL Server supports both row-data and compressed columnar data. Transactional tables can also use a columnstore index instead of the row-store index when writing analytical queries. The use of columnstore indexes would allow the current analytical suite to preserve transactional performance while also running real-time reporting queries over the operational data.

### Query Store

Your DBA team completes a monthly performance tuning task to ensure the correct query plans are used. They monitor query performance and revert query plans where changes in execution plans were affecting performance. The team also reports on the top 10 longest-running queries to the development lead and checks on any resource locks. The Query Store supports all these tasks, and you can enable it with Transact-SQL:

```sql
ALTER DATABASE <database_name>
SET QUERY_STORE (OPERATION_MODE = READ_WRITE);
```

### Automatic tuning and intelligent query processing

You can enable automatic plan choice correction after the Query Store is enabled. With Automatic Tuning enabled, SQL Server monitors query performance. If a new query plan does worse than the previous version, it can replace the new plan with the better performing previous version. The option is available at the database level with an `ALTER` statement:

```sql
ALTER DATABASE <database_name>
SET AUTOMATIC_TUNING ( FORCE_LAST_GOOD_PLAN = ON );
```

Intelligent Query Processing (IQP) is a set of features, many of which are new in SQL Server 2022, that automatically improve and optimize the performance of your workload. The IQP features include:

- **Adaptive Joins (Batch Mode)**: Adaptive joins dynamically select a join type during runtime based on actual input rows.

- **Interleaved Execution**: Uses the actual cardinality of the multi-statement table valued function encountered on first compilation instead of a fixed guess.

- **Memory grant feedback (Batch Mode)**: If a batch mode query has operations that spill to disk, add more memory for consecutive executions. If a query wastes > 50% of the memory allocated to it, reduce the memory grant size for consecutive executions.

- **Approximate Count Distinct**: Provide approximate `COUNT DISTINCT` for big data scenarios with the benefit of high performance and a low memory footprint.

- **Batch Mode on Rowstore**: Provide batch mode for CPU-bound relational DW workloads without requiring columnstore indexes.

- **Memory grant feedback (Row Mode)**: If a row mode query has operations that spill to disk, add more memory for consecutive executions. If a query wastes > 50% of the memory allocated to it, reduce the memory grant size for consecutive executions.

- **Scalar UDF Inlining**: Scalar UDFs are transformed into equivalent relational expressions that are "inlined" into the calling query, often resulting in significant performance gains.

- **Table Variable Deferred Compilation**: Uses the actual cardinality of the table variable encountered on first compilation instead of a fixed guess.

- **Approximate Percentile**: Quickly compute percentiles for a large dataset with acceptable rank-based error bounds to help make rapid decisions by using approximate percentile aggregate functions.

- **Cardinality estimation (CE) feedback**: Automatically adjusts cardinality estimates for repeating queries to optimize workloads where inefficient CE assumptions cause poor query performance. CE feedback identifies and uses a model assumption that better fits a given query and data distribution to improve query execution plan quality.

- **Degrees of Parallelism (DOP) feedback**: Automatically adjusts degree of parallelism for repeating queries to optimize for workloads where inefficient parallelism can cause performance issues. Requires Query Store to be enabled.

- **Parameter Sensitivity Plan optimization**: Parameter Sensitive Plan optimization addresses the scenario where a single cached plan for a parameterized query isn't optimal for all possible incoming parameter values, for example nonuniform data distributions.

- **Memory grant feedback (Percentile)**: Addresses existing limitations of memory grant feedback in a nonintrusive way by incorporating past query execution to refine feedback.

- **Memory Grant feedback persistence**: Provides new functionality to persist memory grant feedback. Requires Query Store to be enabled for the database and in READ_WRITE mode.

- **CE feedback persistence**: Requires Query Store to be enabled for the database and in `READ_WRITE` mode.

- **DOP feedback persistence**: Requires Query Store to be enabled for the database and in `READ_WRITE` mode.

- **Optimized plan forcing**: Reduces compilation overhead for repeating forced queries. For more information, see Optimized plan forcing with Query Store.

IQP doesn't require you to rewrite any code or to change your database schema to take advantage of the best performance. All you have to do is upgrade a database to compatibility level 150 or later:

```sql
ALTER DATABASE <database_name> SET COMPATIBILITY_LEVEL = 160;
```

## Security

SQL Server on Linux supports advanced security features such as Always Encrypted, row-level security and dynamic data masking to protect data on disk, in memory, or in transit. These features are all supported in all editions, including Standard Edition:

- **Transparent Data Encryption (TDE)** encrypts data-at-rest when the data is stored in database files. The data is protected against malicious users both in the database and in backups.

- **Always Encrypted** ensures that only users who own data can view and process it. Users who manage data, like the database administrators, can't view it. If you use Always Encrypted:

  - You can query the encrypted data without first decrypting it.
  - The data is protected at rest, when it's moving into server memory, and when it's moving from the server to the trusted client app.
  - Encryption and decryption take place in the client driver, so that the process is transparent to client applications.
  - Only trusted applications and owners of the data can access it. Application developers and database administrators don't have access to the Column Encryption Key (CEK).

- **Auditing** tracks events that occur on the database engine and who executed those events. The audited events can be stored in event logs or audit files, and you can use them to investigate problems such as attacks and data breaches.

- **Row-level security** controls access to specific rows within a table based on who's executing the query. You control who can access the data, for example, by group membership or execution context.

- **Dynamic data masking** masks a portion of the data. Four different kinds of masks are available: masking all the data in a column, masking email addresses, random number masking for numerical data, and custom string masking. You could use custom string masking, for example, to mask all but the last four digits in a Social Security Number.

- **Data Discovery and Classification** identifies, labels, and reports on the sensitive data in your databases, such as personal data. It's a tool within SQL Server Management Studio (SSMS) that makes it easier to comply with data privacy legislation and harden the databases that contain the most valuable data. Data Discovery and Classification is a service that is part of the Advanced Data Security (ADS) package.

- **Vulnerability Assessment** identifies vulnerabilities in your databases. Once you're aware of the weaknesses that your server configuration and database designs might cause, you can prevent common attacks by mitigating them. Vulnerability Assessment is another ADS service.

## SQL Server Agent

SQL Server Agent runs maintenance jobs and scheduled, automated tasks. SQL Server Agent supports the following three workloads:

- Transact-SQL jobs
- DB mail
- Log shipping

By default, SQL Server Agent is disabled, but it's installed and can be enabled using the command-line `mssql-conf` utility.

```bash
sudo /opt/mssql/bin/mssql-conf set sqlagent.enabled true
sudo systemctl restart mssql-server
```

## High availability

SQL Server has many ways to specify the level of fault tolerance that's acceptable. SQL Server on Linux supports Always On availability groups and Always On failover cluster instances. Both of these options require the `mssql-server-ha` package installed on each server. Linux supports clustering via **Pacemaker**, which is an equivalent to Windows Server Failover Clustering (WSCF), albeit not as tightly integrated into the host operating system.

If there's more flexibility in what's acceptable for downtime, Log Shipping via SQL Agent can provide a warm standby, which you use to recover from server loss.

Another solution for SQL Server on Linux is its ability to run in containers orchestrated with tools such as Kubernetes. Orchestration tools ensure there's always a node running SQL Server. If that node fails, another instance is bootstrapped automatically. When more robust availability is required, an Always On availability group can be run in containers.

## Other notable features

### PolyBase

Many organizations have data in different systems. Perhaps, different teams had different requirements when they selected their system, or the company merged with another company, or for some other historical reason. Traditionally, it's difficult to integrate data across these system boundaries to answer questions for users.

Suppose you have data in SQL Server that records sales for your product catalog, but the data that records how much it costs to make your products, is in an SAP HANA database. You want to create a report that analyzes profit margins, so you need information from both databases. In the past, you could:

- Use an Extract, Transform, Load (ETL) package to migrate data from one database system to the other.
- Query both databases and then write some custom code to join and integrate the results into a single report.

Both these approaches are complex and can require significant development time to get right.

With PolyBase, you can create an external table in SQL Server. An external table is a connection to an external system and a dataset hosted there. Once created, clients can submit queries to the external table in exactly the same way they would to internal tables. `JOIN` queries can integrate data from external tables with internal tables. As you can see, PolyBase can remove the boundaries that different systems impose on your data and make it easier to do the analyses you need on your business data, regardless of its location.

> [!NOTE]
> On Linux operating systems, PolyBase is supported in SQL Server 2019 and later versions. To use it, you must install the `mssql-server-polybase` package, in addition to SQL Server 2022.

### Machine Learning Services

In machine learning, large datasets are used to model the behavior of some complex system. When a model is developed that accurately predicts the observed behavior of the system. The model is used to predict how that system might behave in the future. Sophisticated code libraries, often open-source, were developed in the R and Python languages. These libraries can prepare your dataset, add features to it, train a model, evaluate the accuracy of the trained model, and deploy those models for other clients to call.

SQL Server Machine Learning Services allows you to run these R and Python scripts against the data in your SQL Server databases. You can add the popular machine learning and data science frameworks, including PyTorch, TensorFlow, SciKit-Learn, and others.

> [!NOTE]
> > On Linux operating systems, SQL Server Machine Learning is supported in SQL Server 2019 and later versions. To use it, you must add extra packages. For example, if you want to use Python for all machine learning code, install the `mssql-mlservices-mlm-py-9.4.7` package. The equivalent for R is to install the package `mssql-mlservices-mlm-r-9.4.7`.

### Graph support

SQL Server has native support for storing and querying graph-based data. SQL Server stores data as a series of entities (nodes) and the relationships (edges) between them.

### Full-text search

Full-text searches allow users to run queries against text data that respect linguist rules. For example, when you search for the word `run`, a full-text search returns a result that includes forms of the word `run`, such as `ran` and `running`.

This feature isn't installed by default. On Linux, you enable it by installing the `mssql-server-fts` package.

### ETL workloads

SQL Server Integration Services (SSIS) packages can run on SQL Server on Linux. They're not restricted to running only against SQL Server on Linux. These packages can also connect to Microsoft SQL Server running on Windows on-premises or in the cloud, or SQL Server running in a container.

You must write and maintain SSIS packages on a Windows machine running SQL Server Data Tools.
