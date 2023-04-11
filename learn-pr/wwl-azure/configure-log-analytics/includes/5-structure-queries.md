
Administrators build Log Analytics queries from data stored in dedicated tables in a Log Analytics workspace. Some common dedicated tables include Event, Syslog, Heartbeat, and Alert. When you build a Kusto Query Language (KQL) query, you begin by determining which tables in the Azure Monitor Logs repository have the data you're looking for. 

The following illustration highlights how KQL queries use the dedicated table data for your monitored services and resources. 

:::image type="content" source="../media/query-tables-f3872e3a.png" alt-text="Illustration that shows how to build Log Analytics queries from data in dedicated tables in a Log Analytics workspace." border="false":::

### Things to know about KQL query structure

Let's take a closer look at dedicated table data and how to structure a KQL log query.

- Each of your selected data sources and solution stores its data in dedicated tables in your Log Analytics workspace.

- Documentation for each data source and solution includes the name of the data type that it creates and a description of each of its properties.

- The basic structure of a query is a source table followed by a series of commands (referred to as _operators_).

- A query can have a chain of multiple operators to refine your data and perform advanced functions.

- Each operator in a query chain begins with a pipe character `|`.

- Many queries require data from a single table only, but other queries can use various options and include data from multiple tables.

### KQL log query examples

Let's review some common KQL log query operators and example syntax.

We can build queries to search for data in the `StormEvent` table that has five entries:

| type | event | severity | start | duration | region |
| --- | --- | --- | --- | --- | --- |
| `Water` | `Freezing rain` | `1` | `6:00 AM 01-27-2023` | `3 hours` | `1, 2` |
| `Wind` | `High winds` | `1` | `8:00 AM 01-27-2023` | `12 hours` | `1, 2, 4, 5` |
| `Temperature` | `Below freezing` | `2` | `11:00 PM 01-26-2023` | `10 hours` | `1, 2, 4, 5` |
| `Water` | `Snow` | `3` | `4:00 PM 01-26-2023` | `10 hours` | `1, 2, 4, 5` |
| `Water` | `Flood warning` | `2` | `9:00 AM 01-26-2023` | `10 hours` | `3` |

To find other operators and examples, review [Azure Monitor log queries](/azure/azure-monitor/log-query/query-language).

#### Count number of items

Use the `count` operator to discover the number of records in an input record set.

The following example returns the number of records in the `StormEvent` table. The query results reveal the `StormEvent` table has five entries.

```kusto
StormEvent | count
```

Query results:

| count |
| --- |
| `5` |

#### Return first number of items

Use the `top` operator to see the first N records of your input record set, sorted by your specified columns. The columns correspond to data properties defined in the dedicated table.

The following example returns the first three data records for `StormEvent`. The results table shows the storm `event` name, the severity, and the forecasted duration.

```kusto
StormEvent | top 3 by event severity duration
```

Query results:

| event | severity | duration |
| --- | --- | --- |
| `Freezing rain` | `1` | `3 hours` |
| `High winds` | `1` | `12 hours` |
| `Below freezing` | `2` | `10 hours` |

#### Find matching items

Use the `where` operator to filter your table to the subset of rows that match the supplied predicate value. The predicate value indicates what to search for in the table, as in `where=="find-this"`.

The following example filters the data records for `StormEvent` to use only records that match "snow."

```kusto
StormEvent | where event=="snow"
```

Your query filters to one row in the `StormEvent` table:

| type | event | severity | start | duration | region |
| --- | --- | --- | --- | --- | --- |
| `Water` | `Snow` | `3` | `4:00 PM 01-26-2023` | `10 hours` | `1, 2, 4, 5` |

#### Aggregate content

Use the `summarize` operator to create a table that aggregates the content of the input record set based on your specifications.

The following example returns an aggregate table for `StormEvent`. The results table shows the average (`avg`) severity level of each storm type for each `region` for all (`count`) data records in the dedicated table.

```kusto
StormEvent | summarize count(), avg(severity) by type, region
```

Query results:

| type | avg(severity) | region |
| --- | --- | --- |
| `Water` | `2` | `1, 2, 3` |
| `Water` | `3` | `4, 5` |
| `Wind` | `1` | `1, 2, 4, 5` |
| `Temperature` | `2` | `1, 2, 4, 5` |

#### Chain operators

Any query can contain an operator chain. 

Suppose you want to search the `StormEvent` table to see how many days experienced below-zero freezing temperatures over the last two weeks. If there are results, you want to see them in descending order (oldest date first). 

You can create a query with chained operators: `where` and `summarize`. The query searches the table data collected in the past `ago(14days)`. It looks for matches to the string `Below`, which is part of the entry text `Below freezing` for the storm type `Temperature`.

The results table aggregates (`summarize`) all items (`count`) in the dedicated table and shows the returned items in descending (`desc`) order.

```kusto
StormEvent
| where (EventLevelName == "Below")
| where (TimeGenerated > ago(14days))
| summarize StormEvent = count(), desc
```

Query results:

| type | event | start |
| --- | --- | --- |
| `Temperature` | `Below freezing` | `11:00 PM 01-13-2023` |
| `Temperature` | `Below freezing` | `12:00 AM 01-14-2023` |
| `Temperature` | `Below freezing` |  `3:00 AM 01-16-2023` |
| `Temperature` | `Below freezing` | `12:00 AM 01-17-2023` |
| `Temperature` | `Below freezing` | `11:00 PM 01-26-2023` |