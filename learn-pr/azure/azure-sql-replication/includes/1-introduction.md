## Common data replication use cases and tools

For the purposes of this Microsoft Learn Module, we will use the umbrella term "replication tools" to cover all change data tracking, loading, streaming, synchronizing functionalities. Therefore, we will refer to Change Data Capture (CDC), SQL Data Sync, and Change Tracking as "replication tools".

Tracking, loading, replicating, and streaming data changes among different source and target systems is important for many organizations and business needs. There is a wide range of use cases and business scenarios that require replication tools. For instance, imagine that you are the CTO of a healthcare business that sells medical equipment in different regions around the country. You have different inventory databases in each region and you want to ensure that these databases are all replicating data changes to a central country-wide inventory database which offers you a status on each sale. This central database is essential because based on the inventory you have, you know how much more equipment to produce and deliver regionally. Thus, you need to select the right data replication tool that will help you synchronize your central inventory database with all regional databases.

With a multitude of replication tools available and various use cases and business needs, it is often difficult to decide what tools to use in what specific scenarios. Below is a table that highlights some of the common scenarios and the associated tools that could be used in that context. However, please be aware that this is not the most comprehensive list and many other 1st or 3rd party tools could be used in these use cases.

*Common use cases and potential replication tools to use for each*

| Use case | Potential tools |
| ---- | ---- |
| Maintaining a history of all data changes on your database, for auditing purposes | Change Data Capture |
| Synchronizing distributed workloads and globally distributed data | SQL Data Sync, Change Data Capture |
| Ensuring source and target systems are in sync after migrations | SQL Data Sync, Change Data Capture |
| Recording whether changes were made to your database tables (without needing a historical record of all changes) | Change Tracking |

## Additional considerations when selecting a data replication tool

Beyond considering use cases, you should also explore other aspects when selecting a specific data replication tool. Below is a list of common considerations:

### Performance impact

It is important to understand the impact of the selected replication tool on the **size** of your database. For instance, enabling Change Data Capture (CDC) at the level of your database and tables will lead to the creation of several additional system tables on your source database (e.g. the table in which changes are being tracked); similarly, SQL Data Sync will create additional artifacts on your database. This is why it is important to assess your database tier size limitations before enabling replication tools and upgrade your tier if necessary.

Additionally, understanding the impact of enabling replication tools on the **log throughput** is important. For instance, CDC's scan/cleanup are part of user workload (user’s resources are used). Performance impact can be substantial since entire rows are added to the change tables and for updates operations pre-image is also included. This translates to a log generation that doubles (or more) when CDC is used (relative to when CDC is not enabled).

### Tracking, loading, or streaming?

It is important to clarify that some of the tools explored in this module do not stream the data changes. For instance, CDC tracks your enabled source tables for changes and records these changes in change tables on the same source database. However, if you want to replicate those changes to other targets, you must integrate with other streaming tools (e.g. Azure Data Factory). Unlike CDC, SQL Data Sync automatically syncs your source and target databases, either uni-directionally (e.g. SQL Server -> Azure SLQ DB) or bidirectionally (e.g. SQL Server -> Azure SQL DB -> SQL Server). However, Change Tracking only tracks whether and which rows have been changed and what the type of change was (e.g. insert / update / delete).

### Latency

It is important to consider the latency that of these tools offers (i.e. how long it takes for changes to be replicated from source to destination). For instance, if you are working on apps that support financial transactions, you may be highly sensitive to increased latencies; however, if you are streaming your data changes for analytics or auditing purposes, you might not be that concerned about latency.

### Documented limitations

The public documentation for the features covered includes limitations that it is good to be aware of. Thus, make sure to study those limitations before enabling replication tools on your databases and tables.

Overall, it is advised that you test your workload thoroughly before enabling data replication tools on your databases in production.
