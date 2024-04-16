Ranking and rowset functions aren't scalar functions because they don't return a single value. These functions accept a set of rows as input and return a set of rows as output.


## Ranking functions

Ranking functions allow you to perform calculations against a user-defined set of rows. These functions include ranking, offset, aggregate, and distribution functions.

This example uses the RANK function to calculate a ranking based on the **ListPrice**, with the highest price ranked at 1:

```sql
SELECT TOP 100 ProductID, Name, ListPrice,
RANK() OVER(ORDER BY ListPrice DESC) AS RankByPrice
FROM Production.Product AS p
ORDER BY RankByPrice;
```

The query results might look like:

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
    RankByPrice
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    749
  :::column-end:::
  :::column:::
    Road-150 Red, 62
  :::column-end:::
  :::column:::
    3578.27
  :::column-end:::
  :::column:::
    1
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    750
  :::column-end:::
  :::column:::
    Road-150 Red, 44
  :::column-end:::
  :::column:::
    3578.27
  :::column-end:::
  :::column:::
    1
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    751
  :::column-end:::
  :::column:::
    Road-150 Red, 48
  :::column-end:::
  :::column:::
    3578.27
  :::column-end:::
  :::column:::
    1
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    771
  :::column-end:::
  :::column:::
    Mountain-100 Silver, 38
  :::column-end:::
  :::column:::
    3399.99
  :::column-end:::
  :::column:::
    4
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    772
  :::column-end:::
  :::column:::
    Mountain-100 Silver, 42
  :::column-end:::
  :::column:::
    3399.99
  :::column-end:::
  :::column:::
    4
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    775
  :::column-end:::
  :::column:::
    Mountain-100 Black, 38
  :::column-end:::
  :::column:::
    3374.99
  :::column-end:::
  :::column:::
    6
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


### OVER ###

You can use the OVER clause to define partitions, or groupings within the data. For example, the following query extends the previous example to calculate price-based rankings for products within each category.

```sql
SELECT c.Name AS Category, p.Name AS Product, ListPrice,
  RANK() OVER(PARTITION BY c.Name ORDER BY ListPrice DESC) AS RankByPrice
FROM Production.Product AS p
JOIN Production.ProductCategory AS c
ON p.ProductCategoryID = c.ProductcategoryID
ORDER BY Category, RankByPrice;
```

The results of this query might look something like this:

:::row:::
  :::column:::
    Category
  :::column-end:::
  :::column:::
    Product
  :::column-end:::
  :::column:::
    ListPrice
  :::column-end:::
  :::column:::
    RankByPrice
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Bib-Shorts
  :::column-end:::
  :::column:::
    Men's Bib-Shorts, S
  :::column-end:::
  :::column:::
    89.99
  :::column-end:::
  :::column:::
    1
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Bib-Shorts
  :::column-end:::
  :::column:::
    Men's Bib-Shorts, M
  :::column-end:::
  :::column:::
    89.99
  :::column-end:::
  :::column:::
    1
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Bike Racks
  :::column-end:::
  :::column:::
    Hitch Rack - 4-Bike
  :::column-end:::
  :::column:::
    120
  :::column-end:::
  :::column:::
    1
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Bike Stands
  :::column-end:::
  :::column:::
    All-Purpose Bike Stand
  :::column-end:::
  :::column:::
    159
  :::column-end:::
  :::column:::
    1
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Bottles and Cages
  :::column-end:::
  :::column:::
    Mountain Bottle Cage
  :::column-end:::
  :::column:::
    9.99
  :::column-end:::
  :::column:::
    1
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Bottles and Cages
  :::column-end:::
  :::column:::
    Road Bottle Cage
  :::column-end:::
  :::column:::
    8.99
  :::column-end:::
  :::column:::
    2
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Bottles and Cages
  :::column-end:::
  :::column:::
    Water Bottle - 30 oz.
  :::column-end:::
  :::column:::
    4.99
  :::column-end:::
  :::column:::
    3
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Bottom Brackets
  :::column-end:::
  :::column:::
    HL Bottom Bracket
  :::column-end:::
  :::column:::
    121.49
  :::column-end:::
  :::column:::
    1
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Bottom Brackets
  :::column-end:::
  :::column:::
    ML Bottom Bracket
  :::column-end:::
  :::column:::
    101.24
  :::column-end:::
  :::column:::
    2
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Bottom Brackets
  :::column-end:::
  :::column:::
    LL Bottom Bracket
  :::column-end:::
  :::column:::
    53.99
  :::column-end:::
  :::column:::
    3
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


> [!NOTE]
> Notice that several rows have the same rank value and some values are skipped. This is because we are using RANK only. Depending on the requirement, you may want to avoid ties at the same rank value. You can control the rank value with other functions, DENSE_RANK, NTILE, and ROW_NUMBER, as needed. For details on these functions, see the [Transact-SQL reference documentation](/sql/t-sql/functions/ranking-functions-transact-sql).


## Rowset functions

Rowset functions return a virtual table that can be used in the FROM clause as a data source. These functions take parameters specific to the rowset function itself. They include OPENDATASOURCE, OPENQUERY, OPENROWSET, OPENXML, and OPENJSON.

The OPENDATASOURCE, OPENQUERY, and OPENROWSET functions enable you to pass a query to a remote database server. The remote server will then return a set of result rows. For example, the following query uses OPENROWSET to get the results of a query from a SQL Server instance named **SalesDB**.

```sql
SELECT a.*
FROM OPENROWSET('SQLNCLI', 'Server=SalesDB;Trusted_Connection=yes;',
    'SELECT Name, ListPrice
    FROM AdventureWorks.Production.Product') AS a;
```

To use remote servers, you must enable some advanced options in the SQL Server instance where you're running the query.

The OPENXML and OPENJSON functions enable you to query structured data in XML or JSON format and extract values into a tabular rowset.

A detailed exploration of rowset functions is beyond the scope of this module. For more information, see the [Transact-SQL reference documentation](/sql/t-sql/functions/functions).
