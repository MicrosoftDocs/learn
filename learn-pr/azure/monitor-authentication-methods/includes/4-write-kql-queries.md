Now, that you've integrated your activity logs into log analytics, you can start developing the queries that will retrieve the data you need.

## What is a Kusto query?

A Kusto query is a read-only request to process data and return results. The request is stated in plain text that's easy to read, author, and automate. A Kusto query has one or more query statements and returns data in a tabular or graph format.

## What is a tabular statement?

The most common kind of query statement is a tabular expression statement. Both its input and its output consist of tables or tabular datasets. 

Tabular statements contain zero or more *operators*. Each operator starts with a tabular input and returns a tabular output. Operators are sequenced by a pipe (`|`). Data flows, or is piped, from one operator to the next. The data is filtered or manipulated at each step and then fed into the following step. 

It's like a funnel, where you start out with an entire data table. Each time the data passes through another operator, it's filtered, rearranged, or summarized. Because the piping of information from one operator to another is sequential, the query's operator order is important. At the end of the funnel, you're left with a refined output.

These operators are KQL-specific, although they often have parallels to SQL or other languages.

Let's look at an example query:

```kusto
StormEvents 
| where StartTime between (datetime(2007-11-01) .. datetime(2007-12-01))
| where State == "FLORIDA"  
| count 
```

This query has a single tabular expression statement. The statement begins with a reference to a table called **StormEvents** and contains the operators `where` and `count`. Each operator is separated by a pipe. The data rows for the source table are filtered by the value of the **StartTime** column and then filtered by the value of the **State** column. In the last line, the query returns a table with a single column and a single row that contains the count of the remaining rows.

The following image shows a schematic representation of the data being piped through this query:

:::image type="content" source="../media/storm-events.png" alt-text="Schematic diagram that shows a query as a funnel." border="false":::

### Write activity log queries

With the sign-in logs stored in your workspace tables, you can now run queries against them. You can write two types of queries, *table-based* and *search-based*. The schema structures in the preceding section show you all the fields you can query against.

Each Kusto query follows a common pattern:

- A query always starts with the name of the table you're running the query against.  Here, that name would be **SignInLogs**.
- Each command is separated by a pipe (|) and typically begins on a new line. You can have multiple pipes in a query.

Unless you nominate specific columns, the result set you see contains all schema fields.

The `where` command is the most common means of filtering the data in your query.  When you write a condition to filter your data, the following expressions are valid:

| Expression  | Description                                       | Example                                                    |
| :---------- | :------------------------------------------------ | :--------------------------------------------------------- |
| ==          | Check equality (case-sensitive)                   | `Level == 8`                                               |
| =~          | Check equality (case-insensitive)                 | `EventSourceName =~ "microsoft-windows-security-auditing"` |
| !=, <>      | Check inequality (both expressions are identical) | `Level != 4`                                               |
| `and` `or` | Required between conditions                       | `Level == 16 or CommandLine != ""`                         |

Other common filter commands include:

| Command  | Description | Example |
| -------- | --------- | --------- |
| `take *n*` | Ideally suited to small result sets. Take returns *n* rows from the result set in no particular order. | AuditLogs \| Take 10 |
| `top *n* by *field*` | Use this filter command to return the top *n* rows, sorted by the nominated *field*. | AuditLogs \| Top 10 by timeGenerated |
| `sort by *field* (desc)` | If you want to sort only the result set, you can use the sort command. You need to specify the field to sort on, and then you can optionally add the *desc* instruction to specify a descending sort pattern. | AuditLogs \| Sort by timeGenerated desc |
| Where *field* (expression) *value* | The principal filtering command.  You nominate the field, expression, and comparator value.  You can stack multiple where commands, each separated by a pipe. | AuditLogs \| where CreatedDateTime >= ago(2d) |
| project *fields* | If you want to restrict the result set to display only nominated fields, or columns, you can use the project command with a comma-separated list of the fields. | AuditLogs \| project timeGenerated, OperationName, ResourceGroup, Result |

You can use many other commands to build queries. 

To learn more about queries and filters, see the references at the end of this module.

In the next units, you'll connect to a dataset and learn about some of the most commonly used operators. Then you'll use the operators to answer questions about a sample dataset that contains US meteorological data.