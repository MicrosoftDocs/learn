Azure Arc enables organizations like Contoso to extend some capabilities of *Azure Policy* to computer operating systems that are in on-premises datacenters or are hosted on another cloud provider. This functionality applies to auditing the compliance of settings for the operating system, applications, and environment. Additionally, Contoso can configure the time zone on servers that are running the Windows Server operating system. 

Contoso IT staff can also use Azure Policy to manage and evaluate compliance for Azure Arc enabled Kubernetes clusters. Enabling this functionality requires that IT staff install the Azure Connected Machine agent on each computer in the scope of management. 

> [!IMPORTANT]
> Currently, you can only audit settings in this context. Auto-remediation is not yet available.

Contoso could use *Azure Monitor* to help monitor and manage their existing on-premises server resources. By integrating with Azure Arc, Contoso could extend comprehensive, cloud-based monitoring functionality beyond Azure to their on-premises resources, or to those hosted by third-party providers.

By maintaining their on-premises infrastructures, Contoso could benefit from this functionality when tracking, auditing, or troubleshooting past events. Using Monitor, they could monitor resources such as their onboarded servers. For example, they could select **Insights** to review a map of their resources' network connections.

:::image type="content" source="../media/5-insights-map.png" alt-text="Screenshot that depicts the Map tab on the Insights page for a VM in Azure. ContosoVM1 is displayed with details of open TCP ports. A VM summary is also displayed, detailing the VM's operating system, IP address, and links for Health, Machine properties, and Azure VM properties. Three buttons are displayed for access to Properties (selected), Log Events, Alerts, and Connections." border="false":::

## How can you leverage Azure Policy?

*Azure Policy* is a service that can help organizations manage and evaluate compliance for their Azure environments' organizational standards. Azure Policy uses declarative rules based on properties of target Azure resource types. These rules form policy definitions, which administrators can apply through policy assignment to a resource group or subscription.

For example, to simplify the management of policy definitions, Contoso could consider combining multiple policies into initiatives and then create a few initiative assignments instead of multiple policy assignments.

Azure Policy functionality is grouped into four main categories:

- Enforcing compliance when provisioning new Azure resources
- Auditing the compliance of existing Azure resources
- Remediating noncompliance of existing Azure resources
- Auditing the compliance of the OS, application configuration, and environment settings within Azure VMs

> [!TIP]
> The last of these categories is implemented by using the Azure Policy Guest Configuration client, which is available as an Azure VM extension. Azure Arc for servers uses the same client to provide auditing functionality in hybrid scenarios.

Specifically, Contoso IT staff could use Azure Policy to assign tags to resources during their deployment. After you install the agent, it requires outbound connectivity to Azure Arc over TCP port **443**. At that point, any Azure Policy Guest Configuration client-based configuration that's in the assigned policy or initiative definition will automatically take effect.

### Assign policies with Azure Arc

To manage and assign Azure Arc policies for a computer, browse to Azure Arc in the Azure portal. In the returned list of managed servers, select the appropriate server, and then assign a policy to it. You'll need to configure the following: 

- Scope and any exclusions from the scope of the policy.
- Policy definition.
- Assignment name.
- Description.
- Policy enforcement (Enabled or Disabled).

:::image type="content" source="../media/5-assign-policy.png" alt-text="The screenshot depicts the Assign policy page in the Azure portal. The administrator is selecting from a list of available policies." border="false":::

After assigning policies, you can review the policy settings on the selected server from Azure Arc.

:::image type="content" source="../media/5-review-policies.png" alt-text="The screenshot depicts the applied policies on ContosoVM1. Two policies are applied, and the VM is compliant with one but not the other." border="false":::

## How can you leverage Azure Monitor?

You can use Monitor to optimize the administration of your existing deployments and to forecast capacity requirements for future deployments. Monitor provides three main capabilities, which the following table describes.

| Capability                           | Description                                                  |
| ------------------------------------ | ------------------------------------------------------------ |
| Monitoring and metrics visualization | Metrics are numerical values that represent the health status of monitored systems. |
| Querying and analyzing logs          | Logs include activity, diagnostics, and telemetry. Their analysis provides deep insights into the state of monitored systems and helps facilitate troubleshooting. |
| Alerting and remediation             | You can configure these to automatically trigger corrective actions to remediate any issues. |

Monitor delivers focused, in-depth monitoring capabilities through:

- Deep infrastructure monitoring. This category includes Log Analytics combined with monitoring solutions, such as Service Map, and network monitoring tools, such as Network Watcher and Azure ExpressRoute Monitor.
- Deep application monitoring. This category includes Application Insights, which facilitates monitoring of performance, availability, and usage of web-based applications, regardless of their locations.

Both infrastructure and application monitoring services share capabilities that provide a consistent approach to configuring alerts, including:

- Common action groups that designate alert-triggered actions and recipients of the alerts.
- Designing custom dashboards.
- Analyzing metrics by using tools such as Metrics Explorer or Power BI.

Monitor supports collecting and monitoring metrics, activity and diagnostics logs, and events from a wide range of Azure services and computers both in on-premises datacenters and with other cloud providers. It provides a quick way to assess the status of your environment by using the Azure portal. Monitor presents a summary of triggered alerts, logs, metrics, and application-related telemetry originating from Application Insights. You can also access its data by using Azure PowerShell, the Azure CLI, REST APIs, and the Microsoft .NET SDK.

Additionally, Monitor enables you to archive collected data in Azure Storage for long-term analysis or compliance purposes. You can also route the data to Azure Stream Analytics or to services from Microsoft and others by using Azure Event Hubs. You set up and use alerts to:

- Trigger notifications via text message or email.
- Trigger a remediation action as implemented by Azure Logic Apps, Azure Functions, or a runbook in Azure Automation.
- Raise an incident and work items by taking advantage of the integration between Monitor and your internal IT service management platform.

You can store and analyze near real-time and historical data by using Log Analytics.
> [!NOTE]
> For on-premises computers and Azure VMs, this requires installing the Log Analytics agent, and in some cases, the Dependency Agent.

This agent-based approach enables you to monitor the OS and its workloads by using Automation-based or Monitor-based solutions such as Update Management or Change Tracking and Inventory. 

You can also use Azure Security Center to identify vulnerabilities and potential threats.
