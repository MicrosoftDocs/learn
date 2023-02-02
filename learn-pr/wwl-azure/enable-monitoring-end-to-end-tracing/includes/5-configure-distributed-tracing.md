Application Insights allows you to monitor your application specific logs. You may also want to view other monitoring data. To view data, you'll configure Diagnostic Settings and begin using Log Analytics.

Log Analytics is a tool in the Azure portal used to edit and run log queries with data in Azure Monitor Logs. You may write a query that returns a set of records and then use features of Log Analytics to sort, filter, and analyze them. Or you may write a more advanced query to perform statistical analysis and visualize the results in a chart to identify a particular trend.

To begin capturing log information, do the following procedure.

1.  When configuring diagnostics settings, you can do so for multiple categories of logs. Each service exposes different categories. Use the below statement to get an overview of the log categories Spring Apps Service exposes.
    
    ```Bash
    az monitor diagnostic-settings categories list \
        --resource $SPRING_APPS_SERVICE \
        -g $RESOURCE_GROUP \
        --resource-type Microsoft.AppPlatform/Spring \
        --query value[].name
    ```

2.  Do the following procedure to create a Log Analytics Workspace to send the logs to.
    
    ```Bash
    WORKSPACE=log-$APPNAME-$UNIQUEID
    az monitor log-analytics workspace create \
        --resource-group $RESOURCE_GROUP \
        --workspace-name $WORKSPACE
    ```

3.  Now you create the Diagnostics Settings for your Spring Apps Service to link to a workspace. You begin by creating the *logs.json* file and save it to the directory where you've been CLI statements.
    
    ```azurecli
    [
        {
            "category": "ApplicationConsole",
        "enabled": true
        },
        {
            "category": "SystemLogs",
            "enabled": true
        },
        {
            "category": "IngressLogs",
            "enabled": true
        },
        {
            "category": "BuildLogs",
            "enabled": true
        },
        {
            "category": "ContainerEventLogs",
            "enabled": true
        }
    ]
    ```

4.  Create the **metrics.json**in the same directory by doing the following procedure.
    
    ```azurecli
    [
        {
            "category": "AllMetrics",
            "enabled": true
        }
    ]
    ```

5.  Next, you'll use both files to create the diagnostics settings for your Spring Apps Service. Lastly, you'll send the logs to your Log Analytics workspace.
    
    ```azurecli
    az monitor diagnostic-settings create \
        --name asa-logs \
        --resource $SPRING_APPS_SERVICE \
        --resource-type Microsoft.AppPlatform/Spring \
        --resource-group $RESOURCE_GROUP \
        --workspace $WORKSPACE \
        --logs @logs.json \
        --metrics @metrics.json
    ```

The action will begin log collection. The process may take 5-10 time before data appears in your logs. The next unit will walk you through how to query the data.
