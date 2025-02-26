## Common data tracking use cases and tools

We'll use the umbrella term "data tracking tools" to cover all change data tracking, loading, streaming, and synchronizing functionalities. Therefore, we'll refer to change data capture (CDC) and change tracking as "data tracking tools" for Azure SQL Database. 

There's a wide range of use cases and business scenarios that require data tracking tools to track, load, synchronize, and stream data changes. For instance, imagine that you're the CTO of a healthcare business that sells medical equipment in different areas around the country/region. You have different inventory databases in each region and you want to ensure that all these databases are synchronizing data changes to a central nationwide inventory database, which offers you a status on each sale. This central database is essential because based on the inventory you have, you know how much more equipment to produce and deliver regionally. Thus, you need to select the right data-tracking tool that will help you synchronize your central inventory database with all regional databases.

With a multitude of data tracking tools available and various use cases and business needs, it's often difficult to decide what tools to use in what specific scenarios. The following table highlights some of the common scenarios and the associated tools that you could use in that context. However, this is not the most comprehensive list, and you could also use many other first- or third-party tools in these use cases.

Popular use cases and potential data tracking tools:

| Use case | Potential tools |
| ---- | ---- |
| Maintain a history of all data changes on your database for auditing purposes | Change data capture (CDC), SQL Ledger |
| Synchronize distributed workloads and globally distributed data | Change data capture (CDC) |
| Ensure source and target systems are in sync after migrations | Change data capture (CDC) |
| Record whether changes were made to your database tables (without needing a historical record of all changes) | Change tracking |
| Send data from SQL Server to Azure SQL Database | SQL Server Replication, Azure Data Factory, SQL Server Integration Services |

## Common considerations when selecting a data-replication tool

Beyond considering use cases, you should also explore other aspects when selecting a specific data tracking tool. Here's a list of common considerations:

### Performance impact

It's important to understand the impact of the selected data tracking tool on the **size** of your database. For instance, enabling change data capture (CDC) at your database's level and tables will lead to the creation of several additional system tables on your source database (for example, the table in which changes are being tracked). This is why it's important to assess your database tier-size limitations before enabling data tracking tools and consider upgrading your tier, if necessary.

Additionally, it's important to understand the impact of enabling data tracking tools on the **log throughput**. For instance, CDC's scan/cleanup are part of user workload (user's resources are used). The performance impact can be substantial because entire rows are added to the change capture tables, and a pre-image is also included for update operations. This translates to a log generation that could more than double when using CDC (relative to when CDC isn't enabled).

### Latency

It's important to consider the latency that these tools offer (that is, how long it takes for changes to be synchronized from source to destination). For instance, if you're working on apps that support financial transactions, you might be highly sensitive to increased latencies; however, if you're streaming your data changes for analytics or auditing purposes, you might not be that concerned about latency.

### Tracking, loading, or streaming?

It's important to clarify that the tools explored in this module do not stream the data changes. For instance, CDC tracks your enabled source tables for changes and records these changes in change tables on the same source database. 

Similarly, change tracking only tracks whether and which rows have been changed and the change type (insert, update, or delete). It's up to you to decide how to use that data. We'll discuss how to capture changed data using CDC and change tracking in this Learn module.

[SQL Ledger](/sql/relational-databases/security/ledger/ledger-overview), though a powerful tool in the Database Engine to ensure data trust based on the blockchain, also provides changed data tracking but does not send it out of the database for you. For more information, see [Configure a ledger database in Azure SQL Database](/sql/relational-databases/security/ledger/ledger-how-to-configure-ledger-database?view=azuresqldb-current&preserve-view=true&tabs=Portal%2Ct-sql2&pivots=as1-azure-sql-database).

However, if you want to synchronize data changes to other databases, you must integrate with other data movement tools.

### Other tools for data movement

[Azure Data Factory](/azure/data-factory/introduction) is an industry-leading cloud-based Extract, Transform, and Load (ETL) tool to move data from heterogeneous data sources to data targets anywhere in your enterprise network, Azure, other clouds, or Microsoft Fabric. Also available inside [Microsoft Fabric](/fabric/data-factory/data-factory-overview), Data Factory provides a web-based development environment to accomplish data movement from basic tasks to complex data integration projects. SQL Server Integration Services (SSIS) is a feature of SQL Server that provides similar ETL capabilities for data integration, using servers on-premises or in Azure Virtual Machines. Azure Data Factory Integration Runtimes is a way to run SSIS packages using serverless cloud resources, providing lift-and-shift capability for SSIS packages to run in Azure.

[SQL Server Replication](/sql/relational-databases/replication/sql-server-replication) is a time-honored feature within the SQL Server Database Engine. It's used to move and synchronize data, from whole databases to partial tables, from one data source to another. Replication uses the server resources of a SQL Server instance. [Azure SQL Database can be the target of Replication from a SQL Server](/azure/azure-sql/database/replication-to-sql-database), but not a source. 

[SQL Data Sync is a feature to be retired in 2027](/azure/azure-sql/database/sql-data-sync-retirement-migration?view=azuresql-db&preserve-view=true) and shouldn't be considered for future investments in application development.

### Documented limitations

The public documentation for the features covered includes limitations of which you should be aware. Make sure to study those limitations before enabling data tracking tools on your databases and tables.

Overall, you must test your workload thoroughly before enabling data tracking tools on your production databases.
