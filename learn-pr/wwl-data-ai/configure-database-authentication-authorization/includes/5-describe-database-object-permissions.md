All Relational Database Management platforms have four basic permissions, which control data manipulation language (DML) operations. These permissions are `SELECT`, `INSERT`, `UPDATE`, and `DELETE`, and they apply to all SQL Server platforms. All of these permissions can be granted, revoked or denied on tables and views. If a permission is granted using the `GRANT` statement, then the permission is given to the user or role referenced in the `GRANT` statement. Users can also be denied permissions using the `DENY` command. If a user is granted a permission and denied the same permission, the `DENY` will always supersede the grant, and the user will be denied access to the specific object.

:::image type="content" source="../media/module-33-security-final-03.png" alt-text="A T-SQL Example of a DENY overriding a GRANT":::

In the above example, the user Demo is granted `SELECT` and then denied `SELECT` permissions on the *dbo.Company* table. When the user tries to execute a query that selects from the *dbo.Company* table, the user receives an error that `SELECT` permission was denied.

## Table and view permissions

Tables and views represent the objects on which permissions can be granted within a database. Within those tables and views, you can additionally restrict the columns that are accessible to a given security principal (user or login). SQL Server and Azure SQL Database also include row-level security, which can be used to further restrict access.

| Permission | Definition |
|------------|-------------|
|`SELECT` | Allows the user to view the data within the object (table or view). When denied, the user will be prevented from viewing the data within the object. |
|`INSERT` | Allows the user to insert data into the object. When denied, the user will be prevented from inserting data into the object. |
|`UPDATE` | Allows the user the update data within the object. When denied, the user will be prevented from updating data in the object. |
|`DELETE` | Allows the user to delete data within the object. When denied, the user will be prevented from deleting data from the object. |

Azure SQL Database and Microsoft SQL Server have other permissions, which can be granted, revoked or denied as needed.

| Permission | Definition |
|------------|-------------|
|`CONTROL` | Grants all rights to the objects. It allows the user who has this permission to perform any action they wish against the object, including deleting the object. |
|`REFERENCES` | Grants the user the ability to view the foreign keys on the object. |
|`TAKE OWNERSHIP` | Allows the user the ability to take ownership of the object. |
|`VIEW CHANGE TRACKING` | Allows the user to view the change tracking setting for the object. |
|`VIEW DEFINITION` | Allows the user to view the definition of the object. |

## Function and stored procedure permissions

Like tables and views, functions and stored procedures have several permissions, which can be granted or denied.

| Permission | Definition |
|------------|-------------|
|`ALTER` | Grants the user the ability to change the definition of the object. |
|`CONTROL` | Grants the user all rights to the object. |
|`EXECUTE` | Grants the user the ability to execute the object. |
|`VIEW CHANGE TRACKING` | Allows the user to view the change tracking setting for the object. |
|`VIEW DEFINITION` | Allows the user to view the definition of the object. |

## EXECUTE AS

The `EXECUTE AS [user name]`, or `EXECUTE AS [login name]` (only available in SQL Server and Azure SQL Managed Instance) commands allow for the user context to be changed. As subsequent commands and statements will be executed using the new context with the permissions granted to that context.

If a user has a permission and the user no longer needs to have that permission, permissions can be removed (either grants or denies) using the REVOKE command. The revoke command will remove any `GRANT` or `DENY` permissions for the right specified to the user specified.

### Ownership Chains

A concept called chaining applies to permissions, which allows users to inherit permissions from other objects. The most common example of chaining is a function or stored procedure that accesses a table during its execution. If the procedure has the same owner as the table, the stored procedure is able to be executed and access the table, even though the user doesn't have rights to access the table directly. This access is available because the user inherits the rights to access the table from the stored procedure, but only during the execution of the stored procedure, and only within the context of the stored procedures execution.

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
AS
SELECT P.Name, 
    SUM(SOD.LineTotal) AS TotalSales,
    SOH.OrderDate 
FROM Production.Product P
    INNER JOIN Sales.SalesOrderDetail SOD ON (SOD.ProductID = P.ProductID)
    INNER JOIN Sales.SalesOrderHeader SOH ON (SOH.SalesOrderID = SOD.SalesOrderID)
GROUP BY P.Name, 
    SOH.OrderDate
ORDER BY TotalSales DESC;

GO

EXECUTE AS USER = 'DP300User1';

SELECT P.Name, 
    SUM(SOD.LineTotal) AS TotalSales,
    SOH.OrderDate 
FROM Production.Product P
    INNER JOIN Sales.SalesOrderDetail SOD ON (SOD.ProductID = P.ProductID)
    INNER JOIN Sales.SalesOrderHeader SOH ON (SOH.SalesOrderID = SOD.SalesOrderID)
GROUP BY P.Name, 
    SOH.OrderDate
ORDER BY TotalSales DESC;
```

The above query results in an error that the user *DP300User1* doesn't have `SELECT` permission, because the role that the user belongs to doesn't have any privileges in the Production schema. Now we can try to execute the stored procedure:

```sql
EXECUTE AS USER = 'DP300User1';

EXECUTE Sales.DemoProc;
```

The *DP300User1* user has `EXECUTE` permission on the stored procedure in the *Sales* schema, because the user's role has `EXECUTE` permission on the *Sales* schema. Because the table has the same owner as the procedure, we have an unbroken ownership chain, and the execution will succeed and results will be returned.

Permission changes don't apply when dynamic SQL is being used within stored procedures. The reason that dynamic SQL breaks the permission chain is because the dynamic SQL is executed outside of the context of the calling stored procedure. You can see this behavior by changing the above stored procedure to execute using dynamic SQL as shown below.

```sql
CREATE OR ALTER PROCEDURE Sales.DemoProc
AS
DECLARE @sqlstring NVARCHAR(MAX)

SET @sqlstring = '
SELECT P.Name, 
    SUM(SOD.LineTotal) AS TotalSales, 
    SOH.OrderDate 
FROM Production.Product P
    INNER JOIN Sales.SalesOrderDetail SOD ON (SOD.ProductID = P.ProductID)
    INNER JOIN Sales.SalesOrderHeader SOH ON (SOH.SalesOrderID = SOD.SalesOrderID)
GROUP BY P.Name, SOH.OrderDate'

EXECUTE sp_executesql @sqlstring
GO

--

EXECUTE AS USER = 'DP300User1'

EXECUTE Sales.DemoProc
```

The *DP300User1* user will receive an error that the user doesn't have `SELECT` permission on the *Production.Product* table, just like the user tried to execute the query directly. Permission chains don't apply and the user account that is executing the dynamic SQL must have rights to the tables and views that are being used by the code within the dynamic SQL.

## Principle of least privilege

The principle of least privilege is fairly simple. The basic idea behind the concept is that users and applications should only be given the permissions needed in order for them to complete the task. Applications should only have permissions that they need to do in order to complete the task at hand.

As an example, if an application accesses all data through stored procedures, then the application should only have the permission to execute the stored procedures, with no access to the tables.

### Dynamic SQL

Dynamic SQL is a concept where a query is built programmatically. Dynamic SQL allows T-SQL statements to be generated within a stored procedure or a query itself. A simple example is shown below.

```sql
SELECT 'BACKUP DATABASE ' + name + ' TO DISK =''\\backup\sql1\' + name + '.bak'''
FROM sys.databases
```

The above statement will generate a list of T-SQL statements to back up all of the database on the server. Typically, this generated T-SQL will be executed using `sp_executesql` or passed to another program to execute.
