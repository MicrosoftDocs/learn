


In many data warehouses, you need to handle updates to dimension data and support what are commonly referred to as *slowly changing dimensions* (SCDs).

There are multiple kinds of slowly changing dimension, of which three are commonly implemented:

|Type 0|
| -- |
|Dimension data can't be changed. Any attempted changes fail.|

| DateKey | DateAltKey | Day | Month | Year |
|----------|----------|----------|----------|----------|
|20230101|01-01-2023|Sunday|January|2023|

|Type 1|
| -- |
|A change made to an existing dimension row applies to all previously loaded facts related to the dimension|

| StoreKey | StoreAltKey | StoreName |
|----------|----------|----------|
|123|EH199J|~~High Street Store~~ Town Central Store|

|Type 2|
| -- |
|A change to a dimension results in a new dimension row. Existing rows for previous versions of the dimension are retained for historical fact analysis and the new row is applied to future fact table entries.|

| CustomerKey | CustomerAltKey | Name | Address | City | DateFrom | DateTo | IsCurrent |
|----------|----------|----------|----------|----------|----------|----------|----------|
|1211|jo@contoso.com|Jo Smith|999 Main St|Seattle|20190101|20230105|False|
|2996|jo@contoso.com|Jo Smith|1234 9th Ave|Boston|20230106||True|

### Combining INSERT and UPDATE statements
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

> [!NOTE]
> In the previous example, it is assumed that an incrementing surrogate key based on an `IDENTITY` column identifies each row, and that the highest value surrogate key for a given alternate key indicates the most recent or "current" instance of the dimension entity associated with that alternate key. In practice, many data warehouse designers include a Boolean column to indicate the current active instance of a changing dimension or use DateTime fields to indicate the active time periods for each version of the dimension instance. With these approaches, the logic for a type 2 change must include an `INSERT` of the new dimension row *and* an `UPDATE` to mark the current row as inactive.

### Using a MERGE statement

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
> MERGE is now Generally Available in Synapse Dedicated SQL Pool with version '10.0.17829.0' or higher. Connect to your dedicated SQL pool (formerly SQL DW) and run SELECT @@VERSION. A pause and resume may be required to ensure your instance gets the latest version. See the [MERGE documentation for Azure Synapse Analytics](/sql/t-sql/statements/merge-transact-sql?view=azure-sqldw-latest&preserve-view=true) for more details.
