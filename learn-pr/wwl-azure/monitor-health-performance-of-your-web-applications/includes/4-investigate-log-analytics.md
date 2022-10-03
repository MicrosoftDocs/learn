Log Analytics is part of Microsoft Azure's overall monitoring solution. Log Analytics helps you monitors cloud and on-premises environments to maintain availability and performance.

Log Analytics is the primary tool in the Azure portal for writing log queries and interactively analyzing their results. Even if a log query is used elsewhere in Azure Monitor, you'll typically write and test the query first using Log Analytics.

## Log Analytics at work

At the center of Log Analytics is the Log Analytics workspace, which is hosted in Azure. Log Analytics collects data in the workspace from connected sources by configuring data sources and adding solutions to your subscription. Data sources and solutions each create different record types, each with its own set of properties. But you can still analyze sources and solutions together in queries to the workspace.

When you build a query, you start by determining which tables have the data that you're looking for. Each data source and solution stores its data in dedicated tables in the Log Analytics workspace. Documentation for each data source and solution includes the name of the data type that it creates and a description of each of its properties. Many queries will only require data from a single table, but others may use various options to include data from multiple tables.

You use Kusto to build your queries and use role based access control to ensure your queries can only be run by those you authorize. Additionally, you can use machine learning algorithms for clustering and to aid in detecting anomalies in the data.

## Scenarios

You can use Log Analytics in various scenarios. Here are a few where queries may need to be used and Log Analytics can be helpful.

* **Alert rules**: Alert rules proactively identify issues from data in your workspace. Each alert rule is based on a log search that is automatically run at regular intervals. The results are inspected to determine if an alert should be created.
* **Dashboards**: You can pin the results of any query into an Azure dashboard that allow you to visualize log and metric data together and optionally share with other Azure users.
* **Views**: You can create visualizations of data to be included in user dashboards with View Designer. Log queries provide the data used by tiles and visualization parts in each view.
* **Export**: When you import log data from Azure Monitor into Excel or Power BI, you create a log query to define the data to export.
* **PowerShell**: You can run a PowerShell script from a command line or an Azure Automation runbook that uses `Get-AzOperationalInsightsSearchResults` to retrieve log data from Azure Monitor. This cmdlet requires a query to determine the data to retrieve.
* **Azure Monitor Logs API**: The Azure Monitor Logs API allows any REST API client to retrieve log data from the workspace. The API request includes a query that is run against Azure Monitor to determine the data to retrieve.

## Visualizing Your Log Data

Log Analytics provides a query syntax to quickly retrieve and consolidate data in the repository. You can create and save Log Searches to directly analyze data in the portal, or have log searches run automatically to create an alert if the results of the query indicate an important condition.

To give a quick graphical view of the health of your overall environment, you can add visualizations for saved log searches to your dashboard. To analyze data outside of Log Analytics, you can export the data from the repository into tools such as Power BI or Excel. You can also use the Log Search API to build custom solutions.
