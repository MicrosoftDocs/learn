[Row-Level Security (RLS)](/fabric/data-warehouse/row-level-security?azure-portal=true) is a feature that provides granular control over access to rows in a table based on group membership or execution context. 

For example, in an e-commerce platform, you can ensure that sellers only have access to order rows that are related to their own products. This way, each seller can manage their orders independently, while maintaining the privacy of other sellers’ order information.

If you have experience with SQL Server, you find that row-level security shares similar characteristics and features.

## Protect your data

Row-Level Security (RLS) works by associating a function, known as a security predicate, with a table. This function is defined to return *true* or *false* based on certain conditions, typically involving the values of one or more columns in the table. When a user attempts to access data in the table, the security predicate function is invoked. If the function returns *true*, the row is accessible to the user; if it returns *false*, the row is effectively invisible to the user. 

Depending on the business requirements, RLS can be as simple as `WHERE CustomerId = 29` or as complex as required.

This process is transparent to the user and is enforced automatically by SQL Server, ensuring consistent application of security rules. 

Row-level security is implemented in two main steps:

- **Filter predicates** - It's an inline table-valued function that filters the results based on the predicate defined.

    | Access | Definition |
    |------------|-------------|
    |**SELECT** | Can't view rows that are filtered. |
    |**UPDATE** | Can't update rows that are filtered. |
    |**DELETE** | Can't delete rows that are filtered. |
    |**INSERT** | Not applicable. |

- **Security policy** - It's a security policy that invokes an inline table-valued function to protect access to the rows in a table.

Because access control is configured and applied at the warehouse level, application changes are minimal - if any. Also, users can directly have access to the tables and can query their own data.

## Configure row-level security

The T-SQL commands below demonstrate how to use RLS in a scenario where user access is segregated by tenant:

```sql
-- Create supporting objects for this example
CREATE TABLE [Sales] (SalesID INT, 
    ProductID INT, 
    TenantName NVARCHAR(10), 
    OrderQtd INT, 
    UnitPrice MONEY)
GO

INSERT INTO [Sales]  VALUES (1, 3, 'tenant1@contoso.com', 5, 10.00);
INSERT INTO [Sales]  VALUES (2, 4, 'tenant2@contoso.com', 2, 57.00);
INSERT INTO [Sales]  VALUES (3, 7, 'tenant3@contoso.com', 4, 23.00);
INSERT INTO [Sales]  VALUES (4, 2, 'tenant4@contoso.com', 2, 91.00);
INSERT INTO [Sales]  VALUES (5, 9, 'tenant5@contoso.com', 5, 80.00);

-- View all the rows in the table  
SELECT * FROM Sales;
```

Next, we create a new schema, an inline table-valued function, and grant user access to the new function. The `WHERE @TenantName = USER_NAME() OR USER_NAME() = 'TenantAdmin'` predicate evaluates if the user name executing the query matches the *TenantName* column values.

```sql
--Create a schema
CREATE SCHEMA [Sec];  
GO  

--Create the filter predicate
CREATE FUNCTION sec.tvf_SecurityPredicatebyTenant(@TenantName AS NVARCHAR(10))  
    RETURNS TABLE  
WITH SCHEMABINDING  
AS  
    RETURN	SELECT 1 AS result
			WHERE @TenantName = USER_NAME() OR USER_NAME() = 'tenantAdmin@contoso.com';  
GO

--Create security policy and add the filter predicate
CREATE SECURITY POLICY sec.SalesPolicy  
ADD FILTER PREDICATE sec.tvf_SecurityPredicatebyTenant(TenantName) ON [dbo].[Sales]
WITH (STATE = ON);  
GO
```

The *tenantAdmin@contoso.com* user should see all the rows. The *tenant1@contoso.com* to *tenant5@contoso.com* users should only see their own rows.

If you alter the security policy with `WITH (STATE = OFF);`, you notice that users see all the rows.

>[!NOTE]
> There is a risk of information leakage if an attacker writes a query with a specially crafted `WHERE` clause and, for example, a divide-by-zero error, to force an exception if the `WHERE` condition is true. This is known as a *side-channel attack*. It is wise to limit the ability of users to run ad hoc queries when using row-level security.

## Explore use cases

Row-level security is ideal for many scenarios, including:

- When you need to isolate departmental access at the row level.
- When you need to restrict customers' data access to only the data relevant to their company.
- When you need to restrict access for compliance purposes.

## Apply best practices

Here are a few best practices to consider when implementing RLS:

- It's recommended to create a separate schema for predicate functions, and security policies.
- Whenever possible, avoid type conversions in predicate functions.
- To maximize performance, avoid using excessive table joins and recursion in predicate functions.
