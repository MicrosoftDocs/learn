---
ms.custom:
  - build-2023
---
With the introduction of APPROX_PERCENTILE_DISC and APPROX_PERCENTILE_CONT in SQL Server 2022, Microsoft addresses the challenge of efficiently computing percentiles in large datasets when an approximation is acceptable. These functions deliver quicker query execution and lower memory consumption, enabling users to effectively examine data distribution and derive valuable insights without sacrificing system performance.

## APPROX_PERCENTILE_DISC

This function calculates the approximate value at a given percentile within a data set, returning the nearest existing data point.

## APPROX_PERCENTILE_CONT

This function computes the approximate value at a specified percentile, interpolating between data points if needed.

## Improve large data set query performance with APPROX_PERCENTILE_DISC and APPROX_PERCENTILE_CONT

An online retail company wants to analyze their sales data to better understand customer spending patterns and optimize their pricing strategy. They would like to determine the 90th percentile of product prices sold in each product category, which would give them an idea of how high-end products are priced in comparison to most products.

When you use both APPROX_PERCENTILE_DISC and APPROX_PERCENTILE_CONT functions, the company can efficiently calculate the 90th percentile of product prices within each category. The discrete function provides the exact price value closest to the desired percentile, while the continuous function interpolates between prices to provide a more accurate estimate. This information helps the company make informed decisions on pricing adjustments and inventory management to cater to customer preferences and boost sales.

```sql
WITH ProductSalesByCategory AS (
    SELECT p.ProductID, p.Name AS ProductName, c.Name AS CategoryName, sod.UnitPrice
    FROM AdventureWorks2012.Sales.SalesOrderDetail AS sod
    JOIN AdventureWorks2012.Production.Product AS p ON sod.ProductID = p.ProductID
    JOIN AdventureWorks2012.Production.ProductSubcategory AS sc ON p.ProductSubcategoryID = sc.ProductSubcategoryID
    JOIN AdventureWorks2012.Production.ProductCategory AS c ON sc.ProductCategoryID = c.ProductCategoryID
)

SELECT CategoryName,
       ROUND(APPROX_PERCENTILE_DISC(0.9) WITHIN GROUP (ORDER BY UnitPrice), 2) AS UnitPrice90thPercentile_DISC,
       ROUND(APPROX_PERCENTILE_CONT(0.9) WITHIN GROUP (ORDER BY UnitPrice), 2) AS UnitPrice90thPercentile_CONT
FROM ProductSalesByCategory
GROUP BY CategoryName
ORDER BY CategoryName;
```

Results:

| CategoryName | UnitPrice90thPercentile_DISC | UnitPrice90thPercentile_CONT |
|---|---|---|
| Accessories | 34.99 | 34.99 |
| Bikes | 2384.07 | 2384.07 |
| Clothing | 53.99 | 53.99 |
| Components | 744.27 | 744.27 |
