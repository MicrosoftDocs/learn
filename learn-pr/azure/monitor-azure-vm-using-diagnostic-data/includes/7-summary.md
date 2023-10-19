When you host your VMs on Azure, you get built-in metrics collection and charts for important health and performance metrics without having to do anything more. You can quickly enable recommended alert rules and boot diagnostics when you create VMs or afterwards.

You can collect and graph many more metrics for all your Azure VMs and other resources by using Azure Monitor Metrics Explorer. By enabling the Azure Monitor Agent through VM Insights, you can get and create predefined workbooks that show important performance and networking metrics. You can create DCRs to collect OS and workload metrics from client VMs, or collect system event logs and send them to Azure Monitor Logs.

After implementing these tools, you're confident that you can use Azure Monitor to monitor and manage your VMs and help keep your group's website running effectively.

## Clean up resources

In this module, you created a VM in your Azure subscription. So you don't continue to incur charges for this VM, you can delete it or delete the resource group that contains it.

To delete the resource group that contains the VM:

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
