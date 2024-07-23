You have already learned that window functions require the OVER clause to create and manipulate windows. The OVER clause defines the rows that the window function is applied to. This may be all the rows, or a subset of the rows. It can also define the order of the rows for a window function.

You can use the OVER clause with functions to compute aggregated values such as moving averages, cumulative aggregates, running totals, or a top N per group results.

The OVER clause can take the following arguments:

- **PARTITION BY** – divides the query result set into different parts.
- **ORDER BY** - defines the logical order of the rows of the result set.
- **ROWS/RANGE** - limits the rows by specifying start and end points. This requires the ORDER BY argument and the default value is from the start of the partition to the current element.

If you don't specify an argument to the OVER clause, the window functions will be applied on the entire result set.

The following diagram shows the relationship between SELECT, OVER, and PARTITION BY:

:::image type="content" source="../media/partition-by.png" alt-text="Diagram showing how PARTITION BY further sub-divides the rows defined in the OVER clause.":::

## PARTITION BY

The PARTITION BY clause divides up the result set into partitions before applying the window function. If PARTITION BY is not specified, the window function is applied to all rows of the query. Partitions use one of the columns made available in the FROM clause.

## ORDER BY

ORDER BY defines the logical order of the rows within each partition. As an example, the RANK function requires rows to be ordered so that it can return the rank position of each row. The default order is ASC, but it is best practice to specify ASC or DESC after the order by expressions. NULL is treated as the lowest possible value.

## ROWS or RANGE clauses

The ROW or RANGE arguments set a start and end boundary around the rows being operated on. ROW or RANGE requires an ORDER BY subclause within the OVER clause.

The ROWS clause limits the rows within a partition by specifying a fixed number of rows preceding or following the current row.

The RANGE clause logically limits the rows within a partition by specifying a range of values with respect to the value in the current row.

### CURRENT ROW

Specifies that the window starts or ends at the current row when used with ROWS or the current value when used with RANGE. CURRENT ROW can be specified as both a starting and ending point.

### BETWEEN AND

Used with ROWS or RANGE to specify the start and end boundary points of the window.
