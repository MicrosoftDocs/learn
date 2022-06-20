## Parser

The parser is an internal process that breaks the query into tokens. The parser is made up of two parts:

- MySQL grammar rule checker
- Lexical scanner

The parser then builds a **parse tree** and the pre-processor carries out further checks such as whether tables or columns exist. The pre-processor also checks privileges.

The parser's job is to translate the query text into a valid parse tree structure that can be used by the **Query Optimizer**.

## Query optimizer

The query optimizer takes the parse tree and turns it into a query execution plan. The query optimizer must find the optimal plan amongst many potential plans by predicting the **cost** of different plans. The query optimizer asks the relevant storage engine for **statistics** such as the number of pages for each table or the length of the rows. Because the query optimizer relies on the storage engine for statistics, it does not always have the statistics it needs, or that are up to date and accurate.

> [!NOTE]
> Statistics are created by the relevant storage engine, and each storage engine creates and stores different statistics. As an example, as InnoDB does not store row length statistics.

You can view how Azure Database for MySQL has executed a query by using the **EXPLAIN** statement. EXPLAIN can be used as a prefix to SELECT, INSERT, DELETE, REPLACE, and UPDATE. When you use the EXPLAIN statement, MySQL then explains its chosen execution plan instead of executing it.

> [!NOTE]
> The **EXPLAIN** statement is synonymous with the **DESCRIBE**. In practice, **EXPLAIN** is used to display how MySQL will execute a query, and **DESCRIBE** is used to display information about columns in a table. **EXPLAIN** and **DESCRIBE** require the same privileges as the original statement. **EXPLAIN** also requires the **SHOW VIEW** privilege to show the execution plan for a view.

You can also find out the cost of the last executed query. After running the query, display the cost by executing:

```sql
SHOW STATUS LIKE 'last_query_cost';
```

This displays the number of pages reads required to execute the query. By displaying the last_query_cost after variations of your query, you can find out the relative "cost" of each query.

MySQL's architecture is designed to execute many successful queries concurrently. Where you have a choice, consider executing more small queries, rather than fewer large and complex queries.

> [!TIP]
> DESCRIBE and EXPLAIN are known as utility statements in MySQL. There are four utility statements: DESCRIBE, EXPLAIN, HELP, and USE. HELP returns help on a specific topic, such as HELP 'data types' which displays all the MySQL data types. USE instructs MySQL which database any following statements should be applied to, such as USE MyDatabase;
