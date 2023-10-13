When you host your virtual machines on Azure, you get built-in metrics collection and charts for important health and performance metrics without having to do anything more. You can quickly enable recommended alert rules and boot diagnostics when you create VMs or later.

You can collect and graph many more metrics for all your Azure VMs and other resources by using Azure Monitor Metrics Explorer. By enabling the Azure Monitor Agent through VM Insights, you can get and create predefined workbooks that show important performance and networking metrics. You can create DCRs to collect OS and workload metrics from client VMs, or to collect system event logs and send them to Azure Monitor Logs.

After implementing these tools, you're confident that you can monitor and manage your VMs to keep your group's website running effectively. You plan to use Azure Monitor with your other Azure-hosted resources to explore more cost and performance benefits.

## Clean up

[!include[](../../../includes/azure-subscription-cleanup.md)]

## Learn more

- [Azure Monitor documentation](/azure/azure-monitor)
- [Supported metrics with Azure Monitor](/azure/azure-monitor/reference/supported-metrics/metrics-index)
- [Monitor virtual machines with Azure Monitor](/azure/azure-monitor/vm/monitor-virtual-machine)
- [Supported metrics for Microsoft.Compute/virtualMachines](/azure/azure-monitor/reference/supported-metrics/microsoft-compute-virtualmachines-metrics)
- [What is VM Insights?](/azure/azure-monitor/vm/vminsights-overview)
- [Create interactive reports with VM insights workbooks](/azure/azure-monitor/vm/vminsights-workbooks)
- [View app dependencies with VM Insights](/azure/azure-monitor/vm/vminsights-maps)
- [Azure Monitor Agent](/azure/azure-monitor/agents/azure-monitor-agent-overview)
- [Collect events and performance counters from virtual machines with Azure Monitor Agent](/azure/azure-monitor/agents/data-collection-rule-azure-monitor-agent)
- [Tutorial: Enable recommended alert rules for Azure virtual machine](/azure/azure-monitor/vm/tutorial-monitor-vm-alert-recommended)
- [Tutorial: Collect guest logs and metrics from an Azure virtual machine](/azure/azure-monitor/vm/tutorial-monitor-vm-guest)
