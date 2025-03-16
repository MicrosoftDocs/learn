# Sorting Data with ORDER BY

## Sorting in ascending order (default)

```sql
SELECT * FROM Sales.Products ORDER BY Price;
```

This retrieves products sorted by price in ascending order.

## Sorting in descending order

```sql
SELECT * FROM Sales.Products ORDER BY Price DESC;
```

This retrieves products sorted by price in descending order.

## Sorting by multiple columns

```sql
SELECT * FROM Sales.Customers ORDER BY Country, City;
```

This retrieves customers sorted by country, then by city within each country.

---

# Limiting Results with LIMIT and OFFSET

## Limiting the number of rows returned

```sql
SELECT * FROM Sales.Products LIMIT 10;
```

This retrieves the first 10 products.

## Using OFFSET to skip rows

```sql
SELECT * FROM Sales.Products LIMIT 10 OFFSET 20;
```

This retrieves 10 products, starting from the 21st row.
