Just as the INSERT statement always adds whole rows to a table, the DELETE statement always removes entire rows.

## Use DELETE to remove specific rows

DELETE operates on a set of rows, either defined by a condition in a WHERE clause or defined in a join. The WHERE clause in a DELETE statement has the same structure as a WHERE clause in a SELECT statement.

> [!NOTE]
> It’s important to keep in mind that a DELETE without a corresponding WHERE clause will remove all the rows from a table. Use the DELETE statement with caution.

The following code shows the basic syntax of the DELETE statement:

```sql
DELETE [FROM] <TableName>
WHERE <search_conditions>;
```

The following example uses the DELETE statement to remove all products from the specified table that have been discontinued. There's a column in the table called *discontinued* and for products that are no longer available, the column has a value of 1.

```sql
DELETE FROM Production.Product
WHERE discontinued = 1;
```

## Use TRUNCATE TABLE to remove all rows

DELETE without a WHERE clause removes all the rows from a table. For this reason, DELETE is usually used conditionally, with a filter in the WHERE clause. If you really do want to remove all the rows and leave an empty table, you can use the TRUNCATE TABLE statement. This statement does not allow a WHERE clause and always removes all the rows in one operation. Here’s an example:

```sql
TRUNCATE TABLE Sales.Sample;
```

TRUNCATE TABLE is more efficient than DELETE when you do want to remove all rows.
