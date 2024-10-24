Organizations often face challenges in managing and analyzing their data due to the complexity of integrating various data sources, ensuring data consistency, and maintaining real-time data availability. SQL Database in Microsoft Fabric addresses these challenges by providing a unified platform that simplifies data integration, enhances data consistency, and ensures near real-time data availability.

## Integrate with mirroring

One of the key features of SQL Database in Microsoft Fabric is its ability to mirror databases from Azure SQL Database directly into Fabric's OneLake. 

:::image type="content" source="../media/5-mirroring.png" alt-text="Diagram of Fabric Database Mirroring for Azure SQL Database.":::

This mirroring process ensures that data is continuously replicated in near real-time, eliminating the need for complex Extract, Transform, Load (ETL) processes. By doing so, it reduces the total cost of ownership and accelerates the time-to-insight, allowing businesses to unlock business intelligence, artificial intelligence, data engineering, data science, and data sharing scenarios.

### Enable mirroring

There are two ways to enable mirroring:

- **In your tenant:** Use this option to activate mirroring for all users within the tenant. To enable mirroring, navigate to the tenant settings in the Fabric portal and expand **Mirroring**. Enable the **Mirroring** switch. If needed, use the **Specific security groups** option to enable mirroring for specific users or exclude specific users. Finally, select **Apply**.

- **In your capacity:** Use this option to enable mirroring for users within a specific capacity. To enable mirroring, go to the capacity settings in the Fabric portal, select the desired capacity, and select the **Delegate tenant settings** tab. Expand the **Mirroring** setting, check the **Override tenant admin selection** box. Finally, select **Apply**.

    > [!NOTE]
    > The Fabric capacity needs to be active and running. A paused or deleted capacity will impact mirroring and no data will be replicated.

### Configure mirroring

There are a few essential steps you need to follow to configure mirroring for your Azure SQL Database to SQL database in Fabric. This process is important because it ensures that your data is consistently synchronized and available, enabling data reliability and accessibility.

#### Enable System Assigned Managed Identity (SAMI)

To publish data to Fabric, ensure the SAMI of your Azure SQL logical server is enabled and set as the primary identity. In the Azure portal, navigate to your logical SQL Server, select **Identity** under **Security**, and set the status to **On**.

:::image type="content" source="../media/5-system-assigned-managed-identity.png" alt-text="Screenshot showing how to set system-assigned managed identity in Azure SQL Database.":::

#### Create database principal for Fabric

To connect the Fabric service to your Azure SQL Database, you need a login and a mapped database user. 

- Your login should be a member of the `[##MS_ServerStateReader##]` server role in the `master` database.
    ```sql
    USE [master]
    GO
    ALTER SERVER ROLE [##MS_ServerStateReader##] ADD MEMBER [your_login];
    ```
- In your user database, create a user mapped to the login. Your user must have the `CONTROL` access.
    ```sql
    CREATE USER [your_user] FOR LOGIN [your_login];
    GRANT CONTROL TO [your_user];
    ```

#### Create a SQL Database

In the Fabric portal, navigate to the **Create** pane, select **SQL Database** in the **Databases** section, enter the name of your database, and select **Create**.

#### Start the mirroring process

In the Fabric portal, navigate to the **Create** pane, select **Mirrored Azure SQL Database**, enter the name of your Azure SQL database to be mirrored, select tables, and select **Connect**.

:::image type="content" source="../media/5-choose-data.png" alt-text="Screenshot showing how to select the tables part of a mirroring to SQL database in Fabric.":::

#### Monitor the mirroring process

Monitor the replication status to ensure the tables are synchronized. If there are no updates in the source tables, the engine will back off and resume regular polling after detecting updated data.

You can monitor the state of replication on the **Mirroring Status** page for more information and details on replication states.

To learn more about how to configure mirrored databases, see [Tutorial: Configure Microsoft Fabric mirrored databases from Azure SQL Database](/fabric/database/mirrored-database/azure-sql-database-tutorial?azure-portal=true).

## Explore data virtualization

Data virtualization in SQL Database in Fabric is a capability that allows you to access and manipulate data from various sources without the need to physically move or copy the data. This approach provides a unified view of data, enabling seamless integration and analysis across different platforms.

These features enable scenarios such as accessing Parquet, CSV, and delta files stored in OneLake, lakehouse, and .

| Capability | Definition | Query Example |
|---------|-------------|---------------|
| [**Database scoped credential**](/sql/t-sql/statements/create-database-scoped-credential-transact-sql?azure-portal=true) | Allows you to create credentials that can be used to access external data sources securely. | ```CREATE DATABASE SCOPED CREDENTIAL MyCredential WITH IDENTITY = 'my_identity', SECRET = 'my_secret'; ``` |
| [**External data source**](/sql/t-sql/statements/create-external-data-source-transact-sql?azure-portal=true) | This enables you to define external data sources, such as files stored in OneLake or other databases. | ```CREATE EXTERNAL DATA SOURCE MyExternalDataSource WITH ( LOCATION = 'https://myonelake.dfs.core.windows.net/mycontainer', CREDENTIAL = MyCredential ); ``` |
| [**External file format**](/sql/t-sql/statements/create-external-file-format-transact-sql?azure-portal=true) | This capability lets you specify the format of external files, such as Parquet, CSV, and Delta files. | ```CREATE EXTERNAL FILE FORMAT MyFileFormat WITH ( FORMAT_TYPE = DELIMITEDTEXT, FORMAT_OPTIONS ( FIELD_TERMINATOR = ',', STRING_DELIMITER = '"' ) ); ``` |
| [**External table**](/sql/t-sql/statements/create-external-table-transact-sql?azure-portal=true) | This allows you to create tables that reference data stored outside the SQL database. | ```CREATE EXTERNAL TABLE MyExternalTable ( Column1 INT, Column2 NVARCHAR(50) ) WITH ( LOCATION = 'myfolder/myfile.csv', DATA_SOURCE = MyExternalDataSource, FILE_FORMAT = MyFileFormat ); ``` |
| [**External table `AS SELECT` (CETAS)**](/sql/t-sql/statements/create-external-table-as-select-transact-sql?azure-portal=true) | This capability enables you to create and populate external tables with the results of a SELECT statement. | ```CREATE EXTERNAL TABLE MyExternalTable AS SELECT Column1, Column2 FROM MyInternalTable; ``` |
| [**OPENROWSET**](/sql/t-sql/functions/openrowset-transact-sql?azure-portal=true) | Allows you to access data from an external data source using a single T-SQL query. | ```SELECT * FROM OPENROWSET( BULK 'https://myonelake.dfs.core.windows.net/mycontainer/myfile.csv', FORMAT = 'CSV', PARSER_VERSION = '2.0' ) AS MyExternalData; ``` |

### Query public datasets

In this example, we use `OPENROWSET` to query public datasets. The `OPENROWSET` function allows you to access and read the content of files stored in a specific Azure Blob Storage path.

```sql
SELECT TOP 100 *
FROM OPENROWSET 
(BULK 'abs://citydatacontainer@azureopendatastorage.blob.core.windows.net/Safety/Release/city=Seattle/*.parquet'
, FORMAT = 'PARQUET') 
AS [Seattle_Dataset]
```

The `FORMAT = 'PARQUET'` option indicates that the files are in Parquet format, which is a columnar storage file format optimized for performance.

To see a list of public datasets, see [What are Azure Open Datasets and how can you use them?](/azure/open-datasets/overview-what-are-open-datasets?azure-portal=true).

### Query Parquet files in OneLake

In this example, we use `OPENROWSET` to query Parquet files in OneLake. You can find the ABFS path by navigating to the file location in the Fabric portal, selecting the three dots next to the file, and selecting **Properties**.

:::image type="content" source="../media/5-abfs-path.png" alt-text="Screenshot showing how to find the ABFS path in a lakehouse.":::

```sql
SELECT * FROM OPENROWSET (
BULK 'abfss://d4f5e6a7-b8c9-4d1e-a2f3-b4e5c6d7e8f9@daily-onelake.dfs.fabric.microsoft.com/a1b2c3d4-e5f6-7a8b-9c0d-e1f2a3b4c5d6/Files/parquet/data1.parquet'
, FORMAT = 'PARQUET'
) [dataset]
```

### Query delta lake tables

You can also query [delta lake tables](/fabric/data-engineering/lakehouse-and-delta-tables?azure-portal=true) by providing `DELTA` as the format in `OPENROWSET`. The `FORMAT = 'DELTA'` option indicates that the files are in Delta Lake format, which is optimized for big data workloads and supports ACID (Atomicity, Consistency, Isolation, and Durability) transactions.

```sql
SELECT * FROM OPENROWSET
( BULK 'abfss://f1e2d3c4-b5a6-7b8c-9d0e-f1a2b3c4d5e6@daily-onelake.dfs.fabric.microsoft.com/e7f8g9h0-i1j2-3k4l-5m6n-7o8p9q0r1s2t/Tables/dbo/customers'
, FORMAT = 'DELTA') AS [movies_table];
```
