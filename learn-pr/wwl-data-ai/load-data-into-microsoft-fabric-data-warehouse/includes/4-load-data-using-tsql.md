T-SQL gives you direct control over how data enters your warehouse. Instead of configuring a wizard, you write SQL statements that load files, transform data, and pull from other Fabric assets — all from the SQL editor.

To get started, open your warehouse in the Fabric portal and select **New SQL query** from the toolbar. This opens the SQL editor where you can write and run the statements described in this unit.

## Load files with the COPY statement

The COPY statement loads data from external files into a warehouse table. It works with CSV, Parquet, and other file formats stored in Azure Data Lake Storage Gen2, Azure Blob Storage, or OneLake lakehouse folders.

A basic COPY statement needs three things: a target table, a file path, and connection credentials. The following example loads CSV files from Azure Blob Storage:

```sql
COPY INTO my_table
FROM 'https://myaccount.blob.core.windows.net/myblobcontainer/folder0/*.csv, 
    https://myaccount.blob.core.windows.net/myblobcontainer/folder1/'
WITH (
    FILE_TYPE = 'CSV',
    CREDENTIAL=(IDENTITY= 'Shared Access Signature', SECRET='<Your_SAS_Token>')
    FIELDTERMINATOR = '|'
)
```

Notice the wildcard (``*.csv``) — you can load multiple files in one statement as long as they share the same structure. You can also list multiple paths from the same storage account, separated by commas.

For Parquet files, you can omit the `FILE_TYPE` parameter — Fabric infers the format from the file extension:

```sql
COPY INTO test_parquet
FROM 'https://myaccount.blob.core.windows.net/myblobcontainer/folder1/*.parquet'
WITH (
    CREDENTIAL=(IDENTITY= 'Shared Access Signature', SECRET='<Your_SAS_Token>')
)
```

### Authentication options

You'll notice the `CREDENTIAL` parameter in both examples. Every COPY statement needs to authenticate with the source storage — and how you do that depends on where your files are:

- **Azure storage accounts**: Provide a Shared Access Signature (SAS) or Storage Account Key in the ``CREDENTIAL`` parameter.
- **OneLake lakehouse folders**: No credential needed — authentication uses your workspace identity automatically.

### Handle rejected rows

Not every row loads successfully. The ``REJECTED_ROW_LOCATION`` option sends failed rows to a separate storage location instead of failing the entire load. This lets you complete the bulk of your load and investigate problem rows separately. This option only applies to CSV files.

## Load data from other warehouses and lakehouses

Your warehouse isn't the only data asset in a Fabric workspace. You might have other warehouses, lakehouses, or SQL analytics endpoints that contain data you want to bring together. T-SQL lets you query across these assets using three-part naming (``database.schema.table``).

Two patterns handle cross-asset loading:

| SQL statement | When to use it |
| --- | --- |
| **``CREATE TABLE AS SELECT``** (CTAS) | Creates a new table from a query result. Use when you need a new table from transformed or combined data. |
| **``INSERT...SELECT``** | Inserts rows into an existing table. Use when the target table already exists and you're adding data to it. |

The following example creates a new table by joining data from a warehouse and a lakehouse:

```sql
CREATE TABLE [analysis_warehouse].[dbo].[combined_data]
AS
SELECT *
FROM [sales_warehouse].[dbo].[sales_data] sales
INNER JOIN [social_lakehouse].[dbo].[social_data] social
ON sales.[product_id] = social.[product_id];
``` 

This works because all warehouses in the same workspace share a single SQL connection endpoint. You can reference any of them by name, just like databases on a SQL Server instance.

### Query from external tools

You can also run cross-database queries from SQL Server Management Studio or other SQL client tools that connect to your Fabric workspace.

:::image type="content" border="false" source="../media/4-load-using-ssms.gif" alt-text="Animated GIF showing how to reference other warehouses in a workspace from SQL Server Management Studio." lightbox="../media/4-load-using-ssms.gif":::

In the Fabric portal, the SQL editor lets you add warehouses to your object explorer and run queries across them. Select the warehouses you want to include, and they become available in both the object explorer and the visual query editor.

:::image type="content" border="false" source="../media/4-query-using-workspace.gif" alt-text="Animated GIF showing how to query other warehouses in a workspace from the Fabric workspace." lightbox="../media/4-query-using-workspace.gif":::