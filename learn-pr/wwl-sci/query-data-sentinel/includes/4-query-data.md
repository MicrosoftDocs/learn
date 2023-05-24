You can use the Kusto Query Language (KQL) in Microsoft Sentinel to search and filter collected data.

## Kusto Query Language

KQL provides you with the ability to create, store, and run interactive analytics on collected data. Microsoft Sentinel uses KQL to visualize and analyze the important data. You can use KQL to create complex analytical queries that include some of the following operators:

- Calculated columns
- Join functions
- Group by aggregates

## Write and run basic queries

A query is a read-only request that processes data and returns the results of this processing without modifying the data or metadata. Similar to SQL queries, KQL queries use schema entities that are organized in a hierarchy such as databases, tables, and columns. A schema is a collection of tables grouped under logical categories. The queries consist of sequences of query statements that are delimited by a semicolon (;).

When you construct a query, you start with either a table name or a search command. For example, the following query retrieves all records from the `Event` table:

```kusto
Event
```

You can use the pipe (|) character to separate commands. The output of the first command becomes the input of the next command. You can add any number of commands to a single query. The following query retrieves the records from the `Event` table, and then searches them for the term `error` in any property:

```kusto
Event

| search error
```

You can construct the query with tabular and scalar operators that KQL combines into multiple tabular expression statements, which produce the results of the query.

```kusto
source1 | operator1 | operator2
```

In the following example, the source is `AzureActivity`. The first operator is `where`, which filters out records based on the logical expression. The second operator is again `where`:

```kusto
AzureActivity

| where OperationName == 'Delete Virtual Machine'
| where ActivityStatus == 'Accepted'
```

By default, Log Analytics limits queries to a time range of the past 24 hours. To set a different time range, you can add an explicit `TimeGenerated` filter to the query or use the `Time range` control. For example, the following query returns data from the preceding hour:

```kusto

AzureActivity

| where OperationName == 'Delete Virtual Machine'
| where ActivityStatus == 'Accepted'
| where TimeGenerated > ago (1h)
```

You can combine your queries with some of the most commonly used operators:

- `count`. Returns the count of rows in the table.
- `take`. Returns up to the specified number of rows of data.
- `project`. Selects a subset of columns.
- `sort`. Sorts the rows of the input table into order by one or more columns.
- `top`. Returns the first N records sorted by the specified columns.
- `extend`. Computes derived columns.
- `summarize`. Aggregates groups of rows.
- `render`. Renders results as a graphical output.

To combine the records from two sources (tables), you can use the `join` operator. The `union` operator combines two or more tables into one.

For more information, see the Microsoft [Log analytics tutorial](/azure/azure-monitor/log-query/log-analytics-tutorial) that uses features of Log Analytics to build and run a query instead of working with the query itself.

You can also use [Azure Data explorer tutorial](/azure/data-explorer/kusto/query/tutorial?pivots=azuredataexplorer) to learn about KQL.

> [!NOTE]
> Microsoft Sentinel Log Analytics doesn't support all the KQL syntax that is used in Azure Data Explorer.

## Microsoft Sentinel repository on GitHub

You can also use the [Microsoft Sentinel repository](https://github.com/Azure/Azure-Sentinel) on GitHub to search for specialized queries and workbooks to help secure your environment and hunt for threats.
For example, the following query from Microsoft Sentinel GitHub repository displays suspicious delegation of permissions to user accounts.

```kusto
let timeframe = 7d;
AzureActivity
| where TimeGenerated >= ago(timeframe)
| where OperationName == "Create role assignment"
| where ActivityStatus == "Succeeded"
| project Caller, CallerIpAddress
| evaluate basket()
| extend AccountCustomEntity = Caller, IPCustomEntity = CallerIpAddress
```

The query analyzes the IP address from where the administrator grants access to other users to Azure resources. If an operation isn't from a valid IP address, the query signals suspicious activity, which you can further investigate.

If you want to try some examples, use [the demonstration environment on the Azure portal](https://ms.portal.azure.com/#blade/Microsoft_Azure_Monitoring_Logs/DemoLogsBlade).
