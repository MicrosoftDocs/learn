Azure Monitor Logs collect and organize log data generated from Azure resources. Log data is stored in a Log Analytics workspace. Data living in the workspace can be queried for trend analysis, reporting, and alerting. Some examples of logs captured include Windows event logs, Heartbeat logs, Perf logs, and syslogs.

Azure Monitor for VMs is a set of features, which allow you to monitor virtual machines in greater detail from within the Azure portal. Think of Azure Monitor for VMs as a feature that provides a predefined, curated monitoring experience, with little configuration required. Azure Monitor for VMs uses a table named InsightsMetrics. Administrators can query performance and usage for virtual machines in near real time using that table. The data generated allows you to display everything in a meaningful way. Azure Monitor for VMs also allows administrators an ability to process log data without exposing the underlying queries.

## What is the relationship between all the Azure native monitoring tools?

There are a few different resources and services that complete the native monitoring toolkit in Azure. Azure Monitor becomes the service at the top, which spans across all monitoring tools with everything else lives underneath. The service collects and analyzes data generated from Azure resources. Azure Monitor can capture application monitoring data, guest OS monitoring data, Azure resource monitoring data, Azure subscription monitoring data, and Azure tenant monitoring data.

Data collected by Azure Monitor is composed of metrics (Azure Monitor Metrics) and logs (Azure Monitor Logs). Azure Monitor Metrics are lightweight numerical values stored in a time-series database that can be used for near real time (NRT) alerting. Some examples of metrics captured include IOPS percentages and CPU cycles. As we covered earlier, Azure Monitor Logs collects and organizes log data from Azure resources. The major difference between Azure Monitor Metrics and Azure Monitor Logs surrounds the structure of data generated. Azure Monitor Metrics can only store numeric data using a specific structure, while Azure Monitor Logs can store a variety of data types, each using their own structure. Azure Monitor Logs can also store Azure Monitor Metric data as well.

The following image shows how applications, resources, workloads, tenant data, and custom sources funnel into Azure Monitor (either metrics or logs). Once the data lives in metrics or logs, there are a number of different ways to visualize, analyze, respond, integrate, and view overall resource health.

:::image type="icon" source="../media/2-azure-monitor-overview.png" border="false" alt-text="Diagram that shows Azure resources generating data into metrics and logs, along with the Azure Monitor tooling you can use to consume data.":::

In addition to logs and metrics, Azure resources also emit Azure platform logs as well, which are also collected inside Azure Monitor. Platform logs provide comprehensive diagnostic and auditing information for Azure resources and the underlying Azure platform. Platform logs are resource logs (formerly known as diagnostic logs), activity logs, and Azure Active Directory logs. All resources automatically generate platform logs and send data to Azure Monitor. Administrators may need to configure certain platform logs to be forwarded to one or more destinations (like Log Analytics) in order to be retained.

## Plan a Log Analytics workspace deployment

One of the tasks involved with a Log Analytics deployment is picking the right design. Log Analytics workspaces are containers where Azure Monitor data is collected, aggregated, and analyzed. To better understand Log Analytics workspaces, the following diagram provides more insight into all the different types of logs that can be ingested. Everything from Event logs, to Syslogs, to Heartbeats, and so on. Then there are Azure Resources that can send platform logs and Azure Activity logs to the workspace as well.

:::image type="icon" source="../media/2-log-analytics-other-tables.png" border="false" alt-text="Diagram showing the different types of logs that can be stored in a Log Analytics workspace: Event Logs, Syslogs, Heartbeats, Perf, Activity Logs, Diagnostic Logs, and so on.":::

A number of Azure features help Log Analytics workspace adoption within enterprises. Log Analytics workspaces now provide different levels of access control for the collected logs.

| Feature | Description | Notes
| ---- | ---- | ---- |
| Access mode | Involves how users access a Log Analytics workspace, plus defines data scope | Two options: 1) workspace-context - provides access to all logs in a workspace where the permission is assigned. Queries are scoped to all data in all tables. 2) resource-context - provides access to view logs for resources in all tables you have access to. Queries are scoped to only data associated with that resource.
Access control mode | Defines how permissions work for any given Log Analytics workspace. | Require workspace permissions means a user would have access to all data in any table where permissions have been defined, which does not allow granular role-based access control (RBAC). Then there's the use resource or workspace permissions, which allows for granular RBAC, as users can only see log data for resources they are permitted to view. Permissions can be applied to an individual or to groups of users for the workspace or resource.
| Table level RBAC | Provides a mechanism to define more granular data control inside a Log Analytics workspace in conjunction with other permissions listed in the table. | This feature allows an administrator to define what specific data types are accessible to a set of users. Configuring table level RBAC requires Azure custom roles to either grant or deny access to specific tables. These roles are applied to Log Analytics workspaces, with either workspace-context or resource-context access modes configured.

From a daily operations point of view, the best strategy is to limit the total number of workspaces required for daily operations. Reducing the number of workspaces will make administration and query experience easier and quicker. Multiple workspaces may still need to be a design consideration for certain companies. An example may be if you are employed by a global company and require data sovereignty.

## Azure collects compute monitoring data by using agents

Compute resources in Azure require a number of agents to help collect monitoring data inside Log Analytics and Azure Monitor. Each agent allows customers to measure performance, responsiveness, and availability of guest operating systems and underlying workloads.

The following table lists each agent.

| Agent | Description | Notes
| ---- | ---- | ---- |
| Log Analytics agent | Collects logs and performance data for virtual machines in Azure, other clouds, or on-premises. | Allows the onboarding of Azure Security Center and Azure Sentinel. The agent also works in conjunction with Azure Automation accounts to onboard solutions like Azure Update Management, Azure Automation State Configuration, along with Azure Automation Change Tracking and Inventory.
| Azure diagnostics extension | Enables customers to receive additional data from guest operating systems and workloads living on compute resources. | Data primarily captured with this extension will be sent to Azure Monitor Metrics, which can be collected and analyzed inside a Log Analytics workspace. If necessary, this data could also be sent to a third-party tool by using Azure Event Hubs, sent to Azure Storage for archival, or you could collect boot diagnostics, which helps with investigations for virtual machine boot issues.
| Dependency agent | Collects discovered data about certain processes running on virtual machines. | Maps all dependencies between virtual machines and any external process dependencies.

As referenced earlier, Azure Monitor for VMs also needs to be enabled in order for a Log Analytics workspace to be used with Azure Monitor virtual machine log data. Azure Monitor for VMs is a newer service that provides additional visibility and capabilities for data collection of virtual machines.

Lastly, there are a number of solutions an administrator can install or enable, which provides deeper analytics on any given Azure application or service. Each monitoring solution requires a Log Analytics workspace to store collected data. Some solutions also require an Automation Account as well, which contain resources like runbooks that help complete the solution.

In the next unit, we'll show you how to deploy a Log Analytics workspace with the right access control. From there, we'll walk through deploying the Log Analytics extension and enabling Azure Monitor for VMs.