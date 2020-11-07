Azure Sentinel Logs provides you with the access of the various logs collected from the security connectors. The logs are collected from the connectors that are integrated with Azure Sentinel and they are stored into Azure Log Analytic Workspace.
The Log Analytic Workspace is a repository that store data and configuration information.
You can create queries that can filter important information and can be used in creation of the analytics rules and threat hunting.
For example, Contoso can use Azure Sentinel Logs, to search the data from multiple sources, aggregate large data sets and perform complex operations to locate potential security threats and vulnerabilities.

## Exploring the Azure Sentinel Logs page

You search for the logs in Azure Sentinel Logs page. You can access **Logs** page in Azure Sentinel from the navigation pane on the left.

The **Logs** page has four main parts:

- The page header contains links to the **Queries**, **Query explorer**, Settings and help section.
- Tables pane is presenting collected data from the logs in tables, each composed with multiple columns.
- The query pane is where you write your own query expressions.
- The query result pane shows the results of the queries

![Screenshot that present default Logs page](../media/02-LOGS.PNG)

### Queries

If you select the **Queries** link in the page header you will open a new window where you can select from some of the predefined sample queries.
From the **Queries** drop-down menu you can filter these queries based on:

- Category
- Resource Type
- Solution
- Topic

You can start predefined queries by selecting **Run** which will redirect you in the query pane, where you can observe the query structure and the results.
Contoso is concerned about unauthorized uses, and they can select the predefined query **Unauthorized Users**, as shown in the following screenshot:

![Screenshot that present Unauthorized users](../media/02-Unauthorized-Users.PNG)

### Query Explorer

The Query Explorer link in the page header help you to access your previously saved queries. You can also access some **Solution Queries** that basically filter most common queries that you can use to filter the data. From the **Solution Queries** you can either run the query or organize the query in the favorites section by clicking on the star symbol.

### Table pane

The **Tables** pane is grouping logs from different solutions into tables. You can expand the solution group and see all the logs that are collected. You can select one of the logs from the tables pane, and you can either preview the data, or add that log in Favorites section.

The following screenshot present the logs collected in Azure Sentinel solution.

![Screenshot presenting Tables view](../media/02-Logs-Azure-Sentinel.PNG)

### Query pane

You can use the Query pane to write queries that will retrieve data based on the expression that you provide. The query pane can help you in writing a right query by providing a suggestion and automatic filling of the expected elements of the query.
You can use rich capabilities of Kusto query language (KQL) to write a query that retrieve data from the logs. One example that identify deleted Virtual machines is listed in the following query code:

```kusto
AzureActivity
| where OperationName == 'Delete Virtual Machine'
| where ActivityStatus == 'Accepted'
| extend AccountCustomEntity = Caller
| extend IPCustomEntity = CallerIpAddress
```

### Header toolbar

The header toolbar provide additional interaction with the query, as shown in the following screenshot:

![Screenshot presenting Tables view](../media/02-Header-Toolbar.PNG)

you can save the query from the query pane by selecting **Save**. That will open a new window on the right side, where you are prompted to enter the name of the saved query and category. Saved queries appears in query explorer.
The **Time Range** field lets you change the time in the past from when the results of the query will be shown.
You can also create a link for the query and share with other colleagues by selecting **Copy link to query.** You can also copy the query text.
From the header toolbar in the query pane you can create either a **New Azure Monitor alert** , or **New Azure Sentinel alert.** If you select to create a new Azure Sentinel alert, you will be directed to the steps of creation of analytics rule.
You can export the query into one of the following formats:

- **Export to CSV**. This will export all the columns both visible and hidden into a CSV file, that you can open for example with Microsoft Excel.
- **Export to CSV-Displayed Columns**. This will only export those columns that are shown in the results windows of the query
- **Export to Pover BI (M query)**. This will create and download a file **PowerBIQuery.txt**, that you can open with MIcrosoft PowerBI application.

You can pin the results of the query into a private or shared dashbord, so you can quickly examine the results of the query.
Format query, in the header toolbar can be used to make the query more readable.

> [!Note]

> You can export or pin the query, only if the query expression generate data in the query result section.

### Query results

In the **Query results** pane, you can observe the results of the query. You can also present the results using chart or hide and show additional columns to filter the results of the query.
