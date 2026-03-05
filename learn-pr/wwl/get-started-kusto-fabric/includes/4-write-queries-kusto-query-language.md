KQL databases in an Eventhouse are where you store and query real-time data that flows from Eventstreams and other streaming sources. Once data is loaded into tables, you can use the Kusto Query Language (KQL) or T-SQL to query your data.

:::image type="content" source="../media/eventhouse.png" alt-text="Screenshot of an Eventhouse in Microsoft Fabric." lightbox="../media/eventhouse.png":::

Within an eventhouse, you can create:

- **KQL databases**: Real-time optimized data stores that host a collection of tables, stored functions, materialized views, shortcuts and data streams.
- **KQL querysets**: Collections of KQL queries that you can use to work with data in KQL database tables. A KQL queryset supports queries written using Kusto Query Language (KQL) or a subset of the Transact-SQL language.

## Understand the power of Kusto Query Language (KQL)

To query data in a table in a KQL database, you can use the **KQL**. KQL is specifically designed for analyzing large volumes of structured, semi-structured, and unstructured data with exceptional performance. KQL databases are optimized for time-series data and index incoming data by ingestion time and partition it for optimal query performance. KQL is the same language used in Azure Data Explorer, Azure Monitor Log Analytics, Microsoft Sentinel, and in Microsoft Fabric.

## Get familiar with KQL syntax

KQL queries are made of one or more query statements. A query statement consists of a table name followed by operators that `take`, `filter`, `transform`, `aggregate`, or `join` data. For example, to print any 10 rows in the *stock* table, execute:

```kql
stock
| take 10
```

A more complex example might aggregate data to find average stock prices over the last 5 minutes:

```kql
stock
| where ["time"] > ago(5m)
| summarize avgPrice = avg(todouble(bidPrice)) by symbol
| project symbol, avgPrice
```

> [!TIP]
> To learn more about KQL, see **[Kusto Query Language (KQL) overview](/kusto/query/?azure-portal=true)**.

## Automate data processing with management commands

Beyond basic querying, you can automate data processing through **management commands** including:

- **Update policies**: Automatically transform incoming data and save it to different tables as it arrives.
- **Materialized views**: Precalculate and store summary results for faster queries.
- **Stored functions**: Save frequently used query logic that you can reuse across multiple queries.

> [!TIP]
> For more information about working with KQL databases, including detailed examples of update policies, materialized views, and stored functions, see **[Work with real-time data in a Microsoft Fabric Eventhouse](/training/modules/query-data-kql-database-microsoft-fabric/?azure-portal=true)**.

## Other query options

### Using SQL

KQL databases in Eventhouses also support a subset of common T-SQL expressions for data professionals already familiar with T-SQL syntax. For example:

```sql
SELECT TOP 10 * FROM stock;
```

### Use Copilot to help with queries

Microsoft Fabric includes Copilot for Real-Time Intelligence, which can help you write queries to extract insights from your Eventhouse data. Copilot uses AI to understand what you're looking for and can generate the required query code.

> [!TIP]
> To learn more about Copilot for Real-Time Intelligence, see **[Copilot for Real-Time Intelligence](/fabric/real-time-intelligence/copilot-writing-queries?azure-portal=true)**.
