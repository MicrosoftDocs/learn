You can use a table-valued function anywhere in SQL that you can use a table. You can also treat the table-valued function just as you would a table. Table-valued functions are useful because they can be written to accept input parameters.

The table-valued function definition is stored in the database. You can then use the function in place of a database table when you write SELECT statements.

In the following example, a table-valued function is created with an input parameter for **unitprice**.

```sql
CREATE FUNCTION SalesLT.ProductsListPrice(@cost money)  
RETURNS TABLE  
AS  
RETURN  
    SELECT ProductID, Name, ListPrice  
    FROM SalesLT.Product  
    WHERE ListPrice > @cost; 
```

When the table-valued function is run with a value for the parameter, and all products with a unit price more than this value will be returned.

The following code uses the table-valued function in place of a table.

```sql
SELECT Name, ListPrice  
FROM SalesLT.ProductsListPrice(500);
```
