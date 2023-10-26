The [Azure Monitor Agent](/azure/azure-monitor/agents/agents-overview) that you installed for VM Insights uses the VM Insights Data Collection Rules (DCR) to provide a comprehensive view of client performance data in its prebuilt workbook. You also want to collect system event log data from your Linux VM client. In this unit, you set up a DCR that uses the Azure Monitor Agent to collect Linux VM Syslog event data.

DCRs you define can apply to any VMs in your subscription. Azure installs Azure Monitor Agent on VMs that don't already have it installed. DCRs can send performance counters to both Azure Monitor Metrics and Azure Monitor Logs, but can send Windows Events or Linux Syslog data to Azure Monitor Logs only. You must have a Log Analytics workspace and a data collection endpoint to send log data to. You can use the default Log Analytics workspace that VM Insights sets up for your subscription if you create the DCR in the same region as the Log Analytics workspace.

You can define a DCR to send data from multiple VMs to multiple destinations of the same or different types. For example, a DCR can send log data to multiple Log Analytics workspaces, also known as *multihoming*, across different regions or tenants. For performance counters, you can select from a predefined set of objects and set sampling rates, or create custom objects. For events, you can select severity levels to log.

## Create a DCR in Azure Monitor

In the Azure portal, search for and select *monitor* to go to the Azure Monitor **Overview** screen.

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
1. On the **Data Collection Rules** page, you can see the DCR that VM Insights already created.
1. Select **Create** to create a new data collection rule.

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
1. On the **Add data source** screen, select **Next: Destination** or the **Destination** tab, and make sure the **Account or namespace** matches the default workspace that Azure created for VM Insights.
1. On the **Add data source** screen, select **Add data source**.
1. On the **Create Data Collection Rule** screen, select **Review + create**, and when validation passes, select **Create**.

   :::image type="content" source="../media/create-dcr-finish.png" alt-text="Screenshot of Review + create highlighted on the Create Data Collection Rule screen." lightbox="../media/create-dcr-finish.png":::

## View log data

You can view the data collected by the DCR in your Log Analytics workspace by using a log query written in Kusto Query Language (KQL). A set of precreated KQL queries is available for VMs, but you can write a simple query to look at the events your DCR is collecting.

1. On your VM's **Overview** page, select **Logs** from the left navigation menu under **Monitoring**. Log Analytics opens an empty query window with the scope set to your VM.

   >[!NOTE]
   > The **Queries** window with precreated queries might open when you open Log Analytics. For now, close this window, because you're going to manually create a simple query.
   
1. In the empty query window, type *Syslog*, and then select **Run**. The events the DCR collected within the **Time range** are displayed.

   :::image type="content" source="../media/dcr-log.png" alt-text="Screenshot that shows the events returned from the Syslog by the DCR." lightbox="../media/dcr-log.png":::
