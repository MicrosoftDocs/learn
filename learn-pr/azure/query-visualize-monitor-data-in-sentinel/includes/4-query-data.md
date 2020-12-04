Azure Sentinel provides the Azure Data Explorer that you can use to search and filter collected data.

## Kusto Query Language

The Azure Data Explorer provides you the ability to create,  store, and run interactive analytics on collected data by using KQL. Azure Data Explorer offers different tools and integrations to perform data ingestion, queries, visualization, orchestration, and other operations. Azure Sentinel uses KQL to visualize and analyze the important data. You can use KQL to create complex analytical queries that include some of the following operators:

- Calculated columns
- Join functions
- Group by aggregates

## Write and run basic queries

A query is a read-only request that processes data and returns the results of this processing, without modifying the data or metadata. Similar to SQL queries, KQL queries use schema entities that are organized in a hierarchy such as databases, tables, and columns. A schema is a collection of tables grouped under logical categories. The queries consist of sequences of query statements that are delimited by a semicolon (;).
When you construct a query, you start with either a table name or a search command. The following query retrieves all records from the **Event** table:

```kusto
Event
```

You can use the pipe (|) character to separate commands. The output of the first command becomes the input of the next command. You can add any number of commands to a single query. The following query retrieves the records from the **Event** table, and then searches them for the term **error** in any property:

```kusto
Event

| search error
```

You can construct the query with tabular and scalar operators that are combined into multiple tabular expression statements, which produce the results of the query.

source1 | operator1 | operator2

In the following example, the source is **AzureActivity**, the first operator is **where**, which filters out records based on the logical expression, and the second operator is again **where**:

```kusto
AzureActivity

| where OperationName == 'Delete Virtual Machine'
| where ActivityStatus == 'Accepted'
```

By default, Log Analytics limits queries to a time range of the past 24 hours. To set a different time range, you can add an explicit **TimeGenerated** filter to the query or use the **Time range** control. For example, the following query returns data from the preceding hour:

```kusto

AzureActivity

| where OperationName == 'Delete Virtual Machine'
| where ActivityStatus == 'Accepted'
| where TimeGenerated > ago (1h)
```

You can combine your queries with some of the most commonly used operators:

- **count**. Returns the count of rows in the table.
- **take**. Returns up to the specified number of rows of data.
- **project**. Selects a subset of columns.
- **sort**. Sort the rows of the input table into order by one or more columns.
- **top**. Returns the first N records sorted by the specified columns.
- **extend**. Computes derived columns.
- **summarize**. Aggregates groups of rows.
- **render**. Renders results as a graphical output.

To combine the records from two sources (tables), you can use the **join** operator. The **union** command combines two or more tables into one.

For more information, refer to the Microsoft [Log analytics tutorial](https://docs.microsoft.com/azure/azure-monitor/log-query/log-analytics-tutorial) that uses features of Log Analytics to build and run a query instead of working with the query itself.

You can also use [Azure Data explorer tutorial](https://docs.microsoft.com/azure/data-explorer/kusto/query/tutorial?pivots=azuredataexplorer) to learn about KQL.

## Azure Monitor Community repository on GitHub

The [Azure Monitor Community](https://github.com/microsoft/AzureMonitorCommunity) repository on GitHub contains log queries, workbooks, and alerts, shared by Microsoft and community contributors to help Azure Monitor users make the most of it. You can use many of these ready-to-use queries and workbooks in Azure Sentinel for queries, visualization, and reporting on security threats and vulnerabilities.

## Azure Sentinel repository on GitHub

You can also use the [Azure Sentinel repository](https://github.com/Azure/Azure-Sentinel) on GitHub to search for specialized queries and workbooks to help secure your environment and hunt for threats.
For example, the following query from Azure Sentinel GitHub repository displays suspicious delegation of permissions to user accounts. The query analyzes the IP address from where the administrator grants access to other users to Azure resources. If an operation is not from a valid IP address, the query signals suspicious activity, which you can further investigate.

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

If you want to try some examples, use [the demonstration environment on the Azure portal](https://ms.portal.azure.com/#blade/Microsoft_Azure_Monitoring_Logs/DemoLogsBlade).
