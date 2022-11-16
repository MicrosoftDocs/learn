*What you can't see, you can't measure. What you can't measure, you can't improve.*

Within an enterprise-scale architecture, management and monitoring focus on ensuring observability as a foundation of platform design. A centralized approach to logging is turned on by default across the Azure estate. Centralized logging prevents gaps in observability that can place an organization at risk.

To accomplish enterprise-scale management and monitoring, you must:

- Design, deploy, and integrate platform-level, holistic (horizontal) resource monitoring and alerting.
- Define and streamline operational tasks, such as patching and backup.
- Integrate security operations, monitoring, and logging with resources on Azure and any existing on-premises systems.
- Configure all subscription activity logs that capture control-plane operations across resources to stream into Azure Monitor Log Analytics. This approach makes the logs available for query and analysis, subject to role-based access control (RBAC) permissions.

This diagram shows a dedicated management subscription to support global management capabilities such as Log Analytics workspaces and Azure Automation runbooks:

:::image type="content" source="../media/management-and-monitoring.png" alt-text="A diagram of enterprise-scale management and monitoring." lightbox="../media/management-and-monitoring-large.png":::

## Log Analytics workspace design

Centralized logging is critical to the visibility that operations-management teams require. This centralization drives reports about change management, service health, configuration, and most other aspects of IT operations. Converging on a centralized workspace model in Log Analytics reduces both administrative effort and the chances of gaps in observability. For workspace design at enterprise scale, we recommend a single Log Analytics workspace to manage the platform centrally. An exception would be where RBAC and data-sovereignty requirements mandate separate workspaces.

In the context of the enterprise-scale architecture, centralized logging is primarily concerned with platform operations. This platform focus doesn't prevent the use of the same workspace for virtual-machine (VM)-based application logging. With a workspace that's configured in resource-centric access-control mode, granular RBAC is enforced to ensure that application teams have access only to the logs from their resources. In this model, application teams benefit by using existing platform infrastructure to reduce their management overhead. For any other resources, application teams can use their own Log Analytics workspaces or Application Insights for diagnostic logs and metrics.

## Auditing and log retention

In Azure, the *activity log* is a platform log that provides insight into subscription-level events. The activity log contains all write operations (PUT, POST, DELETE) for subscription resources. These operations include information such as when a resource is modified or when a VM is started. You can view the activity log in the Azure portal or retrieve entries by using PowerShell and Azure CLI. You can configure diagnostic settings for a subscription via policy to send log data to the centralized Log Analytics workspace. This configuration provides a central view across subscriptions and lets you retain log data past the default 90 days.

When a customer requires log-data retention longer than two years, they can configure the subscription diagnostic settings also for export to Azure Storage. Use immutable storage with *write once, read many (WORM)* policies to make data non-erasable and non-modifiable for a user-specified interval.

## Dashboards and visualization

When you operationalize an Azure estate, it's important to provide the various teams in the organization with curated, timely, and easily consumable data that's relevant to them. A centralized approach to visualization simplifies the onboarding experience for application teams. It also ensures a degree of consistency across the enterprise.

Azure Monitor workbooks are the platform-visualization capability where current development efforts are focused. Workbooks provide a flexible canvas for data analysis and the creation of rich visual reports within the Azure portal. They can tap into multiple data sources from across Azure and combine them into unified, interactive experiences.

Workbooks can query data from multiple sources within Azure. Workbook authors can transform this data to provide insights into the availability, performance, usage, and overall health of the underlying components. For example, you can analyze performance logs from VMs to identify high-CPU or low-memory instances and display the results as a grid in an interactive report.

However, the real power of workbooks is the ability to combine data from disparate sources within a single report. You can create composite resource views or joins across resources to produce richer data and insights than would otherwise be possible.

Workbooks are currently compatible with the following data sources:

- Logs
- Metrics
- Azure Resource Graph
- Azure Monitor Alerts
- Workload health
- Azure Resource Health
- Azure Data Explorer

We recommend that you build a curated set of dashboards for specific personas within the organization's operating model.

## Logs and metrics

All data collected by Azure Monitor fits into one of two fundamental types: logs or metrics. *Logs* in Azure Monitor are especially useful for complex analysis across data from various sources. *Metrics* in Azure Monitor are lightweight and can support near real-time scenarios, making them useful for alerting and fast detection of issues.

Logs are events that occurred within the system. They can contain different kinds of data, and might be structured or free-form text with a timestamp. They might be created sporadically as events in the environment generate log entries, and a system under heavy load typically generates more log volume. Azure resource logs can be sent to a Log Analytics workspace via the resource diagnostic settings. You can use Azure Policy to ensure that diagnostic settings are configured appropriately for all resources.

Metrics are numerical values that describe some aspect of a system at a particular time. They're collected at regular intervals and identified by a timestamp, a name, a value, and one or more defining labels. Metrics can be:

- Aggregated by using a variety of algorithms
- Compared with other metrics
- Analyzed for trends over time

Logs and metrics are critical components of application-centric platform monitoring. Enforcing the collection of this data via policy at the platform level ensures that the data is readily available for consumption by application teams. It also prevents unintended gaps in observability across the platform.

## VM management

Apply VM management configurations via policy to ensure consistent configuration across the platform. An important element of this approach is to adhere to the enterprise-scale design principle of using native Azure platform services and capabilities whenever possible.

A VM-management strategy begins with backups to protect against data loss. Azure Backup is the native Azure service for VM backup. The service provides independent and isolated backups to guard against unintended destruction of the data on VMs. Backups are stored in a Recovery Services vault with built-in management of recovery points.

Azure Backup removes the need to manage third-party backup software and infrastructure. As with other native Azure features, backup configurations can be set, audited, and enforced by using Azure Policy. This approach ensures that services remain compliant with the organization's governance requirements. Enforce the use of Azure Backup on all VMs via policy.

Centralized Azure Automation accounts can provide application landing zones with easily consumable VM-management services. They can also provide central IT with the visibility and control required to ensure VM compliance with enterprise standards. Take advantage of the VM update-management and guest-configuration features of Azure Automation.

Enforcing update-management configurations via policy:

- Ensures that all VMs are included in the patch-management regimen
- Gives application teams the ability to manage patch deployment for their VMs
- Provides visibility and enforcement capabilities to the central IT team across all VMs

Enabling guest-configuration audit capabilities via policy helps application teams monitor their workloads for configuration drift with little effort.

## Monitoring and alerts

At the platform level, monitoring focuses on VM and resource-health data in Azure Monitor. You can set diagnostic settings for Azure resources via policy to export to the centralized Log Analytics workspace. Enable Azure Monitor for VMs via policy to provide performance, health, and dependency insights for VMs, virtual-machine scale sets, and Azure Arc machines at scale. The application team is responsible for deploying and configuring application-health monitoring via tools such as Application Insights.

We recommend that you also include service and resource health events as part of the overall platform-monitoring solution. Tracking the health of services and resources from a platform perspective is an important component of resource management in Azure.

Alerts raise notifications about significant events. Azure Monitor provides a unified alerting experience across platform and resources, with activity-log, metrics, and resource-log signal types.

- *Metric alerts* in Azure Monitor work on top of multidimensional metrics. These metrics can be platform metrics, custom metrics, popular logs from Azure Monitor converted to metrics, or Application Insights metrics. Metric alerts are evaluated at regular intervals to check whether conditions on one or more metric time-series are true and to notify when the evaluations are met. Metric alerts are stateful, so they send out notifications only when the state changes.
- *Log-search rules* are created by Azure alerts to automatically run specified log queries at regular intervals. If the log query results meet certain criteria, an alert record is created.
- *Activity-log* alerts activate when a new activity-log event matches the conditions specified in the alert.

## Security monitoring

Microsoft Defender for Cloud also plays an important part in the enterprise-scale monitoring strategy. It can help monitor the security of VMs, networks, storage, data services, and applications. Defender for Cloud provides advanced threat detection by using machine learning and behavioral analytics to help identify active threats targeting Azure resources. It also provides threat protection that blocks malware or other unwanted code and reduces the surface area exposed to brute-force and other network attacks. We recommend that you enable the Standard SKU for Defender for Cloud on all subscriptions via policy.
