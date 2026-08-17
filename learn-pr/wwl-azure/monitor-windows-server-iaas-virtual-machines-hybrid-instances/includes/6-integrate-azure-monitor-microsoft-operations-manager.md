Organizations can use System Center Operations Manager and Azure Monitor as independent monitoring platforms during a gradual modernization. Operations Manager remains useful for management-pack-based monitoring of on-premises applications and infrastructure. Azure Monitor provides cloud-scale metrics, logs, insights, workbooks, and alerting for Azure and Arc-enabled resources.

## Compare coexistence options

Choose a coexistence approach based on the monitoring features you need.

| Approach | Guidance |
|---|---|
| Azure Monitor Agent alongside the Operations Manager agent | This is the recommended coexistence model. The agents can run on the same machine. Azure Monitor Agent uses DCRs, while the Operations Manager agent continues to use management packs and the management group. |
| Connected Operations Manager management group | A connected management group can forward legacy agent data to a Log Analytics workspace. This model requires the legacy agent, doesn't support DCR-based collection, and doesn't enable VM insights unless you onboard each machine directly to Azure Monitor. |
| Azure management pack | The Azure management pack provides selected Azure resource health information in the Operations console. It requires configuration for the Azure resources you want to monitor. |

Don't use a connected management group as the onboarding path for new Azure Monitor deployments. Connect hybrid machines to Azure Arc, install Azure Monitor Agent, and associate DCRs directly with those machines.

## Plan a gradual transition

Use these steps to plan coexistence or migration:

1. Inventory the management packs, rules, monitors, alerts, reports, and business processes that your organization uses.
2. Identify the events, performance counters, and logs required for each critical monitoring scenario.
3. Configure Azure Monitor Agent and DCRs for machines that Azure Monitor will monitor.
4. Re-create required alert behavior with Azure Monitor alert rules and action groups.
5. Compare results from both platforms and tune collection and alert thresholds.
6. Retire management-pack workflows only after Azure Monitor or another service meets the operational requirement.

Azure Monitor separates data collection from alert evaluation. DCRs define the data to collect, while alert rules evaluate metrics or logs. This differs from Operations Manager management packs, which can combine collection, health evaluation, and alerting in one workflow.

> [!IMPORTANT]
> The VM insights Map and Dependency Agent are deprecated and retire on June 30, 2028. Don't design new Operations Manager integrations around Service Map or the VM insights Map experience.

## Learn more

- [Migrate from System Center Operations Manager to Azure Monitor](/azure/azure-monitor/fundamentals/azure-monitor-operations-manager)
- [Monitor virtual machines with Azure Monitor](/azure/azure-monitor/vm/monitor-virtual-machine)
- [Migrate management pack logic for VM workloads](/azure/azure-monitor/vm/monitor-virtual-machine-management-packs)
