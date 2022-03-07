The most frequent type of JOIN in T-SQL queries is INNER JOIN. Inner joins are used to solve many common business problems, especially in highly normalized database environments. To retrieve data that has been stored across multiple tables, you will often need to combine it via INNER JOIN queries. An INNER JOIN begins its logical processing phase as a Cartesian product, which is then filtered to remove any rows that don't match the predicate.

## Processing an INNER JOIN

Let’s examine the steps by which SQL Server will logically process a JOIN query. Line numbers in the following hypothetical example are added for clarity:

```sql
1) SELECT emp.FirstName, ord.Amount
2) FROM HR.Employee AS emp 
3) JOIN Sales.SalesOrder AS ord
4)      ON emp.EmployeeID = ord.EmployeeID;
```

As you should be aware, the FROM clause will be processed before the SELECT clause. Let’s track the processing, beginning with line 2:

 *  The FROM clause specifies the **HR.Employee** table as one of the input tables, giving it the alias **emp**.
 *  The JOIN operator in line 3 reflects the use of an INNER JOIN (the default type in T-SQL) and specifies **Sales.SalesOrder** as the other input table, which has an alias of **ord**.
 *  SQL Server will perform a logical Cartesian join on these tables and pass the results as a virtual table to the next step. (The physical processing of the query may not actually perform the Cartesian product operation, depending on the optimizer's decisions. But it can be helpful to imagine the Cartesian product being created.)
 *  Using the ON clause, SQL Server will filter the virtual table, keeping only those rows where an **EmployeeID** value from the **emp** table matches a **EmployeeID** in the **ord** table.
 *  The remaining rows are left in the virtual table and handed off to the next step in the SELECT statement. In this example, the virtual table is next processed by the SELECT clause, and the two specified columns are returned to the client application.

The result of the completed query is a list of employees and their order amounts. Employees that do not have any associated orders have been filtered out by the ON clause, as have any orders that happen to have a **EmployeeID** that doesn't correspond to an entry in the **HR.Employee** table.

:::image type="content" source="../media/inner-join-venn-diagram.png" alt-text="A Venn diagram showing the matching members of the Employee and SalesOrder sets":::

## INNER JOIN syntax

An INNER JOIN is the default type of JOIN, and the optional INNER keyword is implicit in the JOIN clause. When mixing and matching join types, it can be useful to specify the join type explicitly, as shown in this hypothetical example:

```sql
SELECT emp.FirstName, ord.Amount
FROM HR.Employee AS emp 
INNER JOIN Sales.SalesOrder AS ord
    ON emp.EmployeeID = ord.EmployeeID;
```

When writing queries using inner joins, consider the following guidelines:

 *  Table aliases are preferred, not only for the SELECT list, but also for writing the ON clause.
 *  Inner joins may be performed on a single matching column, such as an **OrderID**, or on multiple matching attributes, such as the combination of **OrderID** and **ProductID**. Joins that specify multiple matching columns are called *composite* joins.
 *  The order in which tables are listed in the FROM clause for an INNER JOIN doesn't matter to the SQL Server optimizer. Conceptually, joins will be evaluated from left to right.
 *  Use the JOIN keyword once for each pair of joined tables in the FROM list. For a two-table query, specify one join. For a three-table query, you'll use JOIN twice; once between the first two tables, and once again between the output of the JOIN between the first two tables and the third table.

## INNER JOIN examples

The following hypothetical example performs a join on a single matching column, relating the **ProductModelID** in the **Production.Product** table to the **ProductModelID** on the **Production.ProductModel** table:

```sql
SELECT p.ProductID, m.Name AS Model, p.Name AS Product
FROM Production.Product AS p
INNER JOIN Production.ProductModel AS m
    ON p.ProductModelID = m.ProductModelID
ORDER BY p.ProductID;
```

This next example shows how an inner join may be extended to include more than two tables. The **Sales.SalesOrderDetail** table is joined to the output of the JOIN between **Production.Product** and **Production.ProductModel**. Each instance of JOIN/ON does its own population and filtering of the virtual output table. The SQL Server query optimizer determines the order in which the joins and filtering will be performed.

```sql
SELECT od.SalesOrderID, m.Name AS Model, p.Name AS ProductName, od.OrderQty
FROM Production.Product AS p
INNER JOIN Production.ProductModel AS m
    ON p.ProductModelID = m.ProductModelID
INNER JOIN Sales.SalesOrderDetail AS od
    ON p.ProductID = od.ProductID
ORDER BY od.SalesOrderID;
```
