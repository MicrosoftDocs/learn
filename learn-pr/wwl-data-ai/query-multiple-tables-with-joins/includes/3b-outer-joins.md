While not as common as inner joins, the use of outer joins in a multi-table query can provide an alternative view of your business data. As with inner joins, you will express a logical relationship between the tables. However, you will retrieve not only rows with matching attributes, but also all rows present in one or both of the tables, whether or not there is a match in the other table.

Previously, you learned how to use an INNER JOIN to find matching rows between two tables. As you saw, the query processor builds the results of an INNER JOIN query by filtering out rows that don't meet the conditions expressed in the ON clause predicate. The result is that only rows with a matching row in the other table are returned. With an OUTER JOIN, you can choose to display all the rows that have matching rows between the tables, plus all the rows that don’t have a match in the other table. Let's look at an example, then explore the process.

First, examine the following query, written with an INNER JOIN:

```sql
SELECT emp.FirstName, ord.Amount
FROM HR.Employee AS emp
INNER JOIN Sales.SalesOrder AS ord
    ON emp.EmployeeID = ord.EmployeeID;
```

These rows represent a match between **HR.Employee** and **Sales.SalesOrder**. Only those **EmployeeID** values that are in both tables will appear in the results.

:::image type="content" source="../media/inner-join-venn-diagram.png" alt-text="A Venn diagram showing the matching members of the Employee and SalesOrder sets":::

Now, let’s examine the following query, written as LEFT OUTER JOIN:

```sql
SELECT emp.FirstName, ord.Amount
FROM HR.Employee AS emp
LEFT OUTER JOIN Sales.SalesOrder AS ord
    ON emp.EmployeeID = ord.EmployeeID;
```

This example uses a LEFT OUTER JOIN operator, which directs the query processor to preserve all rows from the table on the left (**HR.Employee**) and displays the **Amount** values for matching rows in **Sales.SalesOrder**. However, all employees are returned, whether or not they have taken a sales order. In place of the **Amount** value, the query will return NULL for employees with no matching sales orders.

:::image type="content" source="../media/outer-join-venn-diagram.png" alt-text="A Venn diagram showing the outer join results of the Employee and SalesOrder sets":::

## OUTER JOIN syntax

Outer joins are expressed using the keywords LEFT, RIGHT, or FULL preceding OUTER JOIN. The purpose of the keyword is to indicate which table (on which side of the keyword JOIN) should be preserved and have all its rows displayed; match, or no match.

When using LEFT, RIGHT, or FULL to define a join, you can omit the OUTER keyword as shown here:

```sql
SELECT emp.FirstName, ord.Amount
FROM HR.Employee AS emp
LEFT JOIN Sales.SalesOrder AS ord
    ON emp.EmployeeID = ord.EmployeeID;
```

However, like the INNER keyword, it is often helpful to write code that is explicit about the kind of join being used.

When writing queries using OUTER JOIN, consider the following guidelines:

 *  As you have seen, table aliases are preferred not only for the SELECT list, but also for the ON clause.
 *  As with an INNER JOIN, an OUTER JOIN may be performed on a single matching column or on multiple matching attributes.
 *  Unlike an INNER JOIN, the order in which tables are listed and joined in the FROM clause ***does*** matter with OUTER JOIN, as it will determine whether you choose LEFT or RIGHT for your join.
 *  Multi-table joins are more complex when an OUTER JOIN is present. The presence of NULLs in the results of an OUTER JOIN may cause issues if the intermediate results are then joined to a third table. Rows with NULLs may be filtered out by the second join's predicate.
 *  To display only rows where no match exists, add a test for NULL in a WHERE clause following an OUTER JOIN predicate.
 *  A FULL OUTER JOIN is used rarely. It returns all the matching rows between the two tables, plus all the rows from the first table with no match in the second, plus all the rows in the second without a match in the first.
 *  There is no way to predict the order the rows will come back without an ORDER BY clause. There’s no way to know if the matched or unmatched rows will be returned first.
