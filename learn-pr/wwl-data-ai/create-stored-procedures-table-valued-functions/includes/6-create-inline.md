User-defined functions (UDF) are similar to stored procedures in that they're stored separately from tables in the database. These functions accept parameters, perform an action, and then return the action result as a single (scalar) value or a result set (table-valued). You can then use the function in place of a table when writing a SELECT statement. User-defined functions are meant to perform calculations and use that result within another statement. Whereas stored procedures can encapsulate the function and statement, and even modify data within the database.

We'll review three types of user-defined functions. For more details of the different functions, review the [T-SQL reference documentation](/sql/relational-databases/user-defined-functions/user-defined-functions).

## Inline table-valued functions

Inline table-valued functions (TVF) are the simplest function created based on a SELECT statement, and they're the preferred choice for performance.

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

When the table-valued function is run with a value for the parameter, then all products with a unit price more than this value will be returned.

The following code uses the table-valued function in place of a table.

```sql
SELECT Name, ListPrice  
FROM SalesLT.ProductsListPrice(500);
```

## Multi-statement table-valued functions

Unlike the inline TVF, a multi-statement table-valued function (MSTVF) can have more than one statement and has different syntax requirements.

Notice how in the following code, we use a BEGIN/END in addition to RETURN:

```sql
CREATE FUNCTION Sales.mstvf_OrderStatus ()
RETURNS
@Results TABLE
     ( CustomerID int, OrderDate datetime )
AS
BEGIN
     INSERT INTO @Results
     SELECT SC.CustomerID, OrderDate
     FROM Sales.Customer AS SC
     INNER JOIN Sales.SalesOrderHeader AS SOH
        ON SC.CustomerID = SOH.CustomerID
     WHERE Status >= 5
 RETURN;
END;
```

Once created, you reference the MSTVF in place of a table just like with the previous inline function above. You can also reference the output in the FROM clause and join it with other tables.

```sql
SELECT *
FROM Sales.mstvf_OrderStatus();
```

### Performance considerations

The Query Optimizer is unable to estimate how many rows will return for a multi-statement table-valued function, but can with the inline table-valued function. Therefore, use the inline TVF when possible for better performance. If you don't need to join the MSTVF with other tables and/or you know the result will only be a few rows, then the performance impact isn't as concerning. If you expect a large result set and need to join with other tables, instead consider using a temp table to store the results and then join to the temp table.

In SQL Server versions 2017 and higher, Microsoft introduced features for intelligent query processing to improve performance for MSTVF. See more details about the Intelligent Query Processing features in the [T-SQL Reference Documentation](/sql/relational-databases/performance/intelligent-query-processing?#interleaved-execution-for-mstvfs).

## Scalar user-defined functions

A scalar user-defined function returns only one value unlike table-valued functions and therefore is often used for simple, frequent statements.

Here's an example to get the product list price for a specific product on a certain day:

```sql
CREATE FUNCTION dbo.ufn_GetProductListPrice
(@ProductID [int], @OrderDate [datetime])
RETURNS [money] 
AS 
BEGIN
    DECLARE @ListPrice money;
        SELECT @ListPrice = plph.[ListPrice]
        FROM [Production].[Product] p 
        INNER JOIN [Production].[ProductListPriceHistory] plph 
        ON p.[ProductID] = plph.[ProductID] 
            AND p.[ProductID] = @ProductID 
            AND StartDate = @OrderDate
    RETURN @ListPrice;
END;
GO
```

For this function, both parameters must be provided to get the value. Depending on the function, you can list the function in the SELECT statement in a more complex query.

```sql
    SELECT dbo.ufn_GetProductListPrice (707, '2011-05-31')
```

### Bind function to referenced objects

SCHEMABINDING is optional when creating the function. When you specify SCHEMABINDING, it binds the function to the referenced objects, and then objects can't be modified without also modifying the function. The function must first be modified or dropped to remove dependencies before modifying the object.

SCHEMABINDING is removed if any of the following occur:
 - The function is dropped
 - The function is modified with ALTER statement without specifying SCHEMABINDING
