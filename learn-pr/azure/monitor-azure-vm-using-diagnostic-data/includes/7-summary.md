Azure provides many ways to monitor health and performance for your Azure VMs:

- Azure automatically collects and displays activity logs and important health and usage metrics for Azure VMs.
- You can quickly enable recommended alert rules and boot diagnostics when you create VMs or afterwards.
- Azure Monitor Metrics Explorer lets you graph many other metrics for Azure VMs and other resources.
- VM Insights predefined workbooks show important VM client performance and networking metrics.
- You can create DCRs that use the Azure Monitor Agent to collect OS and client workload metrics or logs.
- You can use Log Analytics to query and analyze log data.

Now that you understand these tools, you're confident that Azure Monitor can effectively monitor your Azure VMs and help you keep your website running effectively.

## Clean up resources

In this module, you created a VM in your Azure subscription. So you don't continue to incur charges for this VM, you can delete it or the resource group that contains it.

To delete the resource group that contains the VM and its resources:

1. Select the **Resource group** link at the top of the **Essentials** section on the VM's **Overview** page.
1. At the top of the resource group page, select **Delete resource group**.
1. On the delete screen, select the checkbox next to **Apply force delete for selected virtual machines and virtual machine scale sets**. Enter the resource group name in the field, and then select **Delete**.

## Learn more

To learn more about Azure Monitor for VMs, see the following resources:

- [Azure Monitor documentation](/azure/azure-monitor)
- [Monitor virtual machines with Azure Monitor](/azure/azure-monitor/vm/monitor-virtual-machine)
- [Supported metrics with Azure Monitor](/azure/azure-monitor/reference/supported-metrics/metrics-index)
- [Azure Monitor activity log](/azure/azure-monitor/essentials/activity-log)
- [Supported metrics for Microsoft.Compute/virtualMachines](/azure/azure-monitor/reference/supported-metrics/microsoft-compute-virtualmachines-metrics)
- [What is VM Insights?](/azure/azure-monitor/vm/vminsights-overview)
- [Create interactive reports with VM Insights workbooks](/azure/azure-monitor/vm/vminsights-workbooks)
- [View app dependencies with VM Insights](/azure/azure-monitor/vm/vminsights-maps)
- [Azure Monitor Agent](/azure/azure-monitor/agents/azure-monitor-agent-overview)
- [Collect events and performance counters from virtual machines with Azure Monitor Agent](/azure/azure-monitor/agents/data-collection-rule-azure-monitor-agent)
- [Tutorial: Collect guest logs and metrics from an Azure virtual machine](/azure/azure-monitor/vm/tutorial-monitor-vm-guest)
