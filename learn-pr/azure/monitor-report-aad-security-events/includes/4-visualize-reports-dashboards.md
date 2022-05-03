You've used the tools and services in the Azure portal to gather log files about your network users and their activities. By using the collected audit and sign-in logs, you've built queries to gain insights into specific behaviors. These queries also can alert your team when suspicious user behavior occurs. This process has gone a long way toward meeting your team's security concerns.

Your team members are pleased. They'll be alerted when suspicious behaviors are identified, and they know that those alerts are tightly focused. Now they want to know whether Azure can provide real-time views of the security of their estate. They can then identify and respond to new threats.

Azure provides several visualization tools and reports that can meet the team's needs. You want to understand how to put these tools and reports into practice.

In this unit, you learn how to enhance and customize the underlying report queries and save them to a security dashboard. Then, you learn how to export these reports to Excel and Power BI Desktop.

## Create a security dashboard

Dashboards provide an organized view of the resources in your Azure cloud instance. From a dashboard, you can organize and arrange your day-to-day and recurring operational tasks and activities. You can build each dashboard around a specific activity, such as a task or a project.

To create a new dashboard for your security team, in the Azure portal menu, select **Dashboard**. Begin with a blank dashboard.

:::image type="content" source="../media/dashboard-blank-concept.png" alt-text="Screenshot that shows how to create a blank dashboard.":::

You'll enter a name for the dashboard a name, and you can add common components to the dashboard from the tile gallery. Even though the dashboard contains no data, you have the option to share the dashboard by publishing it for other network users.

:::image type="content" source="../media/dashboard-tiles-concept.png" alt-text="Screenshot that shows how to add tiles to a dashboard.":::

With a dashboard created, you need to add a query report to the dashboard. It might seem as though you can add audit or sign-in log data directly to the dashboard, but you can't yet. To build a query to add to the dashboard, you need to return to your Log Analytics workspace.

## Build a dashboard query

In your Log Analytics workspace, create a new query. Let's suppose you want to identify the most common user event for the last week. You would use a query like this one:

```kusto
AuditLogs
| where TimeGenerated >= ago(7d)
| summarize auditCount = count() by OperationName
| sort by auditCount desc
```

To begin, you go to your logs in your Log Analytics workspace. In the left menu under **General**, select **Logs**.

You want to know the most common user event for last week, so in your query editor, paste the query. Run the query to check for data.

:::image type="content" source="../media/query-new-concept.png" alt-text="Screenshot that shows how to create a new logs query.":::

When you're satisfied that you have the data you want, select **Done editing**, and then save the query with a name, subscription, resource group, and location.

## Pin query results to a dashboard

You can pin query results to the dashboard so that they're easy to find and share:

To pin query results to a dashboard, in the menu bar, select the **Pin** icon. Select the options you want to use, select a dashboard, and then select **Pin**.

:::image type="content" source="../media/query-pin-concept.png" alt-text="Screenshot that shows how to pin a logs query to a dashboard.":::

You can go to the dashboard to view your analytics results.

:::image type="content" source="../media/dashboard-view-concept.png" alt-text="Screenshot that shows selecting a dashboard to view.":::

## Export a report from a dashboard

When you're satisfied with the report, you can export it to Excel or the Power BI Desktop application.

In a report tile on a dashboard, select the **Open in Logs blade** icon:

:::image type="content" source="../media/report-open-logs-view.png" alt-text="Screenshot that shows the Open in Logs blade icon.":::

Run the log query, and then select the **Export** dropdown. Select an export option:

- **Export to CSV - all columns**
- **Export to CSV - displayed columns**
- **Export to Power BI (M query)**
- **Open in Excel**

### Export a report to Power BI (M query)

You can use Power BI to build complex and dynamic reports and dashboards from the data you supply it. In your Log Analytics workspace, export the report to Power BI by selecting the **Export** dropdown, and then selecting the **Export to Power BI (M query)** option. This sequence doesn't export the data directly, but it builds a complex M query. The Power BI desktop application uses the M query to make a connection to your Azure instance and pull active data from it.

Select **Save** to save the report text file to your local computer. Then, open the saved file in a text editor. In a moment, you'll copy the content to Power BI. In Power BI Desktop, select **Get Data**, and then select **Blank Query**.

In the Power BI query editor, select the **View** menu option, and then select **Advanced Editor**. Then, copy the content from the saved Power BI (M query) file and paste the **M Language script** into the editor pane.

Because this query originated in Azure, you'll need to use the **Organizational account** option and your Azure authentication credentials to give Power BI access to your Azure instance.

Then, select a reporting chart style to represent your data in the way you want. The following screenshot shows an example:

:::image type="content" source="../media/power-bi-analytics-visualize.png" alt-text="Screenshot of a report in the Power BI query editor pane.":::

After you've designed the report as you want it, you can select **Publish to Web** to publish it to your Azure Power BI cloud workspace. From there, you can display the report on other webpages as well.
