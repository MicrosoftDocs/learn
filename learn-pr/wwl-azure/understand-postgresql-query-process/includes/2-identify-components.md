There are four separate stages to executing the query. In the order of execution these stages are:

1. Parsing
1. Transformation (Rewriter)
1. Planning
1. Execution

## The parser

The parser is responsible for checking the query string for valid syntax. The parser has two main parts:

- **gram.y** which is made up of a set of grammar rules and corresponding actions.
- **scan.1** the *lexer*, which recognizes identifiers and SQL key words. Every key word or identifier triggers a token being created and handed to the parser.

The parser builds a query tree, which separates the query into identifiable parts to understand which tables are involved, what filters were applied, etc. The parts of a query tree are:

- **Command type** - SELECT, INSERT, UPDATE, or DELETE.
- **Range table entry (RTE)** - a list of relations, `ie` tables, subqueries, results of joins, etc. In a SELECT statement, these items appear after the FROM key word.
- **Result relation** - the result relation for commands INSERT, UPDATE, and DELETE commands, is the table or view where the changes are to take effect.
- **Target list** - the results of the query, identified between the key words SELECT and FROM. DELETE commands don't produce a result, so the planner adds a special entry to allow the executor to find the row to be deleted. INSERT commands identify the new rows that should go into the result relation. For UPDATE commands, the target list describes the new rows that should replace the old ones.
- **Qualification** - a Boolean value that specifies whether or not the operation for the final result row should be executed. It corresponds to the WHERE clause of a SQL statement.
- **Join tree** - this tree could be a list of the FROM items. Joins can be done in any order, or done in a specific order, such as Outer joins.
- **Others** - items that aren't relevant at this stage, such as the ORDER BY clause.

## Rewriter

The output of the parser is passed to the **transformation or rewriter** process, unless an error is found in which case an error message is returned.

The query rewriter rewrites the query text by applying **rules** to it. The rewriter takes rules into consideration, and then passes the modified query to the query planner. Row-level security is implemented at this stage.

For example, rules on SELECT are always applied as the last step, including for INSERT, UPDATE, and DELETE queries. Rules also mean that UPDATE queries don't overwrite existing rows, instead a new row is inserted, and the old row is hidden. After the transaction commits, the vacuum process can remove the hidden row.

## Planner

The job of the planner is to take the query rules and understand which of the different ways that the query could be executed is the fastest.

The planner creates a plan tree, with nodes representing physical operations on the data.

PostgreSQL uses a cost-based query optimizer to find the optimal plan for a query. The planner evaluates various execution plans and estimates how much of the required resources are needed, such as CPU cycles, I/O operations, etc. This estimate is then converted into units, known as the *plan cost*. The plan with the lowest cost is selected.

However, as the number of joins increases, the number of possible plans grows exponentially. Evaluating every possible plan becomes impossible even for relatively simple queries. Heuristics and algorithms are used to limit the number of possible plans. The result is that the selected plan might not be the optimal plan. It's near-optimal, however, and selected in a reasonable time.

The cost is the planner's best estimate. The purpose of cost estimation is to *compare* different execution plans for the *same* query in the *same* conditions. The planner uses statistics collected on tables and rows to produce cost estimates for queries. For cost estimates to be accurate, statistics must be up to date.

### Up to date statistics

The planner component of the query optimizer uses statistics about tables and rows to produce accurate cost estimates.

ANALYZE collects statistics about database tables and stores the results in the **pg_statistic** system catalog. You need to run ANALYZE, if:

- You disabled **autovacuum** (which normally analyses tables automatically)
- You disabled **autovacuum**, and haven't run ANALYZE recently
- Either of the previous, and there are many of INSERTS, UPDATES, or DELETE statements.

Cost estimates rely on up-to-date statistics, and if statistics are out of date and an inefficient plan could be chosen. When no parameter is passed to ANALYZE, every table in the database is examined.

The syntax for ANALYZE is:

```sql
ANALYZE [ VERBOSE ] [ ***table*** [ ( ***column*** [, ...] ) ] ]
```

VERBOSE displays progress messages to show which table is being analyzed, together with some statistics.

Schedule VACUUM and ANALYZE to run daily during a low-usage time. ANALYZE can run in parallel with other activities as it requires only a read lock on the target table.

## Executor

This phase takes the plan created by the planner and processes it recursively to extract the required set of rows. Each time a plan node is called the executor must deliver a row, or report back to say that it finished.

The executor evaluates all four SQL query types:

- SELECT
- INSERT
- UPDATE
- DELETE

For **SELECT**, the executor returns each row back to the client as the result set.

For **INSERT**, each returned row is inserted into the specified table. This task is done in a special top-level plan node called ModifyTable.

For **UPDATE**, each computed row includes all the updated column values, plus the row ID of the target row. The data is sent to a ModifyTable node, which creates an updated row and marks the old row as deleted.

For **DELETE**, the only column that is returned by the plan is the row ID. The ModifyTable node uses the row ID to mark the row as deleted.

