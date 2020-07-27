The EXECUTE AS [user], or EXECUTE AS [login] (only availably in SQL Server and Azure SQL Managed Instance) commands allow for the user context to be changed. As subsequent commands and statements will be executed using the new context with the permissions granted to that context.

If a user has a permission and the user no longer needs to have that permission, permissions can be removed (either grants or denies) using the REVOKE command. The revoke command will remove any GRANT or DENY permissions for the right specified to the user specified.

## Ownership Chains

A concept called chaining applies to permissions, which allows users to inherit permissions from other objects. The most common example of chaining is a function or stored procedure that accesses a table during its execution. If the procedure has the same owner as the table, the stored procedure is able to be executed and access the table, even though the user does not have rights to access the table directly. This access is available because the user inherits the rights to access the table from the stored procedure, but only for the duration of the execution of the stored procedure, and only within the context of the stored procedures execution.

In the example below, run as a database owner or server administrator, a new user is created and added as a member of a new *SalesReader* role, which is then granted permission to select from any object and execute any procedure in the Sales schema. A stored procedure is then created in the Sales schema that accesses a table in the Production schema.

The example then changes content to be the new user and an attempt is made to select directly from the table in the Production schema.

```sql
USE AdventureWorks2016;

GO

CREATE USER [DP300User1] WITH PASSWORD = 'Pa55.w.rd';

GO

CREATE ROLE [SalesReader];

GO

ALTER ROLE [SalesReader] ADD MEMBER [DP300User1];

GO

GRANT SELECT, EXECUTE ON SCHEMA::Sales TO [SalesReader];

GO



CREATE OR ALTER PROCEDURE Sales.DemoProc

as

SELECT P.Name, Sum(SOD.LineTotal) as TotalSales ,SOH.OrderDate 

FROM Production.Product P

INNER JOIN Sales.SalesOrderDetail SOD on SOD.ProductID = P.ProductID

INNER JOIN Sales.SalesOrderHeader SOH on SOH.SalesOrderID = SOD.SalesOrderID

GROUP BY P.Name, SOH.OrderDate

ORDER BY TotalSales DESC;

GO



EXECUTE AS USER = 'DP300User1';



SELECT P.Name, Sum(SOD.LineTotal) as TotalSales ,SOH.OrderDate 

FROM Production.Product P

INNER JOIN Sales.SalesOrderDetail SOD on SOD.ProductID = P.ProductID

INNER JOIN Sales.SalesOrderHeader SOH on SOH.SalesOrderID = SOD.SalesOrderID

GROUP BY P.Name, SOH.OrderDate

ORDER BY TotalSales DESC;
```

The above query results in an error that the user *DP300User1* does not have SELECT permission, because the role that the user belongs to does not have any privileges in the Production schema. Now we can try to execute the stored procedure:

```sql
EXECUTE AS USER = 'DP300User1';

EXECUTE Sales.DemoProc;
```

The *DP300User1* has EXECUTE permission on the stored procedure in the *Sales schema*, because the role the user belongs to has EXECUTE permission on the *Sales schema*. Because the table has the same owner as the procedure, we have an unbroken ownership chain, and the execution will succeed and results will be returned.

Permission changes do not apply when dynamic SQL is being used within stored procedures. The reason that dynamic SQL breaks the permission chain is due to the fact that the dynamic SQL is executed outside of the context of the calling stored procedure. You can see this behavior by changing the above stored procedure to execute using dynamic SQL as shown below.

```sql
CREATE OR ALTER PROCEDURE Sales.DemoProc

AS

DECLARE @sqlstring NVARCHAR(MAX)



SET @sqlstring = 'SELECT P.Name, Sum(SOD.LineTotal) as TotalSales, SOH.OrderDate 

FROM Production.Product P

INNER JOIN Sales.SalesOrderDetail SOD on SOD.ProductID = P.ProductID

INNER JOIN Sales.SalesOrderHeader SOH on SOH.SalesOrderID = SOD.SalesOrderID

GROUP BY P.Name, SOH.OrderDate'

EXECUTE sp_executesql @sqlstring

GO

--

EXECUTE AS USER = 'DP300User1'

EXECUTE Sales.DemoProc
```

The *DP300User1* will receive an error that the user does not have SELECT permission on the *Production.Product* table, just like the user tried to execute the query directly. Permission chains do not apply and the user account that is executing the dynamic SQL must have rights to the tables and views that are being used by the code within the dynamic SQL.
