Use a data collection rule (DCR) to collect Windows events and performance counters from an Azure VM or an Azure Arc-enabled server. When you add a machine to a DCR in the Azure portal, Azure installs the Azure Monitor Agent if needed and creates the DCR association.

## Create a data collection rule

To configure guest data collection in the Azure portal:

1. Open **Monitor**, and then select **Data Collection Rules**.
2. Select **Create**.
3. Enter a rule name, subscription, resource group, and region. Select **Windows** as the platform type.
4. On the **Resources** tab, add the Azure VM or Arc-enabled server that you want to monitor.
5. On the **Collect and deliver** tab, add a data source, such as **Windows Event Logs** or **Performance Counters**.
6. Select a Log Analytics workspace as the destination.
7. Select **Review + create**, and then select **Create**.

The DCR determines which events or counters Azure Monitor collects. Select only the data needed for analysis and alerts to control ingestion volume and cost.

## Validate data collection

After deployment, verify that the machine's Azure Monitor Agent extension has a status of **Provisioning succeeded**. Then open **Logs** in the destination workspace and query the relevant table:

- `Heartbeat` confirms that the agent is reporting.
- `Event` contains collected Windows events.
- `Perf` contains performance counter data collected by a standard logs DCR.
- `InsightsMetrics` contains performance data from a logs-based VM insights DCR.

It can take several minutes for the first records to appear. If a query returns no data, confirm that the DCR is associated with the correct machine, includes the expected data source, and sends data to the workspace you're querying.

## Learn more

- [Collect guest log data from virtual machines with Azure Monitor](/azure/azure-monitor/vm/data-collection)
- [Collect Windows events with Azure Monitor Agent](/azure/azure-monitor/agents/data-collection-windows-events)
- [Install and manage Azure Monitor Agent](/azure/azure-monitor/agents/azure-monitor-agent-manage)
