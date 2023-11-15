Azure Resource logs are platform logs emitted by Azure resources that describe their internal operation. All resource logs share a common top-level schema with the flexibility for each service to emit unique properties for their own events.

When you have an IoT Hub solution running in production, you will want to set up various metrics and enable diagnostic logs. Then, if a problem occurs, you have data to look at that helps you to diagnose the problem and fix it more quickly.

In this exercise, you enable diagnostic logs and use them to check for errors. You also set up some metrics to watch, and alerts that fire when the metrics hit a certain boundary criteria.

## Task 1: Enable diagnostics

In this task, you configure Monitor device connect/disconnect data that is stored in the storage account that you set up in task 1.

1. Navigate to your portal dashboard.

1. In the **Resources** tile, select your IoT Hub.

1. In the portal menu on the left side, under **Monitoring**, click **Diagnostic settings**.

1. On the **Diagnostics settings** blade, under **Name**, click **+ Add diagnostic setting**.

1. In the **Diagnostic settings name** textbox, enter **diags-hub**

1. Take a moment to review the options listed under **Destination details**.

    You can see that there are four options available for routing the metrics - you can learn more about each by following these links:

    * [Send to Log Analytics workspace](/azure/azure-monitor/platform/resource-logs-collect-workspace)
    * [Archive to a storage account](/azure/azure-monitor/platform/resource-logs-collect-storage)
    * [Stream to an event hub](/azure/azure-monitor/platform/stream-monitoring-data-event-hubs)
    * [Send to partner solution](/azure/azure-monitor/partners)

    In this exercise, you use the storage account option.

1. Under **Destination details**, click **Archive to a storage account**.

    More fields are made available once you select this destination option.

1. For the **Subscription** field, select the <rgn>[sandbox resource group name]</rgn> resource group.

1. For the **Storage account** field, select the storage account name that is provided. Make a note of this name. The name should consist of a long sequence of letters and numbers. You will need to select this name from a list in Exercise - Review Metrics, Alerts and Archive. After you've created the diagnostic setting, a storage container is created in the storage account as soon as an event occurs in one of the enabled log categories.

1. Under **Categories**, click **Connections** and **DeviceTelemetry**.

1. At the top of the **Diagnostics settings** blade, click **Save**.

1. Close the **Diagnostics settings** blade.

    You should now be on the **Diagnostics settings** pane of your IoT hub, and you should see that the list of **Diagnostics settings** is updated to show the **diags-hub** setting that you created.

    Later, when you look at the diagnostic logs, you'll be able to see the telemetry and connect/disconnect logging for the device.

### Task 3: Set up Metrics

In this task, you set up various metrics to watch for when messages are sent to your IoT hub.

1. Ensure that you have your IoT Hub blade open.

    The previous task left you on the **Diagnostics settings** pane of the IoT hub blade.

1. On the left-side menu, under **Monitoring**, click **Metrics**.

    The **Metrics** pane is displayed showing a new, empty, chart.

1. In the top-right corner of the screen, to change the time range and granularity for the chart, click **Last 24 hours (Automatic)**.

1. In the context menu that appears, under **Time range**, click **Last 30 minutes**.

1. In the same context menu, under **Show time as**, ensure that **Local** is selected.

1. To save your time settings, click **Apply**.

1. Take a minute to examine the settings that are used to specify the chart Metrics.

    Under the **Chart Title** and the toolbar for the chart, you see an area to specify Metrics.

    * Notice that the **Scope** is already set to the name of your IoT hub.
    * Notice that **Metric Namespace** is already set to **IoT Hub standard metrics**.

    > [!NOTE]
    > By default, there is only one metric namespace available. Namespaces are a way to categorize or group similar metrics together. By using namespaces, you can achieve isolation between groups of metrics that might collect different insights or performance indicators. For example, you might have a namespace called **memorymetrics** that tracks memory-use metrics which profile your app. Another namespace called **apptransaction** might track all metrics about user transactions in your application. You can learn more about custom metrics and namespaces at [Custom metrics in Azure Monitor](/azure/azure-monitor/platform/metrics-custom-overview?toc=%2Fazure%2Fazure-monitor%2Ftoc.json#namespace).

    Your next step is add a metric that is used to monitor how many telemetry messages are sent to your IoT Hub.

1. In the **Metric** dropdown, click **Telemetry messages sent**.

    Notice the large number of metrics that are available for you to select from.

1. Under **Aggregation**, ensure that **Sum** is selected.

    Notice there are four aggregation operations available - *Avg*, *Min*, *Max* and *Sum*.

1. Take a moment to review your chart.

    Notice that the chart title has updated to reflect the metric chosen.

    You completed the specification for the first metric. Next, you add another metric to monitor the number of connected devices.

1. Under the chart title, on the toolbar, click **Add metric**.

    A new metric appears. Notice that the **Scope** and **Metric Namespace** values are prepopulated.

1. In the **Metric** dropdown, click **Connected devices**.

1. Under **Aggregation**, ensure that **Avg** is selected.

    Your screen should now show the minimized metric for Telemetry messages sent, as well as the new metric for avg connected devices. Notice that the chart title is updated to reflect both metrics.

    > [!NOTE]
    > To edit the chart title, click the **pencil** icon to the right of the title.

1. Under the **Chart Title**, on the right side of the toolbar, click **Save to dashboard**, click **Pin to dashboard**, ensure that **My Dashboard** is selected, and then click **Pin**.

    > [!NOTE]
    > In order to retain the chart you have just created, it **must** be pinned to a dashboard.

## Verify your work

1. Navigate to your dashboard and verify that the chart is displayed.

    > [!NOTE]
    > You can customize the size and position of the chart by using drag and drop operations.

1. If the device simulator is running, you should see that telemetry messages have been sent and the device is connected.

Now that you have enabled logging and set up a chart to monitor metrics, it's a good time for you to set up an alert. You'll configure an alert in the next exercise.
