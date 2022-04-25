In this exercise, you create a Log Analytics workspace in your Azure sandbox by using the Azure portal. You then direct the audit and sign-in log files to your workspace. Next, you download and install the prebuilt user sign-in and audit log views from GitHub.

> [!NOTE]
> This exercise is optional. If you don't have an Azure account, you can read through the following instructions to understand how to use Log Analytics and dashboards.
>
> If you want to complete this exercise but you don't have an Azure subscription or prefer not to use your own account, you can create a [free account](https://azure.microsoft.com/free/?azure-portal=true) before you begin.

## Create a Log Analytics workspace

1. Go to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true).

1. Select **Create resource**. In the **Search** box, enter **log analytics**.
  
   :::image type="content" source="../media/log-analytics-search.png" alt-text="Screenshot of Log Analytics search results.":::

1. In the results list, select **Log Analytics Workspace**, and then select **Create** to create a new Log Analytics workspace. Select or enter the following details:

   1. Under **Project details**, select the subscription to use for your workspace. Select an existing resource group or select **Create new** to create a new resource group.

   1. Under **Instance details**, enter a name for the workspace. For this exercise, enter **ContosoWorkspace**, and append it with several characters to create a unique workspace name. For **Region**, Select the location nearest you.

   :::image type="content" source="../media/log-analytics-workspace-add.png" alt-text="Screenshot that shows new Log Analytics workspace options.":::

1. Optionally create tags to use for the workspace, then select **Next : Review + Create >**.

1. Check the settings. The pricing tier is automatically set to **Pay-as-you-go** and is based on a per-gigabyte (GB) cost.

1. Select **Create** to create the workspace.

You've now created a Log Analytics workspace, where you can gather and do analytics on your user audit and sign-in data.

## Send log files to a Log Analytics workspace

To stream the audit and sign-in logs to your Log Analytics workspace:

1. In the Azure portal, go to your Azure AD instance.

1. Select the **Monitoring** tab, and then select **Diagnostic settings**.

1. Select **Add diagnostic setting**.

   :::image type="content" source="../media/diagnostic-setting-add.png" alt-text="Screenshot that shows adding a new diagnostic setting.":::

1. In the **Diagnostics setting** pane:

   1. In **Diagnostic setting name**, enter a name for the setting.
   1. In **Logs**, for **Categories**, select **AuditLogs** and **SignInLogs**.  
   1. In **Destination details**, select **Send to Log Analytics workspace**. Select or enter the subscription and Log Analytics workspace to use. For this exercise, select the Log Analytics workspace that you created, **ContosoWorkspace** appended with unique characters.

   :::image type="content" source="../media/diagnostic-setting-create.png" alt-text="Screenshot that shows the details of a new diagnostic setting.":::

1. Select **Save**.  

## Use existing workbooks or templates in your Log Analytics workspace

You can use existing workbooks to display common views of your audit and sign-in data. If you don't find a workbook that does what you need, you can begin with a template and modify the query.

1. In the Azure portal, go to your Log Analytics workspace.

1. In the left menu under **General**, select **Workbooks**.

1. Select the **Default template** tile.

   :::image type="content" source="../media/workbooks-gallery-tiles.png" alt-text="Screenshot that shows a default workbooks template.":::

1. For this exercise, you want to know the most common user event for last week. In your query editor, paste the following query:

    ```kusto
    AuditLogs
    | where TimeGenerated >= ago(7d)
    | summarize auditCount = count() by OperationName
    | sort by auditCount desc
    ```

1. In the menu bar, select **Run**.

   :::image type="content" source="../media/workbooks-new-query.png" alt-text="Screenshot that shows adding a query to a workbooks template and selecting run.":::

1. When you're satisfied that you have the data you want, select **Done editing**, and then select the **Save** icon in the menu bar.

      :::image type="content" source="../media/query-save.png" alt-text="Screenshot that shows the Save button for a Log Analytics query.":::

1. Enter a descriptive name, like *Common User Events Last 7 days*.  

1. Select or enter the subscription, resource group, and location you want to use.

1. Select **Save**.

1. To view the workbook, in the left menu under **General**, select **Workbooks**. Look for the workbook tile under **Recently modified workbooks**.

    :::image type="content" source="../media/workbooks-recently-modified.png" alt-text="Screenshot that shows how to find modified workbooks.":::

