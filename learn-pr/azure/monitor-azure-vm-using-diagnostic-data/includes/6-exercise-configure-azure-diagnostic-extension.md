VM Insights uses the [Azure Monitor Agent](/azure/azure-monitor/agents/agents-overview) with a Data Collection Rule (DCR) to provide a comprehensive view of client performance in a prebuilt workbook. These metrics measure system performance, but to understand the reasons for performance deficits or anomalies, you need to analyze log data to see which events caused or contributed to the issues.

You can use Azure Monitor to create your own DCRs that collect VM metrics or log data and send it to various destinations. In this unit, you set up a DCR that uses the Azure Monitor Agent to collect Linux VM Syslog event data, and view the log data in Azure Monitor Log Analytics by using a Kusto Query Language (KQL) query.

DCRs can send performance counter data to both Azure Monitor Metrics and Azure Monitor Logs, but can send log data only to Azure Monitor Logs. To collect performance counters, you can select from a predefined set of objects and set sampling rates, or create custom objects. For events, you can select the event severity levels to log.

To send log data, the DCR must specify a Log Analytics workspace and data collection endpoint in the same Azure region as the DCR to send the log data to. You can use the default Log Analytics workspace that VM Insights set up for your subscription, or create and use another Log Analytics workspace.

DCRs that you define can apply to any or all VMs in your subscription. Azure installs Azure Monitor Agent on VMs that don't already have it installed. DCRs can send data from multiple VMs to multiple destinations of the same or different types. For example, a DCR can send log data to multiple Log Analytics workspaces, also known as *multihoming*, across different regions or tenants.

## Create a DCR to collect log data

In the Azure portal, search for and select *monitor* to go to the Azure Monitor **Overview** page.

:::image type="content" source="../media/monitor-overview.png" alt-text="Screenshot that shows the Azure Monitor Overview page." lightbox="../media/monitor-overview.png":::

### Create a Data Collection Endpoint

You must have a data collection endpoint to send log data to. To create the endpoint:

1. In the Azure Monitor left navigation menu under **Settings**, select **Data Collection Endpoints**.
1. On the **Data Collection Endpoints** page, select **Create**.
1. On the **Create data collection endpoint** page, for **Name**, enter *linux-logs-endpoint*.
1. Select the same **Subscription**, **Resource group**, and **Region** as your VM uses.
1. Select **Review + create**, and when validation passes, select **Create**.

### Create the Data Collection Rule

To create the DCR to collect the event logs:

1. In the Monitor left navigation menu under **Settings**, select **Data Collection Rules**.
1. On the **Data Collection Rules** page, you can see the DCR that VM Insights created. Select **Create** to create a new data collection rule.

   :::image type="content" source="../media/dcr-create.png" alt-text="Screenshot of the Data Collection Rules screen with Create highlighted." lightbox="../media/dcr-create.png":::

1. On the **Basics** tab of the **Create Data Collection Rule** screen, provide the following information:
   - **Rule name**: Enter *collect-events-linux*.
   - **Subscription**, **Resource Group**, and **Region**: Select the same as for your VM.
   - **Platform Type**: Select **Linux**.
1. Select **Next: Resources** or the **Resources** tab.

   :::image type="content" source="../media/create-dcr-basics.png" alt-text="Screenshot of the Basics tab of the Create Data Collection Rule screen." lightbox="../media/create-dcr-basics.png":::

1. On the **Resources** screen, select **Add resources**.
1. On the **Select a scope** screen, select the **monitored-linux-vm** VM, and then select **Apply**.
1. On the **Resources** screen, select **Enable Data Collection Endpoints**.
1. Under **Data collection endpoint** for the **monitored-linux-vm**, select the **linux-logs-endpoint** you created.
1. Select **Next: Collect and deliver**, or the **Collect and deliver** tab.

   :::image type="content" source="../media/create-dcr-resources.png" alt-text="Screenshot of the Resources tab of the Create Data Collection Rule screen." lightbox="../media/create-dcr-resources.png":::

1. On the **Collect and deliver** tab, select **Add data source**.
1. On the **Add data source** screen, under **Data source type**, select **Linux Syslog**.
1. On the **Add data source** screen, select **Next: Destination** or the **Destination** tab, and make sure the **Account or namespace** matches the Log Analytics workspace that you want to use, such as the one that VM Insights created.
1. On the **Add data source** screen, select **Add data source**.
1. On the **Create Data Collection Rule** screen, select **Review + create**, and when validation passes, select **Create**.

   :::image type="content" source="../media/create-dcr-finish.png" alt-text="Screenshot of Review + create highlighted on the Create Data Collection Rule screen." lightbox="../media/create-dcr-finish.png":::

## View log data

You can view and analyze the log data collected by your DCR by using KQL log queries. A set of precreated KQL queries is available for VMs, but you can write a simple query to look at the events your DCR is collecting.

1. On your VM's **Overview** page, select **Logs** from the left navigation menu under **Monitoring**. Log Analytics opens an empty query window with the scope set to your VM.

   You can also access log data by selecting **Logs** from the left navigation of the Azure Monitor **Overview** page. If necessary, select **Select scope** at the top of the query window to scope the query to the desired Log Analytics workspace and VM.

   >[!NOTE]
   > The **Queries** window with precreated queries might open when you open Log Analytics. For now, close this window, because you're going to manually create a simple query.
   
1. In the empty query window, type *Syslog*, and then select **Run**. All the system log events the DCR collected within the **Time range** are displayed.

1. You can refine your query to identify events of interest. For example, you can display only the events that had a **SeverityLevel** of **warning**.

   :::image type="content" source="../media/dcr-log.png" alt-text="Screenshot that shows the events returned from the Syslog by the DCR." lightbox="../media/dcr-log.png":::

