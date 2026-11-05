::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=69740b58-dbc6-4c40-bf0f-d0e93bfe79ff]

> [!TIP]
> See the **Text and images** tab for more details!

::: zone-end

::: zone pivot="text"

[Table-valued functions](/sql/relational-databases/user-defined-functions/user-defined-functions?azure-portal=true#table-valued-functions) let you encapsulate complex query logic into reusable components that return result sets. You can call these functions directly in queries, just like tables or views, making your code more modular and maintainable.

When you build database applications, you often need to retrieve filtered or calculated data sets based on input parameters. Table-valued functions solve this problem by packaging query logic into functions that accept parameters and return tables. Unlike stored procedures, you can use table-valued functions in `JOIN` clauses and `SELECT` statements, giving you the flexibility to treat function results as data sources.

## Understand table-valued function types

SQL Server provides two types of table-valued functions, each suited for different scenarios.

### Inline table-valued function

Contains a single `SELECT` statement and returns results directly. With inline functions, you don't define the table structure—SQL Server infers it from your `SELECT` statement. The query optimizer treats inline table-valued functions like views with parameters, often producing better execution plans.

### Multi-statement table-valued function

Uses a `BEGIN...END` block and explicitly declares the structure of the returned table. This type gives you more control when you need to execute multiple statements, perform complex calculations, or build the result set iteratively. However, this flexibility comes with a performance trade-off, as the optimizer treats these functions differently.

The choice between these functions depends on your specific requirements. For simple queries with parameters, inline functions provide better performance. When you need procedural logic or multiple steps to build your result set, multi-statement functions become necessary.

## Create inline table-valued functions

Inline table-valued functions offer a concise way to parameterize queries. You define them with a single RETURN statement followed by a SELECT query.

The following example shows an inline function that retrieves orders for a specific customer:

```sql
CREATE FUNCTION dbo.GetCustomerOrders
(
    @CustomerID INT
)
RETURNS TABLE
AS
RETURN
(
    SELECT
        CustomerID,
        OrderID,
        OrderDate,
        TotalAmount,
        Status
    FROM Sales.Orders
    WHERE CustomerID = @CustomerID
);
```

You can now use this function in queries just like a table:

```sql
SELECT OrderID, OrderDate, TotalAmount
FROM dbo.GetCustomerOrders(1001)
WHERE OrderDate >= '2024-01-01';
```

The function accepts the customer ID parameter and returns only that customer's orders. You can further filter, `JOIN`, or aggregate the results as needed. This approach keeps your main query clean while encapsulating the customer filtering logic.

## Create multi-statement table-valued functions

Multi-statement table-valued functions provide more flexibility when you need to perform multiple operations to build your result set.

Consider a function that calculates product sales summaries with multiple aggregations:

```sql
CREATE FUNCTION dbo.GetProductSalesSummary
(
    @StartDate DATE,
    @EndDate DATE
)
RETURNS @SalesSummary TABLE
(
    ProductID INT,
    ProductName NVARCHAR(100),
    TotalQuantity INT,
    TotalRevenue DECIMAL(18,2),
    AveragePrice DECIMAL(18,2)
)
AS
BEGIN
    INSERT INTO @SalesSummary
    SELECT 
        p.ProductID,
        p.ProductName,
        SUM(od.Quantity) AS TotalQuantity,
        SUM(od.Quantity * od.UnitPrice) AS TotalRevenue,
        AVG(od.UnitPrice) AS AveragePrice
    FROM Production.Products p
    INNER JOIN Sales.OrderDetails od ON p.ProductID = od.ProductID
    INNER JOIN Sales.Orders o ON od.OrderID = o.OrderID
    WHERE o.OrderDate BETWEEN @StartDate AND @EndDate
    GROUP BY p.ProductID, p.ProductName;
    
    RETURN;
END;
```

Notice how you explicitly declare the table variable `@SalesSummary` with specific columns and data types. The function body inserts data into this table variable, then returns it. This structure allows you to add additional processing logic, error handling, or conditional statements as needed.

## Use table-valued functions in queries

Table-valued functions integrate seamlessly into your queries, enabling powerful data retrieval patterns.

You can join function results with other tables:

```sql
SELECT 
    c.CustomerName,
    s.ProductName,
    s.TotalRevenue
FROM Customers c
CROSS APPLY dbo.GetProductSalesSummary('2024-01-01', '2024-12-31') s
WHERE s.TotalRevenue > 10000
ORDER BY s.TotalRevenue DESC;
```

The [`CROSS APPLY`](/sql/t-sql/queries/from-transact-sql?azure-portal=true#using-apply) operator calls the function for each row from the Customers table, though in this example, the function parameters are constants. When you pass column values as parameters, `CROSS APPLY` becomes particularly useful:

```sql
SELECT 
    c.CustomerName,
    o.OrderID,
    o.TotalAmount
FROM Customers c
CROSS APPLY dbo.GetCustomerOrders(c.CustomerID) o
WHERE o.Status = 'Completed';
```

This query retrieves all completed orders for each customer, demonstrating how table-valued functions can reference values from the preceding table source. The function acts as a correlated table expression, while the query optimizer can optimize the combined query.

When a table-valued function does not depend on column values from the preceding table source, you can use `INNER JOIN` to combine its results with other tables. Unlike `CROSS APPLY`, `INNER JOIN` does not support passing columns from the left table as arguments to the function.

For example, the following query retrieves orders for a specific customer and joins the function results with the Customers table:
```sql
SELECT
    c.CustomerName,
    o.OrderDate,
    o.TotalAmount
FROM Customers AS c
INNER JOIN dbo.GetCustomerOrders(1001) AS o
    ON c.CustomerID = o.CustomerID
WHERE o.OrderDate >= '20240101'
  AND o.OrderDate < '20250101'
```

In this example, the function receives a constant parameter and returns a result set that can be joined with the Customers table using the CustomerID column.

When a function requires values from the preceding table source, use `CROSS APPLY` or `OUTER APPLY` instead. Note that `CROSS APPLY` does not necessarily imply row-by-row physical execution, as the query optimizer can inline the function definition and optimize the resulting query.

With these techniques, you can build complex queries from simpler, tested function components, improving both code maintainability and development efficiency.

::: zone-end
