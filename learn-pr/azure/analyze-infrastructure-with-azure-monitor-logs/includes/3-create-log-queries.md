You use Azure Monitor log queries to extract information from log data. Querying is an important part in examining the log data captured by Azure Monitor.

In the example scenario, the operations team will use Azure Monitor log queries to examine the health of their system.

## Azure Monitor Log Analytics in the Azure portal to write Azure Monitor log queries

You can find the Log Analytics tool in the Azure portal and use it to run sample queries or to create your own queries:

1. Click **Monitor** on the left pane in the Azure portal

    You see the Azure monitor page and more options, including **Activity Log**, **Alerts**, **Metrics**, **Logs**

1. Click **Query & Analyze Logs**.

    Here you can type your query and see the output.

    ![Screenshot of the Azure Monitor in the portal.](../media/3-azure-monitor-portal-query-pane.png)

## How to write queries with the Kusto language

You use the Kusto Query Language to query log information for your services running in Azure. A Kusto query is a read-only request to process data and return results. You state the querying plain text, using a data-flow model designed to make the syntax easy to read, author, and automate. The query uses schema entities that are organized in a hierarchy similar to that of SQL Database: databases, tables, and columns.

A Kusto query consists of a sequence of query statements, delimited by a semicolon (`;`), with at least one statement being a tabular expression statement. A tabular expression statement formats the data arranged in a table-like mesh of columns and rows.

The syntax of a tabular expression statement has tabular data flow from one tabular query operator to another, starting with data source. A data source could be a table in a database, or an operator that produces data. The data then flows through a set of data transformation operators that are bound together with the pipe (`|`) delimiter.

For example, the following Kusto query has a single tabular expression statement. The statement starts with a reference to a table called `Events`. The database that hosts this table is implicit here, and part of the connection information. The data for that table, stored in rows, are then filtered by the value of the `StartTime` column, and then filtered further by the value of the `State` column. The query then returns the count of the resulting rows.

```kusto
Events
| where StartTime >= datetime(2018-11-01) and StartTime < datetime(2018-12-01)
| where State == "FLORIDA"  
| count
```

> [!NOTE]
> The Kusto query language used by Azure Monitor is case-sensitive. Language keywords are typically written in lower-case. When using names of tables or columns in a query, make sure to use the correct case.

Events, captured from the event logs of computers being monitored, are just one type of data source. Azure Monitor provides many other types of data sources. For example, the `Heartbeat` data source reports the health of all computers reporting to your Log Analytics workspace. You can also capture data from performance counters, and update management records.

The example retrieves the most recent heartbeat record for each computer. The computer is identified by its IP address. In this example, the `summarize` aggregation with the `arg_max` function. returns the record with the most recent value for each IP address.

```kusto
Heartbeat
| summarize arg_max(TimeGenerated, *) by ComputerIP
```
