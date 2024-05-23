All Relational Database Management platforms have four basic permissions, which control data manipulation language (DML) operations. These permissions are `SELECT`, `INSERT`, `UPDATE`, and `DELETE`, and they apply to all SQL Server platforms. All of these permissions can be granted, revoked or denied on tables and views. If a permission is granted using the `GRANT` statement, then the permission is given to the user or role referenced in the `GRANT` statement. Users can also be denied permissions using the `DENY` command. If a user is granted a permission and denied the same permission, the `DENY` will always supersede the grant, and the user will be denied access to the specific object.

In the above example, the user Demo is granted `SELECT` and then denied `SELECT` permissions on the *dbo.Company* table. When the user tries to execute a query that selects from the *dbo.Company* table, the user receives an error that `SELECT` permission was denied.

## Table and view permissions

Tables and views represent the objects on which permissions can be granted within a database. Within those tables and views, you can additionally restrict the columns that are accessible to a given security principal (user or login). SQL Server and Azure SQL Database also include row-level security, which can be used to further restrict access.

| Permission | Definition |
|------------|-------------|
|`SELECT` | Allows the user to view the data within the object (table or view). When denied, the user will be prevented from viewing the data within the object. |
|`INSERT` | Allows the user to insert data into the object. When denied, the user will be prevented from inserting data into the object. |
|`UPDATE` | Allows the user the update data within the object. When denied, the user will be prevented from updating data in the object. |
|`DELETE` | Allows the user to delete data within the object. When denied, the user will be prevented from deleting data from the object. |

## Function and stored procedure permissions

Like tables and views, functions and stored procedures have several permissions, which can be granted or denied.

| Permission | Definition |
|------------|-------------|
|`ALTER` | Grants the user the ability to change the definition of the object. |
|`CONTROL` | Grants the user all rights to the object. |

## Principle of least privilege

The basic idea of the principle of least privilege is that users and applications should only be given the permissions needed in order for them to complete the task. Applications should only have permissions that they need to do in order to complete the task at hand.

As an example, if an application accesses all data through stored procedures, then the application should only have the permission to execute the stored procedures, with no access to the tables.

### Dynamic SQL

Dynamic SQL is a concept where a query is built programmatically. Dynamic SQL allows T-SQL statements to be generated within a stored procedure or a query itself. A simple example is shown below.

```sql
SELECT 'BACKUP DATABASE ' + name + ' TO DISK =''\\backup\sql1\' + name + '.bak'''
FROM sys.databases
```

The above statement will generate a list of T-SQL statements to back up all of the database on the server. Typically, this generated T-SQL will be executed using `sp_executesql` or passed to another program to execute.
