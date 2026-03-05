Correlated queries are subqueries that reference columns from the outer query, creating a dependency that causes the subquery to execute once for each row processed by the outer query. While this might sound inefficient, correlated queries are useful for row-by-row comparisons and calculations that are difficult or impossible to express otherwise.

## Understand correlated subquery execution

A correlated subquery references one or more columns from the outer query, creating a logical dependency between the two. Unlike a regular subquery that executes once and returns a fixed result, a correlated subquery executes repeatedly, once for each row the outer query processes.

Think of it like a nested loop: for each row in the outer query, the database evaluates the subquery using that row's values. This behavior enables powerful row-by-row comparisons, but it also means you need to understand the execution model to write efficient queries.

Consider how these two queries differ:

```sql
-- Non-correlated subquery (executes once)
SELECT ProductID, Name, ListPrice
FROM SalesLT.Product
WHERE ListPrice > (SELECT AVG(ListPrice) FROM SalesLT.Product);

-- Correlated subquery (executes per outer row)
SELECT p1.ProductID, p1.Name, p1.ListPrice
FROM SalesLT.Product AS p1
WHERE p1.ListPrice > (
    SELECT AVG(p2.ListPrice)
    FROM SalesLT.Product AS p2
    WHERE p2.ProductCategoryID = p1.ProductCategoryID  -- References outer query
);
```

In the noncorrelated example, the subquery calculates a single average price across all products. This value is computed once, and then each product's price is compared against that fixed number.

In the correlated example, the subquery references `p1.ProductCategoryID` from the outer query. This creates a dependency: for each product row, the subquery calculates the average price for that specific category. A product in the "Bikes" category is compared against the bikes average, while a product in "Accessories" is compared against the accessories average.

> [!NOTE]
> The query optimizer often transforms correlated subqueries into equivalent joins internally. However, understanding the logical correlated behavior helps you write correct queries, even when the physical execution differs.

## Filter with correlated subqueries

Correlated subqueries in the `WHERE` clause enable row-specific filtering conditions that would be impossible with static comparisons. Instead of comparing against a single fixed value, each row is evaluated against a dynamically calculated value based on that row's attributes.

This pattern is useful when you need to identify outliers within groups, find records that exceed their own category's threshold, or apply business rules that vary by context. The following example finds products priced above their category average, meaning a low-priced accessory might be flagged as expensive while a higher-priced bike might not:

```sql
SELECT 
    p.ProductID,
    p.Name,
    p.ListPrice,
    pc.Name AS Category
FROM SalesLT.Product AS p
INNER JOIN SalesLT.ProductCategory AS pc
    ON p.ProductCategoryID = pc.ProductCategoryID
WHERE p.ListPrice > (
    SELECT AVG(p2.ListPrice)
    FROM SalesLT.Product AS p2
    WHERE p2.ProductCategoryID = p.ProductCategoryID
)
ORDER BY pc.Name, p.ListPrice DESC;
```

You can apply the same pattern to identify customers whose behavior differs from their personal baseline. 

The following query finds customers who have placed at least one order that exceeds their own average order value, which helps identify unusual purchasing patterns or high-value transactions:

```sql
SELECT DISTINCT
    c.CustomerID,
    c.FirstName,
    c.LastName
FROM SalesLT.Customer AS c
INNER JOIN SalesLT.SalesOrderHeader AS soh
    ON c.CustomerID = soh.CustomerID
WHERE soh.TotalDue > (
    SELECT AVG(soh2.TotalDue)
    FROM SalesLT.SalesOrderHeader AS soh2
    WHERE soh2.CustomerID = c.CustomerID
);
```

## Use `EXISTS` with correlated subqueries

The `EXISTS` operator combined with a correlated subquery tests whether any matching rows exist in a related table, returning a simple true or false result. This pattern is highly efficient because the database engine can stop searching as soon as it finds the first matching row. Unlike subqueries that return actual data, `EXISTS` only needs to confirm presence or absence.

Use `EXISTS` when you need to answer questions like "which customers have placed orders?" or "which products have never been sold?" The subquery typically uses `SELECT 1` because the actual values don't matter:

```sql
-- Find customers who have placed at least one order
SELECT CustomerID, FirstName, LastName
FROM SalesLT.Customer AS c
WHERE EXISTS (
    SELECT 1
    FROM SalesLT.SalesOrderHeader AS soh
    WHERE soh.CustomerID = c.CustomerID
);

-- Find customers who have never placed an order
SELECT CustomerID, FirstName, LastName
FROM SalesLT.Customer AS c
WHERE NOT EXISTS (
    SELECT 1
    FROM SalesLT.SalesOrderHeader AS soh
    WHERE soh.CustomerID = c.CustomerID
);
```

`EXISTS` becomes even more valuable when you need to check complex conditions that combine multiple criteria. You can add any filtering logic inside the subquery, and the outer query will include only rows where at least one matching related row exists. 

The following examples demonstrate finding products with high-quantity orders and categories where every product meets a price threshold:

```sql
-- Find products that have been ordered in quantities greater than 10
SELECT p.ProductID, p.Name
FROM SalesLT.Product AS p
WHERE EXISTS (
    SELECT 1
    FROM SalesLT.SalesOrderDetail AS sod
    WHERE sod.ProductID = p.ProductID
      AND sod.OrderQty > 10
);

-- Find categories where all products are priced above $100
SELECT pc.ProductCategoryID, pc.Name
FROM SalesLT.ProductCategory AS pc
WHERE NOT EXISTS (
    SELECT 1
    FROM SalesLT.Product AS p
    WHERE p.ProductCategoryID = pc.ProductCategoryID
      AND p.ListPrice <= 100
);
```

> [!TIP]
> `EXISTS` typically outperforms `IN` with subqueries, especially when checking for existence in large tables. The optimizer can stop after finding the first match with `EXISTS`, while `IN` may need to retrieve all matching values.

## Calculate values with correlated subqueries in `SELECT`

Correlated subqueries in the `SELECT` clause calculate a separate value for each row in your result set. This pattern lets you include aggregated or derived values from related tables alongside the main row's details, without collapsing the result into groups.

This approach is useful when you need to display contextual information, such as showing each product alongside its category's average price, or each employee alongside their department's total headcount. The subquery executes once per row, using that row's values to filter the calculation:

```sql
-- Show each product with its category's average price
SELECT 
    p.ProductID,
    p.Name,
    p.ListPrice,
    (
        SELECT AVG(p2.ListPrice)
        FROM SalesLT.Product AS p2
        WHERE p2.ProductCategoryID = p.ProductCategoryID
    ) AS CategoryAvgPrice,
    p.ListPrice - (
        SELECT AVG(p2.ListPrice)
        FROM SalesLT.Product AS p2
        WHERE p2.ProductCategoryID = p.ProductCategoryID
    ) AS DifferenceFromAvg
FROM SalesLT.Product AS p;
```

You can also use this pattern to count related records or retrieve specific values from related tables. The following query builds a customer summary that includes each customer's order count and most recent order date, calculated individually for each customer row:

```sql
-- Show each customer with their order count
SELECT 
    c.CustomerID,
    c.FirstName,
    c.LastName,
    (
        SELECT COUNT(*)
        FROM SalesLT.SalesOrderHeader AS soh
        WHERE soh.CustomerID = c.CustomerID
    ) AS OrderCount,
    (
        SELECT MAX(soh.OrderDate)
        FROM SalesLT.SalesOrderHeader AS soh
        WHERE soh.CustomerID = c.CustomerID
    ) AS LastOrderDate
FROM SalesLT.Customer AS c;
```

> [!NOTE]
> Correlated subqueries in the `SELECT` clause must return exactly one value. If the subquery could return multiple rows, wrap it in an aggregate function like `MAX()`, `MIN()`, or `SUM()`.

## Find top-N per group with correlated subqueries

One of the most practical applications of correlated subqueries is finding the top N items within each group. This pattern answers questions like "what are the three most expensive products in each category?" or "who are the top five salespeople in each region?"

The correlated subquery examines each row and determines whether it belongs in the top N for its group by checking how many other rows in the same group rank higher. This approach works well when window functions aren't available or when you need complex ranking logic that window functions can't express.

The following query finds the top three most expensive products per category by selecting products whose IDs appear in the top 3 for their category:

```sql
SELECT 
    pc.Name AS Category,
    p.Name AS Product,
    p.ListPrice
FROM SalesLT.Product AS p
INNER JOIN SalesLT.ProductCategory AS pc
    ON p.ProductCategoryID = pc.ProductCategoryID
WHERE p.ProductID IN (
    SELECT TOP 3 p2.ProductID
    FROM SalesLT.Product AS p2
    WHERE p2.ProductCategoryID = p.ProductCategoryID
    ORDER BY p2.ListPrice DESC
)
ORDER BY pc.Name, p.ListPrice DESC;
```

An alternative approach counts how many items rank higher than the current row. If fewer than N items have a higher value, the current row is in the top N. This technique handles ties differently and can be useful when you need all items that tie for the Nth position:

```sql
-- Find products that are in the top 3 by price within their category
SELECT 
    pc.Name AS Category,
    p.Name AS Product,
    p.ListPrice
FROM SalesLT.Product AS p
INNER JOIN SalesLT.ProductCategory AS pc
    ON p.ProductCategoryID = pc.ProductCategoryID
WHERE (
    SELECT COUNT(*)
    FROM SalesLT.Product AS p2
    WHERE p2.ProductCategoryID = p.ProductCategoryID
      AND p2.ListPrice > p.ListPrice
) < 3
ORDER BY pc.Name, p.ListPrice DESC;
```

## Compare consecutive rows

Correlated subqueries can access values from previous or subsequent rows based on ordering criteria, enabling period-over-period comparisons and trend analysis. This pattern is useful for calculating changes between consecutive records, such as comparing each order to the previous order or tracking how values evolve over time.

The subquery finds a related row by filtering for rows that come before (or after) the current row in the logical sequence, then orders the results to get the immediately adjacent row:

```sql
-- Show each order with the previous order's total
SELECT 
    soh.SalesOrderID,
    soh.OrderDate,
    soh.TotalDue,
    (
        SELECT TOP 1 soh2.TotalDue
        FROM SalesLT.SalesOrderHeader AS soh2
        WHERE soh2.CustomerID = soh.CustomerID
          AND soh2.OrderDate < soh.OrderDate
        ORDER BY soh2.OrderDate DESC
    ) AS PreviousOrderTotal
FROM SalesLT.SalesOrderHeader AS soh
ORDER BY soh.CustomerID, soh.OrderDate;
```

> [!TIP]
> For consecutive row comparisons, window functions like `LAG()` and `LEAD()` are typically more efficient and readable than correlated subqueries. Use correlated subqueries when you need more complex conditions than window functions support.

## Choose between correlated subqueries and alternatives

Correlated subqueries aren't always the best approach. The following table helps you choose the right technique:

| Use this approach | When you need to... |
|-------------------|---------------------|
| **Correlated subqueries** | Compare each row against a dynamically calculated value based on that row's attributes, test for existence with `EXISTS`/`NOT EXISTS`, or retrieve exactly one related value per row with complex selection logic. |
| **Joins** | Retrieve columns from multiple tables, or when relationships are straightforward without per-row calculations. |
| **Window functions** | Calculate running totals, rankings, or access previous/next rows with `LAG()`/`LEAD()`. More efficient than correlated subqueries for these patterns. |
| **CTEs** | Reference the same calculated result multiple times, or break complex logic into named, readable steps. |

## Performance considerations

Correlated subqueries can affect performance when not optimized correctly. Because the subquery executes once for each row in the outer query, poorly designed correlated queries can result in thousands or millions of subquery executions on large tables.

Follow these guidelines to optimize correlated subquery performance:

- **Create indexes on correlation columns**: Ensure the columns referenced in the subquery's `WHERE` clause that links back to the outer query are indexed. For example, if your subquery filters on `ProductCategoryID`, an index on that column lets the database quickly find matching rows instead of scanning the entire table for each outer row.

- **Include additional columns in indexes**: If your subquery also filters or aggregates on other columns, consider a composite index. An index on `(ProductCategoryID, ListPrice)` supports both the correlation lookup and price-based filtering or aggregation in a single index seek.

- **Evaluate alternative approaches**: Many correlated subqueries can be rewritten as joins or window functions with better performance. If you're finding the maximum value per group, a window function with `ROW_NUMBER()` often outperforms a correlated subquery that selects `MAX()` for each row.

- **Review execution plans**: Use `SET STATISTICS IO ON` and examine the actual execution plan to understand how the optimizer processes your correlated subquery. The optimizer might transform it into a join internally, or it might execute it row-by-row as written.

- **Test with realistic data volumes**: Correlated subqueries that perform well on small test datasets can become slow with production-sized tables. Always benchmark with representative data before deploying to production.

> [!IMPORTANT]
> Always review execution plans when working with correlated subqueries on large tables. The optimizer may transform them efficiently, but complex correlations might benefit from query rewrites.

For more information about subqueries, see [Subqueries (Transact-SQL)](/sql/relational-databases/performance/subqueries?azure-portal=true) and [EXISTS (Transact-SQL)](/sql/t-sql/language-elements/exists-transact-sql?azure-portal=true).
