---
ms.custom:
  - build-2023
---
SQL Server 2022 introduces the `WINDOW` clause in `SELECT` statements, making it easier to perform complex window functions and calculations on your data.

## SELECT - WINDOW

The `WINDOW` clause enables you to define a named window specification that can be used with multiple window functions in a query. This feature simplifies complex calculations, such as moving averages and running totals, by allowing you to reuse a single window definition.

## Simplifying aggregations and calculations by using the WINDOWS clause

Imagine you're a database developer working on an e-commerce application. You have table called *SalesOrderHeader*, which contains columns *SalesOrderID* and *OrderDate*. You have a second table called *SalesOrderDetail*, which contains columns for *SalesOrderID*, *ProductID*, *OrderQty*, *UnitPrice* and *LineTotal*. The sales department has asked you to analyze the data for the products *Touring-2000 Blue, 50* and *Touring-3000 Blue, 62* sold on *March 3, 2014*. The team needs: 

- The total sales per product.
- A moving average for the last three sales.
- The sum of sales for each product over the last three orders.
- A running total for both products on that date.

Using the `SELECT` statement with the `WINDOW` clause, you can easily achieve this report with a single query. Here's an example of how to do this query:

```sql
SELECT 
    SOH.SalesOrderID,
	P.Name,
	SOD.OrderQty,
	SOD.UnitPrice,
    SOD.LineTotal,
    SUM(SOD.LineTotal) OVER product_sales AS TotalSalesPerProduct,
    AVG(SOD.LineTotal) OVER last_three_sales AS LastThreeSalesAverageByProduct,
    SUM(SOD.LineTotal) OVER last_three_sales AS LastThreeSalesSumByProduct,
    SUM(SOD.LineTotal) OVER running_total AS RunningTotal
FROM [AdventureWorks2012].[Sales].[SalesOrderDetail] SOD
	JOIN [AdventureWorks2012].[Sales].[SalesOrderHeader] SOH on SOD.SalesOrderID = SOH.SalesOrderID
	JOIN [AdventureWorks2012].[Production].[Product] P ON P.ProductID = SOD.ProductID
WHERE P.Name IN ('Touring-2000 Blue, 50', 'Touring-3000 Blue, 62')
	AND SOH.OrderDate = '2014-03-01'
WINDOW 
	-- Partition by product name window.
    product_sales AS (PARTITION BY P.Name),
	-- Last 3 sales by Product name order by date and Sales order ID.
    last_three_sales AS (PARTITION BY P.Name ORDER BY SOH.OrderDate, SOH.SalesOrderID ROWS BETWEEN 2 PRECEDING AND CURRENT ROW),
	-- The current an all the previous sales window.
    running_total AS (ORDER BY SOH.OrderDate, SOH.SalesOrderID ROWS UNBOUNDED PRECEDING)
```

In this example, we used the `WINDOW` clause to define three named window specifications: *product_sales*, *last_three_sales*, and *running_total*. We reused the *last_three_sales* window specification for calculating both the last three sales moving average and the sum of sales in the last three orders. Using the `WINDOW` clause makes the code more organized and easier to read.

Results:

SalesOrderID | Name | OrderQty | UnitPrice | LineTotal | TotalSalesPerProduct | LastThreeSalesAverageByProduct | LastThreeSalesSumByProduct | RunningTotal
---|---|---|---|---|---|---|---|---
67261 | Touring-2000 Blue, 50  | 1 | 728.91  |  728.910000  |  9475.830000 |  728.910000 | 728.910000 | 728.910000
67261 | Touring-3000 Blue, 62  | 4 | 445.41  | 1781.640000  |  4008.690000 | 1781.640000 | 1781.640000 | 2510.550000  
67279 | Touring-3000 Blue, 62  | 1 | 445.41  |  445.410000  |  4008.690000 | 1113.525000 | 2227.050000 | 2955.960000  
67279 | Touring-2000 Blue, 50  | 3 | 728.91  | 2186.730000  |  9475.830000 | 1457.820000 | 2915.640000 | 5142.690000  
67282 | Touring-2000 Blue, 50  | 2 | 728.91  | 1457.820000  |  9475.830000 | 1457.820000 | 4373.460000 | 6600.510000  
67282 | Touring-3000 Blue, 62  | 2 | 445.41  |  890.820000  |  4008.690000 | 1039.290000 | 3117.870000 | 7491.330000  
67322 | Touring-3000 Blue, 62  | 1 | 445.41  |  445.410000  |  4008.690000 |  593.880000 | 1781.640000 | 7936.740000  
67322 | Touring-2000 Blue, 50  | 5 | 728.91  | 3644.550000  |  9475.830000 | 2429.700000 | 7289.100000 | 11581.290000
67342 | Touring-2000 Blue, 50  | 2 | 728.91  | 1457.820000  |  9475.830000 | 2186.730000 | 6560.190000 | 13039.110000
67342 | Touring-3000 Blue, 62  | 1 | 445.41  |  445.410000  |  4008.690000 |  593.880000 | 1781.640000 | 13484.520000

The `WINDOW` clause in SQL Server 2022 is a valuable addition for data analysts, developers, and database administrators working with SQL Server, as it simplifies complex calculations and aggregations by streamlining the use of window functions in `SELECT` statements.
