In this module, you learned advanced T-SQL techniques that help you write more expressive, efficient, and maintainable database code. These capabilities address common database development scenarios involving complex analytics, hierarchical data, JSON processing, and error handling.

You learned how to:

- Write Common Table Expressions (CTEs) for organizing complex queries and using recursive patterns to traverse hierarchical data structures
- Apply window functions for ranking, running totals, moving averages, and analytical calculations that preserve row-level detail
- Use JSON functions including `JSON_OBJECT`, `JSON_ARRAY`, `JSON_ARRAYAGG`, `OPENJSON`, and `JSON_VALUE` to parse, construct, and transform JSON data
- Implement regular expressions with `REGEXP_LIKE`, `REGEXP_REPLACE`, `REGEXP_SUBSTR`, and related functions for pattern matching and text manipulation
- Find approximate matches using fuzzy string functions like `EDIT_DISTANCE`, `EDIT_DISTANCE_SIMILARITY`, and `JARO_WINKLER_DISTANCE`
- Create graph tables and write queries using the `MATCH` operator and `SHORTEST_PATH` for relationship traversal
- Write correlated subqueries for row-by-row comparisons, existence checks, and per-row calculations
- Implement structured error handling with `TRY...CATCH`, error functions, `THROW`, and proper transaction management

## Key takeaways

- Recursive CTEs are the standard approach for traversing hierarchical data like organizational charts or bill-of-materials structures
- Window functions with `OVER` clauses enable analytical calculations without collapsing rows. Use them instead of self-joins for running totals and rankings
- `JSON_OBJECT` and `JSON_ARRAYAGG` construct JSON from relational data, while `OPENJSON` parses JSON into relational rows
- `JARO_WINKLER_DISTANCE` is optimized for name matching; `EDIT_DISTANCE_SIMILARITY` works better for longer strings
- Always check `@@TRANCOUNT` before `ROLLBACK` in `CATCH` blocks to handle cases where no transaction is active
- Combine `SET XACT_ABORT ON` with `TRY...CATCH` for full transaction protection

## Learn more

- [WITH common_table_expression (Transact-SQL)](/sql/t-sql/queries/with-common-table-expression-transact-sql?azure-portal=true)
- [Window Functions (Transact-SQL)](/sql/t-sql/queries/select-over-clause-transact-sql?azure-portal=true)
- [JSON data in SQL Server](/sql/relational-databases/json/json-data-sql-server?azure-portal=true)
- [Regular expressions](/sql/relational-databases/regular-expressions/overview?azure-portal=true)
- [Graph processing with SQL Server](/sql/relational-databases/graphs/sql-graph-overview?azure-portal=true)
- [TRY...CATCH (Transact-SQL)](/sql/t-sql/language-elements/try-catch-transact-sql?azure-portal=true)
