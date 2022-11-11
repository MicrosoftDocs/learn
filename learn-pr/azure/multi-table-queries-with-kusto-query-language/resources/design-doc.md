# Title

Multi-table queries using the Kusto Query Language
join data across table to do gain insights in KQL
Write advanced queries in Kusto Query Language

## Role(s)

business-analyst
data-analyst
data-scientist
developer
security operations analyst

## Level

Advanced

## Product(s)

Azure Data Explorer

## Prerequisites

A Microsoft account, an Azure Active Directory user identity to create a free cluster, or create a [free Azure account](https://azure.microsoft.com/free/).
Familiarity with database structures like tables, columns, and rows
Familiarity with Kusto Query Language operators such as project, where, sort, summarize, and let.

## Summary

Write advanced queries in Kusto Query Language to help you gain deeper insights by collating data from several tables. Learn how to use the table-level operators `lookup`, `join`, `union`, `materialize`, and new aggregation functions `arg_min` and `arg_max`. Communicate these results visually in charts.

## Learning objectives

1. Use the Kusto Query Language to combine and retrieve data from two or more tables using the `lookup`, `join`, and `union` operators.
1. Optimize multi-table queries by using the `materialize` operator to cache table data.
1. Enrich insights using and new aggregation functions `arg_min` and `arg_max`.

## Chunk your content into subtasks

Identify the subtasks of module title.

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: Exercise or Knowledge check? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
| Group data by using table operators | Introduce concepts | Knowledge check | 1 | yes |
| Exercise: Count different types of events using the `count`, `dcount`, and `countif` operators | basic questions | Exercise| 1 | yes |
| Exercise: Visualize data across time using the `bin`, `render`, and `sum` operators | compare| Exercise | 2 | yes |
| Exercise: Summarize data using the `min`,`max`, `avg`, and `percentiles` operators | compare| Exercise | 1 | yes |
| Exercise: Introduce variables using the `let` operator | compare | Exercise |3 | yes |

## Outline the units

1. Introduction
        Kusto Query Language (KQL) lets you explore your data to discover patterns, identify anomalies and outliers, and create statistical models. A Kusto query is a read-only request to process data and return results. KQL offers a wide variety of functions that analyze your data in different ways.
1. Understand multiple-table queries
1. Exercise: Connect to data source
1. Exercise: Learn how to use the join operator
1. Exercise: Learn how to use the lookup operator
1. Exercise: Learn how to use the union operator
1. Exercise: Learn how to use the materialize function
1. Knowledge check
1. Summary

## Notes

Note any additional information that may be beneficial to this content such as links, reference material, and so on.