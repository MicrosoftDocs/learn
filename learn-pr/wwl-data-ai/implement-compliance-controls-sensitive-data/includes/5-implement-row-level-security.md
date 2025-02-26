Row-level security (RLS) doesn't use encryption and operates at the database level to restrict access to a table by using a security policy based on group membership or authorization context. This functionally is equivalent to a `WHERE` clause.

The security policy invokes an inline table-valued function to protect access to the rows in a table.

Depending on the attribute of a user, the predicate determines if that user has access to the relevant information. When you run a query against a table, the security policy applies the predicate function. Depending on the business requirements, RLS can be as simple as `WHERE CustomerId = 29` or as complex as required.

There are two types of security policies supported by row-level security:

- **Filter predicates** - restrict data access that violates the predicate.

    | Access | Definition |
    |------------|-------------|
    |**SELECT** | Can't view rows that are filtered. |
    |**UPDATE** | Can't update rows that are filtered. |
    |**DELETE** | Can't delete rows that are filtered. |
    |**INSERT** | Not applicable. |

- **Block predicates** - restrict data changes that violate the predicate.

    | Access | Definition |
    |------------|-------------|
    |**AFTER INSERT** | Prevents users from inserting rows with values that violate the predicate. |
    |**AFTER UPDATE** | Prevents users from updating rows to values that violate the predicate. |
    |**BEFORE UPDATE** | Prevents users from updating rows that currently violate the predicate. |
    |**BEFORE DELETE** | Blocks delete operations if the row violates the predicate. |

Because access control is configured and applied at the database level, application changes are minimal - if any. Also, users can directly have access to the tables and can query their own data.

Row-level security is implemented in three main steps:

1. Create the users or groups you want to isolate access.
1. Create the inline table-valued function that filters the results based on the predicate defined.
1. Create a security policy for the table, assigning the function created previously.

The following T-SQL commands demonstrate how to use RLS in a scenario where user access is segregated by tenant:

```sql
-- Create supporting objects for this example
CREATE TABLE [Sales] (SalesID INT, 
    ProductID INT, 
    TenantName NVARCHAR(10), 
    OrderQtd INT, 
    UnitPrice MONEY)
GO

INSERT INTO [Sales]  VALUES (1, 3, 'Tenant1', 5, 10.00);
INSERT INTO [Sales]  VALUES (2, 4, 'Tenant1', 2, 57.00);
INSERT INTO [Sales]  VALUES (3, 7, 'Tenant1', 4, 23.00);
INSERT INTO [Sales]  VALUES (4, 2, 'Tenant2', 2, 91.00);
INSERT INTO [Sales]  VALUES (5, 9, 'Tenant3', 5, 80.00);
INSERT INTO [Sales]  VALUES (6, 1, 'Tenant3', 5, 35.00);
INSERT INTO [Sales]  VALUES (7, 3, 'Tenant4', 8, 11.00);

-- View all the rows in the table  
SELECT * FROM Sales;
```

Next, create the users and grant them access to the *Sales* table. In this example, each user is responsible for a specific tenant. The *TenantAdmin* user has access to see data from all tenants.

```sql
CREATE USER [TenantAdmin] WITH PASSWORD = '<strong password>'
GO
CREATE USER [Tenant1] WITH PASSWORD = '<strong password>'
GO
CREATE USER [Tenant2] WITH PASSWORD = '<strong password>'
GO
CREATE USER [Tenant3] WITH PASSWORD = '<strong password>'
GO
CREATE USER [Tenant4] WITH PASSWORD = '<strong password>'
GO

GRANT SELECT ON [Sales] TO [TenantAdmin]
GO
GRANT SELECT ON [Sales] TO [Tenant1]
GO
GRANT SELECT ON [Sales] TO [Tenant2]
GO
GRANT SELECT ON [Sales] TO [Tenant3]
GO
GRANT SELECT ON [Sales] TO [Tenant4]
GO

```

Next, we create a new schema, an inline table-valued function, and grant user access to the new function. The `WHERE @TenantName = USER_NAME() OR USER_NAME() = 'TenantAdmin'` predicate evaluates if the user name executing the query matches the *TenantName* column values.

```sql
CREATE SCHEMA sec;  
GO  

--Create the filter predicate

CREATE FUNCTION sec.tvf_SecurityPredicatebyTenant(@TenantName AS NVARCHAR(10))  
    RETURNS TABLE  
WITH SCHEMABINDING  
AS  
    RETURN	SELECT 1 AS result
			WHERE @TenantName = USER_NAME() OR USER_NAME() = 'TenantAdmin';  
GO

--Grant users access to inline table-valued function

GRANT SELECT ON sec.tvf_SecurityPredicatebyTenant TO [TenantAdmin]
GO
GRANT SELECT ON sec.tvf_SecurityPredicatebyTenant TO [Tenant1]
GO
GRANT SELECT ON sec.tvf_SecurityPredicatebyTenant TO [Tenant2]
GO
GRANT SELECT ON sec.tvf_SecurityPredicatebyTenant TO [Tenant3]
GO
GRANT SELECT ON sec.tvf_SecurityPredicatebyTenant TO [Tenant4]
GO

--Create security policy and add the filter predicate
CREATE SECURITY POLICY sec.SalesPolicy  
ADD FILTER PREDICATE sec.tvf_SecurityPredicatebyTenant(TenantName) ON [dbo].[Sales]
WITH (STATE = ON);  
GO
```

At this point, we're ready to test the access:

```sql
EXECUTE AS USER = 'TenantAdmin';  
SELECT * FROM dbo.Sales;
REVERT;  
  
EXECUTE AS USER = 'Tenant1';  
SELECT * FROM dbo.Sales;
REVERT;  
  
EXECUTE AS USER = 'Tenant2';  
SELECT * FROM dbo.Sales;
REVERT;

EXECUTE AS USER = 'Tenant3';  
SELECT * FROM dbo.Sales;
REVERT;

EXECUTE AS USER = 'Tenant4';  
SELECT * FROM dbo.Sales;
REVERT;
```

The *TenantAdmin* user should see all the rows. The *Tenant1*, *Tenant2*, *Tenant3*, and *Tenant4* users should only see their own rows.

If you alter the security policy with `WITH (STATE = OFF);`, you notice that users see all the rows.

:::image type="content" source="../media/module-33-security-final-28.png" alt-text="Screenshot of T-SQL commands to alter a security policy.":::

>[!NOTE]
> There's a risk of information leakage if an attacker writes a query with a specially crafted `WHERE` clause and, for example, a divide-by-zero error, to force an exception if the `WHERE` condition is true. This is known as a *side-channel attack*. It's wise to limit the ability of users to run unplanned queries when using row-level security.

## Use case

Row-level security is ideal for many scenarios, including:

- When you need to isolate departmental access at the row level.
- When you need to restrict customers' data access to only the data relevant to their company.
- When you need to restrict access for compliance purposes.

## Best practice

Here are a few best practices to consider when implementing RLS:

- Create a separate schema for predicate functions, and security policies.
- Avoid type conversions in predicate functions.
- Avoid using excessive table joins and recursion in predicate functions.
