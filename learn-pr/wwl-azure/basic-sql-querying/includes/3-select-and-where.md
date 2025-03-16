# Basic SELECT Statements

## Selecting all columns from a table

```sql
SELECT * FROM Sales.Customers;
```

This retrieves all rows and columns from the `Sales.Customers` table.

## Selecting specific columns

```sql
SELECT CustomerName, City, Country FROM Sales.Customers;
```

This retrieves only the `CustomerName`, `City`, and `Country` columns.

## Selecting distinct values

```sql
SELECT DISTINCT Country FROM Sales.Customers;
```

This retrieves a list of unique countries from the `Sales.Customers` table.

---

# Filtering Data with WHERE Clause

## Filtering based on a single condition

```sql
SELECT * FROM Sales.Products WHERE Price > 50;
```

This retrieves products with a price greater than 50.

## Filtering based on multiple conditions (AND, OR, NOT)

```sql
SELECT * FROM Sales.Customers WHERE Country = 'Germany' AND City = 'Berlin';
```

This retrieves customers from Germany who live in Berlin.

```sql
SELECT * FROM Sales.Products WHERE CategoryID = 1 OR CategoryID = 8;
```

This retrieves products that are in categories 1 (Beverages) or 8 (Seafood).

```sql
SELECT * FROM Sales.Customers WHERE NOT Country = 'USA';
```

This retrieves all customers that are not from the USA.

## Using comparison operators (>, <, >=, <=, =, !=)

Examples already covered.

## Using LIKE for pattern matching

```sql
SELECT * FROM Sales.Customers WHERE CustomerName LIKE 'A%';
```

This retrieves customers whose names start with 'A'.

```sql
SELECT * FROM Sales.Products WHERE ProductName LIKE '%Chocolate%';
```

This retrieves products whose names contain the word "Chocolate".

## Using IN and NOT IN for multiple values

```sql
SELECT * FROM Sales.Customers WHERE Country IN ('Germany', 'France', 'UK');
```

This retrieves customers from Germany, France, or the UK.

```sql
SELECT * FROM Sales.Products WHERE CategoryID NOT IN (1, 3);
```

This retrieves products that are not in categories 1 or 3.

## Using BETWEEN for range values

```sql
SELECT * FROM Sales.Products WHERE Price BETWEEN 20 AND 40;
```

This retrieves products with a price between 20 and 40 (inclusive).

## Using IS NULL and IS NOT NULL for null values

```sql
SELECT * FROM Sales.Customers WHERE PostalCode IS NULL;
```

This retrieves customers with a missing postal code.
