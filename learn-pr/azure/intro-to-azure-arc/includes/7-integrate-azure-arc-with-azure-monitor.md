<!-- 5 minutes to read
Title for unit: Integrate Azure Arc with Azure Monitor
-->

You can use Azure Monitor to help monitor and manage your server resources. *Azure Monitor* is a core component of the Microsoft strategy to extend comprehensive, cloud-based monitoring functionality beyond Azure to on-premises datacenters and to Microsoft and other cloud providers.

By maintaining their on-premises infrastructures, Contoso can benefit from this functionality when tracking, auditing, or troubleshooting past events. Using Monitor, you can monitor resources such as your onboarded servers. For example, you can select **Insights** to review a map of your server resources.

![Screenshot that depicts the Map tab on the Insights page for a VM in Azure. ContosoVM1 is displayed with details of open TCP ports. A VM summary is also displayed, detailing the VM's operating system, IP address, and links for Health, Machine properties, and Azure VM properties. Three buttons are displayed for access to Properties (selected), Log Events, Alerts, and Connections.](../media/insights-map.png)

## How can you use Azure Monitor?

You can use Monitor to optimize the administration of your existing deployments and to forecast capacity requirements for future deployments. Monitor provides three main capabilities, which the following table describes.

|Capability|Description|
|------------------------------------|------------------------------------------------------------|
|Monitoring and metrics visualization|Metrics are numerical values that represent the health status of monitored systems.|
|Querying and analyzing logs|Logs include activity, diagnostics, and telemetry. Their analysis provides deep insights into the state of monitored systems and helps facilitate troubleshooting.|
|Alerting and remediation|You can configure these to automatically trigger corrective actions to remediate any issues.|

Monitor delivers focused, in-depth monitoring capabilities through:

- Deep infrastructure monitoring. This category includes Log Analytics combined with monitoring solutions, such as Service Map, and network monitoring tools, such as Network Watcher and Azure ExpressRoute Monitor.
- Deep application monitoring. This category includes Application Insights, which facilitates monitoring of performance, availability, and usage of web-based applications, regardless of their locations.

Both infrastructure and application monitoring services share capabilities that provide a consistent approach to configuring alerts, including:

- Common action groups that designate alert-triggered actions and recipients of the alerts.
- Designing custom dashboards.
- Analyzing metrics by using tools such as Metrics Explorer or Power BI.

Monitor supports collecting and monitoring metrics, activity and diagnostics logs, and events from a wide range of Azure services and computers both in on-premises datacenters and with other cloud providers. It provides a quick way to assess the status of your environment by using the Azure portal. Monitor presents a summary of triggered alerts, logs, metrics, and application-related telemetry originating from Application Insights.

> [!NOTE]
> You can also access its data by using Azure PowerShell, the Azure CLI, REST APIs, and the Microsoft .NET SDK.

Additionally, Monitor enables you to archive collected data in Azure Storage for long-term analysis or compliance purposes. You can also route the data to Azure Stream Analytics or to services from Microsoft and others by using Azure Event Hubs. You set up and use alerts to:

- Trigger notifications via text message or email.
- Trigger a remediation action as implemented by Azure Logic Apps, Azure Functions, or a runbook in Azure Automation.
- Raise an incident and work items by taking advantage of the integration between Monitor and your internal IT service Management platform.

You can also store and analyze near real-time and historical data by using Log Analytics. For on-premises computers and Azure VMs, this requires installing the Log Analytics agent, and in some cases, the Dependency Agent as well. This agent-based approach enables you to monitor the OS and its workloads by using Automation-based or Monitor-based solutions such as Update Management or Change Tracking and Inventory. You can also use Azure Security Center to identify vulnerabilities and potential threats.

To learn more, review this five-minute video tutorial on Monitor:

>[!VIDEO https://www.microsoft.com/videoplayer/embed/RE4zf4p]

## Additional reading

You can learn more by reviewing the following documents:

- [Enable monitoring of Azure Arc enabled Kubernetes cluster](https://aka.ms/container-insights-enable-arc-enabled-clusters?azure-portal=true).
- [Azure Monitor for containers overview](https://aka.ms/container-insights?azure-portal=true).
