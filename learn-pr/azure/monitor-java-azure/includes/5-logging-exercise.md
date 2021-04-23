In this exercise, we look at Logging and Log Analytics.

# Logging

## Streaming logs

To avoid repeatedly specifying your resource group and service instance name, set your default resource group name and cluster name.

```azurecli
az configure --defaults group=<service group name>
az configure --defaults spring-cloud=<service instance name>
```

In following examples, the resource group and service name will be omitted in the commands.

### Tail log for app with single instance

If an app named customers-service has only one instance, you can view the log of the app instance with the following command:

```azurecli
az spring-cloud app logs -n customers-service
```

This command will return logs:

```output
...
2021-04-23 09:13:59.516  INFO [customers-service,,,] 1 --- [           main] o.s.s.p.c.CustomersServiceApplication    : Started CustomersServiceApplication in 48.032 seconds (JVM running for 79.933)
2021-04-23 09:14:05.385  INFO [customers-service,,,] 1 --- [nio-1025-exec-2] o.a.c.c.C.[Tomcat].[localhost].[/]       : Initializing Spring DispatcherServlet 'dispatcherServlet'
2021-04-23 09:14:05.385  INFO [customers-service,,,] 1 --- [nio-1025-exec-2] o.s.web.servlet.DispatcherServlet        : Initializing Servlet 'dispatcherServlet'
2021-04-23 09:14:05.410  INFO [customers-service,,,] 1 --- [nio-1025-exec-2] o.s.web.servlet.DispatcherServlet        : Completed initialization in 25 ms
...
```

### Tail log for app with multiple instances

If multiple instances exist for the app named `customers-service`, you can view the instance log by using the `-i/--instance` option.

First, you can get the app instance names with following command.

```azurecli
az spring-cloud app show -n customers-service --query properties.activeDeployment.properties.instances -o table
```

With results:

```output
Name                                         Status    DiscoveryStatus
-------------------------------------------  --------  -----------------
customers-service-default-12-75cc4577fc-pw7hb  Running   UP
customers-service-default-12-75cc4577fc-8nt4m  Running   UP
customers-service-default-12-75cc4577fc-n25mh  Running   UP
```

Then, you can stream logs of an app instance with the option `-i/--instance` option:

```azurecli
az spring-cloud app logs -n customers-service -i customers-service-default-12-75cc4577fc-pw7hb
```

You can also get details of app instances from the Azure portal.  After selecting **Apps** in the left navigation pane of your Azure Spring Cloud service, select **App Instances**.

### Continuously stream new logs

By default, `az spring-cloud ap log tail` prints only existing logs streamed to the app console and then exits. If you want to stream new logs, add -f (--follow):  

```azurecli
az spring-cloud app logs -n customers-service -f
```

To check all the logging options supported:

```azurecli
az spring-cloud app logs -h 
```

## Log analytics

## Analyze the logs in Log Analytics

After your application is properly set up, your application console log will be streamed to Log Analytics. The structure enables efficient query in Log Analytics.

## Diagnostics settings

Using the diagnostics functionality of Azure Spring Cloud, you can analyze logs and metrics with any of the following services:

* Use Azure Log Analytics, where the data is written to Azure Storage. There's a delay when exporting logs to Log Analytics.
* Save logs to a storage account  for auditing or manual inspection. You can specify the retention time (in days).
* Stream logs to your event hub for ingestion by a third-party service or custom analytics solution.

Choose the log category and metric category you want to monitor.

## Logs

|Log | Description |
|----|----|
| **ApplicationConsole** | Console log of all customer applications. |
| **SystemLogs** | Currently, only **Spring Cloud Config Server** logs in this category. |

## Configure diagnostics settings

1. In the Azure portal, go to your Azure Spring Cloud instance.
1. Select **diagnostics settings** option, and then select **Add diagnostics setting**.
1. Enter a name for the setting, and then choose where you want to send the logs. You can select any combination of the following three options:
    * **Archive to a storage account**
    * **Stream to an event hub**
    * **Send to Log Analytics**

1. Choose which log category and metric category you want to monitor, and then specify the retention time (in days). The retention time applies only to the storage account.
1. Select **Save**.

> [!NOTE]
> There might be a gap of up to 15 minutes between when logs or metrics are emitted and when they appear in your storage account, your event hub, or Log Analytics.
> If the Azure Spring Cloud instance is deleted or moved, the operation will not cascade to the **diagnostics settings** resources. The **diagnostics settings** resources have to be deleted manually before the operation against its parent, i.e. the Azure Spring Cloud instance. Otherwise, if a new Azure Spring Cloud instance is provisioned with the same resource ID as the deleted one, or if the Azure Spring Cloud instance is moved back, the previous **diagnostics settings** resources continue extending it.

## View the logs and metrics

There are various methods to view logs and metrics as described under the following headings.

### Use the Log Search

1. In the Azure portal, go to your Azure Spring Cloud instance.
1. To open the **Log Search** pane, select **Logs**.
1. In the **Tables** search box
   * To view logs, enter a simple query such as:

    ```sql
    AppPlatformLogsforSpring
    | limit 50
    ```

   * To view metrics, enter a simple query such as:

    ```sql
    AzureMetrics
    | limit 50
    ```

1. To view the search result, select **Run**.

### Use Log Analytics

There are actually three ways to access your application's logs: Azure Storage, Azure Events Hub, and Log Analytics. We will focus here on Log Analytics as it's the most common one, and as it's integrated into Azure Spring Cloud.

Log Analytics is part of Azure Monitor, which is well-integrated into Azure Spring Cloud and which we will also use for metrics monitoring.

1. In the Azure portal, in the left pane, select **Log Analytics**.
1. Select the Log Analytics workspace that you chose when you added your diagnostics settings.
1. To open the **Log Search** pane, select **Logs**.
1. In the **Tables** search box,

   * to view logs, enter a query such as:

    ```sql
    AppPlatformLogsforSpring
    | limit 50
    ```

    * to view metrics, enter a query such as:

    ```sql
    AzureMetrics
    | limit 50
    ```

1. To view the search result, select **Run**.
1. You can search the logs of the specific application or instance by setting a filter condition:

    ```sql
    AppPlatformLogsforSpring
    | where ServiceName == "YourServiceName" and AppName == "YourAppName" and InstanceName == "YourInstanceName"
    | limit 50
    ```

## Analyze the logs

Application logs provide critical information and verbose logs about your application's health, performance, and more. In the next sections are some  queries to help you understand your application's current and past states.

### Show application logs from Azure Spring Cloud

To review a list of application logs from Azure Spring Cloud, sorted by time with the most recent logs shown first, run the following query:

```sql
AppPlatformLogsforSpring
| project TimeGenerated , ServiceName , AppName , InstanceName , Log
| sort by TimeGenerated desc
```

### Show logs entries containing errors or exceptions

To review unsorted log entries that mention an error or exception, run the following query:

```sql
AppPlatformLogsforSpring
| project TimeGenerated , ServiceName , AppName , InstanceName , Log
| where Log contains "error" or Log contains "exception"
```

Use this query to find errors, or modify the query terms to find specific error codes or exceptions.

### Show the number of errors and exceptions reported by your application over the last hour

To create a pie chart that displays the number of errors and exceptions logged by your application in the last hour, run the following query:

```sql
AppPlatformLogsforSpring
| where TimeGenerated > ago(1h)
| where Log contains "error" or Log contains "exception"
| summarize count_per_app = count() by AppName
| sort by count_per_app desc
| render piechart
```

In the next unit, we'll discuss Application Performance Monitoring (APM).
