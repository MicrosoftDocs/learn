Dynamic SQL allows you to build a character string that can be executed as T-SQL as an alternative to stored procedures. Dynamic SQL is useful when you don't know certain values until execution time. 

There are two ways of creating dynamic SQL, either using:

1. **EXECUTE** or **EXEC** keywords.
2. The system stored procedure **sp_executesql**.

## Dynamic SQL using EXECUTE or EXEC

To write a dynamic SQL statement with EXECUTE or EXEC, the syntax is:

`EXEC (@string_variable);`

In the following example, we declare a variable called @sqlstring of type VARCHAR, and then assign a string to it.

```sql
DECLARE @sqlstring AS VARCHAR(1000);
    SET @sqlstring='SELECT customerid, companyname, firstname, lastname 
    FROM SalesLT.Customer;'
EXEC(@sqlstring);
GO
```

## Dynamic SQL using Sp_executesql

Sp_executesql allows you to execute a T-SQL statement with parameters. Sp_executesql can be used instead of stored procedures when you want to pass a different value to the statement. The T-SQL statement stays the same, and only the parameter values change. Like stored procedures, it's likely that the SQL Server query optimizer will reuse the execution plan.

Sp_executesql takes a T-SQL statement as an argument, which can be either a Unicode constant or a Unicode variable. For example, both these code examples are valid:

```sql
DECLARE @sqlstring1 NVARCHAR(1000);
SET @SqlString1 =
    N'SELECT TOP(10) name, listprice
    FROM SalesLT.Product
    GROUP BY name, listprice
    ORDER BY listprice DESC;'
EXECUTE sp_executesql @SqlString1;

OR

EXECUTE sp_executesql N'SELECT TOP(10) name, listprice
    FROM SalesLT.Product
    GROUP BY name, listprice
    ORDER BY listprice DESC;'
```

In this example, a parameter is being passed to the T-SQL statement:

```sql
EXECUTE sp_executesql   
          N'SELECT * FROM SalesLT.Customer   
          WHERE CompanyName = @company',  
          N'@company nvarchar(128)',  
          @company = "Sharp Bikes";
```
