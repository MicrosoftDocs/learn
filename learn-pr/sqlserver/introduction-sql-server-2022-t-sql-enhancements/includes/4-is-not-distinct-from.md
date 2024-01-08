---
ms.custom:
  - build-2023
---
SQL Server 2022 enhances the query language with a new predicate, `IS [NOT] DISTINCT FROM`, designed to simplify comparison operations involving `NULL` values.

## IS [NOT] DISTINCT FROM Predicate

The `IS [NOT] DISTINCT FROM` predicate is a convenient way to compare two expressions, ensuring a true or false result even when `NULL` values are involved. It's used in the search condition of `WHERE` and `HAVING` clauses, the join conditions of `FROM` clauses, and other constructs where a Boolean value is required.

Working with `NULL` values in SQL Server can be challenging because comparing them results in an unknown outcome. The `IS DISTINCT FROM / IS NOT DISTINCT FROM` predicate makes this comparison easier by treating `NULLs` as known values in comparisons. Check out the following table with values *A* and *B* to demonstrate the difference between `IS NOT DISTINCT FROM` and equality comparisons:

**A** | **B** | **A = B** | **A** `IS NOT DISTINCT FROM` **B**
---|---|---|---
0 | 0 | True | True
0 | 1 | False | False
0 | NULL | Unknown | False
NULL | NULL | Unknown | True

## Performing searches with the predicate IS DISTINCT FROM even when a value could be NULL

Imagine you're a database developer working on a new e-commerce application. You have a table called *Sales.SalesOrderDetail* that contains columns for *SalesOrderID*, *ProductID*, *ProductSubcategoryID*, *OrderQty*, *UnitPrice*, *UnitPriceDiscount* and *LineTotal*. You want to find all the rows in the *Sales.SalesOrderDetail* table were:

- The *UnitPriceDiscount* is distinct from *zero*, or in other words that it has a discount.
- The subcategory is *Road Bikes*.
- The Order date was on *July 31, 2013*.
- The bike was color *Yellow*.
- The line total is greater than *15,000*.

Additionally, using the previous definition, you also want to find all the rows where the Discount is 10 percent. Not all orders have a discount, so the discount field could be *NULL*.

Using the `IS [NOT] DISTINCT FROM` predicate, you can quickly and easily write queries to achieve these goals. Run the following queries in SQL Server Management Studio (SSMS) to find the desired data:

```sql
-- Query to return rows where the Discount is DISTINCT FROM 0.00
SELECT SOD.SalesOrderID
	, P.Name
      ,SOD.OrderQty
      ,SOD.UnitPrice
      ,SOD.UnitPriceDiscount
      ,SOD.LineTotal
FROM AdventureWorks2012.Sales.SalesOrderDetail SOD
	JOIN AdventureWorks2012.Sales.SalesOrderHeader SOH ON SOD.SalesOrderID = SOH.SalesOrderID
	JOIN  AdventureWorks2012.Production.Product P ON P.ProductID = SOD.ProductID
	JOIN  AdventureWorks2012.Production.ProductSubcategory PSC ON P.ProductSubcategoryID = PSC.ProductSubcategoryID
WHERE Color = 'Yellow'
	AND UnitPriceDiscount IS DISTINCT FROM 0.00
	AND PSC.Name = 'Road Bikes'
	AND SOH.OrderDate = '2013-07-31 00:00:00.000'
	AND LineTotal > 15000
ORDER BY SalesOrderID
```

Results:

SalesOrderID | Name | OrderQty | UnitPrice | UnitPriceDiscount | LineTotal
---|---|---|---|---|---
53460 | Road-350-W Yellow, 48 | 30 | 850.495 | 0.10 | 22963.365000
53530 | Road-350-W Yellow, 48 | 17 | 935.5445 | 0.05 | 15109.043675


```sql
-- Query to return rows where the Discount is NOT DISTINCT FROM 0.10
SELECT SOD.SalesOrderID
	, P.Name
      ,SOD.OrderQty
      ,SOD.UnitPrice
      ,SOD.UnitPriceDiscount
      ,SOD.LineTotal
FROM AdventureWorks2012.Sales.SalesOrderDetail SOD
	JOIN AdventureWorks2012.Sales.SalesOrderHeader SOH ON SOD.SalesOrderID = SOH.SalesOrderID
	JOIN  AdventureWorks2022.Production.Product P ON P.ProductID = SOD.ProductID
	JOIN  AdventureWorks2012.Production.ProductSubcategory PSC ON P.ProductSubcategoryID = PSC.ProductSubcategoryID
WHERE Color = 'Yellow'
	AND UnitPriceDiscount IS NOT DISTINCT FROM 0.10
	AND PSC.Name = 'Road Bikes'
	AND SOH.OrderDate = '2013-07-31 00:00:00.000'
	AND LineTotal > 15000
ORDER BY SalesOrderID
```

Results:

SalesOrderID | Name | OrderQty | UnitPrice | UnitPriceDiscount | LineTotal
---|---|---|---|---|---
53460 | Road-350-W Yellow, 48 | 30 | 850.495 | 0.10 | 22963.365000

These queries return the rows where the *UnitPriceDiscount* column matches or doesn't match the specified value, even when `NULL` values are present.

The `IS [NOT] DISTINCT FROM` predicate in SQL Server 2022 streamlines handling `NULL` values in comparisons. By treating `NULLs` as known values. This predicate simplifies and makes your code more readable and easier to maintain. This feature is a valuable addition for developers and database administrators working with SQL Server.
