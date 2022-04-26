So far, you've learned about the various user-based logging methods provided by Azure. You've learned how to route the audit and sign-in data to an Azure Log Analytics workspace. Also, you've seen how to use this data to create various views and reports for your security team.

In this exercise, you implement a dashboard for the security team, so they can see the potential of Azure Monitor logs and alerting to help them better understand user behavior. You'll do these tasks:

- Create a security dashboard
- Pin a workbook to a dashboard
- Build a query for the dashboard
- Pin query results to a dashboard
- Edit or customize an item in a dashboard
- Export a report to Excel

> [!NOTE]
> This exercise is optional. If you don't have an Azure account, you can read through the following instructions to understand how to use Log Analytics and dashboards.
>
> If you want to complete this exercise but you don't have an Azure subscription or prefer not to use your own account, you can create a [free account](https://azure.microsoft.com/free/?azure-portal=true) before you begin.

## Create a security dashboard

1. In the Azure portal, search for **Dashboard**.

1. Select **New dashboard** > **Blank dashboard**.

    :::image type="content" source="../media/dashboard-blank.png" alt-text="Screenshot that shows how to create a new dashboard.":::

1. At the prompt, name the dashboard **SecurityDashboard**, and then select **Done**. For now, leave the dashboard blank. In the next few steps, you'll be adding a report query to the dashboard.

    :::image type="content" source="../media/dashboard-save.png" alt-text="Screenshot that shows how to save a dashboard.":::

1. Select **Share**.

    :::image type="content" source="../media/dashboard-share.png" alt-text="Screenshot of the Share button.":::

1. In the **Sharing + access control** pane, confirm that the information is correct:  

   - The dashboard name is **SecurityDashboard**.
   - For the subscription name, keep the default value.
   - The **Publish to the 'dashboards' resource group** check box is cleared.
  
1. Select **Publish** to make the empty dashboard available.

    :::image type="content" source="../media/dashboard-share-access.png" alt-text="Screenshot of the Sharing + access control pane.":::

## Pin a workbook to a dashboard

Next, pin a workbook to a dashboard so that it's easy to find or to share it with other users:

1. To pin a workbook to a dashboard, in the left menu under **General**, select **Workbooks**. Open the workbook you want to pin.

1. In the menu bar, select the **Pin** icon.

1. In the **Pin to dashboard** pane, select the options you want to use. For this exercise, select **SecurityDashboard**, the dashboard you created.

    :::image type="content" source="../media/workbook-pin.png" alt-text="Screenshot of pinning workbook.":::

1. Select **Pin**.

1. Go to the dashboard to view your analytics results.

   :::image type="content" source="../media/dashboard-view.png" alt-text="Screenshot of the updated dashboard with the edited name and the Edit button highlighted.":::

## Build a query for the dashboard

To build a query for a dashboard:

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

    :::image type="content" source="../media/logs-search.png" alt-text="Screenshot of searching logs.":::

1. When you're satisfied that you have the data you want, select **Done editing**, and then select the **Save** icon in the menu bar.

1. Enter a descriptive name, like *Common User Events Last 7 days*.  

1. Select or enter the subscription, resource group, and location you want to use.

1. Select **Save**.

## Pin query results to a dashboard

Next, pin query results to the dashboard you created:

1. In your Log Analytics workspace, under **General**, select **Logs**.

1. In the **Queries** dialog, search for the query you created, and then select **Run**.

1. To pin query results to a dashboard, in the menu bar, select the **Pin** icon.

1. In the **Pin to dashboard** pane, select the options you want to use. For example, select **SecurityDashboard**, which you created earlier.

1. Select **Pin**.

    :::image type="content" source="../media/query-pin.png" alt-text="Screenshot of pinning a query.":::

1. Go to the dashboard to view your analytics results.

## Edit or customize an item in a dashboard

To change the title of an item in a dashboard or change the dashboard view:

1. In the Azure portal menu, select **Dashboard**.

   :::image type="content" source="../media/dashboard-menu.png" alt-text="Screenshot that shows selecting Dashboard in the portal menu.":::

1. If you have multiple dashboards, in the dashboard dropdown menu, select **SecurityDashboard**.

1. On a tile, select the horizontal ellipsis, and then select **Configure tile settings** (gear icon) in the item tile.

1. In the **Configure tile settings** pane, change the title to **Top User Events past week**.

1. Select **Apply**.

    :::image type="content" source="../media/dashboard-edit.png" alt-text="Screenshot of editing a report on the dashboard.":::

1. To change how an item appears in the dashboard, select the horizontal ellipsis, and then select **Customize** (pencil icon). Select from the options to change the tile appearance on the dashboard.

   :::image type="content" source="../media/dashboard-customize.png" alt-text="Screenshot of customizing a report on the dashboard.":::

1. Select **Save**.

## Export a report to Excel

Finally, export the report to Excel:

1. In the report tile on the dashboard, select the **Open in Logs blade** icon:

   :::image type="content" source="../media/report-open-logs-view.png" alt-text="Screenshot that shows the Open in Logs blade icon.":::

1. In the **Logs** pane, select **Run**, and then select **Export** > **Open in Excel**.

   :::image type="content" source="../media/export-excel.png" alt-text="Screenshot of the options in the Export dropdown.":::

1. Open the downloaded file, and then save the file to your computer.
