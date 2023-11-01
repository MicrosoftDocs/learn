---
ms.custom:
  - build-2023
---
In this exercise, you'll:

- Use CETAS to export a table as Parquet.
- Use CETAS to move cold data out of the database.
- Use a view to query the data that includes an external table.
- Use wildcard search to query the data.
- learn about folder elimination and metadata information

## Prerequisites

- The **PolyBase Query Service for External Data** feature installed on SQL Server 2022.
- [AdventureWorks2022](/sql/samples/adventureworks-install-configure) sample database is used in this exercise. Restore the sample database to your server.
- The SQL Server 2022 instance must have internet connectivity.
- An Azure Subscription with a storage account and a blob storage container created. For more information, see [Quickstart: Upload, download, and list blobs with the Azure portal](/azure/storage/blobs/storage-quickstart-blobs-portal).
- A blob container SAS Token created with READ, WRITE, LIST and CREATE permissions to be used for CETAS. For more information, see [CREATE EXTERNAL TABLE AS SELECT (CETAS) Permissions](/sql/t-sql/statements/create-external-table-as-select-transact-sql#permissions).
- To create a SAS token, see [Create shared access signature (SAS) tokens for your storage containers](/azure/cognitive-services/translator/document-translation/how-to-guides/create-sas-tokens).

## Use CETAS to export a table as Parquet

Imagine that you're working with the business analytics team, and need to export older data from a table to an Azure Blob Storage container. You would rather the business analytics team run their report queries that use data older than 2012 from this exported data, than running their reports directly querying SQL Server.

1. Configure PolyBase.

    ```sql
    -- ENABLE POLYBASE
    -- =========================================================================
    EXEC SP_CONFIGURE @CONFIGNAME = 'POLYBASE ENABLED', @CONFIGVALUE = 1;
    RECONFIGURE;
    
    EXEC SP_CONFIGURE @CONFIGNAME = 'POLYBASE ENABLED'
    GO
    -- ENABLE CETAS
    -- =========================================================================
    EXEC SP_CONFIGURE @CONFIGNAME = 'ALLOW POLYBASE EXPORT', @CONFIGVALUE = 1;
    ```

1. Execute the following query to understand the data that you want to export. In this case, we're looking for any data that is from 2012 or older.

    ```sql
    Use AdventureWorks2022
    GO
    -- RECORDS BY YEARS
    SELECT COUNT(*) AS QTY, DATEPART(YYYY, [DUEDATE]) AS [YEAR]
    FROM  [PURCHASING].[PURCHASEORDERDETAIL] 
    GROUP BY DATEPART(YYYY, [DUEDATE])
    ORDER BY [YEAR]
    ```

   :::image type="content" source="../media/ssms-order-detail-by-year.png" alt-text="Screenshot of SSMS and the results from the AdventureWorks2022 database showing purchase orders grouped by year.":::

   We'll be exporting all data from 2011 and 2012.

1. Create the database scoped credentials and external data source.

   > [!NOTE]
   > For this example, you'll need to have an Azure Storage account. Create an Azure Blob Storage, and then create a container named `data`. Within the container, create a subfolder called `chapter3`. It is also expected to have a SAS_TOKEN with READ, WRITE, LIST, CREATE privileges in the `data` container.

    ```sql
    -- DATABASE SCOPED CREDENTIAL
    CREATE DATABASE SCOPED CREDENTIAL blob_storage
    	WITH IDENTITY = 'SHARED ACCESS SIGNATURE', 
    	SECRET = 'sas_token'; -- EDIT THE TOKEN
    GO
    
    -- AZURE BLOB STORAGE DATA SOURCE 
    CREATE EXTERNAL DATA SOURCE ABS_Data
    WITH
    (
     LOCATION = 'abs://<storage_account>.blob.core.windows.net/data/chapter3'
    ,CREDENTIAL = blob_storage
    )
    ```

1. Create the external file format for Parquet.

    ```sql
    -- PARQUET FILE FORMAT
    CREATE EXTERNAL FILE FORMAT ffParquet
    WITH (FORMAT_TYPE = PARQUET)
    GO
    ```

1. Create the external table using CETAS.

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

   This query creates the external table named `ext_data_2011_2012`, and export every data from 2011 and 2012 to the location specified by the data source `ABS_Data`.

1. Check your Azure Blob Storage through the Azure portal. You should see the following structure being created:

   :::image type="content" source="../media/parquet-azure-storage.png" alt-text="Screenshot from the Azure portal showing the parquet file in Azure Storage.":::

   SQL Server 2022 will automatically create the file name based on how much data that it exports and the file format.

1. You can now access the external table as if it was a regular table.

    ```sql
    SELECT * FROM ex_data_2011_2012
    ```

   :::image type="content" source="../media/ssms-select-from-external-table.png" alt-text="Screenshot of SSMS and the results from the AdventureWorks2022 database showing the results from the external table.":::

   Now that the data has been exported to Parquet, the data can be easily accessible through the external table. The business analytics team can query the external table, or point their reporting tool at the Parquet file.

## Use CETAS to move cold data out of the database

To keep the data manageable, your company has decided that data that is older than 2014 should be moved from the database. However, all of the data must still be accessible. For this example, we export the data through CETAS, and generate several external tables that we can query later on. We'll go through an example of using a view with UNION statements to query the data, as well as creating a single external table that uses a wildcard search to search through the subfolders of the exported data.

1. Start by cloning the original table, as we want to simulate exporting and removing the data, but don't necessarily want to delete the current data source. Run the following in SSMS:

    ```sql
    -- CLONE TABLE
    SELECT * INTO [PURCHASING].[PURCHASEORDERDETAIL_2] FROM [PURCHASING].[PURCHASEORDERDETAIL]
    ```

1. From the first exercise, we know that there are 5551 records from 2014. Everything before 2014 should be exported to a respective folder, divided by year. Data from 2011 will be put in a folder called `2011`. Data from 2012 will be put in a folder called `2012`, and data from 2013 will be put in a folder called `2013`. Run the following statements:

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
    WHERE YEAR([DUEDATE]) = 2011
    GO
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
    WHERE YEAR([DUEDATE]) = 2012
    GO
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
    WHERE YEAR([DUEDATE]) = 2013
    GO
    ```

1. After executing these three commands, you should able to see the following external tables in SSMS **Object Explorer**. Open the sample database > **Tables** > **External Tables**:

   :::image type="content" source="../media/external-tables-2011-2013.png" alt-text="Screenshot of SSMS showing the external tables for 2011, 2012, and 2013.":::

   On the Azure portal storage container, the following folders are created:

   :::image type="content" source="../media/azure-storage-folders-created.png" alt-text="Screenshot of the Azure portal storage container showing the folders created for our command.":::

1. After the cold data is exported, we can delete it from the table.

    ```sql
    DELETE FROM [PURCHASING].[PURCHASEORDERDETAIL_2] 
    WHERE YEAR([DUEDATE]) < 2014
    ```

### Use a view to query the data that includes the external table

1. Now that the old data that we wanted to remove from the database was exported and deleted, we can use T-SQL to create a view that will query all the external tables as well as the current data in our database.

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

1. By performing the same data exploration query from the beginning of the exercise to see the data distribution, but this time using the newly created view, we can see the same result:

    ```sql
    SELECT  COUNT(*) AS QTY, DATEPART(YYYY, [DUEDATE]) AS [YEAR]
    FROM vw_purchaseorderdetail 
    GROUP BY DATEPART(YYYY, [DUEDATE])
    ORDER BY [YEAR]
    ```

### Use a wildcard search to query the data

In the previous example, we used a view with UNION statements to join the three external tables. That's just one way of achieving our desired results. Another way would be to use the wildcard search method that will scan the folder structure, including subfolders for any data from a particular type.

The following T-SQL example allows OPENROWSET to search across the `ABS_Data` data source for Parquet files, including its subfolders.

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

Each method has its own advantages and disadvantages. For exploration purposes, the wildcard search method is recommended since it's easier to use and more flexible. As for the view method, it's recommended for repetitive requests since it usually performs better, and it also can be combined with physical tables.

## Folder elimination and metadata information

Both external tables and OPENROWSET can use the `filepath` function to collect and filter information based on the file metadata. The `filepath` function returns the full path of the file, the folder name, and the file name. That information can be used to further improve the search capabilities of both the external table and OPENROWSET commands.

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

If we want to ensure one data from a particular folder is retrieved but still leverages the functionality of the wildcard search method, we can use the following query:

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

The end result is the same, but by leveraging the metadata for folder elimination, you guarantee that your query will only access the required folders, instead of scanning across the entire data source, making it better for query performance. With that information in mind, you can use it to help design your own storage architecture to better leverage the capabilities. For example, here's a sample folder architecture:

:::image type="content" source="../media/folder-elimination-architecture.png" alt-text="Screenshot showing a folder architecture example in a storage container.":::

This is how our query would look like:

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

In this example, it would matter little how large the data would grow. SQL Server would only query or load the data from the desired folder, skipping all others. Only the folder content would be read and loaded, and since no data is stored in the database, the database administrator doesn't need to design a specific maintenance strategy to manage this data.

The company must still take all the required precautions to safely maintain the data, including, but not limited to backups, availability, and permissions.

With this newly acquired knowledge, we can combine OPENROWSET, external table, views, wildcard search, and filepath function to design a performant, durable, and scalable solution on Azure Blob Storage, Azure Data Lake Storage Gen 2, or S3-compatible object storage. Everything shown in this example works across every PolyBase supported data source. That means that you can use CETAS to access and export data from another database like SQL Server, Oracle, Teradata, MongoDB, and others.
