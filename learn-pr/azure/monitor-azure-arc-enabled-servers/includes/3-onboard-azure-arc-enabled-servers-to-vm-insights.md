Tailwind Manufacturing has onboarded its machines to Azure Arc-enabled servers, and now wants to use VM insights. In this unit, you learn how to configure and collect data from your Azure Arc-enabled servers by enabling VM insights.

## Enable VM insights

Enable VM insights on an Azure Arc-enabled server to collect guest performance data with Azure Monitor Agent.

Before you begin, connect the server to Azure Arc and verify that its operating system is supported by AMA. You need permission to manage the machine's extensions, create or select data collection rules and associate them with the machine, and use the destination workspace. Allow the Azure Arc and AMA network endpoints required by your deployment. An Arc connection alone doesn't prove that monitoring data can reach Azure Monitor.

For this module, enable logs-based performance collection and use a Log Analytics workspace. The subsequent alert exercise queries the InsightsMetrics table in that workspace.

1. Sign in to the Azure portal, open **Azure Arc**, and select **Machines** under **Infrastructure**. Select the connected server.
1. Under **Monitoring**, select **Insights**. On the **Monitor** page, select **Configure** to open the monitoring configuration.
1. Select the logs-based monitoring option. If you also enable OpenTelemetry metrics, remember that those metrics use an Azure Monitor workspace and PromQL. Enabling only OpenTelemetry metrics doesn't supply the InsightsMetrics data used later in this module.
1. Select **Customize infrastructure monitoring**. Choose the Log Analytics workspace for logs-based performance data, and create or select the corresponding VM insights data collection rule. Confirm that the configuration applies the rule to the selected server.
1. Select **Review + Enable**, review the resources and collection settings, and then select **Enable**. Allow time for the AMA extension to install and for collected data to arrive.
1. Return to **Insights**. If an experience selector is shown, select **Log based visualizations (Classic)**, and then select **Performance**. Inspect the available guest performance charts. The charts show collected data, not performance history from before collection was configured.
1. Under **Monitoring**, select **Logs**. Check for recent Heartbeat and InsightsMetrics records associated with this machine. Heartbeat confirms agent reporting; also check the required performance records before creating a performance alert.
1. If you want to inspect Windows event logs, first configure a Windows events data source in an associated DCR with a Log Analytics destination. Select the logs, severity levels, or XPath filters required for your scenario. After matching events arrive, inspect the Event table. This optional step applies to Windows, and the table contains the events selected by your collection configuration, not every Windows event.

If the expected table or records are missing, check the DCR association, selected data source and destination, agent health, ingestion delay, query scope, time range, and access permissions. Log Analytics hides empty tables by default, so a missing table isn't proof that no collection rule exists.

> [!IMPORTANT]
> For new servers, use AMA-based performance monitoring without installing Dependency Agent or verifying a Map view. Microsoft discourages new installations, and portal onboarding to the mapping capability was restricted after September 30, 2025. Existing installations reach end of support on June 30, 2028. VM insights performance monitoring isn't affected. For inventory requirements, evaluate AMA-based Change Tracking and Inventory. Inventory isn't a replacement for process-dependency or network-topology mapping; use the separate replacement-evaluation guidance in the Summary unit's More Info section for those requirements.

For details, see monitoring a hybrid machine, comparing metrics-based and logs-based monitoring, collecting Windows events, and dependency-mapping lifecycle guidance in the Summary unit's More Info section.
