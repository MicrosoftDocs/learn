Your financial organization has successfully migrated several applications from on-premises to Azure virtual machines and Azure Kubernetes Services. Your organization wants to keep track of resource utilization to ensure the cloud resources have been adequately provisioned and their performance meets the business requirements. However, there are hundreds of resources currently deployed across several subscriptions, so you need a monitoring approach that provides broad visibility with the capability to triage and isolate problems when they arise.

You’ll use Azure Monitor for VMs, Azure Monitor for Containers and other Insights for an at-scale view across all your resources and drill into specific nodes and containers to continue troubleshooting.

## Criteria for assessing Azure Monitor virtual machine insights

You use Azure Monitor virtual machine insights if:

- You want to view the health and performance of your VMs
- You want to monitor your VMs at-scale across multiple subscriptions and resource groups.
- You want a topology view that shows the processes, dependencies, and network connection details of your VMs and scale sets.

You enable Azure Monitor virtual machine insights in the Get Started tab in the Virtual Machines blade of Azure Monitor. Enabling Azure Monitor for VMs adds the required extensions and configuration to your virtual machines and virtual machines scales sets to collect and store a set of utilization and performance measurements.

![Screenshot of getting started with Azure Monitor Virtual Machine insights in Portal](../media/5-vm-get-started.png)

## Monitor your virtual machines at-scale

Once enabled, you can view the VMs and scale sets with the highest resource utilization using Top N Charts and the Top N list in the Performance view. You can quickly identify outliers and performance hot spots where the allocated resources may be insufficient to support the existing load. From this view, you can access more details on the VM of interest including its properties, links to additional performance and connection workbooks, collected logs and alerts.

![Screenshot of Top N List of virtual machines in Portal](../media/5-top-virtual-machines.png)

As shown in the previous example, you can drill down to Azure Monitor Logs by selecting an event type from the list shown under Log Events. For example, selecting the VMConnection event type automatically opens the relevant Log Analytics workspace with appropriate table and filter applied.

![Screenshot of drill into Azure Monitor Logs from Virtual Machine insights](../media/5-drill-into-logs.png)

Access the Azure Monitor for VMs Map view to show network connections for an entire resource group, scale set or individual VM. Use the filters at the top of the view to select the resources of interest. You expand the number of processes for a complete list and to view the network connections per process. Select the arrow representing the connection for additional network usage and performance details.

![Screenshot of Virtual Machine insights map view](../media/5-vm-map-view.png)

## Criteria for assessing Azure Monitor container insights

You use Azure Monitor container insights if:

- You want to view the health and performance of your Kubernetes workloads at-scale across multiple subscriptions and resource groups.
- You want visibility into memory and processor performance metrics from controllers, nodes, and containers.
- If you want view and store container logs for real time and historical analysis.

You enable Azure Monitor container insights during the creation of your cluster or using the Unmonitored clusters tab in the Containers blade in Azure Monitor. Once monitoring is enabled the monitored clusters tab provides an at-scale view of the health and status of all your clusters, nodes, system pods and user pods. You use this view as a starting point to drill into problematic areas.

![Screenshot of Azure Monitor container insights multi-cluster view](../media/5-containers-monitored-clusters.png)

## Monitor Kubernetes clusters at-scale

You can view the performance and resource utilization of your Kubernetes workloads from different perspectives. You may want to investigate an over-utilized node, view the state of pods by controller or look at the number of restarts and CPU or memory utilization of a specific container. Azure Monitor for containers also allows you to filter by namespace, access live and previously collected logs as well as enable commonly used alerts.

![Screenshot of Azure Monitor container insights list of containers by utilization](../media/5-container-monitor-at-scale.png)

## Receive notifications and take action

You also need to configure alert rules for your infrastructure’s performance and availability. Use alert rules and action rules to dictate how alerts should be handled. In some cases, Insights include recommended alert templates, but you can also specify the conditions that should trigger an alert in your environment. Azure Monitor alerts can be based on the same metrics or log data used to populate Insights. For example, Insights can send an alert if a VM exceeds a utilization threshold or if a certain number of container restarts are observed. And you specify who should be notified. Send notifications through email or text message. Or use runbooks and webhooks to respond to alerts in an automated way.

![Screenshot of alert creation](../media/5-alert-creation.png)

You use Azure Monitor insights when you want to monitor resource utilization and performance at-scale with guided troubleshooting to triage and isolate issues. Insights exist for several Azure resources including networks, storage accounts and Cosmos DBs. See a complete list by navigating to the Insights Hub blade in Azure Monitor.

![Screenshot of Azure Monitor Insights Hub](../media/5-insights-hub.png)