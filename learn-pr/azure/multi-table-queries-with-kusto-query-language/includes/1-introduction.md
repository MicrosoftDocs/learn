Kusto Query Language (KQL) lets you explore your data to discover patterns, identify anomalies and outliers, and create statistical models. A Kusto query is a read-only request to process data and return results. KQL offers a wide variety of functions that analyze your data in different ways.

## Example scenario

Suppose you work at a retail company that sells a wide range of products. You're the data analyst on the sales team that's responsible for providing insights that help the team promote awareness of their products and grow sales. You want to provide the desired insights, but to do so requires data that's spread across several tables. You'll use KQL to gain the insights by querying data from multiple tables.

## What will we be doing?

You'll write queries in Kusto Query Language (KQL) to first enrich data by combining multiple tables and then analyze that data for deeper insights. You'll learn how to:

- Extend a fact table with dimension table data by using the `join` or `lookup` operators.
- Merge or append rows from multiple tables or tabular expressions by using the `union` operator.
- Optimize subqueries by using the `materialize()` function and transient tables by using the `as` operator.
- Analyze data by using the `summarize` operator aggregation functions `arg_min()` and `arg_max()`.

## Prerequisites

- Ability to write [novice](../../write-first-query-kusto-query-language/index.yml) and [intermediate](../../gain-insights-data-kusto-query-language/index.yml) level Kusto queries
- Familiarity with the `let` statement, the `summarize` operator, and aggregation functions

## What is the main goal?

By the end of this session, you'll be able to write optimized Kusto queries that combine data from several tables and gain further insights as a result of enriching the data.
