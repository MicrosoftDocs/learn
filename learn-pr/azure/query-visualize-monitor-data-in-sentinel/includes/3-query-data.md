Azure Sentinel provides the Azure Data Explorer that you can use to search and filter collected data. 

## Kusto query language

The Azure Data Explorer provides you the ability to create, store, and run interactive analytics on collected data by using the Kusto query language (KQL). Azure Data Explorer offers different tools and integrations to perform data ingestion, queries, visualization, orchestration, and other operations. Azure Sentinel uses KQL to visualize and analyze the important data. You can use KQL to create complex analytical queries that include some of the following operators:

- Calculated columns
- Join functions
- Group by aggregates

## Write and run basic queries

A query is a read-only request that processes data and returns the results of this processing, without modifying the data or metadata. Similar to SQL queries, KQL queries use schema entities that are organized in a hierarchy such as databases, tables, and columns. A schema is a collection of tables grouped under logical categories. The queries consist of sequences of query statements that are delimited by a semicolon (;).
When you construct a query, you start with either a table name or a search command. The following query retrieves all records from the  **Event**  table:

```kusto
Event
```

You can use the pipe (|) character to separate commands. The output of the first command becomes the input of the next command. You can add any number of commands to a single query. The following query retrieves the records from the  **Event**  table, and then searches them for the term  **error**  in any property:

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

By default, Log Analytics limits queries to a time range of the past 24 hours. To set a different time range, you can add an explicit  **TimeGenerated**  filter to the query, or use the  **Time range**  control. For example, the following query returns data from the preceding hour:

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

**Azure Sentinel repository on GitHub**

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

If you want to try some examples, you can use [this demo environment](https://ms.portal.azure.com/#blade/Microsoft_Azure_Monitoring_Logs/DemoLogsBlade).
