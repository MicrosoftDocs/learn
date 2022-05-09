The simplest SELECT statements with only SELECT and FROM clauses will evaluate every row in a table. By using a WHERE clause, you define conditions that determine which rows will be processed and potentially reduce result set. 

## The structure of the WHERE clause

The WHERE clause is made up of one or more search conditions, each of which must evaluate to TRUE, FALSE, or 'unknown' for each row of the table. Rows will only be returned when the WHERE clause evaluates as TRUE. 
The individual conditions act as filters on the data, and are referred to as 'predicates'. Each predicate includes a condition that is being tested, usually using the basic comparison operators:

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

### IS NULL / IS NOT NULL 
You can also easily filter to allow or exclude the 'unknown' or NULL values using *IS NULL* or *IS NOT NULL*. 

```sql
SELECT ProductCategoryID AS Category, ProductName
FROM Production.Product
WHERE ProductName IS NOT NULL;
```


## Multiple conditions

Multiple predicates can be combined with the AND and OR operators and with parentheses. However SQL Server will only process two conditions at a time. All conditions must be TRUE when connecting multiple conditions with AND operator. When using OR operator to connect two conditions, one or both may be TRUE for the result set. 

For example, the following query returns product in category 2 that cost less than 10.00:

```sql
SELECT ProductCategoryID AS Category, ProductName
FROM Production.Product
WHERE ProductCategoryID = 2
    AND ListPrice < 10.00;
```

AND operators are processed before OR operators, unless parentheses are used. For best practice, use parentheses when using more than two predicates. The following query returns products in category 2 *OR* 3 *AND* cost less than 10.00:

```sql
SELECT ProductCategoryID AS Category, ProductName
FROM Production.Product
WHERE (ProductCategoryID = 2 OR ProductCategoryID = 3)
    AND (ListPrice < 10.00);
```

## Comparison operators

Transact-SQL includes comparison operators that can help simplify the WHERE clause.

### IN

The IN operator is a shortcut for multiple equality conditions for the same column connected with OR. There's nothing wrong with using multiple OR conditions in a query, as in the following example:

```sql
SELECT ProductCategoryID AS Category, ProductName
FROM Production.Product
WHERE ProductCategoryID = 2
    OR ProductCategoryID = 3
    OR ProductCategoryID = 4;
```

However, using IN is clear and concise, and the performance of the query won't be affected.

```sql
SELECT ProductCategoryID AS Category, ProductName
FROM Production.Product
WHERE ProductCategoryID IN (2, 3, 4);
```

### BETWEEN

BETWEEN is another shortcut that can be used when filtering for an upper and lower bound for the value instead of using two conditions with the AND operator. The following two queries are equivalent:

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

The BETWEEN operator uses inclusive boundary values. Products with a price of either 1.00 or 10.00 would be included in the results. BETWEEN is also helpful when querying date fields. For example, the following query will include all product names modified between January 1, 2012 and December 31, 2012:

```sql
SELECT ProductName, ModifiedDate
FROM Production.Product
WHERE ModifiedDate BETWEEN '2012-01-01' AND '2012-12-31';
```
:::row:::
  :::column:::
    ProductName
  :::column-end:::
  :::column:::
    ModifiedDate
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Mountain Bike Socks, M
  :::column-end:::
  :::column:::
    2012-01-01 00:00:00.000
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    HL Mountain Frame - Silver, 42
  :::column-end:::
  :::column:::
    2012-03-05 00:00:00.000
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    HL Mountain Frame - Silver, 38
  :::column-end:::
  :::column:::
    2012-08-29 00:00:00.000
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Mountain-100 Silver, 38
  :::column-end:::
  :::column:::
    2012-12-31 00:00:00.000
  :::column-end:::
:::row-end:::


However because we don't specify a time range, no results are returned after *2012-12-31 00:00:00.000*. To accurately include date **and** time, we need to include the time in the predicate:

```sql
SELECT ProductName, ListPrice, ModifiedDate
FROM Production.Product
WHERE ModifiedDate BETWEEN '2012-01-01 00:00:00.000' AND '2012-12-31 23:59:59.999';
```

Basic comparison operators such as Greater Than (>) and Equals (=) are also accurate when only filtering by date:

```sql
SELECT ProductName, ListPrice, ModifiedDate
FROM Production.Product
WHERE ModifiedDate >= '2012-01-01' 
    AND ModifiedDate < '2013-01-01';
```


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



You can use the **_** (underscore) wildcard to represent a single character, like this:

```sql
SELECT ProductName, ListPrice
FROM SalesLT.Product
WHERE ProductName LIKE 'Mountain Bike Socks, _';
```

The following results only include products that begin with "Mountain Bike Socks, " and a single character after:

:::row:::
  :::column:::
    ProductName
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


You can also define complex patterns for strings that you want to find. For example, the following query searched for products with a name that starts with "Mountain-", then followed by:

 * three characters between 0 and 9
 * a space 
 * any string
 * a comma
 * a space
 * two characters between 0 and 9


```sql
SELECT ProductName, ListPrice
FROM SalesLT.Product
WHERE ProductName LIKE 'Mountain-[0-9][0-9][0-9] %, [0-9][0-9]';
```

The results from this query might look something like this:

:::row:::
  :::column:::
    ProductName
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
