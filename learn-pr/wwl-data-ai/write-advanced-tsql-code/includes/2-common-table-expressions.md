When working with complex queries, you often need to break down logic into manageable pieces or reference the same subquery multiple times. Common Table Expressions (CTEs) provide a way to define temporary named result sets that exist only during a single query, making your code more readable and maintainable.

## Understand CTE syntax

A Common Table Expression is defined using the `WITH` clause, followed by the CTE name, an optional column list, and a query that defines the result set. The CTE can then be referenced in the subsequent `SELECT`, `INSERT`, `UPDATE`, or `DELETE` statement.

```sql
WITH CTE_Name (Column1, Column2)
AS
(
    -- CTE query definition
    SELECT Column1, Column2
    FROM SomeTable
    WHERE SomeCondition = 'Value'
)
SELECT * FROM CTE_Name;
```

CTEs offer several advantages over derived tables and subqueries:

- **Improved readability**: Complex queries become easier to understand when broken into named logical sections
- **Self-referencing capability**: Recursive CTEs can reference themselves, enabling hierarchical data traversal
- **Multiple references**: Reference the same CTE multiple times in the outer query without redefining it
- **Modular design**: Build complex queries incrementally by defining multiple CTEs

> [!NOTE]
> CTEs are temporary result sets that exist only during query execution. Unlike traditional tables, they don't persist beyond the statement that uses them and don't require explicit cleanup.

## Create nonrecursive CTEs

Nonrecursive CTEs define a result set based on a straightforward query that doesn't reference itself. This pattern is useful for simplifying complex joins, breaking down multi-step calculations, or improving code organization.

The following example uses a CTE to calculate sales metrics before joining with product information:

```sql
WITH SalesSummary AS
(
    SELECT 
        ProductID,
        SUM(OrderQty) AS TotalQuantity,
        SUM(LineTotal) AS TotalRevenue,
        COUNT(DISTINCT SalesOrderID) AS OrderCount
    FROM SalesLT.SalesOrderDetail
    GROUP BY ProductID
)
SELECT 
    p.Name AS ProductName,
    p.ProductNumber,
    p.ListPrice,
    ss.TotalQuantity,
    ss.TotalRevenue,
    ss.OrderCount,
    ss.TotalRevenue / NULLIF(ss.TotalQuantity, 0) AS AverageUnitPrice
FROM SalesLT.Product AS p
INNER JOIN SalesSummary AS ss
    ON p.ProductID = ss.ProductID
ORDER BY ss.TotalRevenue DESC;
```

This query first creates a CTE named `SalesSummary` that aggregates order details by product, calculating total quantity sold, total revenue, and order count. The main query then joins this CTE with the `Product` table to display product names alongside their sales metrics. The `NULLIF` function prevents division by zero when calculating the average unit price.

You can define multiple CTEs in a single `WITH` clause by separating them with commas. Later CTEs can reference earlier ones, enabling progressive data transformation:

```sql
WITH CategorySales AS
(
    SELECT 
        p.ProductCategoryID,
        SUM(sod.LineTotal) AS CategoryRevenue
    FROM SalesLT.Product AS p
    INNER JOIN SalesLT.SalesOrderDetail AS sod
        ON p.ProductID = sod.ProductID
    GROUP BY p.ProductCategoryID
),
RankedCategories AS
(
    SELECT 
        ProductCategoryID,
        CategoryRevenue,
        RANK() OVER (ORDER BY CategoryRevenue DESC) AS RevenueRank
    FROM CategorySales
)
SELECT 
    pc.Name AS CategoryName,
    rc.CategoryRevenue,
    rc.RevenueRank
FROM RankedCategories AS rc
INNER JOIN SalesLT.ProductCategory AS pc
    ON rc.ProductCategoryID = pc.ProductCategoryID
WHERE rc.RevenueRank <= 5;
```

> [!TIP]
> When building queries with multiple CTEs, start with the most granular data transformations and progressively aggregate or filter in subsequent CTEs. This approach makes debugging easier since you can test each CTE independently.

## Create recursive CTEs

Recursive CTEs reference themselves to process hierarchical or graph-like data structures. A recursive CTE consists of two parts: an anchor member that provides the initial result set, and a recursive member that references the CTE to build upon previous results.

The general syntax for a recursive CTE is:

```sql
WITH RecursiveCTE AS
(
    -- Anchor member: starting point
    SELECT columns
    FROM table
    WHERE starting_condition
    
    UNION ALL
    
    -- Recursive member: references the CTE
    SELECT columns
    FROM table
    INNER JOIN RecursiveCTE
        ON join_condition
)
SELECT * FROM RecursiveCTE;
```

A common use case is traversing an organizational hierarchy. Consider an employee table where each employee has a manager:

```sql
WITH EmployeeHierarchy AS
(
    -- Anchor: Start with top-level managers (no manager)
    SELECT 
        EmployeeID,
        FirstName,
        LastName,
        ManagerID,
        0 AS Level,
        CAST(FirstName + ' ' + LastName AS NVARCHAR(500)) AS HierarchyPath
    FROM HumanResources.Employee
    WHERE ManagerID IS NULL
    
    UNION ALL
    
    -- Recursive: Find employees who report to previously found employees
    SELECT 
        e.EmployeeID,
        e.FirstName,
        e.LastName,
        e.ManagerID,
        eh.Level + 1,
        CAST(eh.HierarchyPath + ' > ' + e.FirstName + ' ' + e.LastName AS NVARCHAR(500))
    FROM HumanResources.Employee AS e
    INNER JOIN EmployeeHierarchy AS eh
        ON e.ManagerID = eh.EmployeeID
)
SELECT 
    EmployeeID,
    FirstName,
    LastName,
    Level,
    HierarchyPath
FROM EmployeeHierarchy
ORDER BY HierarchyPath;
```

> [!IMPORTANT]
> Recursive CTEs can cause infinite loops if the termination condition is never met. SQL Server limits recursion to 100 levels by default. Use `OPTION (MAXRECURSION n)` to change this limit, where `n` is the maximum recursion depth (0 for unlimited).

## Generate sequences with recursive CTEs

Recursive CTEs excel at generating sequences of numbers or dates without requiring a physical numbers table. This technique is useful for creating date ranges, filling gaps in data, or generating test data:

```sql
-- Generate a sequence of dates for the current month
WITH DateSequence AS
(
    -- Anchor: Get the first day of the current month
    SELECT CAST(DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()), 0) AS DATE) AS DateValue
    
    UNION ALL
    
    -- Recursive: Add one day until we reach the end of the month
    SELECT DATEADD(DAY, 1, DateValue)
    FROM DateSequence
    WHERE DateValue < EOMONTH(GETDATE())
)
-- Output each date with its day name
SELECT DateValue, DATENAME(WEEKDAY, DateValue) AS DayName
FROM DateSequence
OPTION (MAXRECURSION 31);  -- Allow up to 31 iterations (max days in a month)
```

You can combine generated sequences with actual data to identify gaps or create summary reports:

```sql
-- Generate a numbers table from 1 to 1000
WITH Numbers AS
(
    -- Anchor: Start with 1
    SELECT 1 AS n
    UNION ALL
    -- Recursive: Increment until we reach 1000
    SELECT n + 1 FROM Numbers WHERE n < 1000
),
-- Convert numbers to dates for the entire year
DateRange AS
(
    SELECT DATEADD(DAY, n - 1, '2024-01-01') AS OrderDate
    FROM Numbers
    WHERE DATEADD(DAY, n - 1, '2024-01-01') <= '2024-12-31'
)
-- Count orders for each date, showing 0 for dates with no orders
SELECT 
    dr.OrderDate,
    COALESCE(COUNT(soh.SalesOrderID), 0) AS OrderCount
FROM DateRange AS dr
LEFT JOIN SalesLT.SalesOrderHeader AS soh
    ON CAST(soh.OrderDate AS DATE) = dr.OrderDate
GROUP BY dr.OrderDate
ORDER BY dr.OrderDate
OPTION (MAXRECURSION 366);  -- Allow up to 366 iterations (leap year)
```

## Use CTEs with data modification statements

CTEs can be used with `INSERT`, `UPDATE`, and `DELETE` statements, not just `SELECT`. This capability is useful when the modification logic requires complex filtering or calculations:

```sql
-- Update using a CTE to identify target rows
WITH DiscontinuedProducts AS
(
    SELECT ProductID
    FROM SalesLT.Product
    WHERE SellEndDate < DATEADD(YEAR, -2, GETDATE())
        AND ProductID NOT IN (
            SELECT DISTINCT ProductID 
            FROM SalesLT.SalesOrderDetail
            WHERE ModifiedDate > DATEADD(YEAR, -1, GETDATE())
        )
)
UPDATE SalesLT.Product
SET DiscontinuedDate = GETDATE()
WHERE ProductID IN (SELECT ProductID FROM DiscontinuedProducts);
```

This query uses a CTE to identify products that should be marked as discontinued. The CTE finds products where the sold end date is more than two years ago and that haven't appeared in any order details modified within the last year. The `UPDATE` statement then sets the `DiscontinuedDate` for those products. By separating the selection logic into a CTE, the query becomes easier to read and test independently.

For more information about Common Table Expressions, see [WITH common_table_expression (Transact-SQL)](/sql/t-sql/queries/with-common-table-expression-transact-sql?azure-portal=true) and [Recursive Queries Using Common Table Expressions](/sql/t-sql/queries/with-common-table-expression-transact-sql?azure-portal=true#guidelines-for-defining-and-using-recursive-common-table-expressions).
