## Create a data collection rule

This unit describes how you can use Azure Monitor Data Collection Rules (DCRs) to collect event and performance counter data from VMs. The DCRs use the same Azure Monitor Agent [Azure Monitor Agent](azure-monitor-agent-overview.md) that you installed for VM Insights. VM Insights already provides a comprehensive view of performance data in its prebuilt workbook. Now, you set up a DCR to collect event data from the Linux VM Syslog.

The DCRs you define can apply to any VMs in your subscription. Azure installs Azure Monitor Agent on VMs that don't already have it installed.

You can send performance counters to both Azure Monitor Metrics and Azure Monitor Logs, but you can send Windows Events and Linux Syslog data to Azure Monitor Logs only. You must have a Log Analytics workspace and a data collection endpoint to send the data to. You can use the default Log Analytics workspace that VM Insights set up for your subscription, and create the DCR in the same region as your Log Analytics workspace.

You can define a DCR to send data from multiple VMs to multiple destinations of the same or different types. For example, a DCR can send data to multiple Log Analytics workspaces, also known as *multihoming*, across different regions or tenants.

For events, you can select severity levels to log. For performance counters, you can select from a predefined set of objects and set sampling rates, or create custom objects.

1. In the Azure portal, search for and select *monitor* to go to the Azure Monitor **Overview** screen.

1. In the left navigation menu under **Settings**, select **Data Collection Endpoints**.
1. On the **Data Collection Endpoints** page, select **Create**.
1. On the **Create data collection endpoint** page, for **Name**, enter *linux-logs-endpoint*.
1. Select the same **Subscription**, **Resource group**, and **Region** as your VM uses.
1. Select **Review + create**, and when validation passes, select **Create**.

1. In the Monitor left navigation menu under **Settings**, select **Data Collection Rules**.
1. On the **Data Collection Rules** page, you can see the DCR that VM Insights created.
1. Select **Create** to create a new data collection rule.

1. On the **Basics** tab of the **Create Data Collection Rule** screen, provide the following information:
   - **Rule name**: Enter *collect-events-linux*.
   - **Subscription**, **Resource Group**, and **Region**: Select the same as for your VM.
   - **Platform Type**: Select **Linux**.

1. Select **Next: Resources** or the **Resources** tab.
1. On the **Resources** screen, select **Add resources**.
1. On the **Select a scope** screen, select the **monitored-linux-vm** VM, and then select **Apply**.
1. On the **Resources** screen, select **Enable Data Collection Endpoints**.
1. Under **Data collection endpoint** for the **monitored-linux-vm**, select **linux-logs-endpoint**.

1. Select **Next: Collect and deliver**, or the **Collect and deliver** tab.
1. On the **Collect and deliver** tab, select **Add data source**.
1. On the **Add data source** screen, under **Data source type**, select **Linux Syslog**.
1. Select **Next: Destination** or the **Destination** tab, and make sure the **Account or namespace** matches the default workspace that Azure created for VM Insights.
1. Select **Save**.
1. On the **Create Data Collection Rule** screen, select **Review + create**, and when validation passes, select **Create**.

## View log data

You can view the data collected by the DCR in your Log Analytics workspace by using a log query written in Kusto Query Language (KQL). A set of precreated KQL queries is available for VMs, but you can use a simple query to look at the events your DCR is collecting.

1. On your VM's **Overview** page, select **Logs** from the left navigation menu under **Monitoring**. Log Analytics opens an empty query window with the scope set to your VM.

   >[!NOTE]
   > The **Queries** window with precreated queries might open when you open Log Analytics. For now, close this window because you're going to manually create a simple query.
   
1. In the empty query window, type *Syslog*, and then select **Run**. The events the DCR collected within the **Time range** are displayed.
