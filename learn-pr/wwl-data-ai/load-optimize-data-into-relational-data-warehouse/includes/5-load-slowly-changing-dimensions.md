

In most relational data warehouses, you need to handle updates to dimension data and support what are commonly referred to as *slowly changing dimensions* (SCDs).

## Types of slowly changing dimension

There are multiple kinds of slowly changing dimension, of which three are commonly implemented:

### Type 0

*Type 0* dimension data can't be changed. Any attempted changes fail.

| DateKey | DateAltKey | Day | Month | Year |
|----------|----------|----------|----------|----------|
|20230101|01-01-2023|Sunday|January|2023|

### Type 1

In *type 1* dimensions, the dimension record is updated in-place. Changes made to an existing dimension row apply to all previously loaded facts related to the dimension. 

| StoreKey | StoreAltKey | StoreName |
|----------|----------|----------|
|123|EH199J|~~High Street Store~~ Town Central Store|

### Type 1

In a *type 2* dimension, a change to a dimension results in a new dimension row. Existing rows for previous versions of the dimension are retained for historical fact analysis and the new row is applied to future fact table entries.

| CustomerKey | CustomerAltKey | Name | Address | City | DateFrom | DateTo | IsCurrent |
|----------|----------|----------|----------|----------|----------|----------|----------|
|1211|jo@contoso.com|Jo Smith|999 Main St|Seattle|20190101|20230105|False|
|2996|jo@contoso.com|Jo Smith|1234 9th Ave|Boston|20230106||True|

> [!Note]
> Type 2 dimensions often include columns to track the effective time periods for each version of an entity, and/or a flag to indicate which row represents the current version of the entity. If you’re using an incrementing surrogate key and you only need to track the most recently added version of an entity, then you may not need these columns; but before making that decision, consider how you’ll look up the appropriate version of an entity when a new fact is entered based on the time at which the event the fact relates to occurred.

## Combining INSERT and UPDATE statements

Logic to implement Type 1 and Type 2 updates can be complex, and there are various techniques you can use. For example, you could use a combination of `UPDATE` and `INSERT` statements.

```sql
-- New Customers
INSERT INTO dbo.DimCustomer
SELECT stg.*
FROM dbo.StageCustomers AS stg
WHERE NOT EXISTS
    (SELECT * FROM dbo.DimCustomer AS dim
    WHERE dim.CustomerAltKey = stg.CustNo)

-- Type 1 updates (name)
UPDATE dbo.DimCustomer
SET CustomerName = stg.CustomerName
FROM dbo.StageCustomers AS stg
WHERE dbo.DimCustomer.CustomerAltKey = stg.CustomerNo;

-- Type 2 updates (StreetAddress)
INSERT INTO dbo.DimCustomer
SELECT stg.*
FROM dbo.StageCustomers AS stg
JOIN dbo.DimCustomer AS dim
ON stg.CustNo = dim.CustomerAltKey
AND stg.StreeetAddress <> dim.StreetAddress;

```

In the previous example, it's assumed that an incrementing surrogate key based on an `IDENTITY` column identifies each row, and that the highest value surrogate key for a given alternate key indicates the most recent or "current" instance of the dimension entity associated with that alternate key. In practice, many data warehouse designers include a Boolean column to indicate the current active instance of a changing dimension or use DateTime fields to indicate the active time periods for each version of the dimension instance. With these approaches, the logic for a type 2 change must include an `INSERT` of the new dimension row *and* an `UPDATE` to mark the current row as inactive.

## Using a MERGE statement

As an alternative to using multiple `INSERT` and `UPDATE` statements, you can use a single `MERGE` statement to perform an "*upsert*" operation to insert new records and update existing ones.

```sql
MERGE dbo.DimProduct AS tgt
    USING (SELECT * FROM dbo.StageProducts) AS src
    ON src.ProductID = tgt.ProductBusinessKey
WHEN MATCHED THEN
    -- Type 1 updates
    UPDATE SET
        tgt.ProductName = src.ProductName,
        tgt.ProductCategory = src.ProductCategory,
        tgt.Color = src.Color,
        tgt.Size = src.Size,
        tgt.ListPrice = src.ListPrice,
        tgt.Discontinued = src.Discontinued
WHEN NOT MATCHED THEN
    -- New products
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
> For more information about the MERGE statement, see the [MERGE documentation for Azure Synapse Analytics](/sql/t-sql/statements/merge-transact-sql?view=azure-sqldw-latest&preserve-view=true&azure-portal=true).
