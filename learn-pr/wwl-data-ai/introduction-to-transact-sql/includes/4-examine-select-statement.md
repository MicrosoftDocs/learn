Transact-SQL or T-SQL, is a dialect of the ANSI standard SQL language used by Microsoft SQL products and services. It is similar to standard SQL. Most of our focus will be on the SELECT statement, which has by far the most options and variations of any DML statement.

Let's start by taking a high-level look at how a SELECT statement is processed. The order in which a SELECT statement is written is not the order in which it is evaluated and processed by the SQL Server database engine.

Consider the following query:

```sql
SELECT OrderDate, COUNT(OrderID) AS Orders
FROM Sales.SalesOrder
WHERE Status = 'Shipped'
GROUP BY OrderDate
HAVING COUNT(OrderID) > 1
ORDER BY OrderDate DESC;
```

The query consists of a SELECT statement, which is composed of multiple *clauses*, each of which defines a specific operation that must be applied to the data being retrieved. Before we examine the run-time order of operations, let's briefly take a look at what this query does, although the details of the various clauses will not be covered in this module.

The SELECT clause returns the **OrderDate** column, and the count of **OrderID** values, to which is assigns the name (or *alias*) **Orders**:

```sql
SELECT OrderDate, COUNT(OrderID) AS Orders
```

The FROM clause identifies which table is the source of the rows for the query; in this case it's the **Sales.SalesOrder** table:

```sql
FROM Sales.SalesOrder
```

The WHERE clause filters rows out of the results, keeping only those rows that satisfy the specified condition; in this case, orders that have a status of "shipped":

```sql
WHERE Status = 'Shipped'
```

The GROUP BY clause takes the rows that met the filter condition and groups them by**OrderDate**, so that all the rows with the same **OrderDate** are considered as a single group and one row will be returned for each group:

```sql
GROUP BY OrderDate
```

After the groups are formed, the HAVING clause filters the groups based on its own predicate. Only dates with more than one order will be included in the results:

```sql
HAVING COUNT(OrderID) > 1
```

For the purposes of previewing this query, the final clause is the ORDER BY, which sorts the output into descending order of **OrderDate**:

```sql
ORDER BY OrderDate DESC;
```

Now that you've seen what each clause does, let's look at the order in which SQL Server actually evaluates them:

1.  The FROM clause is evaluated first, to provide the source rows for the rest of the statement. A virtual table is created and passed to the next step.
2.  The WHERE clause is next to be evaluated, filtering those rows from the source table that match a predicate. The filtered virtual table is passed to the next step.
3.  GROUP BY is next, organizing the rows in the virtual table according to unique values found in the GROUP BY list. A new virtual table is created, containing the list of groups, and is passed to the next step. From this point in the flow of operations, only columns in the GROUP BY list or aggregate functions may be referenced by other elements.
4.  The HAVING clause is evaluated next, filtering out entire groups based on its predicate. The virtual table created in step 3 is filtered and passed to the next step.
5.  The SELECT clause finally executes, determining which columns will appear in the query results. Because the SELECT clause is evaluated after the other steps, any column aliases (in our example, **Orders**) created there cannot be used in the GROUP BY or HAVING clause.
6.  The ORDER BY clause is the last to execute, sorting the rows as determined by its column list.

To apply this understanding to our example query, here is the logical order at run time of the SELECT statement above:

```sql
FROM Sales.SalesOrder
WHERE Status = 'Shipped'
GROUP BY OrderDate 
HAVING COUNT(OrderID) > 1
SELECT OrderDate, COUNT(OrderID) AS Orders
ORDER BY OrderDate DESC;
```

Not all the possible clauses are required in every SELECT statement that you write. The only required clause is the SELECT clause, which can be used on its own in some cases. Usually a FROM clause is also included to identify the table being queried. In addition, Transact-SQL has other clauses that can be added.

As you have seen, you do not write T-SQL queries in the same order in which they are logically evaluated. The run-time order of evaluation determines what data is available to which clauses, as a clause only has access to information already made available from an already processed clause. For this reason, it's important to understand the true logical processing order when writing queries.

## Selecting all columns

The SELECT clause is often referred to as the SELECT *list*, because it lists the values to be returned in the query’s results.

The simplest form of a SELECT clause is the use of the asterisk character (\*) to return all columns. When used in T-SQL queries, it is called a *star*. While SELECT \* is suitable for a quick test, you should avoid using it in production work for the following reasons:

 *  Changes to the table that add or rearrange columns will be reflected in the query results, which may result in unexpected output for applications or reports that use the query.
 *  Returning data that is not needed can slow down your queries and cause performance issues if the source table contains a large number of rows.

For example, the following example retrieves all columns from the (hypothetical) **Production.Product** table.

```sql
SELECT * FROM Production.Product;
```

The result from this query is a rowset that contains all columns for all rows of the table, which might look something like this:

:::row:::
  :::column:::
    ProductID
  :::column-end:::
  :::column:::
    Name
  :::column-end:::
  :::column:::
    ProductNum
  :::column-end:::
  :::column:::
    Color
  :::column-end:::
  :::column:::
    StandardCost
  :::column-end:::
  :::column:::
    ListPrice
  :::column-end:::
  :::column:::
    Size
  :::column-end:::
  :::column:::
    Weight
  :::column-end:::
  :::column:::
    ProductCatID
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    680
  :::column-end:::
  :::column:::
    HL Road Frame - Black, 58
  :::column-end:::
  :::column:::
    FR-R92B-58
  :::column-end:::
  :::column:::
    Black
  :::column-end:::
  :::column:::
    1059.31
  :::column-end:::
  :::column:::
    1431.5
  :::column-end:::
  :::column:::
    58
  :::column-end:::
  :::column:::
    1016.04
  :::column-end:::
  :::column:::
    18
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    706
  :::column-end:::
  :::column:::
    HL Road Frame - Red, 58
  :::column-end:::
  :::column:::
    FR-R92R-58
  :::column-end:::
  :::column:::
    Red
  :::column-end:::
  :::column:::
    1059.31
  :::column-end:::
  :::column:::
    1431.5
  :::column-end:::
  :::column:::
    58
  :::column-end:::
  :::column:::
    1016.04
  :::column-end:::
  :::column:::
    18
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    707
  :::column-end:::
  :::column:::
    Sport-100 Helmet, Red
  :::column-end:::
  :::column:::
    HL-U509-R
  :::column-end:::
  :::column:::
    Red
  :::column-end:::
  :::column:::
    13.0863
  :::column-end:::
  :::column:::
    34.99
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    35
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    708
  :::column-end:::
  :::column:::
    Sport-100 Helmet, Black
  :::column-end:::
  :::column:::
    HL-U509
  :::column-end:::
  :::column:::
    Black
  :::column-end:::
  :::column:::
    13.0863
  :::column-end:::
  :::column:::
    34.99
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    35
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    ...
  :::column-end:::
  :::column:::
    ...
  :::column-end:::
  :::column:::
    ...
  :::column-end:::
  :::column:::
    ...
  :::column-end:::
  :::column:::
    ...
  :::column-end:::
  :::column:::
    ...
  :::column-end:::
  :::column:::
    ...
  :::column-end:::
  :::column:::
    ...
  :::column-end:::
  :::column:::
    ...
  :::column-end:::
:::row-end:::

## Selecting specific columns

An explicit column list allows you to have control over exactly which columns are returned and in which order. Each column in the result will have the name of the column as the header.

For example, consider the following query; which again uses the hypothetical **Production.Product** table.

```sql
SELECT ProductID, Name, ListPrice, StandardCost
‎FROM Production.Product;
```

This time, the results include only the specified columns:

:::row:::
  :::column:::
    ProductID
  :::column-end:::
  :::column:::
    Name
  :::column-end:::
  :::column:::
    ListPrice
  :::column-end:::
  :::column:::
    StandardCost
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    680
  :::column-end:::
  :::column:::
    HL Road Frame - Black, 58
  :::column-end:::
  :::column:::
    1431.5
  :::column-end:::
  :::column:::
    1059.31
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    706
  :::column-end:::
  :::column:::
    HL Road Frame - Red, 58
  :::column-end:::
  :::column:::
    1431.5
  :::column-end:::
  :::column:::
    1059.31
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    707
  :::column-end:::
  :::column:::
    Sport-100 Helmet, Red
  :::column-end:::
  :::column:::
    34.99
  :::column-end:::
  :::column:::
    13.0863
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    708
  :::column-end:::
  :::column:::
    Sport-100 Helmet, Black
  :::column-end:::
  :::column:::
    34.99
  :::column-end:::
  :::column:::
    13.0863
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    ...
  :::column-end:::
  :::column:::
    ...
  :::column-end:::
  :::column:::
    ...
  :::column-end:::
  :::column:::
    ...
  :::column-end:::
:::row-end:::

## Selecting expressions

In addition to retrieving columns stored in the specified table, a SELECT clause can perform calculations and manipulations, which use operators to combine columns and values or multiple columns. The result of the calculation or manipulation must be a single-valued (scalar) result that will appear in the result as a separate column.

For example, the following query includes two expressions:

```sql
SELECT ProductID,
      Name + '(' + ProductNumber + ')',
  ListPrice - StandardCost
FROM Production.Product;
```

The results from this query might look something like this:

:::row:::
  :::column:::
    ProductID
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    680
  :::column-end:::
  :::column:::
    HL Road Frame - Black, 58(FR-R92B-58)
  :::column-end:::
  :::column:::
    372.19
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    706
  :::column-end:::
  :::column:::
    HL Road Frame - Red, 58(FR-R92R-58)
  :::column-end:::
  :::column:::
    372.19
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    707
  :::column-end:::
  :::column:::
    Sport-100 Helmet, Red(HL-U509-R)
  :::column-end:::
  :::column:::
    21.9037
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    708
  :::column-end:::
  :::column:::
    Sport-100 Helmet, Black(HL-U509)
  :::column-end:::
  :::column:::
    21.9037
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    ...
  :::column-end:::
  :::column:::
    ...
  :::column-end:::
  :::column:::
    ...
  :::column-end:::
:::row-end:::


There are a couple of interesting things to note about these results:

 *  The columns returned by the two expressions have no column names. Depending on the tool you are using to submit your query, a missing column name might be indicated by a blank column header, a literal *"no column name"* indicator, or a default name like **column1**. We'll see how to specify an *alias* for the column name in the query later in this section.
 *  The first expression uses the **+** operator to concatenate string (character-based) values, while the second expression uses the **-** operator to subtract one numeric value from another. When used with numeric values, the **+** operator performs addition. Clearly then, it is important to understand the *data types* of the columns you include in expressions. We'll discuss data types in the next section.

## Specifying column aliases

You can specify an *alias* for each column returned by the SELECT query, either as an alternative to the source column name or to assign a name to the output of an expression.

For example, here's the same query as before, but with aliases specified for each of the columns:

```sql
SELECT ProductID AS ID,
      Name + '(' + ProductNumber + ')' AS ProductName,
  ListPrice - StandardCost AS Markup
FROM Production.Product;
```

The results from this query include the specified column names:

:::row:::
  :::column:::
    ID
  :::column-end:::
  :::column:::
    ProductName
  :::column-end:::
  :::column:::
    Markup
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    680
  :::column-end:::
  :::column:::
    HL Road Frame - Black, 58(FR-R92B-58)
  :::column-end:::
  :::column:::
    372.19
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    706
  :::column-end:::
  :::column:::
    HL Road Frame - Red, 58(FR-R92R-58)
  :::column-end:::
  :::column:::
    372.19
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    707
  :::column-end:::
  :::column:::
    Sport-100 Helmet, Red(HL-U509-R)
  :::column-end:::
  :::column:::
    21.9037
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    708
  :::column-end:::
  :::column:::
    Sport-100 Helmet, Black(HL-U509)
  :::column-end:::
  :::column:::
    21.9037
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    ...
  :::column-end:::
  :::column:::
    ...
  :::column-end:::
  :::column:::
    ...
  :::column-end:::
:::row-end:::

> [!NOTE]
> The AS keyword is optional when specifying an alias, but it's good practice to include it for clarification.

## Formatting queries

You may note from the examples in this section that you can be flexible about how you format your query code. For example, you can write each clause (or the entire query) on a single line, or break it over multiple lines. In most database systems, the code is case-insensitive, and some elements of the T-SQL language are optional (including the AS keyword as mentioned previously, and even the semi-colon at the end of a statement).

Consider the following guidelines to make your T-SQL code easily readable (and therefore easier to understand and debug!):

 *  Capitalize T-SQL keywords, like SELECT, FROM, AS, and so on. Capitalizing keywords is a commonly used convention that makes it easier to find each clause of a complex statement.
 *  Start a new line for each major clause of a statement.
 *  If the SELECT list contains more than a few columns, expressions, or aliases, consider listing each column on its own line.
 *  Indent lines containing subclauses or columns to make it clear which code belongs to each major clause.
