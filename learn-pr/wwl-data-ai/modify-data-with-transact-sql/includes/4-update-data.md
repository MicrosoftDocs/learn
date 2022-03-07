The UPDATE statement in T-SQL is used to change existing data in a table. UPDATE operates on a set of rows, either defined by a condition in a WHERE clause or defined in a join. The UPDATE statement has a SET clause that specifies which columns are to be modified. The SET clause one or more columns, separated by commas, and supplies new values to those columns. The WHERE clause in an UPDATE statement has the same structure as a WHERE clause in a SELECT statement.

> [!NOTE]
> It’s important to note that an UPDATE without a corresponding WHERE clause or a join, will update all the rows in a table. Use the UPDATE statement with caution.

The basic syntax of an UPDATE statement is shown below.

```sql
UPDATE <TableName>
SET 
<ColumnName> = { expression | DEFAULT | NULL }
{,…n}
WHERE <search_conditions>;
```

The following example shows the UPDATE statement used to modify the notes for a promotion:

```sql
UPDATE Sales.Promotion
SET Notes = '25% off socks'
WHERE PromotionID = 2;
```

You can modify multiple columns in the SET clause. For example, the following UPDATE statement modified both the **Discount** and **Notes** fields for all rows where the promotion name is "Get Framed":

```sql
UPDATE Sales.Promotion
SET Discount = 0.2, Notes = REPLACE(Notes, '10%', '20%')
WHERE PromotionName = 'Get Framed';
```

The UPDATE statement also supports a FROM clause, enabling you to modify data based on the results of a query. For example, the following code updates the **Sales.Promotion** table using values retrieved from the **Product.ProductModel** table.

```sql
UPDATE Sales.Promotion
SET Notes = FORMAT(Discount, 'P') + ' off ' + m.Name
FROM Product.ProductModel AS m
WHERE Notes IS NULL
    AND Sales.Promotion.ProductModelID = m.ProductModelID;
```
