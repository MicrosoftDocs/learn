You use the GROUP BY clause  in a SELECT statement in Transact-SQL to arrange rows in groups, typically to support aggregations. However, if you need to group by different attributes at the same time, for example to report at different levels, you would normally need multiple queries combined with UNION ALL. Instead, if you need to produce aggregates of multiple groupings in the same query, you can use the GROUPING SETS subclause of the GROUP BY clause in Transact-SQL.
GROUPING SETS provides an alternative to using UNION ALL to combine results from multiple individual queries, each with its own GROUP BY clause.

## Use the GROUPING SETS subclause

To use GROUPING SETS, you specify the combinations of attributes on which to group, as in the following syntax example:

```sql
SELECT <column list with aggregate(s)>
FROM <source>
GROUP BY 
GROUPING SETS(
    (<column_name>),--one or more columns
    (<column_name>),--one or more columns
    () -- empty parentheses if aggregating all rows
        );
```

For example, suppose you want to use GROUPING SETS to aggregate on the **Category** and **Cust** columns from a **Sales.CategorySales** table, in addition to the empty parentheses notation to aggregate all rows:

```sql
SELECT Category, Cust, SUM(Qty) AS TotalQty
FROM Sales.CategorySales
GROUP BY 
    GROUPING SETS((Category),(Cust),())
ORDER BY Category, Cust;
```

The result could look like this:

|Category    |Cust |TotalQty|
|----------- |---- |--------|
|NULL        |NULL |999|
|NULL        |1    |80|
|NULL        |2    |12|
|NULL        |3    |154|
|NULL        |4    |241|
|NULL        |5    |512|
|Beverages   |NULL |513|
|Condiments  |NULL |114|
|Confections |NULL |372|

Notice the presence of NULLs in the results. NULLs may be returned because a NULL was stored in the underlying source, or because it is a placeholder in a row generated as an aggregate result. For example, in the previous results, the first row displays `NULL, NULL, 999`. This represents a grand total row. The NULL in the **Category** and **Cust** columns are placeholders because neither **Category** nor **Cust** take part in the aggregation.

> [!TIP]
> If you want to know whether a NULL marks a placeholder or comes from the underlying data, you can use GROUPING_ID. Visit the reference page for [GROUPING_ID](/sql/t-sql/functions/grouping-id-transact-sql?view=sql-server-ver15)  for more information.

## Use the CUBE and ROLLUP subclauses

Like GROUPING SETS, the CUBE and ROLLUP subclauses also enable multiple groupings for aggregating data. However, CUBE and ROLLUP do not need you to specify each set of attributes to group. Instead, given a set of columns, CUBE will determine all possible combinations and output groupings. ROLLUP creates combinations, assuming the input columns represent a hierarchy. Therefore, CUBE and ROLLUP can be thought of as shortcuts to GROUPING SETS.

To use CUBE, append the keyword CUBE to the GROUP BY clause and provide a list of columns to group. For example, to group on all combinations of columns **Category** and **Cust**, you'd use the following syntax in your query:

```sql
SELECT Category, Cust, SUM(Qty) AS TotalQty
FROM Sales.CategorySales
GROUP BY CUBE(Category,Cust);
```

This outputs groupings for the following combinations: (**Category**, **Cust**), (**Cust**, **Category**), (**Cust**), (**Category**) and the aggregate on all empty ():

|Category  |Cust  |TotalQty  |
|---------|---------|---------|
|Beverages      | 1          |36|
|Condiments     | 1           |44
|NULL           | 1           |80
|Beverages      | 2           |5
|Confections    | 2           |7
|NULL           | 2           |12
|Beverages      | 3           |105
|Condiments     | 3           |4
|Confections    | 3           |45
|NULL           | 3           |154
|...            |             |  
|NULL           | NULL        |999
|Beverages      | NULL        |513
|Condiments     | NULL        |114
|Confections    | NULL        |372

To use ROLLUP, you'd append the keyword ROLLUP to the GROUP BY clause and provide a list of columns to group. For example, to group on combinations of the **Category**, **Subcategory**, and **Product** columns, you'd use the following syntax in your query:

```sql
SELECT Category, Subcategory, Product, SUM(Qty) AS TotalQty
FROM Sales.ProductSales
GROUP BY ROLLUP(Category,Subcategory, Product);
```

This would result in groupings for the following combinations: (**Category**, **Subcategory**, **Product**), (**Category**, **Subcategory**), (**Category**), and the aggregate on all empty (). The order in which columns are supplied matters: ROLLUP assumes that the columns are listed in an order that expresses a hierarchy. It provides subtotals for each grouping, along with a grand total for all groupings at the end.
