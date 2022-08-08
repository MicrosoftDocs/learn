
There are three primary log types in Microsoft Sentinel:

- Analytics Logs
- Basic Logs
- Archive Logs


Data in each table in a Log Analytics workspace is retained for a specified period of time after which it's either removed or archived with a reduced retention fee. Set the retention time to balance your requirement for having data available with reducing your cost for data retention.

To access archived data, you must first retrieve data from it in an Analytics Logs table using one of the following methods:
- Search Jobs
- Restore




:::image type="content" source="../media/workspace-plan-overview.png" alt-text="Diagram of different Workspace Log Types.":::



## Analytical Logs

By default, all tables in a workspace are of type Analytics Logs, which are available to all features of a Log Analytics workspace and any other services that use the workspace. 



## Basic Logs

 You can configure certain tables as **Basic Logs** to reduce the cost of storing high-volume verbose logs you use for debugging, troubleshooting and auditing, but not for analytics and alerts. Tables configured for Basic Logs have a lower ingestion cost in exchange for reduced features.  Basic logs are only **retained for 8 days**.

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

> [!NOTE] 
> Basic Logs are currently in *Preview*.  The supported/eligible tables documentation will be updated with current information when the feature is *Generally Available*. 



### Configure log type

To adjust the log type for an **eligible** table, select the workspace settings in the Microsoft Sentinel Settings area.  
The next screen is in the Log Analytics portal.  
1. Select the "Tables" tab.  
1. Select the table then **...** at the end of the row.
1. Select Manage table
1. Change the *Table plan*.
1. Select **Save**



## Archive Logs

Archiving lets you keep older, less used data in your workspace at a reduced cost. Each workspace has a default retention policy that's applied to all tables. You can set a different retention policy on individual tables.  


:::image type="content" source="../media/retention-archive.png" alt-text="Diagram of the Retention archive process.":::



During the interactive retention period, data is available for monitoring, troubleshooting and analytics. When you no longer use the logs, but still need to keep the data for compliance or occasional investigation, archive the logs to save costs. You can access archived data by running a search job or restoring archived logs.


### Configure table retention

To adjust the retention days for a table, select the workspace settings in the Microsoft Sentinel Settings area.  
The next screen is in the Log Analytics portal.  
1. Select the "Tables" tab.  
1. Select the table then **...** at the end of the row.
1. Select Manage table
1. Change the *Total retention period*.
1. Select **Save**

