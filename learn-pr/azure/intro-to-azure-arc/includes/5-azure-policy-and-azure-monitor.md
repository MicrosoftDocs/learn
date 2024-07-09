Azure Arc enables organizations like Contoso to extend Azure capabilities to computer operating systems that are in on-premises datacenters or are hosted on another cloud provider. For example, Azure Policy can be used to audit the compliance of settings for the operating system, applications, and environment. Contoso IT staff can also use Azure Policy to manage and evaluate compliance for Azure Arc-enabled Kubernetes clusters.

Similarly, Contoso could use Azure Monitor to help monitor and manage their existing on-premises server resources that are connected through Azure Arc. Azure Monitor Container Insights can help Contoso collect health and resource utilization data for their Azure Arc-enabled Kubernetes clusters.

:::image type="content" source="../media/5-insights-map.png" alt-text="Screenshot that depicts the Map tab on the Insights page for a VM in Azure. ContosoVM1 is displayed with details of open TCP ports. A VM summary is also displayed." border="false" lightbox="../media/5-insights-map.png":::

## How can you use Azure Policy?

Azure Policy is a service that can help organizations manage and evaluate compliance for their Azure environments' organizational standards. Azure Policy uses declarative rules based on properties of target Azure resource types. These rules form policy definitions, which administrators can apply through policy assignment to a resource group or subscription.

Azure Policy functionality for Arc-enabled servers includes:

- Enforcing compliance when provisioning new Azure resources.
- Auditing the compliance of existing Azure resources.
- Auditing the compliance of the OS, application configuration, and environment settings within Azure VMs.

To manage and assign Azure Arc policies for a computer, browse to Azure Arc in the Azure portal. In the returned list of managed servers, select the appropriate server, and then assign a policy to it. You need to configure the following settings:

- Policy scope, and any exclusions from the policy's scope
- Policy definition
- Assignment name
- Description
- Policy enforcement (Enabled or Disabled)

:::image type="content" source="../media/5-assign-policy.png" alt-text="The screenshot depicts the Assign policy page in the Azure portal. The administrator is selecting from a list of available policies." border="false" lightbox="../media/5-assign-policy.png" :::

After assigning policies, you can review the policy settings on the selected server from Azure Arc.

:::image type="content" source="../media/5-review-policies.png" alt-text="The screenshot depicts the applied policies on ContosoVM1. Two policies are applied, and the VM is compliant with one but not the other." border="false" lightbox="../media/5-review-policies.png":::

## How can you use Azure Monitor?

You can use Monitor to optimize the administration of your existing deployments and to forecast capacity requirements for future deployments. Monitor delivers focused, in-depth monitoring capabilities through:

- Monitoring and metrics visualization.
- Querying and analyzing logs.
- Alerting and remediation.

You can collect and monitor metrics, activity and diagnostic logs, and events for Arc-enabled servers. Azure Monitor can collect data directly from your connected machines into a Log Analytics workspace for detailed analysis and correlation.

Deploying the Azure Monitor agent to your Arc-enabled servers lets you do the following:

- Monitor the operating system and any workloads running on the machine or server using VM insights
- Analyze and alert using Azure Monitor
- Perform security monitoring in Azure by using Microsoft Defender for Cloud or Microsoft Sentinel
- Collect inventory and track changes by using Azure Automation Change Tracking and Inventory

For Azure Arc-enabled Kubernetes, you can use Container insights, a feature of Azure Monitor that monitors the performance and health of container workloads. Container insights helps to collect memory and processor metrics from controllers, nodes, and containers, in addition to gathering container logs. You can analyze the collected data for the different components in your Kubernetes clusters with a collection of views and pre-built workbooks.

You can archive collected monitoring data in Azure Storage for long term analysis or compliance purposes. You can also route this data to Azure Stream Analytics, or to other services, for further analysis.
