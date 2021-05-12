Although the rows in a table should always be unique, when you select only a subset of the columns, the result rows may not be unique even if the original rows are. For example, you may have a table of suppliers with a requirement the city and state (or province) be unique so that there will never be more than one supplier in any city. However, if you just want to see the cities and countries/regions where suppliers are located, the returned results may not be unique. Suppose you write the following query:

```sql
SELECT City, CountryRegion
FROM Production.Supplier
ORDER BY CountryRegion, City;
```

This query may return results similar to the following:

:::row:::
  :::column:::
    City
  :::column-end:::
  :::column:::
    CountryRegion
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Aurora
  :::column-end:::
  :::column:::
    Canada
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Barrie
  :::column-end:::
  :::column:::
    Canada
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Brampton
  :::column-end:::
  :::column:::
    Canada
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Brossard
  :::column-end:::
  :::column:::
    Canada
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Brossard
  :::column-end:::
  :::column:::
    Canada
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Burnaby
  :::column-end:::
  :::column:::
    Canada
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Burnaby
  :::column-end:::
  :::column:::
    Canada
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Burnaby
  :::column-end:::
  :::column:::
    Canada
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Calgary
  :::column-end:::
  :::column:::
    Canada
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Calgary
  :::column-end:::
  :::column:::
    Canada
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    ...
  :::column-end:::
  :::column:::
    ...
  :::column-end:::
:::row-end:::


By default, the SELECT clause includes an implicit ALL keyword that results in this behavior:

```sql
SELECT ALL City, CountryRegion
FROM Production.Supplier
ORDER BY CountryRegion, City;
```

T-SQL also supports an alternative the DISTINCT keyword, which removes any duplicate result rows:

```sql
SELECT DISTINCT City, CountryRegion
FROM Production.Supplier
ORDER BY CountryRegion, City;
```

When using DISTINCT, the example returns only one of each unique combination of values in the SELECT list:

:::row:::
  :::column:::
    City
  :::column-end:::
  :::column:::
    CountryRegion
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Aurora
  :::column-end:::
  :::column:::
    Canada
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Barrie
  :::column-end:::
  :::column:::
    Canada
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Brampton
  :::column-end:::
  :::column:::
    Canada
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Brossard
  :::column-end:::
  :::column:::
    Canada
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Burnaby
  :::column-end:::
  :::column:::
    Canada
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Calgary
  :::column-end:::
  :::column:::
    Canada
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    ...
  :::column-end:::
  :::column:::
    ...
  :::column-end:::
:::row-end:::
