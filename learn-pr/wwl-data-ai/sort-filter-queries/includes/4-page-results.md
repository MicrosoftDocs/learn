An extension to the ORDER BY clause called OFFSET-FETCH enables you to return only a range of the rows selected by your query. It adds the ability to supply a starting point (an offset) and a value to specify how many rows you would like to return (a fetch value). This extension provides a convenient technique for paging through results.

If you want to return rows a "page" at a time (using whatever number you choose for a page), you'll need to consider that each query with an OFFSET-FETCH clause runs independently of any other queries. There's no server-side state maintained, and you'll need to track your position through a result set via client-side code.

## OFFSET-FETCH syntax

The syntax for the OFFSET-FETCH clause, which is technically part of the ORDER BY clause, is as follows:

```sql
OFFSET { integer_constant | offset_row_count_expression } { ROW | ROWS }
[FETCH { FIRST | NEXT } {integer_constant | fetch_row_count_expression } { ROW | ROWS } ONLY]
```

## Using OFFSET-FETCH

To use OFFSET-FETCH, you'll supply a starting OFFSET value, which may be zero, and an optional number of rows to return, as in the following example:

This example will return the first 10 rows, and then return the next 10 rows of product data based on the **ListPrice**:

```sql
SELECT ProductID, ProductName, ListPrice
FROM Production.Product
ORDER BY ListPrice DESC 
OFFSET 0 ROWS --Skip zero rows
FETCH NEXT 10 ROWS ONLY; --Get the next 10
```

To retrieve the *next* page of product data, use the OFFSET clause to specify the number of rows to skip:

```sql
SELECT ProductID, ProductName, ListPrice
FROM Production.Product
ORDER BY ListPrice DESC 
OFFSET 10 ROWS --Skip 10 rows
FETCH NEXT 10 ROWS ONLY; --Get the next 10
```

In the syntax definition you can see the OFFSET clause is required, but the FETCH clause is not. If the FETCH clause is omitted, all rows following OFFSET will be returned. You'll also find that the keywords ROW and ROWS are interchangeable, as are FIRST and NEXT, which enables a more natural syntax.

To ensure the accuracy of the results, especially as you move from page to page of data, it's important to construct an ORDER BY clause that will provide unique ordering and yield a deterministic result. Because of the way SQL Server’s query optimizer works, it's technically possible for a row to appear on more than one page, unless the range of rows is deterministic.

