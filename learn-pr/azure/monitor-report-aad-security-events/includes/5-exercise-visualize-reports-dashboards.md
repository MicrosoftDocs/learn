In this exercise, you set up a dashboard for the security team, so they can see the potential of Azure logs and alerts in monitoring user behavior. You'll do these tasks:

- Create a security dashboard.
- Build a query for the dashboard.
- Pin query results to your dashboard.
- Edit or customize an item in your dashboard.
- Export a report to Excel.

> [!NOTE]
> This exercise is optional. If you don't have an Azure account, you can read through the following instructions to understand how to use your Log Analytics workspace and dashboards.
>
> If you want to complete this exercise but you don't have an Azure subscription or prefer not to use your own account, you can create a [free account](https://azure.microsoft.com/pricing/purchase-options/azure-account?cid=msft_learn) before you begin.

## Create a security dashboard

1. In the Azure portal, search for **Dashboard**.

1. Select **New dashboard** > **Blank dashboard**.

    :::image type="content" source="../media/dashboard-blank.png" alt-text="Screenshot that shows how to create a new dashboard.":::

1. Name the dashboard **SecurityDashboard**, and then select **Save**. For now, leave the dashboard blank. In the next few steps, you'll add a report query to the dashboard.

    :::image type="content" source="../media/dashboard-save.png" alt-text="Screenshot that shows how to save a dashboard.":::

1. Select **Share**.

    :::image type="content" source="../media/dashboard-share.png" alt-text="Screenshot of the Share button.":::

1. In the **Sharing + access control** pane, confirm that the information is correct:  

   - The dashboard name is **SecurityDashboard**.
   - For the subscription name, keep the default value.
   - The **Publish to the 'dashboards' resource group** check box is cleared.
  
1. Select **Publish** to make the empty dashboard available.

    :::image type="content" source="../media/dashboard-share-access.png" alt-text="Screenshot of the Sharing and access control pane.":::

## Build a query for the dashboard

To build a query for a dashboard:

1. In the Azure portal, select **All resources**.

1. Select the Log Analytics workspace you created earlier.

1. Under **General**, select **Logs**.

1. For this exercise, you want to know the most common user event for last week. In your query editor, paste the following query:

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

## Pin query results to your dashboard

Next, pin query results to the dashboard you created:

1. In your Log Analytics workspace, under **General**, select **Logs**.

1. In the **Queries** dialog, search for the query you created, and then select **Run**.

1. To pin query results to a dashboard, in the menu bar, select the **Pin** icon.

1. In the **Pin to dashboard** pane, select the options you want to use. For example, select **SecurityDashboard**, which you created earlier.

1. Select **Pin**.

    :::image type="content" source="../media/query-pin.png" alt-text="Screenshot of pinning a query.":::

1. Go to the dashboard to view your analytics results.

## Edit or customize a report in your dashboard

To change the title of an item in a dashboard or change the dashboard view:

1. In the Azure portal menu, select **Dashboard**.

   :::image type="content" source="../media/dashboard-menu.png" alt-text="Screenshot that shows selecting Dashboard in the portal menu.":::

1. If you have multiple dashboards, in the dashboard dropdown menu, select **SecurityDashboard**.

1. On a tile, select the ellipsis, and then select **Configure tile settings** (the gear icon) in the item tile.

1. In the **Configure tile settings** pane, change the title to **Top User Events past week**.

1. Select **Apply**.

    :::image type="content" source="../media/dashboard-edit.png" alt-text="Screenshot of editing a report on the dashboard.":::

1. To change how an item appears in the dashboard, select the ellipsis, and then select **Customize** (the pencil icon). Select from the options to change the tile appearance on the dashboard, and then select **Done customizing**.

   :::image type="content" source="../media/dashboard-customize.png" alt-text="Screenshot of customizing a report on the dashboard.":::

1. Select **Save**.

## Export a report to Excel

Finally, export the report to Excel:

1. In the report tile on the dashboard, select the **Open in Logs blade** icon:

   :::image type="content" source="../media/report-open-logs-view.png" alt-text="Screenshot that shows the Open in Logs blade icon.":::

1. In the **Logs** pane, select **Run**, and then select **Export** > **Open in Excel**.

   :::image type="content" source="../media/export-excel.png" alt-text="Screenshot of the options in the Export dropdown.":::

1. Open the downloaded file, and then save the file to your computer.
