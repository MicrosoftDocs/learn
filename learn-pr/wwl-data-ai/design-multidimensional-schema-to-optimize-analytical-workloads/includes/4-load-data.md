One of the most common patterns for loading a data warehouse is to transfer data from source systems to files in a data lake, ingest the file data into staging tables, and then use SQL statements to load the data from the staging tables into the dimension and fact tables. Usually data loading is performed as a periodic batch process in which inserts and updates to the data warehouse are coordinated to occur at a regular interval (for example, daily, weekly, or monthly).

There are many technologies you can use to load data, including pipelines created using Azure Synapse Analytics or Azure Data Factory, SQL Server Integration Services packages, or command line tools like the bulk copy program (BCP). In this unit, we'll focus on SQL-based techniques to ingest data from a data lake.

## Loading data into staging tables

If you use *external* tables for staging, there's no need to load the data into them because they already reference the data files in the data lake. However, if you use "regular" relational tables, you can use the `COPY` statement to load data from the data lake, as shown in the following example:

```sql
COPY INTO dbo.StageProducts
    (ProductID, ProductName, ProductCategory, Color, Size, ListPrice, Discontinued)
FROM 'https://mydatalake.blob.core.windows.net/data/stagedfiles/products/*.parquet'
WITH
(
    FILE_TYPE = 'PARQUET',
    MAXERRORS = 0,
    IDENTITY_INSERT = 'OFF'
);
```

## Loading staged data into dimension tables

After staging dimension data, you can load it into dimension tables using SQL.

### Using a CREATE TABLE AS (CTAS) statement

One of the simplest ways to load data into a new dimension table is to use a `CREATE TABLE AS` (*CTAS*) expression. This statement creates a new table based on the results of a SELECT statement.

> [!NOTE]
> For more information, see [CREATE TABLE AS SELECT (CTAS)](/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-develop-ctas) in the Azure Synapse Analytics documentation.

For example, the following code creates a new **DimProduct** table based on the results of a query that retrieves data from the **StageProduct** table:

```sql
CREATE TABLE dbo.DimProduct
WITH
(
    DISTRIBUTION = REPLICATE,
    CLUSTERED COLUMNSTORE INDEX
)
AS
SELECT ROW_NUMBER() OVER(ORDER BY ProductID) AS ProductKey,
       ProductID AS ProductAltKey,
       ProductName,
       ProductCategory,
       Color,
       Size,
       ListPrice,
       Discontinued
FROM dbo.StageProduct;
```

> [!NOTE]
> You can't use `IDENTITY` to generate a unique integer value for the surrogate key when using a CTAS statement, so  this example uses the `ROW_NUMBER` function to generate an incrementing row number for each row in the results ordered by the **ProductID** business key in the staged data.

### Using an INSERT statement

When you need to load staged data into an existing dimension table, you can use an `INSERT` statement. This approach works if the staged data contains only records for new dimension entities (not updates to existing entities).

```sql
INSERT INTO dbo.DimCustomer
SELECT CustomerNo AS CustomerAltKey,
       CustomerName,
       EmailAddress,
       Phone,
       StreetAddress,
       City,
       PostalCode,
       CountryRegion
FROM dbo.StageCustomers
```

> [!NOTE]
> Assuming the **DimCustomer** dimension table is defined with an `IDENTITY` **CustomerKey** column for the surrogate key (as described in the previous unit), the key will be generated automatically and the remaining columns will be populated using the values retrieved from the staging table by the `SELECT` query.

### Loading *time* dimension tables

Time dimension tables store a record for each time interval based on the grain of the table. For example, a time dimension table at the *date* grain contains a record for each date between the earliest and latest dates referenced by the data in related fact tables.

One way to populate a time dimension table is to use a loop that generates the required attributes for each date incrementally. For example, you could use the following SQL code to populate a **DimDate** table:

```sql
-- Create a temporary table for the dates we need
CREATE TABLE #TmpStageDate (DateVal DATE NOT NULL)

-- Populate the temp table with a range of dates
DECLARE @StartDate DATE
DECLARE @EndDate DATE
SET @StartDate = '2019-01-01'
SET @EndDate = '2022-12-31' 
DECLARE @LoopDate DATE
SET @LoopDate = @StartDate
WHILE @LoopDate <= @EndDate
BEGIN
    INSERT INTO #TmpStageDate VALUES
    (
        @LoopDate
    ) 
    SET @LoopDate = DATEADD(dd, 1, @LoopDate)
END

-- Insert the dates and calculated attributes into the dimension table
INSERT INTO dbo.DimDate 
SELECT  CAST(CONVERT(VARCHAR(8), DateVal, 112) AS int) , -- date key
        DateVal, -- date alt key
        Day(DateVal),  -- day number of month
        datepart(dw, DateVal), -- day number of week
        datename(dw, DateVal), -- day name of week
        Month(DateVal), -- month number of year
        datename(mm, DateVal), -- month name
        datepart(qq, DateVal), -- calendar quarter
        Year(DateVal), -- calendar year
        CASE
            WHEN Month(DateVal) IN (1, 2, 3) THEN 3
            WHEN Month(DateVal) IN (4, 5, 6) THEN 4
            WHEN Month(DateVal) IN (7, 8, 9) THEN 1
            WHEN Month(DateVal) IN (10, 11, 12) THEN 2
        END, -- fiscal quarter (fiscal year runs from Jul to June)
        CASE
            WHEN Month(DateVal) < 7 THEN Year(DateVal)
            ELSE Year(DateVal) + 1
        END -- Fiscal year 
FROM #TmpStageDate
GO
```

> [!NOTE]
> As the data warehouse is populated in the future with new fact data, you periodically need to extend the range of dates in the **DimDate** table.

While the scripted loop approach can be an effective way to populate a time dimension table, it may take some time to run on an MPP system. In some cases, it may be more efficient to generate a sequence of date attributes using an external tool (such as Microsoft Excel) in a file, and using the `COPY` command to load the date data.

### Updating dimension tables

So far we've explored how to Insert new dimension data. However, in many data warehouses you need to handle updates to dimension data and support what are commonly referred to as *slowly changing dimensions* (SCDs).

There are multiple kinds of slowly changing dimension, of which three are commonly implemented:

- **Type 0**: Dimension data cannot be changed. Any attempted changes fail.
- **Type 1**: A change made to an existing dimension row applies to all previously loaded facts related to the dimension.
- **Type 2**: A change to a dimension results in a new dimension row. Existing rows for previous versions of the dimension are retained for historical fact analysis and the new row is applied to future fact table entries.

Let's take a look at an example of a *Type 1* change. Suppose a store changes its name from "High Street Store" to "Town Center Store". In this case, the change should be reflected for all new sales and also all existing historical sales - so any queries that aggregate sales by store name should include all previous sales in the total for the store, regardless of the name change. To handle this change, the load process must identify the existence of any current rows for the affected store in the dimension table based on the alternate key, and update them to change the store name.

Now let's consider an example of a *Type 2* change. Suppose a customer changes their address because they move to a new city. In this case, you would want all existing historical sales to still be counted under the city where the customer lived when the sale was made, and all future sales after they moved to be counted under their new city. To handle this change, the load process must create a new row for the customer with a new surrogate key (but the same alternate key) to reflect the new address. Optionally, the table could include a Boolean column to indicate which record for this alternate key is the currently active record, or a DateTime column to indicate the point in time from which the new record applies (otherwise you can rely on an incrementing surrogate key and use the `MAX` function to find the most recently inserted row for a given alternate key.).

Logic to implement Type 1 and Type 2 updates can be complex, and there are various techniques you can use. For example, you could use a combination of `UPDATE` and `INSERT` statements as shown in the following code example:

```sql
-- Insert new customers
INSERT INTO dbo.DimCustomer
SELECT stg.CustomerNo,
       stg.CustomerName,
       stg.EmailAddress,
       stg.Phone,
       stg.StreetAddress
FROM dbo.StageCustomers AS stg
WHERE NOT EXISTS
    (SELECT * FROM dbo.DimCustomer AS dim
     WHERE dim.CustomerAltKey = stg.CustomerNo);

-- Type 1 updates (name, email, phone)
UPDATE dbo.DimCustomer
SET CustomerName = stg.CustomerName,
    EmailAddress = stg.EmailAddress,
    Phone = stg.Phone
FROM dbo.StageCustomers AS stg
WHERE dbo.DimCustomer.CustomerAltKey = stg.CustomerNo;

-- Type 2 updates (geographic address)
INSERT INTO dbo.DimCustomer
SELECT stg.CustomerNo AS CustomerAltKey,
       stg.CustomerName,
       stg.EmailAddress,
       stg.Phone,
       stg.StreetAddress,
       stg.City,
       stg.PostalCode,
       stg.CountryRegion
FROM dbo.StageCustomers AS stg
JOIN dbo.DimCustomer AS dim
ON stg.CustomerNo = dim.CustomerAltKey
AND stg.StreetAddress <> dim.StreetAddress;
```

> [!NOTE]
> In the previous example, it is assumed that an incrementing surrogate key based on an `IDENTITY` column identifies each row, and that the highest value surrogate key for a given alternate key indicates the most recent or "current" instance of the dimension entity associated with that alternate key. In practice, many data warehouse designers include a Boolean column to indicate the current active instance of a changing dimension or use DateTime fields to indicate the active time periods for each version of the dimension instance. With these approaches, the logic for a type 2 change must include an `INSERT` of the new dimension row *and* an `UPDATE` to mark the current row as inactive.

As an alternative to using multiple `INSERT` and `UPDATE` statement, you can use a single `MERGE` statement to perform an "*upsert*" operation to insert new records and update existing ones, as shown in the following example, which loads new product records and applies type 1 updates to existing products:

```sql
MERGE dbo.DimProduct AS tgt
    USING (SELECT * FROM dbo.StageProducts) AS src
    ON src.ProductID = tgt.ProductBusinessKey
WHEN MATCHED THEN
    UPDATE SET
        tgt.ProductName = src.ProductName,
        tgt.ProductCategory = src.ProductCategory
        tgt.Color = src.Color,
        tgt.Size = src.Size,
        tgt.ListPrice = src.ListPrice,
        tgt.Discontinued = src.Discontinued
WHEN NOT MATCHED THEN
    INSERT VALUES
        (src.ProductID,
         src.ProductName,
         src.ProductCategory,
         src.Color,
         src.Size,
         src.ListPrice,
         src.Discontinued);
```

> [!NOTE]
> At the time of writing, the `MERGE` statement is in preview for Azure Synapse Analytics dedicated SQL pools and is subject to some some constraints, including the requirement that the target table uses a HASH distribution and the inability to use an `IDENTITY` column for surrogate keys when inserting new records. See the [MERGE documentation for Azure Synapse Analytics](/sql/t-sql/statements/merge-transact-sql?view=azure-sqldw-latest) for more details.

Another way to load a combination of new and updated data into a dimension table is to use a `CREATE TABLE AS` (*CTAS*) statement to create a new table that contains the existing rows from the dimension table and the new and updated records from the staging table. After creating the new table, you can delete or rename the current dimension table, and rename the new table to replace it.

```sql
CREATE TABLE dbo.DimProductUpsert
WITH
(
    DISTRIBUTION = REPLICATE,
    CLUSTERED COLUMNSTORE INDEX
)
AS
-- New or updated rows
SELECT  stg.ProductID AS ProductBusinessKey,
        stg.ProductName,
        stg.ProductCategory,
        stg.Color,
        stg.Size,
        stg.ListPrice,
        stg.Discontinued
FROM    dbo.StageProduct AS stg
UNION ALL  
-- Existing rows
SELECT  dim.ProductBusinessKey,
        dim.ProductName,
        dim.ProductCategory,
        dim.Color,
        dim.Size,
        dim.ListPrice,
        dim.Discontinued
FROM    dbo.DimProduct AS dim
WHERE NOT EXISTS
(   SELECT  *
    FROM dbo.StageProduct AS stg
    WHERE stg.ProductId = dim.ProductBusinessKey
);

RENAME OBJECT dbo.DimProduct TO DimProductArchive;
RENAME OBJECT dbo.DimProductUpsert TO DimProduct;
```

> [!NOTE]
> When using MERGE or CTAS techniques to load dimension tables, you can't rely on `IDENTITY` columns for surrogate keys. You need to either implement some custom logic to create unique surrogate keys (and maintain consistency with existing related *fact* table records) or design a schema that relies purely on business keys (which makes it difficult to implement type 2 changes).

## Loading staged data into fact tables

Typically, a regular data warehouse load operation loads fact tables after dimension tables. This ensures that the dimensions to which the facts will be related are already present in the data warehouse.

The staged fact data usually includes the business (alternate) keys for the related dimensions, so your logic to load the data must look up the corresponding surrogate keys. In the case of slowly changing dimensions, the appropriate version of the dimension record must be identified to ensure the correct surrogate key is used to match the event recorded in the fact table with the state of the dimension at the time the fact occurred. In most cases, this means retrieving the latest "current" version of the dimension; but in some cases you might need to find the right dimension record based on DateTime columns that indicate the period of validity for each version of the dimension.

The following example assumes that the dimension records have an incrementing surrogate key, and that the most recently added version of a specific dimension instance (which will have the highest key value) should be used.

```sql
INSERT INTO dbo.FactSales
SELECT  (SELECT MAX(DateKey)
         FROM dbo.DimDate
         WHERE FullDateAlternateKey = stg.OrderDate) AS OrderDateKey,
        (SELECT MAX(CustomerKey)
         FROM dbo.DimCustomer
         WHERE CustomerAlternateKey = stg.CustomerNo) AS CustomerKey,
        (SELECT MAX(ProductKey)
         FROM dbo.DimProduct
         WHERE ProductAlternateKey = stg.ProductID) AS ProductKey,
        (SELECT MAX(StoreKey)
         FROM dbo.DimStore
         WHERE StoreAlternateKey = stg.StoreID) AS StoreKey,
        OrderNumber,
        OrderLineItem,
        OrderQuantity,
        UnitPrice,
        Discount,
        Tax,
        SalesAmount
FROM dbo.StageSales AS stg
```

## Post-load optimization

After loading new data into the data warehouse, it's a good idea to rebuild the table columnstore indexes and update statistics on commonly queried columns.

The following example rebuilds all indexes on the **DimProduct** table.

```sql
ALTER INDEX ALL ON dbo.DimProduct REBUILD
```

The following example creates statistics on the **ProductCategory** column of the **DimProduct** table:

```sql
CREATE STATISTICS productcategory_stats
ON dbo.DimProduct (ProductCategory);
```

> [!NOTE]
> For more information, see the [Indexes on dedicated SQL pool tables in Azure Synapse Analytics](/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-tables-index) and [Table statistics for dedicated SQL pool in Azure Synapse Analytics](/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-tables-statistics) articles in the Azure Synapse Analytics documentation.
