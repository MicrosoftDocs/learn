The principle of least privilege is fairly simple. The basic idea behind the concept is that users and applications should only be given the permissions needed in order for them to complete the task. Applications should only have permissions that they need to do in order to complete the task at hand.

As an example, if an application accesses all data through stored procedures, then the application should only have the permission to execute the stored procedures, with no access to the tables.

## Dynamic SQL

Dynamic SQL is a concept where a query is built programmatically. Dynamic SQL allows T-SQL statements to be generated within a stored procedure or a query itself. A simple example is shown below.

```sql
SELECT 'BACKUP DATABASE ' + name + ' TO DISK =''\\backup\sql1\' + name + '.bak'''
FROM sys.databases
```

The above statement will generate a list of T-SQL statements to back up all of the database on the server. Typically, this generated T-SQL will be executed using sp_executesql or passed to another program to execute.
