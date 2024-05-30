In this exercise, you examined some of the reporting and logging resources that you configured earlier in this module. You review the metrics, alerts, and diagnostic log event data has been recorded in the short time that has elapsed.

## Task 1: See the metrics in the portal

In order to trigger the alert where the number of connected devices is less than one, stop the device simulator app.

1. Return to Visual Studio Code and stop the running app.

1. Wait 30 seconds before proceeding to the next step.

1. Use the portal menu to navigate to your dashboard that includes the metrics chart that you created.

1. Open the metrics chart that you pinned to the dashboard by selecting the chart title.

    The chart opens and fills the page.

1. Select **Local Time: Last 30 minutes**. Notice that you can adjust the time range, granularity and time zone. Select **Cancel**.

1. Observe that you can see **Telemetry messages sent** and **Connected devices** values at the bottom of the blade. Hover your mouse over different parts of the chart to see **Telemetry messages sent** and **Connected devices** values for specific points in time. You should notice that the telemetry and connected devices plot lines reduced to zero after you stopped your telemetry simulator program.

## Task 2: See the alerts

To use the portal to review alerts, complete the following steps.

1. Close the metrics graphical display to return to the dashboard.

1. In the portal search box, type **monitor**.

1. In the search result pane, under **Services**, select **Monitor**.

    The **Monitor - Overview** page is displayed. This is the overview for all of the monitoring activities for the current subscription.

1. On the left-side menu, near the top of the list, select **Alerts**.

1. For this module, the alerts view shows all alerts for only your **Concierge Subscription**. In a production environment, you would need to adjust the **Subscription** filter to filter for your subscription only.

1. Select **Time range**, select **Past hour**, then select **Apply**.

1. Select **Alert condition**, select **Select all**, then select **Apply**.

    You should now see a summary of alerts for the last hour including a total alerts count and a list of the severity categories with alert counts per category. If you do not yet see an alert, wait a few more minutes. There is sometimes a delay in the alerts being raised.

    The alerts we're interested in are **3 - Informational** Severity. You should see at least one alert. If you stopped and restarted the device simulator, you may have generated more that one alert.

1. In the list of severities, select the number under **Informational**.

    The **Informational** pane opens. At the top of the pane, you see several filter fields. These fields have been populated with the values from the preceding screen. And only the **Informational** alerts for the selected IoT hub are shown. It also shows the **Alert condition** of either **Fired** or **Resolved**, and the **Fire time**.

1. Under **Name**, to select metrics alert details about your 3 - Informational alert, select **Connected Devices Less than 1**.

    An **Alert details** pane opens showing a **Summary** of the details for the alert. This pane includes a chart illustrating why the alert fired. A dash line shows the **Threshold** value and the current values for the monitored metric. Below this are more details.

1. At the top of the pane, below the title, select **History**.

    In this view, you can see when the alert fired, the action group that was invoked, and any other changes such as when the alert was resolved.

1. Close the **Alert details** pane.

1. At this point, check your email and/or text and verify you received an alert message.

1. To resolve the alert, return to Visual Studio Code and restart the app. As it takes a few minutes to resolve the alert, continue with the remaining tasks.

## Task 3: See the diagnostic logs

Earlier in this lab, you set up your diagnostic logs to be exported to Blob Storage. It's a good time to check and see what was written.

1. In the portal menu, select **Home**.

1. In **Resources**, select the storage account that you created earlier.

1. The **Essentials** and **Properties** of the storage account are displayed.

1. To view the storage metrics, select the **Monitoring** tab.

1. Scroll down until you can see the metrics charts for the storage account: **Total egress**, **Total ingress**, **Average latency** and **Request breakdown**.

    You should see that there's activity displayed.

1. On the left-side menu, to view the data that has been logged, select **Storage browser**.

    You can use the **Storage browser** to verify that your data is being added to the storage account.

1. In the **Storage Browser** blade, select the **Blob containers** node.

    When Azure Monitor first sends data to a storage account, it creates a container named **insights-logs-connections**.

1. Under **Blob containers**, select **insights-logs-connection**.

    To view the logged data, you need to navigate down a hierarchy of folders. If no data is displayed, select **Refresh**. You may need to wait a minute or two and then refresh again.

1. Navigate down into the folder hierarchy until you reach the minute folder. The folder should appear as **m=00**. As you navigate down you see numeric values for the year, month, day, and hour. The final folder represents the minute. The minute folder contains a JSON format blob file that contains your monitor logging data.

1. Select the **...** context menu for the .json file, then select **Download**.

1. Open your **File Explorer** and navigate to your **Downloads** folder.

1. Right-click the .json file, then select **Open with**, then select **Visual Studio Code**.

1. To make the JSON easier to read, press **Shift+Alt+F**.

    The JSON shows a list of connection and disconnection events similar to the following.

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

    Notice that each individual entry is a single JSON record, although the overall document is not a valid JSON document as the JSON objects aren't declared within a JSON array **[ ]** and comma separated. Within each record you can see details relating to the originating IoT Hub and **properties** for each event. Within the **properties** object, you can see the connecting (or disconnecting) **deviceId**.

## Task 4: Review resolved alert

By this point, you should have received an email or SMS indicating the Monitor alert is resolved. If you have not yet received the email or SMS, wait until they arrive before proceeding.

Complete the following steps to review the resolved alert in the portal.

1. On the portal toolbar, in the search box, type **monitor**

1. In the search result pane, under **Services**, select **Monitor**.

    The Monitor overview page is displayed. This is the overview for all of the monitoring activities for the current subscription.

1. On the left-side menu, near the top of the list, select **Alerts**.

1. Ensure that the **Subscription** shown is **Concierge Subscription**.

1. Select **Time range**, select **Past hour**, then select **Apply**.

1. Select **Alert condition**, select **Select all**, then select **Apply**.

1. In the list of severities, select the number under **Informational**.

1. Under **Name**, select the latest **Connected Devices Less than 1** alert.

    A pane opens showing a **Summary** of the details for the alert. As before, this includes a chart illustrating why the alert fired. A dash line shows the threshold value and the current values for the monitored metric. Below this are more details.

1. Review the chart to verify that the alert was resolved.

1. At the top of the pane, below the title, select **History**.

    In this view, you can see when the alert fired, the action group that was invoked, when the alert is resolved, and other details.

1. In the list of historical events, verify that the alert was resolved.

1. You can now close the device simulator App.

## Verify your work

In this exercise, you reviewed the operational metrics, alerts, and diagnostic logs data based on the configuration that you created. These monitoring items are fed by the telemetry data sent by the DeviceSimulator program.

The Azure services, email, and SMS notifications that you set up will terminate automatically 120 minutes after the sandbox was first created. You can unsubscribe from email and SMS alerts using your apps if needed before the sandbox terminates.
