Many organizations use a relational database in Azure SQL Database or Microsoft SQL Server to support business applications. These databases are optimized for transactional workloads that store and manipulate operational data. Performing analytical queries on the data in these databases to support reporting and data analysis incurs resource contention that can be detrimental to application performance.

A traditional approach to resolving this problem is to implement an *extract, transform, and load* (ETL) solution that loads data from the operational data store into an analytical store as a batch operation at regular intervals. While this solution supports the analytical workloads required for reporting and data analysis, it suffers from the following limitations:

- The ETL process can be complex to implement and operate.
- The analytical store is only updated at periodic intervals, so reporting doesn't reflect the most up-to-date operational data.

## Azure Synapse Link for SQL

Azure Synapse Link for SQL addresses the limitations of a traditional ETL process by automatically replicating changes made to tables in the operational database to corresponding tables in an analytical database. After the initial synchronization process, the changes are replicated in near real-time without the need for a complex ETL batch process.

![A diagram showing Azure Synapse Link for SQL replicating data from a SQL Database to Azure Synapse Analytics.](../media/synapse-link-sql.png)

In the diagram above, the following key features of the Azure Synapse Link for SQL architecture are illustrated:

1. An Azure SQL Database or SQL Server 2022 instance contains a relational database in which transactional data is stored in tables.
2. Azure Synapse Link for SQL replicates the table data to a dedicated SQL pool in an Azure Synapse workspace.
3. The replicated data in the dedicated SQL pool can be queried in the dedicated SQL pool, or connected to as an external source from a Spark pool without impacting the source database.

### Source and target databases

Azure Synapse Link for SQL supports the following source databases (used as operational data stores):

- Azure SQL Database
- Microsoft SQL Server 2022

> [!NOTE]
> Azure Synapse link for SQL is not supported for Azure SQL Managed Instance.

The target database (used as an analytical data store) must be a dedicated SQL pool in an Azure Synapse Analytics workspace.

The implementation details for Azure Synapse Link vary between the two types of data source, but the high-level principle is the same - changes made to tables in the source database are synchronized to the target database.

### Change feed

Azure Synapse Link for SQL uses the *change feed* feature in Azure SQL Database and Microsoft SQL Server 2022 to capture changes to the source tables. All data modifications are recorded in the transaction log for the source database. The change feed feature monitors the log and applies the same data modifications in the target database. In the case of Azure SQL Database, the modifications are made directly to the target database. When using Azure Synapse Link for SQL Server, the changes are recorded in files and saved to a *landing zone* in Azure Data Lake Gen2 storage before being applied to the target database.

> [!NOTE]
> Change feed is similar to the *change data capture* (CDC) feature in SQL Server. The key difference is that CDC is used to reproduce data modifications in a table in the same database as the modified table. Change feed caches the data modification in memory and forwards it to Azure Synapse Analytics.

After implementing Azure Synapse Link for SQL, you can use system views and stored procedures in your Azure SQL Database or SQL Server database to monitor and manage change feed activity.

> [!TIP]
> Learn more:
> 
> - For more information about change feed, see [Azure Synapse Link for SQL change feed](/sql/sql-server/synapse-link/synapse-link-sql-server-change-feed?azure-portal=true).
> - To learn more about monitoring and managing change feed, see [Manage Azure Synapse Link for SQL Server and Azure SQL Database](/sql/sql-server/synapse-link/synapse-link-sql-server-change-feed-manage?azure-portal=true).
