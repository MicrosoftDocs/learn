In this exercise, you'll create a Log Analytics workspace, create a diagnostic setting that routes logs to that workspace, and then use a query to show activity in your storage account.

## Create a Log Analytics workspace

1. In the Azure portal, search for and select **Log Analytics workspaces**.

2. Select **+ Create**, and then provide values for the following options:

   - Select a **Subscription** from the subscription drop-down list if the default selected is not appropriate.

   - For **Resource Group**, select the **<rgn>[Sandbox resource group]</rgn>** resource group.

   - Provide a name for the new **Log Analytics workspace**, such as *DefaultLAWorkspace*. This name must be unique per resource group.

   - Select an available **Region**.  

3. Select **Review + create** to review the settings, then select  **Create** to create the workspace.

## Create a diagnostic setting

1. On the Azure portal menu, select **Storage accounts**.

2. On the **Storage accounts** page, select the name of the storage account that you created in unit 3.

3. In the **Monitoring** section, select **Diagnostic settings**.

4. In the **Diagnostic settings** pane, select **blob**, then select **+ Add diagnostic setting**.

5. In the **Diagnostic setting name** box, provide a name for the setting. 

6. Select the **StorageRead** log category and in the **Destination details** section, select **Send to Log Analytics workspace**.

7. In the **Log Analytics workspace** drop-down list, select the Log Analytics workspace that you created in an earlier step.

8. Select **Save**.

## Download a blob to generate activity

1. In the **Data storage** section, select **Containers**.

2. In the **Containers** panel, select the container that you created in an earlier exercise.

3. Select a blob that you added in an earlier exercise, and the select **Download**

## View logged activity by using a Log Analytics query

1. In the **Monitoring** section, select **Logs**.

   The **Queries** window appears. This window provides you with several queries that you can run. You can also customize any of these queries by hovering over the query, and then selecting the **Load to Editor** that appears for the query. For this exercise, we will create a query from scratch.

2. Close the **Queries** window by selecting **X** in the corner of the window.

   The query editor appears.

3. In the query editor, add the following query.

    ```kusto
    StorageBlobLogs
    | where TimeGenerated > ago(1h) and OperationName  == "GetBlob"
    | project TimeGenerated, AuthenticationType, RequesterObjectId, OperationName, Uri
    ```

    This query shows read operations that occurred in the last hour, and includes various fields such as how the request was authentication, the name of the operation and the Uri of the resource. A read operation should appear for the download operation that you just performed.
