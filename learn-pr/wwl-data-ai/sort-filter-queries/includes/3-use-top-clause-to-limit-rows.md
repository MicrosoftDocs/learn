The TOP clause is a Microsoft-proprietary extension of the SELECT clause. TOP will let you specify how many rows to return, either as a positive integer or as a percentage of all qualifying rows. The number of rows can be specified as a constant or as an expression. TOP is most frequently used with an ORDER BY, but can be used with unordered data.

## Using the TOP clause

The simplified syntax of the TOP clause, used with ORDER BY, is as follows:

```sql
SELECT TOP (N) <column_list>
FROM <table_source>
WHERE <search_condition>
ORDER BY <order list> [ASC|DESC];
```

For example, to retrieve only the 10 most expensive products from the **Production.Product** table, use the following query:

```sql
SELECT TOP 10 Name, ListPrice
FROM Production.Product
ORDER BY ListPrice DESC;
```

The results might look something like this:

:::row:::
  :::column:::
    Name
  :::column-end:::
  :::column:::
    ListPrice
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Road-150 Red, 62
  :::column-end:::
  :::column:::
    3578.27
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Road-150 Red, 44
  :::column-end:::
  :::column:::
    3578.27
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Road-150 Red, 48
  :::column-end:::
  :::column:::
    3578.27
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Road-150 Red, 52
  :::column-end:::
  :::column:::
    3578.27
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Road-150 Red, 56
  :::column-end:::
  :::column:::
    3578.27
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Mountain-100 Silver, 38
  :::column-end:::
  :::column:::
    3399.99
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Mountain-100 Silver, 42
  :::column-end:::
  :::column:::
    3399.99
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Mountain-100 Silver, 44
  :::column-end:::
  :::column:::
    3399.99
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Mountain-100 Silver, 48
  :::column-end:::
  :::column:::
    3399.99
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Mountain-100 Black, 38
  :::column-end:::
  :::column:::
    3374.99
  :::column-end:::
:::row-end:::


The TOP operator depends on an ORDER BY clause to provide meaningful precedence to the rows selected. TOP can be used without ORDER BY, but in that case, there is no way to predict which rows will be returned. In this example, any 10 orders might be returned if there wasn’t an ORDER BY clause.

## Using WITH TIES

In addition to specifying a fixed number of rows to be returned, the TOP keyword also accepts the WITH TIES option, which will retrieve any rows with values that might be found in the selected top N rows.

In the previous example, the query returned the first 10 products in descending order of price. However, by adding the WITH TIES option to the TOP clause, you will see that more rows qualify for inclusion in the top 10 most expensive products:

```sql
SELECT TOP 10 WITH TIES Name, ListPrice
FROM Production.Product
ORDER BY ListPrice DESC;
```

This modified query returns the following results:

:::row:::
  :::column:::
    Name
  :::column-end:::
  :::column:::
    ListPrice
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Road-150 Red, 62
  :::column-end:::
  :::column:::
    3578.27
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Road-150 Red, 44
  :::column-end:::
  :::column:::
    3578.27
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Road-150 Red, 48
  :::column-end:::
  :::column:::
    3578.27
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Road-150 Red, 52
  :::column-end:::
  :::column:::
    3578.27
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Road-150 Red, 56
  :::column-end:::
  :::column:::
    3578.27
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Mountain-100 Silver, 38
  :::column-end:::
  :::column:::
    3399.99
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Mountain-100 Silver, 42
  :::column-end:::
  :::column:::
    3399.99
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Mountain-100 Silver, 44
  :::column-end:::
  :::column:::
    3399.99
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Mountain-100 Silver, 48
  :::column-end:::
  :::column:::
    3399.99
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Mountain-100 Black, 38
  :::column-end:::
  :::column:::
    3374.99
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Mountain-100 Black, 42
  :::column-end:::
  :::column:::
    3374.99
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Mountain-100 Black, 44
  :::column-end:::
  :::column:::
    3374.99
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Mountain-100 Black, 48
  :::column-end:::
  :::column:::
    3374.99
  :::column-end:::
:::row-end:::


The decision to include WITH TIES will depend on your knowledge of the source data, its potential for unique values, and the requirements of the query you are writing.

## Using PERCENT

To return a percentage of the eligible rows, use the PERCENT option with TOP instead of a fixed number.

```sql
SELECT TOP 10 PERCENT Name, ListPrice
FROM SalesLT.Product
ORDER BY ListPrice DESC;
```

The PERCENT may also be used with the WITH TIES option.

> [!NOTE]
> For the purposes of row count, TOP (N) PERCENT will round **up** to the nearest integer.

The TOP option is used by many SQL Server professionals as a method for retrieving only a certain range of rows. However, consider the following facts when using TOP:

 *  TOP is proprietary to T-SQL.
 *  TOP on its own doesn't support skipping rows.
 *  Because TOP depends on an ORDER BY clause, you cannot use one sort order to establish the rows filtered by TOP and another to determine the output order.
