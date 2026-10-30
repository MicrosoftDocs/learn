Performance data helps identify anomalies. Linux Syslog provides additional event data that can help investigate them. The performance data collection rule (DCR) from the previous unit doesn't collect Syslog. You now create a separate DCR that sends selected Syslog events to the same Log Analytics workspace.

## Before you begin

Confirm that **monitored-linux-vm** has Azure Monitor Agent (AMA) installed, a managed identity configured, and access to the [required Azure Monitor endpoints](/azure/azure-monitor/agents/azure-monitor-agent-network-configuration). Record the region of the Log Analytics workspace selected in the previous unit.

This exercise uses public Azure Monitor endpoints. It doesn't configure Private Link or an Azure Monitor Private Link Scope (AMPLS).

> [!NOTE]
> Linux Syslog collection uses a supported Syslog daemon such as **rsyslog** or **syslog-ng**. The daemon forwards messages to AMA using the configuration installed for collection. AMA doesn't automatically collect every event that exists only in the systemd journal.

## Create the Syslog DCR

1. In the Azure portal, open **Monitor** > **Data Collection Rules** and select **Create**.
1. If the default creation experience opens, use its banner link to switch to the **classic creation experience**. The following steps use **Platform Type** and **Add data source** from that experience.
1. On **Basics**, enter **collect-events-linux** for the rule name.
1. Select your subscription and **learn-monitor-vm-rg**. For **Region**, select the region of the destination **Log Analytics workspace**.
1. For **Platform Type**, select **Linux**. Leave **Data Collection Endpoint** unselected for this public-endpoint Syslog exercise.

   :::image type="content" source="../media/create-dcr-basics-revised.png" alt-text="Screenshot of the DCR Basics tab with collect-events-linux, Linux selected, and no data collection endpoint." lightbox="../media/create-dcr-basics-revised.png":::

1. On **Resources**, select **Add resources**, select **monitored-linux-vm**, and select **Apply**. Don't select **Enable Data Collection Endpoints**.

   :::image type="content" source="../media/create-dcr-resources-revised.png" alt-text="Screenshot of the DCR Resources tab with monitored-linux-vm selected and Enable Data Collection Endpoints cleared." lightbox="../media/create-dcr-resources-revised.png":::

1. On **Collect and deliver**, select **Add data source**, then **Linux Syslog**.
1. Configure the **user**, **daemon**, and **syslog** facilities with minimum level **Warning** (shown as **LOG_WARNING** in some portal views). Set other facilities to **NONE** for this exercise. If using the bulk selector, select the intended facilities and apply the minimum level, then confirm the resulting level on each row.

   :::image type="content" source="../media/syslog-facilities-revised.png" alt-text="Screenshot of Linux Syslog settings with LOG_USER, LOG_DAEMON, and LOG_SYSLOG set to LOG_WARNING and other facilities set to none." lightbox="../media/syslog-facilities-revised.png":::

1. On **Destination**, select **Azure Monitor Logs** and the exact Log Analytics workspace used for performance collection.
1. Select **Add data source**, then **Review + create**, and **Create**.
1. Open the DCR's **Resources** page and confirm that the intended VM is associated. Allow several minutes for the configuration to reach the agent.

The minimum level includes Warning and more-severe events for the selected facilities. It doesn't mean "Warning only," and it doesn't collect unselected facilities. For more information, see [Collect Syslog events with AMA](/azure/azure-monitor/vm/data-collection-syslog) and [Create a VM data collection rule](/azure/azure-monitor/vm/data-collection).

> [!IMPORTANT]
> A DCE isn't required for this public-endpoint Syslog path. Private Link deployments, including AMA networks that share DNS with AMPLS resources, need additional endpoint and DNS configuration. Follow the [DCE requirements](/azure/azure-monitor/data-collection/data-collection-endpoint-overview#when-is-a-dce-required) and [Private Link guidance](/azure/azure-monitor/fundamentals/private-link-security) for that topology instead of treating this lab as a private-network recipe. Other data sources can also have their own DCE requirements.

## Generate an event that matches the DCR

1. On the VM, select **Operations** > **Run command** > **RunShellScript**. This executes on the Linux VM, not in the local computer's terminal.
1. Enter the following commands and select **Run** to check that the Syslog daemon and agent are active:

   ```bash
   systemctl is-active rsyslog
   systemctl is-active azuremonitoragent
   ```

   Both should report **active**. If either is inactive, resolve the service/configuration problem before continuing. Use the [AMA Syslog troubleshooting guidance](/azure/azure-monitor/agents/azure-monitor-agent-troubleshoot-linux-vm-rsyslog) rather than assuming collection succeeded.

1. After the previous command completes and the DCR has reached the agent, replace the script with the following command and select **Run**:

   ```bash
   logger -p user.warning -t learn-monitor-vm "learn-monitor-vm syslog test"
   ```

This creates one warning event in the **user** facility, matching the configured filter. [Run Command](/azure/virtual-machines/linux/run-command) uses the Azure VM agent and requires its documented outbound connectivity; it doesn't require opening an inbound SSH port.

## View the collected event

1. Open **Logs** from **monitored-linux-vm**. Confirm the resource scope is this VM.
1. If Simple mode is selected, switch to **KQL mode**. Close the example-query dialog if it opens.
1. Run the following query:

   ```kusto
   Syslog
   | where TimeGenerated > ago(30m)
   | where Facility == "user"
   | where SeverityLevel == "warning"
   | where SyslogMessage contains "learn-monitor-vm syslog test"
   | project TimeGenerated, Computer, Facility, SeverityLevel, SyslogMessage
   | order by TimeGenerated desc
   ```

   :::image type="content" source="../media/syslog-test-result-revised.png" alt-text="Screenshot of the KQL query and its matching user-facility warning event containing learn-monitor-vm syslog test." lightbox="../media/syslog-test-result-revised.png":::

The result should contain the test event. Data delivery isn't instantaneous. Allow several minutes; if the event was generated before the configuration arrived, generate a new event after confirming the association and agent health.

To inspect recent warnings across the collected facilities, run:

```kusto
Syslog
| where TimeGenerated > ago(30m)
| where SeverityLevel == "warning"
| top 100 by TimeGenerated desc
```

> [!NOTE]
> These queries assume the VM resource scope. If you open Logs from a workspace instead, constrain the query to the VM's full resource ID with an `_ResourceId` filter. A computer name alone might not uniquely identify a VM across a shared workspace. See [Log Analytics modes and scope](/azure/azure-monitor/logs/log-analytics-overview).

If the Syslog table isn't available yet or the query returns no matching records, check the DCR's destination and region, VM association, configured facility/severity values, Syslog daemon, AMA status, and network connectivity. This heartbeat query can help distinguish a disconnected agent from a Syslog-specific problem:

```kusto
Heartbeat
| where TimeGenerated > ago(30m)
| where Category == "Azure Monitor Agent"
| top 20 by TimeGenerated desc
```

A heartbeat confirms agent communication, not successful Syslog collection. The matching `Syslog` record is the exercise's success criterion. For more information, see [Troubleshoot AMA on Linux](/azure/azure-monitor/agents/azure-monitor-agent-troubleshoot-linux-vm) and [Syslog query examples](/azure/azure-monitor/reference/queries/syslog).
