---
ms.custom:
  - build-2023
---
In this exercise, you:

- Use CETAS to export a table as Parquet.
- Use CETAS to move cold data out of a database.
- Use a view to query the data that includes an external table.
- Use wildcard search to query the data.
- Learn about folder elimination and metadata information.

## Prerequisites

- A SQL Server 2022 instance with internet connectivity and the **PolyBase Query Service for External Data** feature installed and enabled as in previous units.
- The [AdventureWorks2022](/sql/samples/adventureworks-install-configure) sample database restored to your server to use for sample data.
- An Azure Storage account with a Blob Storage container named `data` created. To create the storage, see [Quickstart: Upload, download, and list blobs with the Azure portal](/azure/storage/blobs/storage-quickstart-blobs-portal).
- The **Storage Blob Data Contributor** data access role assigned by Azure role-based access control (RBAC). For more information, see [Assign an Azure role for access to blob data](/azure/storage/blobs/assign-azure-role-data-access).
- A blob container SAS token with **READ**, **WRITE**, **LIST**, and **CREATE** permissions to be used for CETAS. To create the SAS token, see [Create shared access signature (SAS) tokens for your storage containers](/azure/cognitive-services/translator/document-translation/how-to-guides/create-sas-tokens).

## Use CETAS to export a table as Parquet

Imagine that you work with a business analytics team that wants to export data older than 2012 from a SQL Server table to an Azure Blob Storage container. You want the team to run their report queries on this exported data rather than directly querying SQL Server.

1. Enable CETAS on the SQL Server instance.

    ```sql
    EXEC SP_CONFIGURE @CONFIGNAME = 'ALLOW POLYBASE EXPORT', @CONFIGVALUE = 1;
    ```

1. Execute the following query to understand the data that you want to export. In this case, you're looking for data that's from 2012 or earlier. You want to export all data from 2011 and 2012.

    ```sql
    -- RECORDS BY YEARS
    SELECT COUNT(*) AS QTY, DATEPART(YYYY, [DUEDATE]) AS [YEAR]
    FROM  [PURCHASING].[PURCHASEORDERDETAIL] 
    GROUP BY DATEPART(YYYY, [DUEDATE])
    ORDER BY [YEAR]
    ```

   :::image type="content" source="../media/ssms-order-detail-by-year.png" alt-text="Screenshot of SSMS and the results from the AdventureWorks2022 database showing purchase orders grouped by year.":::

1. Create a database master key for the database, as in the previous exercises.

    ```sql
    Use AdventureWorks2022
    
    DECLARE @randomWord VARCHAR(64) = NEWID();
    DECLARE @createMasterKey NVARCHAR(500) = N'
    IF NOT EXISTS (SELECT * FROM sys.symmetric_keys WHERE name = ''##MS_DatabaseMasterKey##'')
        CREATE MASTER KEY ENCRYPTION BY PASSWORD = '  + QUOTENAME(@randomWord, '''')
    EXEC sp_executesql @createMasterKey;
    
    SELECT * FROM sys.symmetric_keys;
    ```

1. Create the database scoped credentials and external data source. Replace the `<sas_token>` and `<storageccount>` placeholders with the storage account and SAS token you created in Azure.

    ```sql
    -- DATABASE SCOPED CREDENTIAL
    CREATE DATABASE SCOPED CREDENTIAL blob_storage
          WITH IDENTITY = 'SHARED ACCESS SIGNATURE',
          SECRET = '<sas_token>';
    
    -- AZURE BLOB STORAGE DATA SOURCE
    CREATE EXTERNAL DATA SOURCE ABS_Data
    WITH
    (
     LOCATION = 'abs://<storageaccount>.blob.core.windows.net/data/chapter3'
    ,CREDENTIAL = blob_storage
    );
    ```

1. Create the external file format for Parquet.

    ```sql
    -- PARQUET FILE FORMAT
    CREATE EXTERNAL FILE FORMAT ffParquet
    WITH (FORMAT_TYPE = PARQUET);
    ```

1. Create the external table using CETAS. The following query creates an external table named `ext_data_2011_2012` and exports all data from 2011 and 2012 to the location specified by the data source `ABS_Data`.

    ```sql
    CREATE EXTERNAL TABLE ex_data_2011_2012
    WITH(
            LOCATION = 'data_2011_20122',
            DATA_SOURCE = ABS_Data,
            FILE_FORMAT = ffParquet
    )AS
    SELECT
    	[PurchaseOrderID]
          ,[PurchaseOrderDetailID]
          ,[DueDate]
          ,[OrderQty]
          ,[ProductID]
          ,[UnitPrice]
          ,[LineTotal]
          ,[ReceivedQty]
          ,[RejectedQty]
          ,[StockedQty]
          ,[ModifiedDate]
    FROM  [PURCHASING].[PURCHASEORDERDETAIL] 
    WHERE YEAR([DUEDATE]) < 2013
    GO
    ```

1. Check your Azure Blob Storage in the Azure portal. You should see the following structure created. SQL Server 2022 automatically creates the filename based on how much data it exports and the file format.

   :::image type="content" source="../media/parquet-azure-storage.png" alt-text="Screenshot from the Azure portal showing the parquet file in Azure Storage.":::

1. You can now access the external table like a regular table.

    ```sql
    SELECT * FROM ex_data_2011_2012
    ```

   :::image type="content" source="../media/ssms-select-from-external-table.png" alt-text="Screenshot of SSMS and the results from the AdventureWorks2022 database showing the results from the external table.":::

The data is now exported to Parquet and is easily accessible through the external table. The business analytics team can query the external table or point their reporting tool at the Parquet file.

## Use CETAS to move cold data out of the database

To keep the data manageable, your company decides to move data older than 2014 from the SQL Server database. However, all of the data must still be accessible.

For this example, you export the data through CETAS and generate several external tables that you can query later. You can use a view with UNION statements to query the data, or create a single external table and use a wildcard to search through the subfolders of the exported data.

First, clone the original table, because you want to simulate exporting and removing the data but don't necessarily want to delete the current data source. Run the following statement:

```sql
-- CLONE TABLE
SELECT * INTO [PURCHASING].[PURCHASEORDERDETAIL_2] FROM [PURCHASING].[PURCHASEORDERDETAIL]
```

From the previous exercise, you know there are 5551 records from 2014. Everything before 2014 should be exported to a folder identified by year. Data from 2011 goes into a folder called `2011`, and so on. 

1. Run the following statements:

    ```sql
    CREATE EXTERNAL TABLE ex_2011
    WITH(
            LOCATION = '2011',
            DATA_SOURCE = ABS_Data,
            FILE_FORMAT = ffParquet
    )AS
    SELECT
        [PurchaseOrderID]
          ,[PurchaseOrderDetailID]
          ,[DueDate]
          ,[OrderQty]
          ,[ProductID]
          ,[UnitPrice]
          ,[LineTotal]
          ,[ReceivedQty]
          ,[RejectedQty]
          ,[StockedQty]
          ,[ModifiedDate]
    FROM  [PURCHASING].[PURCHASEORDERDETAIL_2] 
    WHERE YEAR([DUEDATE]) = 2011;
    ```

    ```sql
    CREATE EXTERNAL TABLE ex_2012
    WITH(
            LOCATION = '2012',
            DATA_SOURCE = ABS_Data,
            FILE_FORMAT = ffParquet
    )AS
    SELECT
        [PurchaseOrderID]
          ,[PurchaseOrderDetailID]
          ,[DueDate]
          ,[OrderQty]
          ,[ProductID]
          ,[UnitPrice]
          ,[LineTotal]
          ,[ReceivedQty]
          ,[RejectedQty]
          ,[StockedQty]
          ,[ModifiedDate]
    FROM  [PURCHASING].[PURCHASEORDERDETAIL_2] 
    WHERE YEAR([DUEDATE]) = 2012;
    ```

    ```sql
    CREATE EXTERNAL TABLE ex_2013
    WITH(
            LOCATION = '2013',
            DATA_SOURCE = ABS_Data,
            FILE_FORMAT = ffParquet
    )AS
    SELECT
        [PurchaseOrderID]
          ,[PurchaseOrderDetailID]
          ,[DueDate]
          ,[OrderQty]
          ,[ProductID]
          ,[UnitPrice]
          ,[LineTotal]
          ,[ReceivedQty]
          ,[RejectedQty]
          ,[StockedQty]
          ,[ModifiedDate]
    FROM  [PURCHASING].[PURCHASEORDERDETAIL_2] 
    WHERE YEAR([DUEDATE]) = 2013;
    ```

1. After you execute these three commands, refresh SSMS **Object Explorer**. Then open **Databases** > **AdventureWorks2022** > **Tables** > **External Tables** to see the external tables.

   :::image type="content" source="../media/external-tables-2011-2013.png" alt-text="Screenshot of SSMS showing the external tables for 2011, 2012, and 2013.":::

   The following folders are created in the Azure Storage container:

   :::image type="content" source="../media/azure-storage-folders-created.png" alt-text="Screenshot of the Azure portal storage container showing the folders created for our command.":::

1. After the cold data is exported, you can delete it from the original table location.

    ```sql
    DELETE FROM [PURCHASING].[PURCHASEORDERDETAIL_2] 
    WHERE YEAR([DUEDATE]) < 2014
    ```

## Query the data that includes the external table

You can use a view or a wildcard search to query the exported external data. Each method has advantages and disadvantages. The view method is recommended for repetitive requests because it usually performs better, and can also be combined with physical tables. The wildcard search method is more flexible and easier to use for exploration purposes.

### Use a view to query the data

Now that the old data is exported and deleted from the database, you can use T-SQL to create a view that queries all the external tables and the current data in your database.

```sql
CREATE VIEW vw_purchaseorderdetail 
AS
SELECT * FROM ex_2011
UNION ALL
SELECT * FROM ex_2012
UNION ALL
SELECT * FROM ex_2013
UNION ALL
SELECT * FROM  [PURCHASING].[PURCHASEORDERDETAIL_2] 
```

You can run the data exploration query you used at the beginning of the exercise to see the data distribution, this time using the newly created view, to see the same results.

```sql
SELECT  COUNT(*) AS QTY, DATEPART(YYYY, [DUEDATE]) AS [YEAR]
FROM vw_purchaseorderdetail 
GROUP BY DATEPART(YYYY, [DUEDATE])
ORDER BY [YEAR]
```

### Use a wildcard search to query the data

In the preceding example, you used a view with UNION statements to join the three external tables. Another way to achieve the desired results is to use a wildcard search to scan the folder structure, including subfolders for any data from a particular type.

The following T-SQL example allows OPENROWSET to search across the `ABS_Data` data source, including its subfolders, for Parquet files.

```sql
SELECT COUNT(*) AS QTY, DATEPART(YYYY, [DUEDATE]) AS [YEAR]
FROM OPENROWSET 
    (BULK '**'
    , FORMAT = 'PARQUET'
    , DATA_SOURCE = 'ABS_Data')
    AS [cc]
GROUP BY DATEPART(YYYY, [DUEDATE])
ORDER BY [YEAR]
```

## Folder elimination and metadata information

Both external tables and OPENROWSET can use the `filepath` function to collect and filter information based on the file metadata. The `filepath` function returns the full path of the file, the folder name, and the file name. You can use that information to further improve the search capabilities of both the external table and OPENROWSET commands.

```sql
SELECT
    r.filepath(1) 'folder_name'
    ,r.filepath() 'full_path'
    ,r.filepath(2) 'file_name'
FROM OPENROWSET(
        BULK '*/*.parquet',
        DATA_SOURCE = 'ABS_Data',
        FORMAT = 'parquet'
    ) as [r]
GROUP BY
    r.filepath(2),r.filepath(1), r.filepath()
ORDER BY 
    r.filepath(2)
```

:::image type="content" source="../media/ssms-filepath-function.png" alt-text="Screenshot of SSMS showing the filepath function.":::

If you want to ensure data from a particular folder is retrieved but still use the functionality of the wildcard search method, you can use the following query:

```sql
SELECT  *
FROM OPENROWSET(
 BULK '*/*.parquet',
DATA_SOURCE = 'ABS_Data',
FORMAT = 'parquet'
 ) AS r
WHERE
 r.filepath(1) IN ('2011')
```

The end result is the same, but by using the folder elimination metadata, your query accesses only the required folders instead of scanning the entire data source, producing better query performance. Keep this information in mind to help design your own storage architecture to better leverage capabilities. For example, here's a sample folder architecture:

:::image type="content" source="../media/folder-elimination-architecture.png" alt-text="Screenshot showing a folder architecture example in a storage container." border="false":::

This is what your query would look like:

```sql
SELECT  *
FROM OPENROWSET(
 BULK 'year=*/month=*/*.parquet',
DATA_SOURCE = 'ABS_Data',
FORMAT = 'parquet'
 ) AS r
WHERE
 r.filepath(1) IN ('<year>')
 r.filepath(2) IN ('<month>')
```

In this example, it matters little how large the data grows. SQL Server queries or loads the data only from the desired folder, skipping all others. Only the folder content is read and loaded.

Because no data is stored in the database, the database administrator doesn't need to design a specific maintenance strategy to manage this data. Organizations must still take all the required precautions to safely maintain the data, including but not limited to backups, availability, and permissions.

With this knowledge, you can combine OPENROWSET, external table, views, wildcard search, and filepath function to design a performant, durable, and scalable solution across every PolyBase supported data source. You can use CETAS to access and export data from another database like SQL Server, Oracle, Teradata, MongoDB, and others, or from Azure Blob Storage, Azure Data Lake Storage, or S3-compatible object storage.