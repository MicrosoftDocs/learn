There are three primary log types in Microsoft Sentinel:

- Analytics Logs
- Basic Logs
- Auxiliary Logs (Preview)

Data in each table in a Log Analytics workspace is retained for a specified period of time after which it's either removed or archived with a reduced retention fee. Set the retention time to balance your requirement for having data available with reducing your cost for data retention.

To access archived data, you must first retrieve data from it in an Analytics Logs table using one of the following methods:

- Search Jobs
- Restore

:::image type="content" source="../media/workspace-plan-overview.png" alt-text="Diagram of different Workspace Log Types.":::

## Analytical Logs

By default, all tables in a workspace are of type Analytics Logs, which are available to all features of a Log Analytics workspace and any other services that use the workspace.

## Basic Logs

 You can configure certain tables as **Basic Logs** to reduce the cost of storing high-volume verbose logs you use for debugging, troubleshooting and auditing, but not for analytics and alerts. Tables configured for Basic Logs have a lower ingestion cost in exchange for reduced features. Basic logs are only **retained for 8 days**.

## Auxiliary Logs (Preview)

Auxiliary Logs are suited for low-touch data, such as verbose logs, and data required for auditing and compliance. This plan offers low-cost ingestion and unoptimized single-table queries for 30 days.

### KQL language limits

Queries against Basic Logs are optimized for simple data retrieval using a subset of KQL language, including the following operators:

- where
- extend
- project
- project-away
- project-keep
- project-rename
- project-reorder
- parse
- parse-where

The following KQL isn't supported:

- join
- union
- aggregates (summarize)

### Table support Basic Logs

All tables in your Log Analytics are Analytics tables, by default. You can configure particular tables to use Basic Logs. You can't configure a table for Basic Logs if Azure Monitor relies on that table for specific features.

You can currently configure the following tables for Basic Logs:

- All tables created with the Data Collection Rule (DCR)-based custom logs API.
- ContainerLogV2, which Container Insights uses and which include verbose text-based log records.
- AppTraces, which contain freeform log records for application traces in Application Insights.

### Configure log type

To adjust the log type for an **eligible** table, select the workspace settings in the Microsoft Sentinel Settings area.  
The next screen is in the Log Analytics portal.

1. Select the "Tables" tab.  
1. Select the table then **...** at the end of the row.
1. Select Manage table
1. Change the *Table plan*.
1. Select **Save**

## Long-term retention

By default, all tables in a Log Analytics workspace retain data for 30 days, except for log tables with 90-day default retention. During this period - the interactive retention period - you can retrieve the data from the table through queries, and the data is available for visualizations, alerts, and other features and services, based on the table plan.

You can extend the interactive retention period of tables with the Analytics plan to up to two years. The Basic and Auxiliary plans have a fixed interactive retention period of 30 days.  

:::image type="content" source="../media/retention-long-term.png" alt-text="Diagram of the Retention archive process.":::

To retain data in the same table beyond the interactive retention period, extend the table's total retention to up to 12 years. At the end of the interactive retention period, the data stays in the table for the remainder of the total retention period you configure. During this period - the long-term retention period - run a search job to retrieve the specific data you need from the table and make it available for interactive queries in a search results table.

### Configure table retention

To adjust the retention days for a table, select the workspace settings in the Microsoft Sentinel Settings area.  
The next screen is in the Log Analytics portal.
  
1. Select the "Tables" tab.  
1. Select the table then **...** at the end of the row.
1. Select Manage table
1. Change the *Total retention period*.
1. Select **Save**
