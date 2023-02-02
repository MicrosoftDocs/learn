Now that you've been collecting log data from your Spring Apps Service, your next step will be to query the log data.

In this section, you'll view the following entries:

 -  Log entries containing errors or exceptions
 -  Ingress log entries.
 -  Container log entries

:::image type="content" source="../media/service-logs-a667bb5c.png" alt-text="Displays a screenshot of the Service instance logs.":::


To view the log entries, do the following procedures.

1.  In the Azure portal, navigate to your resource group and to the **Log Analytics** Workspace.
2.  Select **Logs**.
3.  On the **Tables** tab, review the list of tables and verify that they include **AppPlatformContainerEventLogs, AppPlatformIngressLogs, AppPlatformLogsforSpring, AppPlatformSystemLogs, AzureMetrics** and **AppPlatformBuildLogs**.
    
    > [!NOTE]
    > Not all of these categories will be available. It might takes extra time for the logging data to appear in the Log Analytics workspace. If needed, wait for a few minutes and refresh the web page displaying the Azure portal.

4.  In the query editor, input the below query and select *Run*.
    
    ```azurecli
    AppPlatformLogsforSpring
    | where Log contains "error" or Log contains "exception"
    | project TimeGenerated, ServiceName , AppName , InstanceName , Log
    ```
    
    This query provides the log entries that are an error or an exception.

5.  In the query editor, replace the query with the query below, and select **Run**.
    
    ```azurecli
    AppPlatformIngressLogs
    | where TimeGenerated > ago(1h)
    | project TimeGenerated, Host, Request, Status, BodyBytesSent, RequestTime, ReqId, RequestHeaders
    | sort by TimeGenerated
    ```
    
    The next query provides the ingress logs.

6.  In the query editor, replace the query with the query below, and select **Run**.
    
    ```azurecli
    AppPlatformContainerEventLogs
    | where TimeGenerated > ago(1h)
    | sort by TimeGenerated
    ```
    
    The query provides the container event logs.

7.  You can also have this last query be summarized on a time chart. Replace the query with the one below and select **Run**.
    
    ```azurecli
    AppPlatformContainerEventLogs
    | where TimeGenerated > ago(1h)
    | sort by TimeGenerated
    | summarize count() by bin(TimeGenerated, 5m), Event.
    | render timechart
    ```

8.  Select the **Chart** tab to view the results in graphical format. Select **Pin to** and then select **Azure dashboard** to pin the visual representation to your Azure Home screen.
