The UNION operator allows two or more query result sets to be combined into a single result set. There are two ways of doing this:

* UNION – the combined result does **not** include duplicates.
* UNION ALL – the combined result set **does** include duplicates.

> [!TIP] 
> A NULL in one set is treated as being equal to a NULL in another set.

There are two rules when combining result sets using UNION:

* The number and the order of the columns must be the same in all queries.
* The data types must be compatible.

> [!NOTE] 
> UNION is different from JOIN. JOIN compares columns from two tables, to create a result set containing rows from two tables. UNION concatenates two result sets together: all the rows in the first result set are appended to the rows in the second result set.

Let’s take a simple example of two lists of customers and the result sets they return. The first query returns customers with a CustomerID between 1 and 9.

```sql
SELECT CustomerID, companyname, FirstName + ' ' + LastName AS 'Name'
FROM SalesLT.Customer
WHERE CustomerID BETWEEN 1 AND 9; 
```

:::image type="content" source="../media/select-result-1.png" alt-text="A screenshot that shows results from the first SELECT statement.":::

The second query returns customers with a CustomerID between 10 and 19.

```sql
SELECT customerid, companyname, FirstName + ' ' + LastName AS 'Name'
FROM saleslt.Customer
WHERE customerid BETWEEN 10 AND 19;
```

:::image type="content" source="../media/select-result-2.png" alt-text="A screenshot that shows results from the second SELECT statement.":::

To combine these two queries into the same result set, use the UNION operator:

```sql
SELECT customerid, companyname, FirstName + ' ' + LastName AS 'Name'
FROM saleslt.Customer
WHERE customerid BETWEEN 1 AND 9
UNION
SELECT customerid, companyname, FirstName + ' ' + LastName AS 'Name'
FROM saleslt.Customer
WHERE customerid BETWEEN 10 AND 19; 
```

This is the result set that is returned:

:::image type="content" source="../media/union-result.png" alt-text="A screenshot that shows results from the UNION statement.":::

As with all Transact-SQL statements, no sort order is guaranteed unless one is explicitly specified. If you require sorted output, add an ORDER BY clause at the end of the second query.

With UNION or UNION ALL, both queries must have the same number of columns, and the columns must be of the same data type, allowing you to join rows from different queries.
