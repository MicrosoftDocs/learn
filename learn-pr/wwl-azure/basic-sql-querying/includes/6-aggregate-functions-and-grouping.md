# Aggregate Functions

## COUNT

```sql
SELECT COUNT(*) FROM Sales.Orders;
```

This counts the total number of orders.

```sql
SELECT COUNT(DISTINCT Country) FROM Sales.Customers;
```

This counts the distinct number of countries in the customer table.

## SUM

```sql
SELECT SUM(Price) FROM Sales.Products;
```

This calculates the total price of all products.

## AVG

```sql
SELECT AVG(Price) FROM Sales.Products;
```

This calculates the average price of all products.

## MAX and MIN

```sql
SELECT MAX(Price), MIN(Price) FROM Sales.Products;
```

This retrieves the maximum and minimum prices of products.

---

# Grouping Data with GROUP BY and HAVING

## GROUP BY

```sql
SELECT CategoryID, AVG(Price) FROM Sales.Products GROUP BY CategoryID;
```

This calculates the average price for each product category.

## HAVING

```sql
SELECT CategoryID, AVG(Price) FROM Sales.Products GROUP BY CategoryID HAVING AVG(Price) > 30;
```

This calculates the average price for each category and filters out categories with an average price less than or equal to 30.

---

# Subqueries

## Subquery in WHERE clause

```sql
SELECT * FROM Sales.Products WHERE SupplierID IN (SELECT SupplierID FROM Sales.Suppliers WHERE Country = 'Japan');
```

This retrieves products supplied by suppliers from Japan.

## Subquery in FROM clause (derived table)

```sql
SELECT AVG(AveragePrice) FROM (SELECT CategoryID, AVG(Price) AS AveragePrice FROM Sales.Products GROUP BY CategoryID) AS CategoryAverages;
```

This calculates the average of the average prices for each product category.
