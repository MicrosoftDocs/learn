
Several Azure services use Azure Monitor Logs to store data and use the Kusto Query Language (KQL) to extract data. Azure Security Center, Azure Sentinel, and Azure Monitor Application Insights all use Log Analytics workspaces to store and query logs. Azure Monitor Logs are based on Azure Data Explorer. A Log Analytics workspace is the equivalent of a database inside Azure Data Explorer.

To unlock the full range of possibilities with Azure Monitor Logs, you'll need to use log queries. These queries help you obtain a deep understanding of data collected in Azure Monitor Logs. The underlying query language allows for complex operations with minimal code. Kusto is a rich language designed to be easy to read and author. All data generated in Azure Monitor Logs is available to collect and examine through log queries. Different Azure data sources write to different log tables.

Log Analytics is the primary tool used for writing log queries and analyzing results. Even if a log query is used elsewhere in Azure Monitor, you'll typically write and test the query by using Log Analytics.

In addition to writing and working with log queries in Log Analytics, you can use log queries in the following areas:

| Feature | Description
| ---- | ----
| Alert rules | Proactively identify issues related to Azure resources reporting into your workspace. Each alert rule consists of a log search, which automatically runs at regular intervals. Results are inspected to determine if an alert should be created.
| Dashboards | Results of any query can be pinned to an Azure dashboard. A pinned query on a dashboard allows visualization of log and metric data together.
| Export | Azure Monitor data can be imported into Excel or Power BI. Prior to the import, you create a log query that defines all data to export.
| PowerShell | A PowerShell script can be run from a command line or an Azure Automation runbook. The script retrieves log data from Azure Monitor and determines the data to collect based on the query.
| Azure Monitor Logs API | Allows for any REST API client to receive and collect log data from the workspace. The API request includes a query, which runs against Azure Monitor to determine all necessary data to retrieve.

## Kusto syntax and operators

At its core, a Kusto query is a read-only request. The request processes data and returns results. The request comes back in plain text, which makes the data easy to read. Each query uses schema entities that are organized into a hierarchy similar to SQL: databases, tables, and columns.

A query consists of references to actual tables and one or more query operators applied in sequence. When you look at a query, each reference is indicated visually by the use of a pipe character (|) to delimit operators. At least one statement in the query is a tabular expression statement, which is a statement that produces data arranged in columns and rows.

Tabular operators will predominantly be the way you interact with and query monitoring data. Tabular operators such as count, distinct, evaluate, join, limit, and project are all relevant in formulating queries. Since the KQL was originally written for Azure Data Explorer, there are a number of additional ways to manipulate data that are outside the scope of this Learn module. The language is powerful and can perform complex analysis on generated data.

## Understand the schema and schema pane

The *schema* is a series of tables logically grouped together. The schema allows for an easy understanding behind how Log Analytics stores data. The schema displays on the *schema pane* located on the far left of a Log Analytics workspace. The schema is helpful when you craft queries.

As you look at the schema pane, you'll begin to understand that you don't have to build a query from scratch. You're able to:

- Identify a table as a favorite.
- Change scopes so you only see the relevant tables for the resources you select.
- Display metadata to easily find what you need.

You also have capacity to use a preview pane that provides insight into a table's content, along with additional information and metadata.

:::image type="content" source="../media/4-schema-pane-location.png" alt-text="Screenshot of schema pane in the Logs section of a Log Analytics workspace." lightbox="../media/4-schema-pane-location.png":::

## Write a new query

Starting with a table name is the right way to configure log queries. Using a table name defines a clear scope for the query, which improves query performance and relevance of the results.

The KQL is case sensitive. Language keywords are typically written in lowercase, such as consume, count, distinct, evaluate, join, limit, and project. When you use names of tables or columns in a query, make sure to use the correct case. If you're ever stuck, the schema pane will show how to use correct casing for the table name.

## Basic query understanding

One of the tables captured by Azure Monitor is the Heartbeat table. This table contains a number of useful columns. Heartbeat captures data on everything from OS type, OS major version, resource ID, and resource group. To understand all columns that make up this table, run a query with only Heartbeat to see what makes up this table.

:::image type="content" source="../media/4-heartbeat-query.png" alt-text="Screenshot of running the Heartbeat query." lightbox="../media/4-heartbeat-query.png":::

In the results pane at the bottom of logs, you'll see some of the following fields in the screenshot: TimeGenerated [UTC], SourceComputerId, ComputerIP, Computer, Category, OSType, and so on. Each of these columns is a data point you can filter on.

The tabular operators can be applied to help the query return more relevant and specific information you want to examine. Recall that tabular operators help you filter on extracted data. There seem to be many results received from Heartbeat in this example. You know from the previous module that only two virtual machines are reporting to the Log Analytics workspace. To make sure there are only two virtual machines reporting to the workspace, let's add the distinct operator to this query.

:::image type="content" source="../media/4-distinct-operator.png" alt-text="Screenshot showing the Heartbeat query with a pipe and distinct Computer listed." lightbox="../media/4-distinct-operator.png":::

The results now show only two virtual machines are reporting to the workspace. Heartbeat acts like an inventory of all virtual machines reporting to a specific workspace. The distinct operator produces a table with the distinct combination of columns requested within the input query.

In the next unit, we'll show you how to take an existing query and produce results. From there, we'll build on that query to gather the additional relevant data and pin that to a dashboard.