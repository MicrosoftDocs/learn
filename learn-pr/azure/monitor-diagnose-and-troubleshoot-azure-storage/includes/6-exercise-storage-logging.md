In this exercise, you create a Log Analytics workspace, create a diagnostic setting that routes logs to that workspace, and then use a query to show activity in your storage account.

## Create a Log Analytics workspace

1. In the Azure portal, search for and select **Log Analytics workspaces**.

1. Select **+ Create**, and then provide values for the following options:

   - Select **Concierge Subscription** from the subscription drop-down list.

   - For **Resource Group**, select the **<rgn>[Sandbox resource group]</rgn>** resource group.

   - Provide a name for the new **Log Analytics workspace**, such as *DefaultLAWorkspace*. This name must be unique per resource group.

   - Select an available **Region**.  

1. Select **Review + Create** to review the settings, then select  **Create** to create the workspace.

## Create a diagnostic setting

1. On the Azure portal menu, select **Storage accounts**.

1. On the **Storage accounts** page, select the name of the storage account that you created in the previous exercise.

1. In the menu pane, under **Monitoring**, select **Diagnostic settings**.

1. In the **Diagnostic settings** pane, select **blob**, then select **+ Add diagnostic setting**.

1. In the **Diagnostic setting name** box, provide a name for the setting.

1. In the **Categories** section, check the box for **StorageRead**. In the **Destination details** section, check the box next to **Send to Log Analytics workspace**.

1. In the **Log Analytics workspace** drop-down list, select the Log Analytics workspace that you created in the previous section.

1. Select **Save**.

## Download a blob to generate activity

1. Go back to your storage account. In the **Data storage** section, select **Containers**.

1. In the **Containers** panel, select the container that you created in the last exercise.

1. Select a blob that you added, select **...**, and select **Download**.

## View logged activity by using a Log Analytics query

1. Go back to your storage account. In the menu pane, under **Monitoring**, select **Logs**.

   The **Queries hub** window appears. This window provides you with several queries that you can run. You can also customize any of these queries by hovering over the query, and then selecting the **Load to Editor** that appears for the query. For this exercise, we create a query from scratch.

1. Close the **Queries** window by selecting **X** in the corner of the window.

   The query editor appears.

1. In the top-right corner of the Query menu, select **KQL mode** in the drop-down.

1. In the query editor, add the following query.

    ```kusto
    StorageBlobLogs
    | where OperationName == "GetBlobServiceProperties" and Category == "StorageRead"
    | project TimeGenerated, AuthenticationType, OperationName, Category, Uri
    ```

    This query shows read operations that occurred during this exercise. It includes various fields, such as how the request was authenticated, the name of the operation, The category of the operation, and the URI of the resource. A result should appear for the operation that you just performed.

1. Select **Run**.
