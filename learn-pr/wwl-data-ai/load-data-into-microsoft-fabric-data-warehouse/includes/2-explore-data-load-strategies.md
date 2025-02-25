In Microsoft Fabric, there are many ways you can choose to load data in a warehouse. This step is fundamental as it ensures that high-quality, transformed, or processed data is integrated into a single repository. 

Also, the efficiency of data loading directly impacts the timeliness and accuracy of analytics, making it vital for real-time decision-making processes. Investing time and resources in designing and implementing a robust data loading strategy is essential for the success of the data warehouse project.

## Understand data ingestion and data load operations

While both processes are part of the ETL (Extract, Transform, Load) pipeline in a data warehouse scenario, they usually serve different purposes. **Data ingestion/extract** is about moving raw data from various sources into a central repository. On the other hand, **data loading** involves taking the transformed or processed data and loading it into the final storage destination for analysis and reporting. 

Fabric data warehouses and lakehouses automatically store their data in OneLake using the Delta Parquet format.

## Stage your data

You might have to build and work with auxiliary objects involved in a load operation, such as tables, stored procedures, and functions. These auxiliary objects are commonly known as **staging**. Staging objects act as temporary storage and transformation areas. They can either share resources with a data warehouse or reside in their own storage area.

Staging serves as an abstraction layer, simplifying and facilitating the load operation to the final tables in the data warehouse.

:::image type="content" source="../media/1-data-warehouse-process.png" alt-text="Diagram of sequential steps in the data science process.":::

Also, staging area provides a buffer that can help to minimize the impact of the load operation on the performance of the data warehouse. This is important in environments where the data warehouse needs to remain operational and responsive during the data loading process.

## Review type of data loads

There are two types of data loads to consider when loading a data warehouse.

| Load Type | Description | Operation | Duration | Complexity | Best used |
| --- | --- | --- | --- | --- | --- |
| **Full (initial) load** | The process of populating the data warehouse for the first time. | All the tables are truncated and reloaded, and the old data is lost | It may take longer to complete due to the amount of data being handled | Easier to implement as there's no history preserved | This method is typically used when setting up a new data warehouse, or when a complete refresh of the data is required |
| **Incremental load** | The process of updating the data warehouse with the changes since the last update | The history is preserved, and tables are updated with new information | Takes less time than the initial load | Implementation is more complex than the initial load | This method is commonly used for regular updates to the data warehouse, such as daily or hourly updates. It requires mechanisms to track changes in the source data since the last load. |

An ETL (Extract, Transform, Load) process for a data warehouse doesn't always need both the full load and the incremental load. In some cases, a combination of both methods might be used. The choice between a full load and an incremental load depends on many factors such as the amount of data, the characteristics of the data, and the requirements of the data warehouse.

To learn more about how to perform an incremental load, see [**Incremental load**](/fabric/data-factory/tutorial-incremental-copy-data-warehouse-lakehouse?azure-portal=true).

## Understand business key and surrogate key

In a data warehouse, both surrogate keys and business keys are essential for effective data warehousing and data integration, but they serve different purposes.

- **Surrogate key:** A surrogate key is a system-generated identifier that is used to uniquely identify a record in a table within the data warehouse. It has no business meaning and is typically an integer or a unique identifier. Surrogate keys are used to maintain consistency and accuracy in the data warehouse, especially when integrating data from multiple sources. They help to avoid issues that can arise from changes in the source systems, such as reusing or changing business keys. 

- **Business Key:** A business key, also known as a natural key, is an identifier that comes from the source system and has business meaning. It's used to uniquely identify a record in the source system. Examples of business keys include product codes, customer IDs, and employee numbers. Business keys are important for maintaining traceability between the data warehouse and the source systems. They help to ensure that data in the warehouse can be accurately matched to the corresponding records in the source systems.

## Load a dimension table

Think of a dimension table as the *"who, what, where, when, why”* of your data warehouse. It’s like the descriptive backdrop that gives context to the raw numbers found in the fact tables.

For example, if you’re running an online store, your fact table might contain the raw sales data - how many units of each product were sold. But without a dimension table, you wouldn’t know who bought those products, when they were bought, or where the buyer is located.

### Slowly changing dimensions (SCD)

Slowly Changing Dimensions evolve over time, but at a slow pace and unpredictably. Take, for instance, a customer's address in a retail business. When a customer relocates, their address changes. If you overwrite the old address with the new one, you lose the historical data. However, if you need to analyze historical sales data, it's crucial to know where the customer lived at the time of each sale. This is where SCDs become essential.

There are several types of slowly changing dimensions in a data warehouse, with type 1 and type 2 being the most frequently used.

- **Type 0 SCD:** The dimension attributes never change.
- **Type 1 SCD**: Overwrites existing data, doesn't keep history.
- **Type 2 SCD**: Adds new records for changes, keeps full history for a given natural key.
- **Type 3 SCD:** History is added as a new column.
- **Type 4 SCD**: A new dimension is added.
- **Type 5 SCD**: When certain attributes of a large dimension change over time, but using type 2 isn't feasible due to the dimension’s large size.
- **Type 6 SCD**: Combination of type 2 and type 3.

In type 2 SCD, when a new version of the same element is brought to the data warehouse, the old version is considered expired and the new one becomes active.

:::image type="content" source="../media/2-slowly-changing-dimension.png" alt-text="Diagram showing the function and structure of OneLake." lightbox="../media/2-slowly-changing-dimension.png":::

The following example shows how to handle the business key in a type 2 SCD for the *Dim_Products* table using T-SQL.

```sql
IF EXISTS (SELECT 1 FROM Dim_Products WHERE SourceKey = @ProductID AND IsActive = 'True')
BEGIN
    -- Existing product record
    UPDATE Dim_Products
    SET ValidTo = GETDATE(), IsActive = 'False'
    WHERE SourceKey = @ProductID 
        AND IsActive = 'True';
END
ELSE
BEGIN
    -- New product record
    INSERT INTO Dim_Products (SourceKey, ProductName, StartDate, EndDate, IsActive)
    VALUES (@ProductID, @ProductName, GETDATE(), '9999-12-31', 'True');
END
```

The mechanism for detecting changes in source systems is crucial for determining when records are inserted, updated, or deleted. [Change Data Capture (CDC)](/sql/relational-databases/track-changes/about-change-data-capture-sql-server?azure-portal=true), [change tracking](/sql/relational-databases/track-changes/about-change-tracking-sql-server?azure-portal=true), and [triggers](/sql/relational-databases/triggers/dml-triggers?azure-portal=true) are all features available for managing data tracking in source systems such as SQL Server.

## Load a fact table

Typically, a standard data warehouse load operation involves loading fact tables after dimension tables. This ensures that the dimensions, which the facts reference, are already present in the data warehouse.

The staged fact data usually includes business keys for the related dimensions, so your loading logic must look up the corresponding surrogate keys. When dealing with slowly changing dimensions in the data warehouse, it's crucial to identify the appropriate version of the dimension record to ensure the correct surrogate key is used. This matches the event recorded in the fact table with the state of the dimension at the time the fact occurred.

In many cases, you can retrieve the latest "current" version of the dimension. However, sometimes you might need to find the correct dimension record based on DateTime columns that indicate the period of validity for each version of the dimension.

The following example assumes that dimension records have incrementing surrogate keys and that the most recently added version of a specific dimension instance, which will have the highest key value, might be used.

```sql
-- Lookup keys in dimension tables
INSERT INTO dbo.FactSales
SELECT  (SELECT MAX(DateKey)
         FROM dbo.DimDate
         WHERE FullDateAlternateKey = stg.OrderDate) AS OrderDateKey,
        (SELECT MAX(CustomerKey)
         FROM dbo.DimCustomer
         WHERE CustomerAlternateKey = stg.CustNo) AS CustomerKey,
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
