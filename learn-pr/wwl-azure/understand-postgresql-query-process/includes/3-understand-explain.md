Use the EXPLAIN statement to display the execution plan for the query. EXPLAIN can be used with any SELECT, INSERT, UPDATE, DELETE, VALUES, EXECUTE, DECLARE, or CREATE TABLE AS statement.

EXPLAIN displays the execution plan for the query, allowing you to understand how PostgreSQL: executes a statement, whether indexes are used, how tables are joined, and the notional cost of a query.

The syntax for EXPLAIN is:

```sql
EXPLAIN [ (parameter [, ...] ) ] statement
```

The optional parameters are:

- ANALYZE
- VERBOSE
- COSTS
- BUFFERS
- FORMAT

For example:

```sql
EXPLAIN ANALYZE SELECT * FROM category ORDER BY cat_id;
```

This simple query returns the following information:

![Screenshot showing the Query Plan.](../media/3-query-plan-1.png)

## ANALYZE

This option executes the statement, and returns the query plan. The output from the statement is discarded, but the statement is still executed. You can combine the ROLLBACK and EXPLAIN ANALYZE statements to prevent the changes being applied with a query that makes changes to the database, such INSERT, UPDATE, or DELETE. For example:

```sql
BEGIN;

> EXPLAIN ANALYZE INSERT INTO Animal 
> (ani_id, name, weight_kg, cat_id, enc_id) 
> VALUES (28, 'Robin Robin', 0.5, 1, 2);

ROLLBACK;
```

## VERBOSE

Displays additional information including:

- the output column list for each node in the plan tree
- the schema-qualified table and function names
- the variables names in expressions together with the table alias
- the name of each trigger for which statistics are displayed

## COSTS

Includes the estimated start-up cost, and total cost, plus the estimated number of rows and estimated width of each row.

## BUFFERS

Buffers can only be used with the ANALYZE option. PostgreSQL uses a Least Recently Used (LRU) cache to store frequently used data in memory. Buffers display how much of the data comes from a cache, and how much is retrieved from disk. Displays the number of shared, local, and temp blocks hits, reads, and writes. The data provided by BUFFERS can help to understand I/O-intensive parts of a query.

## FORMAT

Defines the output format. XML, JSON, or YAML contain the same information as TEXT, but in a format that is easier for programs to use. TEXT is the default.