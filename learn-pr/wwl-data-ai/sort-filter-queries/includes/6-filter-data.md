The simplest SELECT statements with just SELECT and FROM clauses will evaluate every row in a table. If you only want a subset of rows to be processed, you can include a WHERE clause, which defines conditions that determine which rows will be processed and returned.

## The structure of the WHERE clause

The WHERE clause is made up of one or more search conditions, each of which must evaluate to TRUE, FALSE or ‘unknown’ for each row of the table. Only rows for which the WHERE clause evaluates to TRUE will be returned. The individual conditions are frequently referred to as ‘predicates’ and they act as filters on the data rows. Each predicate includes a condition that is being tested, usually using the basic comparison operators:

 *  = (equals)
 *  &lt;&gt; (not equals)
 *  &gt; (greater than)
 *  &gt;= (greater than or equal to)
 *  &lt; (less than)
 *  &lt;= (less than or equal to)

For example, the following query returns all products with a **ProductCategoryID** value of 2:

```sql
SELECT ProductCategoryID AS Category, ProductName
FROM Production.Product
WHERE ProductCategoryID = 2;
```

Similarly, the following query returns all products with a **ListPrice** less than 10.00:

```sql
SELECT ProductCategoryID AS Category, ProductName
FROM Production.Product
WHERE ListPrice < 10.00;
```

## Multiple conditions

Multiple predicates can be combined with the AND and OR operators, and with parentheses. However SQL Server will only process two conditions at a time. The result of two conditions connected with AND will only be TRUE (and the row will be returned) if both conditions are TRUE. The result of two conditions connected with OR will be TRUE if either one, or both, of the conditions are TRUE.

For example, the following query returns product in category 2 that cost less than 10.00:

```sql
SELECT ProductCategoryID AS Category, ProductName
FROM Production.Product
WHERE ProductCategoryID = 2
AND ListPrice < 10.00;
```

AND operators are processed before OR operators unless parentheses are used. Best practice, however, dictates that if you have more than two predicates, you should use parenthesis to avoid confusion, as shown in the following query, which returns products in category 2 or 3 that cost less than 10.00:

```sql
SELECT ProductCategoryID AS Category, ProductName
FROM Production.Product
WHERE (ProductCategoryID = 2 OR ProductCategoryID = 3)
AND (ListPrice < 10.00);
```

## Comparison operators

Transact-SQL provides some additional comparison operators that can help simplify the WHERE clause.

### IN

The IN operator is a shortcut for multiple equality conditions for the same column connected with OR. There is nothing incorrect about writing a query with multiple OR conditions, as in the following example:

```sql
SELECT ProductCategoryID AS Category, ProductName
FROM Production.Product
WHERE ProductCategoryID = 2
    OR ProductCategoryID = 3
    OR ProductCategoryID = 4;
```

However, using IN is a bit clearer, and saves some typing. The performance of the query will not be affected.

```sql
SELECT ProductCategoryID AS Category, ProductName
FROM Production.Product
WHERE ProductCategoryID IN (2, 3, 4);
```

### BETWEEN

Another shortcut can sometimes be used when there are two inequality comparisons on the same column combined with AND, that result in an upper and lower bound for the value. The following two queries are equivalent:

```sql
SELECT ProductCategoryID AS Category, ProductName
FROM Production.Product
WHERE ListPrice >= 1.00
    AND ListPrice <= 10.00;
```

```sql
SELECT ProductCategoryID AS Category, ProductName
FROM Production.Product
WHERE ListPrice BETWEEN 1.00 AND 10.00;
```

The BETWEEN operator uses inclusive boundary values. Products with a price of either 1.00 or 10.00 would be included in the results.

### LIKE

The final comparison operator can only be used for character data and allows us to use wildcard characters and regular expression patterns. Wildcards allow us to specify partial strings. For example, you could use the following query to return all products with names that contain the word "mountain":

```sql
SELECT Name, ListPrice
FROM SalesLT.Product
WHERE Name LIKE '%mountain%';
```

The **%** wildcard represents any string of 0 or more characters, so the results include products with the word "mountain" anywhere in their name, like this:

:::row:::
  :::column:::
    Name
  :::column-end:::
  :::column:::
    ListPrice
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Mountain Bike Socks, M
  :::column-end:::
  :::column:::
    9.50
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Mountain Bike Socks, L
  :::column-end:::
  :::column:::
    9.50
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    HL Mountain Frame - Silver, 42
  :::column-end:::
  :::column:::
    1364.0
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    HL Mountain Frame - Black, 42
  :::column-end:::
  :::column:::
    1349.60
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    HL Mountain Frame - Silver, 38
  :::column-end:::
  :::column:::
    1364.50
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Mountain-100 Silver, 38
  :::column-end:::
  :::column:::
    3399.99
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    ...
  :::column-end:::
  :::column:::
    ...
  :::column-end:::
:::row-end:::


You can use the **\_** wildcard to represent a single character, like this:

```sql
SELECT Name, ListPrice
FROM SalesLT.Product
WHERE Name LIKE 'Mountain Bike Socks, _';
```

The results of this query include products with a name that begins with "Mountain Bike Socks, ", and is followed by a single character:

:::row:::
  :::column:::
    Name
  :::column-end:::
  :::column:::
    ListPrice
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Mountain Bike Socks, M
  :::column-end:::
  :::column:::
    9.50
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Mountain Bike Socks, L
  :::column-end:::
  :::column:::
    9.50
  :::column-end:::
:::row-end:::


You can define complex patterns for strings that you want to find. For example, the following query searched for products with a name that starts with "Mountain-", followed by three characters between 0 and 9, followed by a space and then any string, and ending with a comma, a space, and two characters between 0 and 9.

```sql
SELECT Name, ListPrice
FROM SalesLT.Product
WHERE Name LIKE 'Mountain-[0-9][0-9][0-9] %, [0-9][0-9]';
```

The results from this query might look something like this:

:::row:::
  :::column:::
    Name
  :::column-end:::
  :::column:::
    ListPrice
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Mountain-100 Silver, 38
  :::column-end:::
  :::column:::
    3399.99
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Mountain-100 Silver, 42
  :::column-end:::
  :::column:::
    3399.99
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Mountain-100 Black, 38
  :::column-end:::
  :::column:::
    3399.99
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Mountain-100 Black, 42
  :::column-end:::
  :::column:::
    3399.99
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Mountain-200 Silver, 38
  :::column-end:::
  :::column:::
    2319.99
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Mountain-200 Silver, 42
  :::column-end:::
  :::column:::
    2319.99
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Mountain-200 Black, 38
  :::column-end:::
  :::column:::
    2319.99
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Mountain-200 Black, 42
  :::column-end:::
  :::column:::
    2319.99
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    ...
  :::column-end:::
  :::column:::
    ...
  :::column-end:::
:::row-end:::
