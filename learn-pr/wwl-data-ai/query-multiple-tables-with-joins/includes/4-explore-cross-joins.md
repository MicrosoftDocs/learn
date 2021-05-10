A cross join is simply a Cartesian product of the two tables. Using ANSI SQL-89 syntax, you can create a cross join by just leaving off the filter that connects the two tables. Using the ANSI-92 syntax, it’s a little harder; which is good, because in general, a cross join isn't something that you usually want. With the ANSI-92 syntax, it's highly unlikely you'll end up with a cross join accidentally.

To explicitly create a Cartesian product, you use the CROSS JOIN operator.

This operation creates a result set with all possible combinations of input rows:

```sql
SELECT <select_list>
FROM table1 AS t1
CROSS JOIN table2 AS t2;
```

While this result isn't typically a desired output, there are a few practical applications for writing an explicit CROSS JOIN:

 *  Creating a table of numbers, with a row for each possible value in a range.
 *  Generating large volumes of data for testing. When cross joined to itself, a table with as few as 100 rows can readily generate 10,000 output rows with little work from you.

## CROSS JOIN syntax

When writing queries with CROSS JOIN, consider the following guidelines:

 *  There is no matching of rows performed, and so no ON clause is used. (It is an error to use an ON clause with CROSS JOIN.)
 *  To use ANSI SQL-92 syntax, separate the input table names with the CROSS JOIN operator.

The following query is an example of using CROSS JOIN to create all combinations of employees and products:

```sql
SELECT emp.FirstName, prd.Name
FROM HR.Employee AS emp
CROSS JOIN Production.Product AS prd;
```
