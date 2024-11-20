---
ms.custom:
  - ignite-2024
---
Organizations often face challenges in managing and analyzing their data due to the complexity of integrating various data sources, ensuring data consistency, and maintaining real-time data availability. SQL Database in Microsoft Fabric addresses these challenges by providing a unified platform that simplifies data integration, enhances data consistency, and ensures near real-time data availability.

## Integrate with mirroring

One of the key features of SQL Database in Microsoft Fabric is its ability to mirror databases from Azure SQL Database directly into Fabric's OneLake. 

:::image type="content" source="../media/5-mirroring.png" alt-text="Diagram of Fabric Database Mirroring for Azure SQL Database." lightbox="../media/5-mirroring.png":::

This mirroring process ensures that data is continuously replicated in near real-time, eliminating the need for complex Extract, Transform, Load (ETL) processes. By doing so, it reduces the total cost of ownership and accelerates the time-to-insight, allowing businesses to unlock business intelligence, artificial intelligence, data engineering, data science, and data sharing scenarios.

After you initiate a mirroring process, you can monitor the replication status by selecting the **Monitor replication** option from the **Replication** tab. If there are no updates in the source tables, the engine will back off and resume regular polling after detecting updated data.

:::image type="content" source="../media/5-monitor.png" alt-text="Screenshot of how to monitor a mirroring process for SQL database in Fabric." lightbox="../media/5-monitor.png":::

To learn more about how to configure mirrored databases, see [Tutorial: Configure Microsoft Fabric mirrored databases from Azure SQL Database](/fabric/database/mirrored-database/azure-sql-database-tutorial?azure-portal=true).

## Explore data virtualization

Data virtualization in SQL Database in Fabric is a capability that allows you to access and manipulate data from various sources without the need to physically move or copy the data. This approach provides a unified view of data, enabling seamless integration and analysis across different platforms.

These features enable scenarios such as querying Parquet, CSV, and Delta tables available in a lakehouse.

| Capability | Definition | Query Example |
|---------|-------------|---------------|
| [**Database scoped credential**](/sql/t-sql/statements/create-database-scoped-credential-transact-sql?azure-portal=true) | Allows you to create credentials that can be used to access external data sources securely. | ```CREATE DATABASE SCOPED CREDENTIAL MyCredential WITH IDENTITY = 'USER IDENTITY'; ``` |
| [**External data source**](/sql/t-sql/statements/create-external-data-source-transact-sql?azure-portal=true) | This enables you to define external data sources, such as files stored in OneLake. | ```'abfss://aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb@<onelake_account_name>.dfs.fabric.microsoft.com/bbbbbbbb-1111-2222-3333-cccccccccccc/Files/parquet/data1.parquet'; ``` |
| [**External file format**](/sql/t-sql/statements/create-external-file-format-transact-sql?azure-portal=true) | This capability lets you specify the format of external files, such as Parquet, CSV, and Delta files. | ```CREATE EXTERNAL FILE FORMAT MyFileFormat WITH ( FORMAT_TYPE = DELIMITEDTEXT, FORMAT_OPTIONS ( FIELD_TERMINATOR = ',', STRING_DELIMITER = '"' ) ); ``` |
| [**External table**](/sql/t-sql/statements/create-external-table-transact-sql?azure-portal=true) | This allows you to create tables that reference data stored outside the SQL database. | ```CREATE EXTERNAL TABLE MyExternalTable ( Column1 INT, Column2 NVARCHAR(50) ) WITH ( LOCATION = 'myfolder/myfile.csv', DATA_SOURCE = MyExternalDataSource, FILE_FORMAT = MyFileFormat ); ``` |
