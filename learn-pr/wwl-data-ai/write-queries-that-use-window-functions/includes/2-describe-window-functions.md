Window functions allow you to perform calculations such as ranking, aggregations, and offset comparisons between rows.

Window functions require a set of rows to work on, known as a window. The OVER clause is used to define the window you want to work on. You can then use a window function on the subset of rows you have defined.

Window functions solve common problems such as generating row numbers in a result set or calculating running totals. Windows also provide an efficient way to compare values in one row with values in another without needing to join a table to itself.

Windows and window functions provide functionality that is difficult to replicate with other SQL commands:

- Ordering the rows that are passed to a window function, without affecting the sort order of the output query.
- Dividing a result set into different parts and applying a window function to each.
- Subdividing a partition, by setting upper and lower boundaries for the window frame.
