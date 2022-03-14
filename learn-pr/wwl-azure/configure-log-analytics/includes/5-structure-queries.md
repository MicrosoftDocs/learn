When you build a query, you start by determining which tables have the data that you're looking for. Each data source and solution stores its data in dedicated tables in the Log Analytics workspace. Documentation for each data source and solution includes the name of the data type that it creates and a description of each of its properties. Many queries will only require data from a single table, but others may use a variety of options to include data from multiple tables.

:::image type="content" source="../media/query-tables-f3872e3a.png" alt-text="Illustration showing how Log Analytics queries are built from data in dedicated tables in a Log Analytics workspace. An example of a query is given that uses the main query tables Event, Syslog, Heartbeat, and Alert.":::


Some common query tables are: Event, Syslog, Heartbeat, and Alert.

The basic structure of a query is a source table followed by a series of operators separated by a pipe character \|. You can chain together multiple operators to refine the data and perform advanced functions. For example, this query returns a count of the top 10 errors in the Event log during the last day. The results are in descending order.

```
Event
| where (EventLevelName == "Error")
| where (TimeGenerated > ago(1days))
| summarize ErrorCount = count() by Computer
| top 10 by ErrorCount desc

```

Some common operators are:

**count** \- Returns the number of records in the input record set.

```
StormEvents | count

```

**limit** \- Return up to the specified number of rows.

```
T | limit 5

```

**summarize** \- Produces a table that aggregates the content of the input table.

```
T | summarize count(), avg(price) by fruit, supplier

```

**top** \- Returns the first N records sorted by the specified columns.

```
T | top 5 by Name desc nulls last

```

**where** \- Filters a table to the subset of rows that satisfy a predicate.

```
T | where fruit=="apple"

```

For more information, [Azure Monitor log queries](/azure/azure-monitor/log-query/query-language)
