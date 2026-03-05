>[!VIDEO https://learn-video.azurefd.net/vod/player?id=778d274c-f2bc-474b-94f1-690bd6b46ad5]

When working with sensitive information in a data lakehouse, you need more than just role-based permissions. Unity Catalog allows you to enforce **fine-grained access control** so that different users can query the same tables but see only the data they're allowed to. Two approaches are commonly used, as explained in the previous unit:

- **Row and Column Security** – restricts which rows and columns a user can see at the table level.
- **Dynamic Views** – encapsulates filtering and masking logic in a view definition that adapts automatically to user context.

Both strategies depend on group membership checks, such as `is_account_group_member()`, to determine whether a user should see protected values.

## Row and column security

Row and column security lets you define rules directly on a table. Two operations are available: **column masking** and **row filtering**.

### Column masking

Column masking ensures that sensitive values are hidden unless a user belongs to an authorized group. For example, the `c_phone` column in a **customers** table can be masked with a function:

```sql
CREATE OR REPLACE FUNCTION phone_mask(c_phone STRING)
  RETURN CASE WHEN is_account_group_member('metastore_admins') 
    THEN c_phone 
    ELSE 'REDACTED PHONE NUMBER' 
  END;
```

The masking function is then applied to the column:

```sql
ALTER TABLE customers 
  ALTER COLUMN c_phone 
  SET MASK phone_mask;
```

From this point forward, queries against the table return actual phone numbers only to `metastore_admins`. Other users always see `REDACTED PHONE NUMBER`.

### Row filtering

Row filtering removes rows from query results for users who aren't authorized. You define a function that returns `true` only when a row should be visible. For example:

```sql
CREATE OR REPLACE FUNCTION nation_filter(c_nationkey INT)
  RETURN IF(is_account_group_member('admin'), true, c_nationkey = 21);
```

When applied as a row filter:

```sql
ALTER TABLE customers 
SET ROW FILTER nation_filter ON (c_nationkey);
```

This ensures that non-admins only see rows where `c_nationkey = 21`. Admin users continue to see all rows.

Together, column masking and row filtering provide a way to enforce restrictions directly on the base table.

## Dynamic views

An alternative to modifying a table is to create a **dynamic view**. Views allow you to express row and column restrictions in SQL, and every user querying the view automatically sees the appropriate subset of the data.

Consider a **customers_new** table with sensitive information. A dynamic view can redact phone numbers and limit rows in one definition:

```sql
CREATE OR REPLACE VIEW vw_customers AS
SELECT 
  c_custkey, 
  c_name, 
  c_address, 
  c_nationkey,
  CASE 
    WHEN is_account_group_member('admins') THEN c_phone
    ELSE 'REDACTED PHONE NUMBER'
  END as c_phone,
  c_acctbal, 
  c_mktsegment, 
  c_comment
FROM customers_new
WHERE
  CASE WHEN
    is_account_group_member('admins') THEN TRUE
    ELSE c_nationkey = 21
  END;
```

When users query this view, the rules apply automatically:

- Phone numbers are shown only for members of the `admins` group.
- Non-admins see only rows with `c_nationkey = 21`.

Access to the view can then be granted with standard SQL permissions:

```sql
GRANT SELECT ON VIEW vw_customers TO `account users`;
```

The underlying table remains untouched, while the view enforces security logic.

## Choosing between the two approaches

Both approaches achieve fine-grained security, but they differ in scope:

- **Row and Column Security** is embedded at the table level and guarantees that restrictions apply everywhere the table is used.
- **Dynamic Views** provide flexibility: you can create multiple views with different rules for different audiences, while keeping the base table unrestricted.

:::image type="content" source="../media/choose-between-approaches.png" alt-text="Diagram helping you choose between the two approaches." border="false" lightbox="../media/choose-between-approaches.png":::

In practice, you use table-level controls when you need strict enforcement, and dynamic views when you want adaptable, shareable abstractions.