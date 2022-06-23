Delta Lake is designed as a transactional, relational storage layer for Apache Spark; including Spark pools in Azure Synapse Analytics. However, Azure Synapse Analytics also includes a serverless SQL pool runtime that enables data analysts and engineers to run SQL queries against data in a data lake or a relational database.

> [!NOTE]
> You can only *query* data from Delta Lake tables in a serverless SQL pool; you can't *update*, *insert*, or *delete* data.

## Querying delta formatted files with OPENROWSET

The serverless SQL pool in Azure Synapse Analytics includes support for reading delta format files; enabling you to use the SQL pool to query Delta Lake tables. This approach can be useful in scenarios where you want to use Spark and Delta tables to process large quantities of data, but use the SQL pool to run queries for reporting and analysis of the processed data.

In the following example, a SQL `SELECT` query reads delta format data using the `OPENROWSET` function.

```sql
SELECT *
FROM
    OPENROWSET(
        BULK 'https://mystore.dfs.core.windows.net/files/delta/mytable/',
        FORMAT = 'DELTA'
    ) AS deltadata
```

You could run this query in a serverless SQL pool to retrieve the latest data from the Delta Lake table stored in the specified file location.

You could also create a database and add a data source that encapsulates the location of your Delta Lake data files, as shown in this example:

```sql
CREATE DATABASE MyDB
      COLLATE Latin1_General_100_BIN2_UTF8;
GO;

USE MyDB;
GO

CREATE EXTERNAL DATA SOURCE DeltaLakeStore
WITH
(
    LOCATION = 'https://mystore.dfs.core.windows.net/files/delta/'
);
GO

SELECT TOP 10 *
FROM OPENROWSET(
        BULK 'mytable',
        DATA_SOURCE = 'DeltaLakeStore',
        FORMAT = 'DELTA'
    ) as deltadata;
```

> [!NOTE]
> When working with Delta Lake data, which is stored in Parquet format, it's generally best to create a database with a UTF-8 based collation in order to ensure string compatibility.

## Querying catalog tables

The serverless SQL pool in Azure Synapse Analytics has shared access to databases in the Spark metastore, so you can query catalog tables that were created using Spark SQL. In the following example, a SQL query in a serverless SQL pool queries a catalog table that contains Delta Lake data:

```sql
-- By default, Spark catalog tables are created in a database named "default"
-- If you created another database using Spark SQL, you can use it here
USE default;

SELECT * FROM MyDeltaTable;
```

> [!TIP]
> For more information about using Delta Tables from a serverless SQL pool, see [Query Delta Lake files using serverless SQL pool in Azure Synapse Analytics](/azure/synapse-analytics/sql/query-delta-lake-format) in the Azure Synapse Analytics documentation.
