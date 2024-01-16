In this exercise, you create a Log Analytics workspace in the Azure portal. You then direct the audit and sign-in log files to your Log Analytics workspace. Finally, you use a workbook template to create a workbook that holds a query report.

In this exercise, you'll:

- Create a Log Analytics workspace.
- Send log files to your Log Analytics workspace.
- Use a workbook template to hold a query report.
- View your saved workbook.

> [!NOTE]
> This exercise is optional. If you don't have an Azure account, you can read through the following instructions to understand how to use Log Analytics and workbooks.
>
> If you want to complete this exercise but you don't have an Azure subscription or prefer not to use your own account, you can create a [free account](https://azure.microsoft.com/free/?azure-portal=true) before you begin.

## Create a Log Analytics workspace

1. In the [Azure portal](https://portal.azure.com?azure-portal=true), select **Create a resource**.

1. In the **Search** box, enter **log analytics**.
  
   :::image type="content" source="../media/log-analytics-search.png" alt-text="Screenshot of Log Analytics search results.":::

1. In the results list, select **Log Analytics Workspace**, and then select **Create**. Select or enter the following details:

   1. Under **Project details**, select the subscription to use for your workspace. Select an existing resource group or select **Create new** to create a new resource group.

   1. Under **Instance details**, enter a name for the workspace. For this exercise, enter **ContosoWorkspace** and append the name with several characters to create a unique workspace name. For **Region**, select the location nearest you.

   :::image type="content" source="../media/log-analytics-workspace-add.png" alt-text="Screenshot that shows new Log Analytics workspace options.":::

1. Select **Next : Review + Create >**, and then check the settings. The pricing tier is automatically set to **Pay-as-you-go** and is based on a per-gigabyte (GB) cost.

1. Select **Create**.

## Send logs to your Log Analytics workspace

To stream the audit and sign-in logs to your Log Analytics workspace:

1. In the Azure portal, go to your Microsoft Entra instance.

1. In the left menu under **Monitoring**, select **Diagnostic settings**, and then select **Add diagnostic setting**.

   :::image type="content" source="../media/diagnostic-setting-add.png" alt-text="Screenshot that shows adding a new diagnostic setting.":::

1. In the **Diagnostic setting** pane:

   1. In **Diagnostic setting name**, enter a name for the setting, like *SendToLogAnalytics*.
   1. Under **Logs** > **Categories**, select **AuditLogs** and **SignInLogs**.  
   1. Under **Destination details**, select **Send to Log Analytics workspace**. Select or enter the subscription and Log Analytics workspace to use. For this exercise, select the Log Analytics workspace you created, **ContosoWorkspace** appended with unique characters.

   :::image type="content" source="../media/diagnostic-setting-create.png" alt-text="Screenshot that shows the details of a new diagnostic setting.":::

1. Select **Save**.  

## Use a workbook template to hold a query report

Next, begin with a workbook template to create a workbook that will hold a query report:

1. In the Azure portal, go to your Log Analytics workspace.

1. In the left menu under **General**, select **Workbooks**.

1. Select the **Default Template** tile.

   :::image type="content" source="../media/workbooks-gallery-tiles.png" alt-text="Screenshot that shows a default workbooks template.":::

1. For this exercise, you want to know the most common user event for the past week. In your query editor, paste the following query:

    ```kusto
    AuditLogs
    | where TimeGenerated >= ago(7d)
    | summarize auditCount = count() by OperationName
    | sort by auditCount desc
    ```

1. In the menu bar, select **Run Query**, and then select **Done editing**:

   :::image type="content" source="../media/workbooks-new-workbook.png" alt-text="Screenshot that shows adding a query to a workbooks template and selecting run.":::

1. In the menu bar, select **Save**.

   :::image type="content" source="../media/query-save.png" alt-text="Screenshot that shows the Save menu option for a Log Analytics query.":::

1. Enter a descriptive name, like *Common User Events Last 7 days*.  

1. Select or enter the subscription, resource group, and location you want to use. Select **Save**.

   :::image type="content" source="../media/query-save-details.png" alt-text="Screenshot that shows details and the Save button for a Log Analytics query.":::

## View a saved workbook

To view the workbook you saved, still in your Log Analytics workspace, in the left menu under **General**, select **Workbooks**. Look for the workbook tile under **Recently modified workbooks**.

   :::image type="content" source="../media/workbooks-recently-modified.png" alt-text="Screenshot that shows how to find modified workbooks.":::
