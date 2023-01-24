

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

Another way to load a combination of new and updated data into a dimension table is to use a CREATE TABLE AS (CTAS) statement to create a new table that contains the existing rows from the dimension table and the new and updated records from the staging table. After creating the new table, you can delete or rename the current dimension table, and rename the new table to replace it.

```sql

Copy
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

Azure Synapse Analytics allows you to create, control, and manage resource availability when workloads are competing. This allows you to manage the relative importance of each workload when waiting for available resources.

To facilitate faster load times, you can create a workload classifier for the load user with the “importance” set to above_normal or High. Workload importance ensures that the load takes precedence over other waiting tasks of a lower importance rating. Use this with your own workload group definitions for workload isolation to manage minimum and maximum resource allocations during peak and quiet periods.
