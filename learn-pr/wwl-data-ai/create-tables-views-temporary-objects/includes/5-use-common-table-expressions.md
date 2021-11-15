Common Table Expressions (CTEs) provide a mechanism for you to define a subquery that may then be used elsewhere in a query. Unlike a derived table, a CTE is defined at the beginning of a query and may be referenced multiple times in the outer query.

CTEs are named expressions defined in a query. Like subqueries and derived tables, CTEs provide a means to break down query problems into smaller, more modular units. CTEs are limited in scope to the execution of the outer query. When the outer query ends, so does the CTE's lifetime.

## Write queries with CTEs to retrieve results

You can use CTEs to retrieve results. To create a CTE, you define it in a WITH clause, based on the following syntax:

```sql
WITH <CTE_name>
AS (<CTE_definition>)
```

For example, to use a CTE to retrieve information about orders placed per year by distinct customers, you could run the following query:

```sql
WITH CTE_year 
AS
(
    SELECT YEAR(orderdate) AS orderyear, custid
    FROM Sales.Orders
)
SELECT orderyear, COUNT(DISTINCT custid) AS cust_count
FROM CTE_year
GROUP BY orderyear;
```

You name the CTE (named CTE_year) using the WITH clause, then you use AS () to define your subquery. You can then reference your resulting CTE in the outer query, which in this case is done  in the final SELECT statement (FROM CTE_year).
The result would look like this:

|orderyear  |cust_count  |
|---------|---------|
|2019|67|
|2020|86|
|2021|81|

When writing queries with CTEs, consider the following guidelines:

- CTEs require a name for the table expression, in addition to unique names for each of the columns referenced in the CTE's SELECT clause.
- CTEs may use inline or external aliases for columns.
- Unlike a derived table, a CTE may be referenced multiple times in the same query with one definition. Multiple CTEs may also be defined in the same WITH clause.
- CTEs support recursion, in which the expression is defined with a reference to itself. Recursive CTEs are beyond the scope of this module.
