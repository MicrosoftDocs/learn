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

In the non-correlated example, the subquery calculates a single average price across all products. This value is computed once, and then each product's price is compared against that fixed number.

In the correlated example, the subquery references `p1.ProductCategoryID` from the outer query. This creates a dependency: for each product row, the subquery calculates the average price for that specific category. A product in the "Bikes" category is compared against the bikes average, while a product in "Accessories" is compared against the accessories average.

```
Execution flow for correlated subquery:
┌──────────────────────────────────────────────────────────────┐
│ Outer query processes Row 1 (Mountain Bike, Category: Bikes) │
│   → Subquery calculates AVG for Bikes category = $1,500      │
│   → Compare: $2,000 > $1,500? Yes → Include in results       │
├──────────────────────────────────────────────────────────────┤
│ Outer query processes Row 2 (Water Bottle, Category: Access) │
│   → Subquery calculates AVG for Accessories category = $15   │
│   → Compare: $10 > $15? No → Exclude from results            │
├──────────────────────────────────────────────────────────────┤
│ Outer query processes Row 3 (Road Bike, Category: Bikes)     │
│   → Subquery calculates AVG for Bikes category = $1,500      │
│   → Compare: $1,200 > $1,500? No → Exclude from results      │
└──────────────────────────────────────────────────────────────┘
```

> [!NOTE]
> The query optimizer often transforms correlated subqueries into equivalent joins internally. However, understanding the logical correlated behavior helps you write correct queries, even when the physical execution differs.

## Filter with correlated subqueries

Correlated subqueries in the `WHERE` clause enable row-specific filtering conditions that would be impossible with static comparisons. Instead of comparing against a single fixed value, each row is evaluated against a dynamically calculated value based on that row's attributes.

This pattern is particularly useful when you need to identify outliers within groups, find records that exceed their own category's threshold, or apply business rules that vary by context. The following example finds products priced above their category average, meaning a $50 accessory might be flagged as expensive while a $500 bike might not:

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

You can apply the same pattern to identify customers whose behavior differs from their personal baseline. The following query finds customers who have placed at least one order that exceeds their own average order value, which helps identify unusual purchasing patterns or high-value transactions:

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

`EXISTS` becomes even more valuable when you need to check complex conditions that combine multiple criteria. You can add any filtering logic inside the subquery, and the outer query will include only rows where at least one matching related row exists. The following examples demonstrate finding products with high-quantity orders and categories where every product meets a price threshold:

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

## Calculate values with correlated subqueries in SELECT

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

The following query finds the top 3 most expensive products per category by selecting products whose IDs appear in the top 3 for their category:

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

Correlated subqueries aren't always the best approach. Understanding when to use them versus joins, window functions, or CTEs helps you write more efficient and maintainable queries.

### Use correlated subqueries when

The following table summarizes scenarios where correlated subqueries are the preferred approach:

| Scenario | Why correlated subqueries work best | Example use case |
|----------|-------------------------------------|------------------|
| **Compare against row-specific calculated values** | Each row needs its own dynamically calculated comparison value based on that row's attributes. Joins would require pre-aggregating all possible groups. | Find products priced above their own category's average. A $50 accessory might be expensive for its category while a $500 bike might be cheap for its category. |
| **Test for related records with EXISTS/NOT EXISTS** | `EXISTS` is optimized for correlated subqueries and stops searching after finding the first match. More efficient than `IN` for large datasets. | Find customers who have never placed an order, or products that have never been sold. |
| **Apply dynamic filtering based on current row values** | The filter criteria change based on each row's values, requiring conditions that can't be expressed with static joins. | Find each customer's most recent order that exceeds $500. The "most recent" and "$500 threshold" criteria apply per-customer. |
| **Retrieve a single related value per row** | You need exactly one value from a related table for each row, with complex selection logic (TOP 1, specific ordering). | Show each employee alongside their most recent performance review score. |
| **Check universal conditions (all/none)** | `NOT EXISTS` elegantly expresses "there are no exceptions" logic that would require awkward outer joins otherwise. | Find categories where ALL products are priced above $100 (no product exists with price ≤ $100). |

### Use joins instead when

Joins are typically a better choice when you need data from multiple tables in your result set. If you're retrieving columns from both a parent and child table, a `JOIN` is cleaner and usually more efficient than embedding a correlated subquery in the `SELECT` clause to fetch each related value separately.

Joins also outperform correlated subqueries when the relationship is straightforward and doesn't require per-row calculations. For simple one-to-many relationships like customers to orders or products to categories, a standard `INNER JOIN` or `LEFT JOIN` lets the optimizer choose the most efficient execution plan without the overhead of repeated subquery evaluation.

### Use window functions instead when

Window functions are the better choice when you need running totals, rankings, or comparisons across rows within a partition. Functions like `ROW_NUMBER()`, `RANK()`, and `DENSE_RANK()` express ranking logic more clearly and efficiently than correlated subqueries that count how many rows have higher values. The query optimizer can process window functions in a single pass over the data, whereas correlated subqueries may require repeated scans.

Window functions also excel at accessing values from previous or next rows. The `LAG()` and `LEAD()` functions retrieve values from adjacent rows with simple, readable syntax, while the equivalent correlated subquery requires `TOP 1` with complex ordering logic. Unless you need filtering conditions that window functions can't express, prefer the window function approach for consecutive row comparisons.

### Use CTEs instead when

Common Table Expressions (CTEs) are preferable when you need to reference the same calculated result multiple times in your query. If you're using identical correlated subqueries in multiple places, such as calculating a category average for both display and comparison, the database may execute that subquery repeatedly. A CTE calculates the result once and lets you join to it multiple times.

CTEs also improve readability for complex queries by breaking the logic into named, logical steps. Instead of nesting correlated subqueries that are hard to follow, you can define intermediate results with meaningful names and then combine them in the final `SELECT`. This approach makes queries easier to understand, debug, and maintain.

## Performance considerations

Correlated subqueries can impact performance when not optimized correctly. Because the subquery executes once for each row in the outer query, poorly designed correlated queries can result in thousands or millions of subquery executions on large tables.

Follow these guidelines to optimize correlated subquery performance:

- **Create indexes on correlation columns**: Ensure the columns referenced in the subquery's `WHERE` clause that link back to the outer query are indexed. For example, if your subquery filters on `ProductCategoryID`, an index on that column lets the database quickly find matching rows instead of scanning the entire table for each outer row.

- **Include additional columns in indexes**: If your subquery also filters or aggregates on other columns, consider a composite index. An index on `(ProductCategoryID, ListPrice)` supports both the correlation lookup and price-based filtering or aggregation in a single index seek.

- **Evaluate alternative approaches**: Many correlated subqueries can be rewritten as joins or window functions with better performance. If you're finding the maximum value per group, a window function with `ROW_NUMBER()` often outperforms a correlated subquery that selects `MAX()` for each row.

- **Review execution plans**: Use `SET STATISTICS IO ON` and examine the actual execution plan to understand how the optimizer processes your correlated subquery. The optimizer may transform it into a join internally, or it may execute it row-by-row as written.

- **Test with realistic data volumes**: Correlated subqueries that perform well on small test datasets may become slow with production-sized tables. Always benchmark with representative data before deploying to production.

> [!IMPORTANT]
> Always review execution plans when working with correlated subqueries on large tables. The optimizer may transform them efficiently, but complex correlations might benefit from query rewrites.

For more information about subqueries, see [Subqueries (Transact-SQL)](/sql/relational-databases/performance/subqueries?azure-portal=true) and [EXISTS (Transact-SQL)](/sql/t-sql/language-elements/exists-transact-sql?azure-portal=true).
