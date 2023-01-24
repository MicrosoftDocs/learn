


In many data warehouses you need to handle updates to dimension data and support what are commonly referred to as *slowly changing dimensions* (SCDs).

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
