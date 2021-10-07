Derived tables allow you to write Transact-SQL statements that are more modular, helping you to break down complex queries into more manageable parts. Using derived tables in your queries can also provide workarounds for some of the restrictions imposed by the logical order of query processing, such as the use of column aliases.

Like subqueries, you create derived tables in the FROM clause of an outer SELECT statement. Unlike subqueries, you write derived tables using a named expression that is logically equivalent to a table and may be referenced as a table elsewhere in the outer query.

Derived tables are not stored in the database. Therefore, no special security privileges are required to write queries using derived tables, other than the rights to select from the source objects.
A derived table is created at the time of execution of the outer query and goes out of scope when the outer query ends.
Derived tables do not necessarily have an impact on performance, compared to the same query expressed differently. When the query is processed, the statement is unpacked and evaluated against the underlying database objects.

## Return results using derived tables

To create a derived table, you write an inner query between parentheses, followed by an AS clause and a name for your derived table, using the following syntax:

```sql
SELECT <outer query column list>
FROM (SELECT <inner query column list>
    FROM <table source>) AS <derived table alias>
```

For example, you can use a derived table to retrieve information about orders placed per year by distinct customers:

```sql
SELECT orderyear, COUNT(DISTINCT custid) AS cust_count
FROM (SELECT YEAR(orderdate) AS orderyear, custid
    FROM Sales.Orders) AS derived_year
GROUP BY orderyear;
```

The inner query builds a set of orders and places it into the derived table's derived year. The outer query operates on the derived table and summarizes the results. The results would look like this:

|orderyear|cust_count|
|---------|---------|
|2019|67|
|2020|86|
|2021|81|

### Pass arguments to derived tables

Derived tables can accept arguments passed in from a calling routine, such as a Transact-SQL batch, function, or a stored procedure. You can write derived tables with local variables serving as placeholders. At runtime, the placeholders can be replaced with values supplied in the batch or with values passed as parameters to the stored procedure that invoked the query. This will allow your code to be reused more flexibly than rewriting the same query with different values each time.

For example, the following batch declares a local variable (marked with the **@** symbol) for the employee ID, and then uses the ability of SQL Server to assign a value to the variable in the same statement. The query accepts the **@emp_id** variable and uses it in the derived table expression:

```sql
DECLARE @emp_id INT = 9; --declare and assign the variable
SELECT orderyear, COUNT(DISTINCT custid) AS cust_count
FROM (    
    SELECT YEAR(orderdate) AS orderyear, custid
    FROM Sales.Orders
    WHERE empid=@emp_id --use the variable to pass a value to the derived table query
) AS derived_year
GROUP BY orderyear;
GO
```

When writing queries that use derived tables, keep the following guidelines in mind:

- The nested SELECT statement that defines the derived table must have an alias assigned to it. The outer query will use the alias in its SELECT statement in much the same way you refer to aliased tables joined in a FROM clause.
- All columns referenced in the derived table's SELECT clause should be assigned aliases, a best practice that is not always required in Transact-SQL. Each alias must be unique within the expression. The column aliases may be declared inline with the columns or externally to the clause.
- The SELECT statement that defines the derived table expression may not use an ORDER BY clause, unless it also includes a TOP operator, an OFFSET/FETCH clause, or a FOR XML clause. As a result, there is no sort order provided by the derived table. You sort the results in the outer query.
- The SELECT statement that defines the derived table may be written to accept arguments in the form of local variables. If the SELECT statement is embedded in a stored procedure, the arguments may be written as parameters for the procedure.
- Derived table expressions that are nested within an outer query can contain other derived table expressions. Nesting is permitted, but it is not recommended due to increased complexity and reduced readability.
- A derived table may not be referred to multiple times within an outer query. If you need to manipulate the same results, you will need to define the derived table expression every time, such as on each side of a JOIN operator.
