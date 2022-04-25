You've used the tools and services in the Azure portal to gather logging details about your users and their activities. With the collected audit and sign-in data, you've built queries to gain answers and insights into specific behaviors. These queries will also alert your team when there's suspicious user behavior. This process has gone a long way toward meeting your team's security concerns.

Your team members are pleased. They'll be alerted when suspicious behaviors are identified, and they know that those alerts are tightly focused. Now they want to know whether Azure can provide real-time views of the security of their estate. They can then identify and respond to new threats.

Azure provides several visualization tools and reports that can meet the team's needs. You want to understand how to put these tools and reports into practice.

In this unit, you learn how to enhance and customize the underlying report queries, and save them to a security dashboard. Finally, you learn how to export these reports to Excel and Power BI.

## Create a security dashboard

Dashboards provide an organized view of the resources in your Azure cloud instance. From a dashboard, you can organize and arrange your day-to-day and recurring operational tasks and activities. Each dashboard can be built around a specific activity, such as a task or a project.

To create a new dashboard for your security team, do the following:

1. In the Azure portal menu, select **Dashboard**.

1. Select **New dashboard** > **Blank dashboard**.

1. Enter a name for the dashboard a name.

1. Select **Add tiles**, and then select **Save**.

1. Even though the dashboard contains no data, you have the option to share the dashboard. Select the **Share** option, and then confirm that the sharing and access controls are correct. To share, select **Publish**.

Now that you've created a dashboard, you need to add a query report to it. It might seem as though you can add audit or sign-in log data directly to the dashboard, but you can't yet. To build a query to add to the dashboard, you need to return to the Log Analytics workspace you created earlier.

### Build a dashboard query

From the Log Analytics workspace, create a new query. Let's suppose you want to identify the most common user event for the last week. You would use a query like this one:

```kusto
AuditLogs
| where TimeGenerated >= ago(7d)
| summarize auditCount = count() by OperationName
| sort by auditCount desc
```

1. In the Azure portal, select **All resources**.

1. Select the Log Analytics workspace you created earlier.

1. Under **General**, select **Logs**.

1. For this exercise, you want to know the most common user event for last week. In your query editor, paste the following query.

    ```kusto
    AuditLogs
    | where TimeGenerated >= ago(7d)
    | summarize auditCount = count() by OperationName
    | sort by auditCount desc
    ```

1. In the menu bar, select **Run** to ensure that the query returns data.

1. When you're satisfied that you have the data you want, select **Done editing**, and then select the **Save** icon in the menu bar.

    :::image type="content" source="../media/4-save-query.png" alt-text="Screenshot of the Save and Pin to dashboard buttons for a Log Analytics query.":::

1. Enter a descriptive name, like *Common User Events Last 7 days*.  

1. Select or enter the subscription, resource group, and location you want to use.

1. Select **Save**.

## Export reports

When you're satisfied with the report, you can export it to Excel or the Power BI Desktop application. In the log query view, select the **Export** dropdown, and then select one of these options:

- **Export to CSV - all columns**
- **Export to CSV - displayed columns**
- **Export to Power BI (M query)**
- **Open in Excel**

:::image type="content" source="../media/4-export-options.png" alt-text="Screenshot of the options in the Export dropdown.":::

### Export a report to Excel

When you export to Excel, you have two choices. You can export the whole report or selected columns. This action exports all the result set data for the query you've built. You can save the CSV file to your local computer.

### Export a report to Power BI (M query)

Power BI lets you build complex and dynamic reports and dashboards from the data you supply it. From your Log Analytics workspace, you export the report to Power BI by selecting the **Export** dropdown, and then selecting the **Export to Power BI (M query)** option. This sequence doesn't export the data directly, but it builds a complex M query. The Power BI desktop application uses the M query to make a connection to your Azure instance and pull active data from it.

Select **Save** to save the report text file to your local computer. Then, open the saved file in a text editor. In a moment, you'll copy the content to Power BI.

Open Power BI Desktop. Select **Get Data**, and then select **Blank Query**. The Power BI query editor appears.

Select the **View** menu option, and then select **Advanced Editor**. Then, opy the content from the saved Power BI (M query) file and paste the **M Language script** into the editor pane. Select **Done**.

Because this query originated in Azure, you'll need to use the **Organizational account** option, and your Azure authentication credentials to grant Power BI access to your Azure instance.

Now that you've created the link, you can select a reporting chart style to represent your data in the way you want.

:::image type="content" source="../media/power-bi-analytics-visualize.png" alt-text="Screenshot of a report in the Power BI query editor pane.":::

After you've designed the report as you want it, you can select **Publish to Web** to publish it to your Azure Power BI cloud workspace. From there, you can display the report on other webpages as well.
