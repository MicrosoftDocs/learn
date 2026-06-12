Row-level security (RLS) controls which rows a user can see in a table — automatically and transparently, without changing application queries. Rather than filtering results in your application layer, you define a security predicate in the database and the SQL engine enforces it for every query against that table.

In a shared sales table, for example, you might use RLS so that each salesperson sees only their own orders. They query the same table as everyone else, but get results scoped to their data.

## How row-level security works

RLS uses two components that work together:

- **Filter predicates** – An inline table-valued function that evaluates each row and returns `true` or `false`. Rows where the predicate returns `false` are invisible to the user for `SELECT`, `UPDATE`, and `DELETE` operations. `INSERT` isn't affected by filter predicates.

- **Security policies** – A policy that binds one or more filter predicates to specific tables. When a query runs against a secured table, the policy applies the predicate automatically.

Because filtering happens at the database engine level, users can query tables directly with no awareness that rows are being filtered. Application code doesn't need to change.

## Configure row-level security

The following example shows how to set up RLS so that each salesperson in a shared `Sales` table sees only their own rows.

First, create the table and add test data:

```sql
CREATE TABLE [Sales] (
    SalesID INT,
    ProductID INT,
    SalesPerson NVARCHAR(50),
    OrderQty INT,
    UnitPrice MONEY
);

INSERT INTO [Sales] VALUES (1, 3, 'alice@contoso.com', 5, 10.00);
INSERT INTO [Sales] VALUES (2, 4, 'alice@contoso.com', 2, 57.00);
INSERT INTO [Sales] VALUES (3, 7, 'bob@contoso.com', 4, 23.00);
INSERT INTO [Sales] VALUES (4, 2, 'bob@contoso.com', 2, 91.00);
INSERT INTO [Sales] VALUES (5, 9, 'carol@contoso.com', 5, 80.00);
```

Next, create a dedicated schema for security objects, define the filter predicate, and apply the security policy:

```sql
-- Create a schema for security objects
CREATE SCHEMA [Sec];
GO

-- Define the filter predicate
CREATE FUNCTION sec.tvf_SecurityPredicateBySalesPerson(@SalesPerson AS NVARCHAR(50))
    RETURNS TABLE
WITH SCHEMABINDING
AS
    RETURN SELECT 1 AS result
           WHERE @SalesPerson = USER_NAME()
              OR USER_NAME() = 'salesadmin@contoso.com';
GO

-- Apply the policy to the Sales table
CREATE SECURITY POLICY sec.SalesPolicy
ADD FILTER PREDICATE sec.tvf_SecurityPredicateBySalesPerson(SalesPerson) ON [dbo].[Sales]
WITH (STATE = ON);
GO
```

With this policy active, `alice@contoso.com` sees only her rows, while `salesadmin@contoso.com` sees all rows. To disable the policy temporarily, set `STATE = OFF`.

## Understand security considerations

RLS applies security predicates to all users — including workspace Admins, Members, and Contributors. If a predicate isn't written to explicitly include admin-level users, those users will have rows filtered from their results just like any other user. Always write your predicate to include an explicit condition for admin access if full visibility is required.

RLS is also vulnerable to *side-channel attacks*, where a carefully crafted query can reveal the values of filtered rows without the user ever directly reading them. For example, an attacker could write a query that forces a divide-by-zero error only when a hidden value meets a certain condition — and use the error itself as a signal.

>[!NOTE]
> To reduce side-channel risks, combine RLS with column-level security and dynamic data masking. Monitor security policy changes and restrict `ALTER ANY SECURITY POLICY` to trusted users only.
