Before choosing a loading tool, you need a strategy. Loading data into a warehouse follows a predictable process: decide how much data to load, stage it for preparation, then load your dimension and fact tables in the right order. Each step builds on the previous one.

:::image type="content" source="../media/1-data-warehouse-process.png" alt-text="Diagram of sequential steps in the data warehouse loading process." lightbox="../media/1-data-warehouse-process.png":::

## Decide between full and incremental loads

The first decision is how much data to move. You choose between two loading patterns depending on whether you're populating a warehouse for the first time or keeping it current with ongoing changes.

| Load type | What it does | When to use it |
| --- | --- | --- |
| **Full load** | Truncates and reloads all tables. Old data is replaced entirely. | Setting up a new warehouse, or when you need a complete data refresh. Simpler to implement because you don't track history. |
| **Incremental load** | Updates tables with only the changes since the last load. History is preserved. | Regular updates (daily, hourly). Faster than a full load, but requires change-tracking mechanisms in the source data. |

Most warehouses use both. You perform a full load during the initial migration to Fabric, then switch to incremental loads for daily updates. The choice depends on your data volume, update frequency, and whether you need to preserve history.

## Stage data before loading

Once you decide on a load type, you need a place to prepare data before it reaches your final warehouse tables. Staging provides that workspace. You create staging tables, stored procedures, and functions that clean, transform, and validate incoming data. These staging objects can share resources with your warehouse or reside in separate storage.

Staging serves two purposes. First, it gives you a place to apply business rules and data type conversions without affecting production tables. Second, it acts as a buffer that keeps your warehouse responsive while large data loads process in the background.

## Identify records with business and surrogate keys

As data moves from staging into warehouse tables, you need a reliable way to identify and match records — especially during incremental loads where the same record might arrive multiple times. Two types of keys handle this.

A **business key** (also called a natural key) comes from your source system and carries meaning. Product SKUs, customer IDs, and employee numbers are all business keys. They let you trace warehouse records back to their source.

A **surrogate key** is a system-generated integer that uniquely identifies each warehouse record. It has no business meaning. Surrogate keys protect your warehouse from changes in source systems. If a source system reuses or modifies a product code, the surrogate key keeps your warehouse relationships intact.

For example, a product's SKU (``PRD-4521``) is a business key. The warehouse assigns it a surrogate key (``ProductKey = 1047``) that stays consistent regardless of source system changes.

## Load dimension tables

Dimension tables provide the descriptive context for your warehouse. While fact tables store measurements like sales amounts and quantities, dimension tables hold the attributes you analyze those measurements by — product names, customer locations, dates, and store details. You load dimension tables first because fact tables reference them.

The challenge with dimensions is that their attributes change over time. A customer moves to a new city. A product gets reclassified. These changes create a decision: do you overwrite the old value or keep a historical record? Slowly changing dimensions (SCD) provide a framework for handling these updates.

### Handle slowly changing dimensions

There are several SCD types. Type 1 and type 2 are by far the most common.

- **Type 0**: Dimension attributes never change.
- **Type 1**: Overwrites the existing value. No history is kept. Use when you don't need to track changes (for example, fixing a data entry error).
- **Type 2**: Adds a new row for each change and marks the old row as expired. Use when you need full history (for example, tracking a customer's address at the time of each sale).
- **Type 3**: Stores the previous value in a separate column. Tracks limited history only.
- **Type 4**: Moves changing attributes to a separate dimension table.
- **Type 5**: Combines type 4 with type 1 for large dimensions where type 2 isn't practical.
- **Type 6**: Combines type 2 and type 3 for both current and historical tracking.

In a type 2 SCD, each change creates a new version of the record. The old version is marked inactive, and the new version becomes the current record.

:::image type="content" source="../media/2-slowly-changing-dimension.png" alt-text="Diagram showing how a type 2 slowly changing dimension tracks record versions over time." lightbox="../media/2-slowly-changing-dimension.png":::

The following T-SQL example shows how to handle a type 2 SCD for a *Dim_Products* table. When a product already exists, the code expires the current version and inserts a new one. When the product is new, it inserts the first version.

```sql
IF EXISTS (SELECT 1 FROM Dim_Products WHERE SourceKey = @ProductID AND IsActive = 'True')
BEGIN
    -- Expire the current version
    UPDATE Dim_Products
    SET ValidTo = GETDATE(), IsActive = 'False'
    WHERE SourceKey = @ProductID 
        AND IsActive = 'True';
END
ELSE
BEGIN
    -- Insert new product record
    INSERT INTO Dim_Products (SourceKey, ProductName, StartDate, EndDate, IsActive)
    VALUES (@ProductID, @ProductName, GETDATE(), '9999-12-31', 'True');
END
```

## Load fact tables

You load fact tables after dimensions because each fact row references dimension records through surrogate keys. Your staged fact data contains business keys from source systems, so your loading logic looks up the matching surrogate key in each dimension table.

When dimensions use type 2 SCD, you also need to match the correct *version* of the dimension record. This ensures a sale is linked to the customer's address at the time of the transaction, not their current address. In many cases, you retrieve the most recent version. Sometimes you match based on validity dates.

The following example looks up surrogate keys from dimension tables. It assumes that dimension records have incrementing surrogate keys, so ``MAX()`` retrieves the most recently added version.

```sql
-- Lookup surrogate keys from dimension tables
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

With your load strategy, staging process, and table loading order defined, you're ready to explore the tools Fabric provides for loading data.