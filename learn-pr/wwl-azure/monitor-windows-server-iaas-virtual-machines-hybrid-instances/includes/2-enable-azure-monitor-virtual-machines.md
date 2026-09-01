Azure Monitor collects, analyzes, and acts on telemetry from Azure and hybrid resources. Use it to assess resource health, investigate performance, and respond to conditions that affect workloads.

## Understand Azure Monitor capabilities

Azure Monitor provides three core capabilities.

| Capability | Description |
|---|---|
| Metrics and visualization | Metrics are numeric values that describe resource health and performance over time. |
| Log collection and analysis | Logs contain events, diagnostics, and other records that you can query in a Log Analytics workspace. |
| Alerts and automated actions | Alert rules evaluate monitoring data and use action groups to notify responders or start automated actions. |

Azure resources provide platform metrics and activity logs without an agent. To collect data from a virtual machine's guest operating system and workloads, install the **Azure Monitor Agent**. Data collection rules (DCRs) define which data the agent collects, how Azure Monitor processes that data, and where Azure Monitor sends it.

VM insights simplifies this configuration. When you enable VM insights, Azure Monitor installs the Azure Monitor Agent if needed and creates or associates a DCR that collects performance data. You can use additional DCRs to collect Windows events, performance counters, and file-based logs.

## Review VM monitoring requirements

Before you enable monitoring, verify the following requirements.

| Requirement | Description |
|---|---|
| Supported machine | VM insights supports Azure VMs, Azure Virtual Machine Scale Sets, and Azure Arc-enabled servers. |
| Supported operating system | Azure Monitor Agent supports Windows Server 2016 and later, Windows 10 version 1803 and later, and supported Linux distributions. Review the current list before deployment. |
| Workspace | Use an Azure Monitor workspace for the recommended metrics-based experience. Use a Log Analytics workspace when you collect logs or use the classic logs-based experience. |
| Permissions | You need permission to create DCRs and associate them with VMs. You also need access to the destination workspace and monitored resources. |
| Network access | The VM must reach the Azure Monitor endpoints required by Azure Monitor Agent. |

> [!IMPORTANT]
> The legacy Log Analytics agent was retired on August 31, 2024. Use Azure Monitor Agent for new and migrated deployments.

## Enable monitoring for an Azure VM

To enable enhanced monitoring for one VM in the Azure portal:

1. Sign in to the Azure portal, and select **Virtual machines**.
2. Select a running VM, and then select **Insights** under **Monitoring**.
3. Select **Configure** or **Enable**.
4. Select the monitoring configuration and destination workspace. You can use an existing DCR or allow the portal to create one.
5. Select **Review + Enable**, and then select **Enable**.

Azure installs the Azure Monitor Agent extension, associates the selected DCR, and begins collecting data. It can take several minutes for charts and log records to appear.

## Review monitored data

Use the VM's **Insights** page to review processor, memory, disk, and network performance. Use **Logs** to query guest data sent to a Log Analytics workspace, and use **Alerts** to review or configure alert rules.

The Dependency Agent isn't required for VM insights performance monitoring. It supported the VM insights Map experience, which is deprecated and no longer available for new portal onboarding. Don't install the Dependency Agent for new deployments. The Map experience and Dependency Agent retire on June 30, 2028.

## Learn more

- [Enable VM monitoring in Azure Monitor](/azure/azure-monitor/vm/vminsights-enable-overview)
- [Azure Monitor Agent supported operating systems and environments](/azure/azure-monitor/agents/azure-monitor-agent-supported-operating-systems)
- [Collect guest log data from virtual machines with Azure Monitor](/azure/azure-monitor/vm/data-collection)
- [VM Insights Map and Dependency Agent retirement guidance](/azure/azure-monitor/vm/vminsights-maps-retirement)
