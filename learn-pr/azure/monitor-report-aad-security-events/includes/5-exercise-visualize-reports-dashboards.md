So far, you've learned about the various user-based logging methods provided by Azure. You've learned how to route the audit and sign-in data to an Azure Log Analytics workspace. Also, you've seen how to use this data to create various views and reports for your security team.

You want to implement a dashboard for the security team so they can see the potential of Azure Monitor logs and alerting to help them better understand user behavior.

In this exercise, you create a Log Analytics workspace in your Azure sandbox by using the Azure portal. You then direct the audit and sign-in log files to your workspace. Next, you download and install the prebuilt user sign-in and audit log views from GitHub. Finally, you create a dashboard for your security team that displays reports that are built into it from the workspace.

> [!NOTE]
> This exercise is optional. If you don't have an Azure account, you can read through the following instructions to understand how to use Log Analytics and dashboards.
>
> If you want to complete this exercise but you don't have an Azure subscription or prefer not to use your own account, you can create a [free account](https://azure.microsoft.com/free/?azure-portal=true) before you begin.

## Create a Log Analytics workspace

1. Go to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true).

1. Select **Create resource**. In the **Search** box, enter **log analytics**.
  
   :::image type="content" source="../media/5-log-analytics.png" alt-text="Screenshot of Log Analytics search results.":::

1. In the results list, select **Log Analytics Workspace**, and then select **Create** to create a new Log Analytics workspace. Select or enter the following details:

   1. Under **Project details**, select the subscription to use for your workspace. Select an existing resource group or select **Create new** to create a new resource group.

   1. Under **Instance details**, enter a name for the workspace. For this exercise, enter **ContosoWorkspace**, and append it with several characters to create a unique workspace name. For **Region**, Select the location nearest you.

   :::image type="content" source="../media/5-log-analytics-workspace-add.png" alt-text="Screenshot that shows new Log Analytics workspace options.":::

1. Optionally create tags to use for the workspace, then select **Next : Review + Create >**.

1. Check the settings. The pricing tier is automatically set to **Pay-as-you-go** and is based on a per-gigabyte (GB) cost.

1. Select **Create** to create the workspace.

You've now created a Log Analytics workspace, where you can gather and do analytics on your user audit and sign-in data.

## Send log files to a Log Analytics workspace

To stream the audit and sign-in logs to your Log Analytics workspace:

1. In the Azure portal, go to your Azure AD instance.

1. Select the **Monitoring** tab, and then select **Diagnostics settings**.

1. Select **Add diagnostic setting**.

   :::image type="content" source="../media/5-add-diagnostic-setting.png" alt-text="Screenshot that shows adding a new diagnostic setting.":::

1. In the **Diagnostics setting** pane:

   1. In **Diagnostic setting name**, enter a name for the setting.
   1. In **Logs**, for **Categories**, select **AuditLogs** and **SignInLogs**.  
   1. In **Destination details**, select **Send to Log Analytics workspace**. Select or enter the subscription and Log Analytics workspace to use. For this exercise, select the Log Analytics workspace that you created, **ContosoWorkspace** appended with unique characters.

   :::image type="content" source="../media/5-create-diagnostic-setting.png" alt-text="Screenshot that shows the details of a new diagnostic setting.":::

1. Select **Save**.  

## Use existing workbooks or templates in your Log Analytics workspace

You can use existing workbooks to display common views of your audit and sign-in data. If you don't find a workbook that does what you need, you can begin with a template and modify the query.

1. In the Azure portal, go to your Log Analytics workspace.

1. In the left menu under **General**, select **Workbooks**.

1. In the workbooks gallery, you can select a tile that contains a view you'd like to use. You also can start with a default template or an empty workbook. Select the **Default template** tile.

   :::image type="content" source="../media/5-workbooks-gallery-tiles.png" alt-text="Screenshot that shows the details of a new diagnostic setting.":::

1. For this exercise, you want to know the most common user event for last week. In your query editor, paste the following query:

    ```kusto
    AuditLogs
    | where TimeGenerated >= ago(7d)
    | summarize auditCount = count() by OperationName
    | sort by auditCount desc
    ```

1. In the menu bar, select **Run** to ensure that the query returns data.

   :::image type="content" source="../media/5-new-workbooks-query.png" alt-text="Screenshot that shows the details of a new diagnostic setting.":::

1. When you're satisfied that you have the data you want, select **Done editing**, and then select the **Save** icon in the menu bar.

   ![Screenshot of the "Save" and "Pin to dashboard" buttons for a Log Analytics query.](../media/4-save-query.png)

1. Enter a descriptive name, like *Common User Events Last 7 days*.  

1. Select or enter the subscription, resource group, and location you want to use.

1. Select **Save**.

1. To view the workbook, in the left menu under **General**, select **Workbooks**. Look for the workbook tile under **Recently modified workbooks**.

    :::image type="content" source="../media/5-recently-modified-workbooks.png" alt-text="Screenshot that shows how to find modified workbooks.":::

## Create a security dashboard

1. In the Azure portal, search for **Dashboard**.

1. Select **New dashboard** > **Blank dashboard**.

    :::image type="content" source="../media/5-dashboard-blank.png" alt-text="Screenshot that shows how to create a new dashboard.":::

1. At the prompt, name the dashboard **SecurityDashboard**, and then select **Done**. For now, leave the dashboard blank. In the next few steps, you'll be adding a report query to the dashboard.

    :::image type="content" source="../media/5-dashboard-save.png" alt-text="Screenshot that shows how to save a dashboard.":::

1. Select **Share**.

    :::image type="content" source="../media/5-dashboard-share.png" alt-text="Screenshot of the Share button.":::

1. In the **Sharing + access control** pane, confirm that the information is correct:  

   - The dashboard name is **SecurityDashboard**.
   - For the subscription name, keep the default value.
   - The **Publish to the 'dashboards' resource group** check box is cleared.
   
1. Select **Publish** to make the empty dashboard available.

    :::image type="content" source="../media/5-dashboard-share.png" alt-text="Screenshot of the Sharing + access control pane.":::

## Pin a workbook to a dashboard

You can pin a workbook to a dashboard so that it's easy to find or to share it with other users.

1. To pin a workbook to a dashboard, in the left menu under **General**, select **Workbooks**. Open the workbook you want to pin.

1. In the menu bar, select the **Pin** icon.

1. In the **Pin to dashboard** pane, select the options you want to use. For this exercise, select **SecurityDashboard**, the dashboard you created.

    :::image type="content" source="../media/5-pin-workbook.png" alt-text="Screenshot of pinning workbook.":::

1. Select **Pin**.

1. Go to the dashboard to view your analytics results.

   ![Screenshot of the updated dashboard with the edited name and the Edit button highlighted.](../media/5-view-dashboard.png)

To change the title of the report in the dashboard, do the following:

1. Select **Edit** (pencil icon) in the report tile.

1. Select the title, and change it to **Top User Events past seven days**.

1. Remove the subtitle, which you don't need for this report.

    :::image type="content" source="../media/5-query-rename.png" alt-text="Screenshot of renaming query.":::

You can use them to display common views of your audit and sign-in data.

In the next section, you set up a dashboard that your security team can begin to use.

## Build a query for the dashboard

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

    :::image type="content" source="../media/5-logs-search.png" alt-text="Screenshot of searching logs.":::

1. When you're satisfied that you have the data you want, select **Done editing**, and then select the **Save** icon in the menu bar.

1. Enter a descriptive name, like *Common User Events Last 7 days*.  

1. Select or enter the subscription, resource group, and location you want to use.

1. Select **Save**.

## Pin query results to a dashboard

You can pin query results to a dashboard so that they're easy to find or to share them with other users.

1. In your Log Analytics workspace, under **General**, select **Logs**.

1. In the **Queries** dialog, search for the query you created, and then select **Run**.

1. To pin query results to a dashboard, in the menu bar, select the **Pin** icon.

1. In the **Pin to dashboard** pane, select the options you want to use. For example, select **SecurityDashboard**, which you created earlier.

1. Select **Pin**.

    :::image type="content" source="../media/5-pin-query.png" alt-text="Screenshot of pinning a query.":::

1. Go to the dashboard to view your analytics results.

## Edit or customize an item in a dashboard

To change the title of an item in a dashboard or change the dashboard view:

1. Select **Configure tile settings** (gear icon) in the item tile.

1. In the **Configure tile settings** pane, change the title to **Top User Events past week**.

1. Select **Apply**.

    :::image type="content" source="../media/5-pin-query.png" alt-text="Screenshot of pinning a query.":::

1. To change how an item appears in the dashboard, select **Customize** (pencil icon)), and then select from the options.

1. Select **Save**.

    :::image type="content" source="../media/5-customize-dashboard.png" alt-text="Screenshot of pinning a query.":::

You've now created a dashboard with a query report embedded in it.
