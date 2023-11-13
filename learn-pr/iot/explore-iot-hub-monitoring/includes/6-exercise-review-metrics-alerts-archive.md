In this exercise, you examine some of the reporting and logging resources that you configured earlier in this module. You review the metrics, alerts, and diagnostic log event data has been recorded in the short time that has elapsed.

## Task 1: See the Metrics in the Portal

In order to generate the alert where the number of connected devices is less than one, the device simulator app must be closed.

1. Return to Visual Studio Code and exit the running app.

    Wait 30 seconds or so before proceeding to the next step.

1. Navigate to your Dashboard that includes the Metrics chart that you created.

1. Open the Metrics chart that you pinned to the dashboard by clicking on the chart title.

    The chart opens and fills the page.

1. Click on **Local Time: Last 30 minutes**. Notice that you can adjust the time range, granularity and time zone. Click **Cancel**.

1. Observe that you can see *Telemetry messages sent* and *Connected devices* values at the bottom of the blade. Hover your mouse over different parts of the chart to see *Telemetry messages sent* and *Connected devices* values for specific points in time. You should notice that the telemetry and connected devices plot lines reduced to zero after you stopped your telemetry simulator program.

## Task 2: See the Alerts

To use the Azure portal to review alerts, complete the following steps.

1. Close the Metrics graphical display to return to the Dashboard.

1. On the Azure portal toolbar, in the search box, type **monitor**

1. In the search result pane, under **Services**, click **Monitor**.

    The **Monitor - Overview** page is displayed. This is the overview for all of the monitoring activities for the current subscription.

1. On the left-side menu, near the top of the list, click **Alerts**.

    This alerts view shows all alerts for all subscriptions. Let's filter this for the IoT Hub used in this project.

1. Near the top of the blade, click **Subscription**, then select only the subscription you are using for this project. Then click **Apply**.

1. Click **Time range**, click **Past hour**, then click **Apply**.

1. Click **Alert condition**, click **Select all**, then click **Apply**.

    You should now see a summary of alerts for the last hour including a total alerts count and a list of the severity categories with alert counts per category. The alerts we are interested in are **3 - Informational** Severity. You should see at least one alert. If you stopped and restarted the device simulator, you may have generated more that one alert.

    > [!NOTE]
    > If you do not yet see an alert, wait a few more minutes - there is sometimes a delay in the alerts being raised.

1. In the list of severities, click the number under **Informational**.

    The **Informational** pane opens. At the top of the pane, you see several filter fields. These fields have been populated with the values from the preceding screen. And only the **Informational** alerts for the selected IoT hub are shown. It also shows the alert condition of either Fired or Resolved, and the Fire time.

1. Under **Name**, to select metrics alert details about your 3 - Informational alert, click **Connected Devices Less than 1**.

    A pane opens showing a **Summary** of the details for the alert. This pane includes a chart illustrating why the alert fired - a dash line shows the threshold value and the current values for the monitored metric. Below this are **Additional details**.

1. At the top of the pane, below the title, click **History**.

    In this view, you can see when the alert fired, the action group that was invoked, and any other changes such as when the alert was resolved.

1. At this point, check your email and/or text and verify you received an alert message.

1. To automatically resolve the alert, return to Visual Studio Code and restart the app.

    > [!NOTE]
    > As it takes a few minutes to resolve the alert, continue with the remaining tasks.

## Task 3: See the Diagnostic Logs

Earlier in this lab, you set up your diagnostic logs to be exported to blob storage. It is a good time to check and see what was written.

1. Navigate to your Dashboard.

1. In the list of resources, select the Storage Account that you created earlier.

1. The **Essentials** and **Properties** of the storage account are displayed.

1. To view the storage metrics, select the **Monitoring** tab.

1. Scroll down until you can see the metrics charts for the Storage Account: *Total egress*, *Total ingress*, *Average latency* and *Request breakdown*.

    You should see that there is activity displayed.

1. On the left-side menu, to view the data that has been logged, click **Storage Browser**.

    You can use the Storage browser to verify that your data is being added to the storage account.

1. In the **Storage Browser** blade, expand the **Blob containers** node.

    When Azure Monitor first sends data to a storage account, it creates a container called **insights-logs-connection**.

1. Under **Blob containers**, click **insights-logs-connection**.

    To view the logged data, you need to navigate down a hierarchy of folders. The first folder is named for the IoT Hub.

    > [!NOTE]
    > If no data is displayed, click **Refresh**. You may need to wait a minute or two and then refresh again.

1. In the right-hand pane, select the name of your IoT hub, and then navigate down into the folder hierarchy.

    Under your IoT hub folder, you see folders for the partition, then numeric values for the year, month, and day. The final folder represents the hour, listed in UTC time. The hour folder contains several block blobs that contain your logging message data.

1. Locate the block blob for the data with the earliest time stamp.

    The .avro files use a naming pattern of **{num}.avro** (that is, **22.avro**).

1. Select **...** next to the block blob with the earliest time stamp, then select **Download** from the Context menu.

1. Open Windows **File Explorer** and navigate to your **Downloads** folder.

1. Right-click the .avro file, then select **Open with**, then select **Visual Studio Code**.

1. In the Visual Studio Code window, select **Open Anyway**, then open the file in the Visual Studio text editor.

1. To make the JSON easier to read, press **Shift+Alt+F** or select **Format Document** from the Context Menu.

    The JSON shows a list of connection and disconnection events similar to:

    ```json
    {
        "time": "2023-09-21T22:16:00Z",
        "resourceId": "/SUBSCRIPTIONS/AE82FF3B-4BD0-462B-8449-D713DD18E11E/RESOURCEGROUPS/SandboxResourceGroup/PROVIDERS/MICROSOFT.DEVICES/IOTHUBS/IOT-TRAINING-DM092121",
        "operationName": "deviceConnect",
        "category": "Connections",
        "level": "Information",
        "properties": "{\"deviceId\":\"sensor-th-2001\",\"sdkVersion\":\".NET/1.38.0 (.NET Core 3.1.19; Microsoft Windows 10.0.22000 WindowsProduct:0x00000030; X64; {FF88E933-1C12-457D-A098-A5093B53FBA2})\",\"protocol\":\"Mqtt\",\"authType\":null,\"maskedIpAddress\":\"24.9.142.XXX\",\"statusCode\":null,\"errorMessage\":\"\"}",
        "location": "centralus"
    }
    {
        "time": "2023-09-21T22:33:34Z",
        "resourceId": "/SUBSCRIPTIONS/AE82FF3B-4BD0-462B-8449-D713DD18E11E/RESOURCEGROUPS/SandboxResourceGroup/PROVIDERS/MICROSOFT.DEVICES/IOTHUBS/IOT-TRAINING-DM092121",
        "operationName": "deviceDisconnect",
        "category": "Connections",
        "level": "Error",
        "resultType": "404104",
        "resultDescription": "DeviceConnectionClosedRemotely",
        "properties": "{\"deviceId\":\"sensor-th-2001\",\"protocol\":\"Mqtt\",\"authType\":null,\"maskedIpAddress\":\"24.9.142.XXX\",\"statusCode\":\"404\",\"errorMessage\":\"Device disconnected, see cause and resolution at https://aka.ms/iothub404104\"}",
        "location": "centralus"
    }
    ```

    Notice that each individual entry is a single JSON record, although the overall document is not a valid JSON document as the JSON objects are not declared within a JSON array **[ ]** and comma separated. Within each record you can see details relating to the originating IoT Hub and **properties** for each event. Within the **properties** object, you can see the connecting (or disconnecting) **deviceId**.

## Task 4: Review resolved Alert

By this point, you should have received an email or SMS indicating the Monitor Alert is resolved. Complete the following steps to review the resolved Alert in the portal.

> [!NOTE]
> If you have not yet received the email or SMS - wait until they arrive before proceeding.

1. In the Azure portal, navigate back to your Dashboard.

1. On the Azure portal toolbar, in the search box, type **monitor**

1. In the search result pane, under **Services**, click **Monitor**.

    The Monitor overview page is displayed. This is the overview for all of the monitoring activities for the current subscription.

1. On the left-side menu, near the top of the list, click **Alerts**.

    This alerts view shows all alerts for all subscriptions. Let's filter this list to your IoT Hub.

1. Click **Subscription**, then select only the subscription you are using for this project. Then click **Apply**.

1. Click **Time range**, click **Past hour**, then click **Apply**.

1. Click **Alert condition**, click **Select all**, then click **Apply**.

1. In the list of severities, click the number under **Informational**.

1. Under **Name**, click the latest **Connected Devices Less than 1** alert.

    A pane opens showing a **Summary** of the details for the alert. As before, this includes a chart illustrating why the alert fired - a dash line shows the threshold value and the current values for the monitored metric. Below this are **Additional details**.

1. At the top of the pane, below the title, click **History**.

    In this view you can see when the alert fired, the action group that was invoked, and when the alert is resolved and so forth.

1. You can now close the Device Simulator App.

## Verify your work
