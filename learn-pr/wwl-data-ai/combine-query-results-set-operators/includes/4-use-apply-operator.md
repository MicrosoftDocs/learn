As an alternative to combining or comparing rows from two sets, SQL Server provides a mechanism to apply a table expression from one set on each row in the other set.  The APPLY operator enables queries that evaluate rows in one input set against the expression that defines the second input set. APPLY is actually a table operator, not a set operator, and is part of the FROM clause. APPLY is more like a JOIN, rather than as a set operator that operates on two compatible result sets of queries.

Conceptually, the APPLY operator is similar to a correlated subquery in that it applies a correlated table expression to each row from a table. However, APPLY returns a table-valued result rather than a scalar or multi-valued result. For example, the table expression could be a table-valued function. You can pass elements from the left row as input parameters to the table-valued function.  

There are two forms of APPLY:

- CROSS APPLY
- OUTER APPLY

The syntax for APPLY is as follows:

```sql
SELECT <column_list>
FROM left_table_source { CROSS | OUTER } APPLY right_table_source 
```

This is best explained with an example. The first example uses an INNER JOIN to return columns from the following tables:

- **SalesLT.SalesOrderHeader**.
- **SalesLT.SalesOrderDetail**.

In the following code example, the tables are joined using an INNER JOIN:

```sql
SELECT oh.SalesOrderID, oh.OrderDate,od.ProductID, od.UnitPrice, od.Orderqty 
FROM SalesLT.SalesOrderHeader AS oh 
INNER JOIN SalesLT.SalesOrderDetail AS od 
ON oh.SalesOrderID = od.SalesOrderID;
```

In the following code example, CROSS APPLY applies the right table source to each row in the left table source. Only rows with results in both the left table and right table are returned. Most INNER JOIN statements can be rewritten as CROSS APPLY statements.

```sql
SELECT oh.SalesOrderID, oh.OrderDate,
od.ProductID, od.UnitPrice, od.Orderqty 
FROM SalesLT.SalesOrderHeader AS oh 
CROSS APPLY (SELECT productid, unitprice, Orderqty 
        FROM SalesLT.SalesOrderDetail AS od 
        WHERE oh.SalesOrderID = SalesOrderID
              ) AS od;
```

In both cases, the result set is the same:

:::image type="content" source="../media/cross-apply.png" alt-text="A screenshot showing the result set from the CROSS APPLY operator.":::
