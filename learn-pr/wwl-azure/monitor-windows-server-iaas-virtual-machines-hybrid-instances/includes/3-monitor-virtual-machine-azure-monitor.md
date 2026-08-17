After you enable enhanced monitoring, Azure Monitor uses the Azure Monitor Agent and associated data collection rules (DCRs) to collect guest operating system data. Review the configuration and incoming data to confirm that monitoring works as expected.

## Verify the monitoring configuration

On the VM's **Insights** page, confirm that the monitoring configuration shows as enabled. Azure Monitor installs the `AzureMonitorWindowsAgent` extension on Windows VMs and the `AzureMonitorLinuxAgent` extension on Linux VMs.

To verify the extension directly:

1. In the Azure portal, open the VM.
2. Under **Settings**, select **Extensions + applications**.
3. Confirm that the Azure Monitor Agent extension has a status of **Provisioning succeeded**.
4. Under **Monitoring**, select **Insights**, and verify that performance charts contain data.

It can take several minutes after onboarding for data to appear.

## Analyze monitoring data

Use the following Azure Monitor experiences to investigate VM health and performance:

- **Insights** displays processor, memory, disk, and network performance.
- **Metrics** displays platform metrics and supports charting and aggregation.
- **Logs** lets you query guest operating system data in a Log Analytics workspace by using Kusto Query Language (KQL).
- **Alerts** evaluates metrics or logs and uses action groups to notify responders or start automated actions.

For logs-based monitoring, query the `Heartbeat` table to confirm that Azure Monitor Agent is reporting. The `InsightsMetrics` table contains performance data collected by the classic logs-based VM insights configuration. Other tables appear when DCRs collect Windows events, Syslog, or custom logs.

## Learn more

- [Monitor virtual machines with Azure Monitor](/azure/azure-monitor/vm/monitor-virtual-machine)
- [Analyze monitoring data for virtual machines](/azure/azure-monitor/vm/monitor-virtual-machine-analyze)
- [Create Azure Monitor alert rules](/azure/azure-monitor/alerts/alerts-create-new-alert-rule)
