You can search and filter the data in Azure Sentinel, using Azure Data Explorer. This is a service for storing and running interactive analytics on collected data by using **Kusto Query Language** (KQL). Azure Data Explorer offers different tools and integrations to do data ingestion, queries, visualization, orchestration and more. Azure Sentinel is usng KQL to visualize and analyze the important data. You can use KQL to make complex analytical queries that include some of the following operators:

- calculated columns
- join functions
- group by-aggregates

## Write and run basic queries

A query is a read-only request to process data and return the results of this processing, without modifying the data or metadata. The query uses schema entities that are organized in a hierarchy similar to SQL's: databases, tables, and columns. A schema is a collection of tables grouped under logical categories. The queries consist of sequence of query statements that are delimeted by a semicolon (;).
When you construct the query you start with either a table name or a search command.   

The following query retrieves all records from the  **Event**  table:

```kusto

Event
```

You can use the pipe (|) character to separate commands. Then the output of the first command is the input of the next command. You can add any number of commands to a single query. The following query retrieves the records from the  **Event**  table, and then searches them for the term  **error**  in any property:

```kusto

Event

| search error
```
You can construct the query with tabular and scalar operators that are combined into multple tabular expression statements, that produce the results of the query.

source1 | operator1 | operator2 

In the following example, the source is **AzureActivity**, the first opeator is **where**, which filter out records based on the logical expression, and the second operator is again **where**:

```kusto
AzureActivity
| where OperationName == 'Delete Virtual Machine'
| where ActivityStatus == 'Accepted'
```

By default, Log Analytics limits queries to a time range of the past 24 hours. To set a different time range, you can add an explicit  **TimeGenerated**  filter to the query, or use the  **Time range**  control. For example the following query is returning the data from the last hour: 

```kusto

Event

| search error
| where TimeGenerated > ago (1h)
```


If you want to try some of the examples you can use [this demo environment](https://ms.portal.azure.com/#blade/Microsoft_Azure_Monitoring_Logs/DemoLogsBlade),.
