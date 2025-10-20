## Logging and auditing in Microsoft cloud security benchmark

Microsoft cloud security benchmark provides guidance on designing logging capabilities, which is summarized in the following table. For more complete information about these controls, see [Microsoft cloud security benchmark - Logging and threat detection](/security/benchmark/azure/mcsb-logging-threat-detection)

Refer to [Introduction to Microsoft Cybersecurity Reference Architecture and cloud security benchmark](/training/modules/design-solutions-microsoft-cybersecurity-cloud-security-benchmark/1-introduction-reference-architecture-benchmark) for more background on Microsoft Cloud Security Benchmark.

The summary that follows, includes controls from the full baseline where:

* Security controls are *supported* but *not* enabled by default
* There's explicit guidance that contains action to be taken on the part of the customer

| Control number | Title | Summary |
|---|---|---|
| LT-3   | Enable logging for security investigation  | Enable logging for your cloud resources to meet the requirements for security incident investigations and security response and compliance purposes. |
| LT-4  | Enable network logging for security investigation  | Enable logging for your network services to support network-related incident investigations, threat hunting, and security alert generation. The network logs may include logs from network services such as IP filtering, network and application firewall, DNS, flow monitoring and so on. |
| LT-5  | Centralize security log management and analysis  | Centralize logging storage and analysis to enable correlation across log data. For each log source, ensure that you have assigned a data owner, access guidance, storage location, what tools are used to process and access the data, and data retention requirements. Use Cloud native SIEM if you don't have an existing SIEM solution for CSPs. or aggregate logs/alerts into your existing SIEM. |
| LT-6  | Configure log storage retention  | Plan your log retention strategy according to your compliance, regulation, and business requirements. Configure the log retention policy at the individual logging services to ensure the logs are archived appropriately. |

## Centralized logging on Azure

The recommended logging guidance from MCSB on Azure is the following:

* Ensure that you're integrating Azure activity logs into a centralized Log Analytics workspace.
* Use Azure Monitor to query and perform analytics and create alert rules using the logs aggregated from Azure services, endpoint devices, network resources, and other security systems.
* In addition, enable and onboard data to Microsoft Sentinel, which provides the security information event management (SIEM) and security orchestration automated response (SOAR) capability.

## Azure Monitor overview

Azure Monitor is a comprehensive monitoring solution for collecting, analyzing, and responding to telemetry from your cloud and on-premises environments. You can use Azure Monitor to maximize the availability and performance of your applications and services.

Azure Monitor collects and aggregates the data from every layer and component of your system into a common data platform. It correlates data across multiple Azure subscriptions and tenants, in addition to hosting data for other services. Because this data is stored together, it can be correlated and analyzed using a common set of tools. The data can then be used for analysis and visualizations to help you understand how your applications are performing and respond automatically to system events.

Azure Monitor also includes Azure Monitor SCOM Managed Instance, which allows you to move your on-premises System Center Operation Manager (Operations Manager) installation to the cloud in Azure.

Use Azure Monitor to monitor these types of resources in Azure, other clouds, or on-premises:

* Applications
* Virtual machines
* Guest operating systems
* Containers
* Databases
* Security events in combination with Microsoft Sentinel
* Networking events and health in combination with Network Watcher
* Custom sources that use the APIs to get data into Azure Monitor
* Collect your Prometheus metrics with Azure Managed Prometheus and analyze them using PromQL in Azure Managed Grafana.

You can also export monitoring data from Azure Monitor into other systems so you can:

* Integrate with other non-Microsoft and open-source monitoring and visualization tools
* Integrate with ticketing and other ITSM systems

### High level architecture

The following diagram gives a high-level view of Azure Monitor.

![Architecture diagram showing the system components of Azure Monitor.](../media/overview-02-2023.png)

The diagram depicts the Azure Monitor system components:

* The **[data sources](/azure/azure-monitor/data-sources)** are the types of data collected from each monitored resource. The data is collected and routed to the **data platform**.
* The **[data platform](/azure/azure-monitor/data-platform)** is made up of the data stores for collected data. Azure Monitor's data platform has stores for metrics, logs, traces, and changes.
* The functions and components that consume data include analysis, visualizations, insights, and responses.
* Services that integrate with Azure Monitor to provide more functionality and are integrated throughout the system.
<!--
[](/azure/azure-monitor/overview#data-sources)
-->

### Data sources

Azure Monitor can collect data from multiple sources, including from your application, operating systems, the services they rely on, and from the platform itself.

You can integrate monitoring data from sources outside Azure, including on-premises and other non-Microsoft clouds, using the application, infrastructure, and custom data sources.

Azure Monitor collects these types of data:

|Data type  |Description  |
|---------|---------|
|Application|Data about the performance and functionality of your application code on any platform.|
|Infrastructure|**- Container.** Data about containers, such as Azure Kubernetes Service, Prometheus, and about the applications running inside containers.<br>**- Operating system.** Data about the guest operating system on which your application is running.|
|Azure Platform|**- Azure resource**. The operation of an Azure resource.<br>**- Azure subscription.** The operation and management of an Azure subscription, and data about the health and operation of Azure itself.<br>**- Azure tenant.** Data about the operation of tenant-level Azure services, such as Microsoft Entra ID.<br>**- Azure resource changes.** Data about changes within your Azure resources and how to address and triage incidents and issues. |
|Custom Sources|Use the Azure Monitor REST API to send customer metric or log data to Azure Monitor and incorporate monitoring of resources that don’t expose monitoring data through other methods.|

For detailed information about each of the data sources, see [data sources](/azure/azure-monitor/data-sources).
<!--
[](/azure/azure-monitor/overview#data-collection-and-routing)
-->

### Data collection and routing

Azure Monitor collects and routes monitoring data using several mechanisms, depending on the data being routed and the destination data platform stores.

|Collection method|Description  |
|---------|---------|
|Direct data routing|Platform metrics are sent automatically to Azure Monitor Metrics by default and without configuration.|
|Diagnostic settings|Use diagnostic settings to determine where to send resource and activity log data on the data platform.|
|Data collection rules|Use data collection rules to specify what data should be collected, how to transform that data, and where to send that data.|
|Application SDK|Add the Application Insights SDK to your application code to receive, store, and explore your monitoring data. The SDK preprocesses telemetry and metrics before sending the data to Azure where it's ingested and processed further before being stored in Azure Monitor Logs.|
|Azure Monitor REST API|The Logs Ingestion API in Azure Monitor lets you send data to a Log Analytics workspace from any REST API client.|
|Azure Monitor Agents|Azure Monitor Agent (AMA) collects monitoring data from the guest operating system of Azure and hybrid virtual machines and delivers it to Azure Monitor for use by features, insights, and other services, such as Microsoft Sentinel and Microsoft Defender for Cloud.|
|Azure Monitor managed service for Prometheus|Azure Monitor managed service for Prometheus lets you collect and analyze metrics at scale using a Prometheus-compatible monitoring solution, based on the Prometheus project from the Cloud Native Compute Foundation.

For detailed information about data collection, see [data collection](/azure/azure-monitor/best-practices-data-collection).
<!--
[](/azure/azure-monitor/overview#data-platform)
-->

### Data platform

Azure Monitor stores data in data stores for each of the pillars of observability: metrics, logs, distributed traces, and changes. Each store is optimized for specific types of data and monitoring scenarios.

|Pillar of observability/<br>Data store|Description|
|---------|---------|
|Azure Monitor Metrics|Metrics are numerical values that describe an aspect of a system at a particular point in time. Azure Monitor Metrics is a time-series database, optimized for analyzing time-stamped data. Azure Monitor collects metrics at regular intervals. Metrics are identified with a timestamp, a name, a value, and one or more defining labels. They can be aggregated using algorithms, compared to other metrics, and analyzed for trends over time. It supports native Azure Monitor metrics and Prometheus metrics|
|Azure Monitor Logs|Logs are recorded system events. Logs can contain different types of data, be structured or free-form text, and they contain a timestamp. Azure Monitor stores structured and unstructured log data of all types in Azure Monitor Logs. You can route data to Log Analytics workspaces for querying and analysis.|
|Traces|Distributed traces identify the series of related events that follow a user request through a distributed system. A trace measures the operation and performance of your application across the entire set of components in your system. Traces can be used to determine the behavior of application code and the performance of different transactions. Azure Monitor gets distributed trace data from the Application Insights SDK. The trace data is stored in a separate workspace in Azure Monitor Logs.|
|Changes|Changes are a series of events in your application and resources. They're  tracked and stored when you use the Change Analysis service, which uses Azure Resource Graph as its store. Change Analysis helps you understand which changes, such as deploying updated code, may have caused issues in your systems.|

## Auditing solutions in Microsoft Purview

Microsoft Purview auditing solutions provide an integrated solution to help organizations effectively respond to security events, forensic investigations, internal investigations, and compliance obligations. Thousands of user and admin operations performed in dozens of Microsoft 365 services and solutions are captured, recorded, and retained in your organization's unified audit log. Audit records for these events are searchable by security ops, IT admins, insider risk teams, and compliance and legal investigators in your organization. This capability provides visibility into the activities performed across your Microsoft 365 organization.

### Auditing features

Microsoft Purview Audit (Standard) provides with you with the ability to log and search for audited activities and power your forensic, IT, compliance, and legal investigations.

* *Enabled by default.* Audit (Standard) is turned on by default for all organizations with the appropriate subscription. That means records for audited activities are captured and searchable. The only setup that required is to assign the necessary permissions to access the audit log search tool (and the corresponding cmdlet) and make sure that users are assigned the right license for Microsoft Purview Audit (Premium) features.

* *Thousands of searchable audit events.* You can search for a wide-range of audited activities that occur is most of the Microsoft 365 services in your organization. For a list of the activities you can search for, see Audit log activities. For a list of the services and features that support audited activities, see Audit log record type.

* *Audit search tool in the Microsoft Purview portal.* Use the Audit log search tool in the portals to search for audit records. You can search for specific activities, for activities performed by specific users, and activities that occurred with a date range.

* *Search-UnifiedAuditLog cmdlet.* You can also use the Search-UnifiedAuditLog cmdlet in Exchange Online PowerShell (the underlying cmdlet for the search tool) to search for audit events or to use in a script. For more information, see:
  * Search-UnifiedAuditLog cmdlet reference
  * Use a PowerShell script to search the audit log

* *Export audit records to a CSV file.* After running the Audit log search tool in the Microsoft Purview portal, you can export the audit records returned by the search to a CSV file. This lets you use Microsoft Excel sort and filter on different audit record properties. You can also use Excel Power Query transform functionality to split each property in the AuditData JSON object into its own column. This lets you effectively view and compare similar data for different events. For more information, see Export, configure, and view audit log records.

* *Access to audit logs via Office 365 Management Activity API.* A third method for accessing and retrieving audit records is to use the Office 365 Management Activity API. This lets organizations retain auditing data for longer periods than the default 180 days and lets them import their auditing data to a SIEM solution. For more information, see Office 365 Management Activity API reference.

* *180-day audit log retention.* When an audited activity is performed by a user or admin, an audit record is generated and stored in the audit log for your organization. In Audit (Standard), records are retained for 180 days, which means you can search for activities that occurred within the past six months.

## Log storage tiers in Microsoft Sentinel

Microsoft Sentinel is a cloud-native Security Information and Event Management (SIEM) solution that provides comprehensive visibility and threat detection across an organization's entire technology ecosystem. When you create an instance of Microsoft Sentinel, you create or select an Azure Log Analytics workspace and enable Microsoft Sentinel on that workspace. That workspace becomes the SIEM data repository.

Microsoft Sentinel, being cloud-based solution, introduces cost considerations. You pay for data ingestion, data retention, and sometimes queries. Also, organizations have different needs for logs. Some logs contain high fidelity data that have critical security value and are used for real-time monitoring, alerts, and analytics. Other logs contain high volume data and limited security value, but help draw a full picture of security incident or breach through on-demand querying, analytics, and long-term hunting. So, while all logs can be useful, not all logs are of equal value.

Microsoft Sentinel is designed with two distinct storage tiers to optimize cost and performance:

* Analytics tier: The existing Microsoft Sentinel data tier (log analytics) supporting advanced hunting, alerting, and incident management to help you proactively identify and resolve issues across your infrastructure and applications. This tier is designed for high-performance analytics and real-time data processing.
* Data lake tier: Provides centralized long-term storage for querying and Python-based advanced analytics. It's designed for cost effective retention of large volumes of security data for up to 12 years. Data in the data lake tier isn’t available for real-time analytics features and threat hunting. The data is in a low-cost cold tier.

:::image type="content" source="../media/sentinel-log-tiers.png" lightbox="../media/sentinel-log-tiers.png" alt-text=" A block diagram that shows and describes the two storage tiers available in Microsoft Sentinel. The analytics tier and the Data lake tier.":::

#### Data lake

The data lake tier is made possible with the introduction of the [Microsoft Sentinel data lake (preview)](/azure/sentinel/datalake/sentinel-lake-overview). Microsoft Sentinel data lake enables a fully managed, cloud-native, data lake that is purposefully designed for security, inside Microsoft Sentinel.

Microsoft Sentinel data lake is an opt-in feature. Customers can continue to use the existing analytics tier without any change. If a customer is looking to optimize costs, they can split data across analytics and data lake tiers. Microsoft Sentinel data lake is only available in the Defender portal.

Microsoft Sentinel data lake simplifies security data management, eliminates security data silos, and enables cost-effective long-term security data retention with the ability to run multiple forms of analytics.

:::image type="content" source="../media/sentinel-with-data-lake.png" lightbox="../media/sentinel-with-data-lake.png" alt-text="An architecture diagram that shows the components of Microsoft Sentinel with data lake":::

Watch this brief video on the benefits of Microsoft Sentinel data lake.

> [!VIDEO https://learn-video.azurefd.net/vod/player?id=70653000-83ec-42ef-9e2f-206748f6bd28]

#### Data connectors and data flow

When you onboard to Microsoft Sentinel data lake, your existing Microsoft Sentinel data connectors are configured to send data to both the analytics tier - your Microsoft Sentinel log analytics workspaces (SIEM storage), and mirror the data to the data lake tier for longer term storage (data lake).

Mirroring data in the data lake with the same retention as the analytics tier doesn’t incur extra billing charges. Only when the retention is increased will it generate more cost for the storage. Once in the analytics tier, the advanced KQL features are available.

If you switch from analytic + data lake mirror (default) to only ingesting into the data lake tier, any new data stops coming to the analytic tier table, and data is stored only in the data lake.

:::image type="content" source="../media/data-lake-tiers-data-flow.png" lightbox="../media/data-lake-tiers-data-flow.png" alt-text="A block diagram that depicts the mirroring of data from analytics tier to the data lake tier.":::
