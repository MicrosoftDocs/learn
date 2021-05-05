In the logical order of query processing, ORDER BY is the last phase of a SELECT statement to be executed. ORDER BY enables you to control the sorting of rows as they are returned from SQL Server to the client application. SQL Server doesn't guarantee the physical order of rows in a table, and the only way to control the order the rows will be returned to the client is with an ORDER BY clause. This behavior is consistent with relational theory.

## Using the ORDER BY clause

To tell SQL Server to return the results of your query in a particular order, you add an ORDER BY clause in this form:

```sql
SELECT<select_list>
FROM <table_source>
ORDER BY <order_by_list> [ASC|DESC];
```

ORDER BY can take several types of elements in its list:

 *  **Columns by name**. You can specify the names of the column(s) by which the results should be sorted. The results are returned in order of the first column, and then subsorted by each additional column in order.
 *  **Column aliases**. Because the ORDER BY is processed after the SELECT clause, it has access to aliases defined in the SELECT list.
 *  **Columns by ordinal position in the SELECT list**. Using the position isn't recommended in your applications, because of diminished readability and the extra care required to keep the ORDER BY list up to date. However, for complex expressions in the SELECT list, using the position number can be useful during troubleshooting.
 *  **Columns not included in the SELECT list, but available from tables listed in the FROM clause**. If the query uses a DISTINCT option, any columns in the ORDER BY list must be included in the SELECT list.

## Sort direction

In addition to specifying which columns should be used to determine the sort order, you may also control the direction of the sort. You can use ASC for ascending (A-Z, 0-9) or DESC for descending (Z-A, 9-0). Ascending sorts are the default. Each column can have its own direction specified, as in the following example:

```sql
SELECT ProductCategoryID AS Category, ProductName
FROM Production.Product
ORDER BY Category ASC, Price DESC;
```
