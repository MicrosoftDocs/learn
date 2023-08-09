---
ms.custom:
  - build-2023
---
With the introduction of `DATE_BUCKET`, `DATETRUNC`, `GENERATE_SERIES`, `FIRST_VALUE`, and `LAST_VALUE` in SQL Server 2022, Microsoft tackles the challenges of efficiently working with dates, time periods, and generating value series. These functions improved ease of use, allowing users to effortlessly manipulate time periods and series and derive meaningful insights without hindering system performance.

## DATETRUNC

The `DATETRUNC` function in SQL Server 2022 returns the date-time start of a *date part*, such as a day, week, month, quarter or year. For example, the start of the *month* of the date *'2023-04-28 14:23:16.635'* would be *'2023-04-01 00:00:00.000'*.

## DATE_BUCKET

SQL Server 2022 also introduced the `DATE_BUCKET` function that works in a similar way to `DATETRUNC`, but has an extra parameter to decide the *width* of the *date part* buckets from the origin time. For example, you might want to know beginning of the *previous year* from the date *'2023-04-28 14:23:16.635'* which would be *'2022-01-01 00:00:00.000'*. In this case you would specify 2 as your width, for example: `DATE_BUCKET(YEAR, 2, DateTimeWeAreLookingFor)`.

## FIRST_VALUE and LAST_VALUE

The `FIRST_VALUE` and `LAST_VALUE` functions were introduced in earlier versions of SQL Server to allow you to obtain the first or last value in an ordered set of rows. In SQL Server 2022, we enhanced both functions by adding the ability to `IGNORE NULLS` or `RESPECT NULLS`.

## Return the first and last order IDs using DATETRUNC, FIRST_VALUE and LAST_VALUE

Time to put all these functions together. Let's assume you're a DBA for a retail company. The sales team would like to understand our best customer's purchase patterns slightly better. The team asked you provide them with the first and last sales order IDs for that customer's latest year of purchases in our database. The customer ID is 11711.

With the help of some of the new and enhanced SQL Server 2022 functions, this problem is less challenging. The function `DATETRUNC` helps you group together all the purchases for our customer's latest purchase year on record. Once you have all those purchases grouped together, using the functions `FIRST_VALUE` and `LAST_VALUE` make it easy to find the first and last order dates. Run the following query in SQL Server Management Studio (SSMS) to see the power of combining `DATETRUNC`, `FIRST_VALUE` and `LAST_VALUE` to help out the sales team.

```sql
DECLARE @LastPurchaseDate DATETIME
DECLARE @CustomerID INT = 11711

SELECT @LastPurchaseDate = MAX(soh.OrderDate)
FROM [AdventureWorks2022].[Sales].[SalesOrderHeader] soh
	JOIN [AdventureWorks2012].Person.Person p ON p.BusinessEntityID = soh.CustomerID
WHERE soh.CustomerID = 11711
GROUP BY CustomerID

SELECT DISTINCT FIRST_VALUE(SalesOrderID) IGNORE NULLS OVER (PARTITION BY CustomerID ORDER BY OrderDate) AS FirstOrderId,
       LAST_VALUE(SalesOrderID) IGNORE NULLS OVER (PARTITION BY CustomerID ORDER BY OrderDate ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) AS LastOrderId
FROM [AdventureWorks2012].[Sales].[SalesOrderHeader] soh
WHERE CustomerID = @CustomerID
	AND DATETRUNC(YEAR,@LastPurchaseDate) = DATETRUNC(YEAR,OrderDate)
```

Results:

| FirstOrderId | LastOrderId |
| --- | --- |
| 64134 | 75036 |

This introduction to the new or enhanced functions in SQL Server 2022 date and series functions should help you find easier ways to tackle some of those problems. While you're reviewing some of our date and series functions, also check out our new `GENERATE_SERIES` function that allows you to generate a series of values in a specified range with a given increment.
