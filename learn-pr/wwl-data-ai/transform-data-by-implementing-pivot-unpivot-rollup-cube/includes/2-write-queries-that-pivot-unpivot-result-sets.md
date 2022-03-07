Use pivot in SQL Server to rotate the way data is displayed from a rows-based orientation to a columns-based orientation. When pivoting, you consolidate values in a column to a list of distinct values, and then projecting that list across as column headings. Typically, this includes aggregation to column values in the new columns.

For example, the partial source data below lists repeating values for **Category** and **Orderyear**, along with values for **Qty**, for each instance of a **Category/Orderyear** pair:

|Category|Qty|Orderyear|
|---------|---------|---------|
|Dairy Products|12|2019|
|Grains/Cereals|10 |2019|
|Dairy Products|5|2019|
|Seafood|2|2020|
|Confections|36|2020|
|Condiments|35|2020|
|Confections|55|2020|
|Condiments|16|2020|
|Dairy Products|60|2020|
|Dairy Products|20|2020|
|Confections|24|2020|
|...(2155 row(s) affected)|

The table above represents over 2000 rows, with many duplicate values. To analyze the results by category and year, you might want to arrange the values to be displayed as follows, summing the **Qty** column along the way:

|Category|       2019 |2020| 2021|
|-------------- |---- |---- |----|
|Beverages|1842 |3996 |3694|
|Condiments|962  |2895 |1441|
|Confections|1357 |4137 |2412|
|Dairy Products |2086 |4374 |2689|
|Grains/Cereals |549  |2636 |1377|
|Meat/Poultry|950  |2189 |1060|
|Produce|549  |1583 |858|
|Seafood|1286 |3679 |2716|
|(8 row(s) affected)|||

The result set is now a total of eight rows. In the pivoting process, each distinct year was created as a column header, and values in the **Qty** column were grouped by **Category** and aggregated.

## Use PIVOT to pivot a result set

You can pivot a result set using the PIVOT operator. The Transact-SQL PIVOT table operator works on the output of the FROM clause in a SELECT statement. To use PIVOT, you need to supply three elements to the operator:

- **Grouping**: in the FROM clause, you provide the input columns. From those columns, PIVOT will determine which column(s) will be used to group the data for aggregation. This is based on looking at which columns aren't being used as other elements in the PIVOT operator.
- **Spreading**: you provide a comma-delimited list of values to be used as the column headings for the pivoted data. The values need to occur in the source data.
- **Aggregation**: you provide an aggregation function (SUM, and so on) to be performed on the grouped rows.

Additionally, you need to assign a table alias to the result table of the PIVOT operator. The following example shows the elements in place:

```sql
SELECT  Category, [2019],[2020],[2021]
FROM  ( SELECT  Category, Qty, Orderyear FROM Sales.CategoryQtyYear) AS D 
          PIVOT(SUM(qty) FOR orderyear IN ([2019],[2020],[2021])) AS pvt;
```

In the example above, **Orderyear** is the column providing the spreading values, Qty is used for aggregation, and **Category** for grouping. **Orderyear** values are enclosed in delimiters to indicate that they're identifiers of columns in the result.

## Use UNPIVOT to unpivot a result set

Unpivoting data is the logical reverse of pivoting data. Instead of turning rows into columns, unpivot turns columns into rows. This is a technique useful in taking data that has already been pivoted (with or without using a Transact-SQL PIVOT operator) and returning it to a row-oriented tabular display. You can use the UNPIVOT table operator to accomplish this.

To use the UNPIVOT operator, you provide three elements:

- Source columns to be unpivoted.
- A name for the new column that will display the unpivoted values.
- A name for the column that will display the names of the unpivoted values.

The following example specifies 2019, 2020, and 2021 as the columns to be unpivoted, using the new column name **orderyear** and the **qty** values to be displayed in a new **qty** column.

```sql
SELECT category, qty, orderyear
FROM Sales.PivotedCategorySales
UNPIVOT(qty FOR orderyear IN([2019],[2020],[2021])) AS unpvt;
```

When unpivoting data, one or more columns is defined as the source to be converted into rows. The data in those columns is spread, or split, into one or more new rows, depending on how many columns are being unpivoted.
In the following source data, three columns will be unpivoted. Each **Orderyear** value will be copied into a new row and associated with its **Category** value. Any NULLs will be removed in the process and no row is created:

|Category        |2019 |2020 |2021|
|--------------- |---- |---- |----|
|Beverages|1842 |3996 |3694|
|Condiments|962  |2895 |1441|
|Confections|1357 |4137 |2412|
|Dairy Products|2086  |374 |2689|
|Grains/Cereals|549  |2636 |1377
|Meat/Poultry|950  |2189 |1060|
|Produce|549  |1583 |858|
|Seafood|1286 |3679|2716|

For each intersection of **Category** and **Orderyear**, a new row will be created, as in these partial results:

|category        |qty  |orderyear|
|--------------- |---- |---------|
|Beverages       |1842 |2019|
|Beverages       |3996 |2020|
|Beverages       |3694 |2021|
|Condiments      |962  |2019|
|Condiments      |2895 |2020|
|Condiments      |1441 |2021|
|Confections     |1357 |2019|
|Confections     |4137 |2020|
|Confections     |2412 |2021|

Unpivoting does not restore the original data. Detail-level data was lost during the aggregation process in the original pivot. UNPIVOT has no ability to allocate values to return to original detail values.
