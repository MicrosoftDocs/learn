_What you can't see, you can't measure. What you can't measure, you can't improve.

Within an enterprise-scale architecture, management and monitoring focus on ensuring observability as a foundation of platform design. A centralized approach to logging is turned on by default across the Azure estate. It prevents gaps in observability that can place an organization at risk.

Platform-level, holistic (horizontal) resource monitoring and alerting must be designed, deployed, and integrated. Operational tasks, such as patching and backup, must also be defined and streamlined. Security operations, monitoring, and logging must be integrated with resources on Azure and any existing on-premises systems. All subscription activity logs that capture control-plane operations across resources should be streamed into Azure Monitor Log Analytics. This approach makes the logs available for query and analysis, subject to role-based access control (RBAC) permissions.

This diagram shows a dedicated management subscription to support global management capabilities such as Log Analytics workspaces and Azure Automation runbooks:

:::image type="content" source="../media/management-and-monitoring.png" alt-text="A diagram of enterprise-scale management and monitoring." lightbox="../media/management-and-monitoring-large.png":::

## Log Analytics workspace design

Centralized logging is critical to the visibility that operations-management teams require. This centralization drives reports about change management, service health, configuration, and most other aspects of IT operations. Converging on a centralized workspace model in Log Analytics reduces both administrative effort and the chances of gaps in observability. For workspace design at enterprise scale, we recommend a single Log Analytics workspace to manage the platform centrally. An exception would be where role-based access control (RBAC) and data-sovereignty requirements mandate separate workspaces.

In the context of the enterprise-scale architecture, centralized logging is primarily concerned with platform operations. This platform focus doesn't prevent the use of the same workspace for virtual-machine (VM)-based application logging. With a workspace that's configured in resource-centric access-control mode, granular RBAC is enforced to ensure that application teams have access only to the logs from their resources. In this model, application teams benefit by using existing platform infrastructure to reduce their management overhead. For any other resources, application teams can use their own Log Analytics workspaces or Application Insights for diagnostic logs and metrics.

## Auditing and log retention

In Azure, the *activity log* is a platform log that provides insight into subscription-level events. The activity log contains all write operations (PUT, POST, DELETE) for subscription resources. These operations include information such as when a resource is modified or when a VM is started. You can view the activity log in the Azure portal or retrieve entries by using PowerShell and Azure CLI. Configure diagnostic settings for a subscription via policy to send log data to the centralized Log Analytics workspace. This configuration provides a central view across subscriptions and enables the retention of log data past the default 90 days.

When a customer requires log-data retention longer than two years, configure the subscription diagnostic settings also for export to Azure Storage. Use immutable storage with a write once, read many (WORM) policy to make data non-erasable and non-modifiable for a user-specified interval.

## Dashboards and visualization

When you operationalize an Azure estate, it's important to provide the various teams in the organization with curated, timely, and easily consumable data that's relevant to them. A centralized approach to visualization simplifies the onboarding experience for application teams and ensures a degree of consistency across the enterprise.

Azure Monitor workbooks are the platform-visualization capability where current development efforts are focused. Workbooks provide a flexible canvas for data analysis and the creation of rich visual reports within the Azure portal. They can tap into multiple data sources from across Azure and combine them into unified, interactive experiences.

Workbooks can query data from multiple sources within Azure. Authors of workbooks can transform this data to provide insights into the availability, performance, usage, and overall health of the underlying components. For example, you can analyze performance logs from VMs to identify high-CPU or low-memory instances and display the results as a grid in an interactive report.

But the real power of workbooks is the ability to combine data from disparate sources within a single report. This ability enables the creation of composite resource views or joins across resources, which produce richer data and insights than would otherwise be possible.

Workbooks are currently compatible with the following data sources:

- Logs
- Metrics
- Azure Resource Graph
- Azure Monitor Alerts (preview)
- Workload health (preview)
- Azure Resource Health (preview)
- Azure Data Explorer (preview)

Build a curated set of dashboards for specific personas within the organization's operating model.

## Logs and metrics

All data collected by Azure Monitor fits into one of two fundamental types: metrics and logs. Logs in Azure Monitor are especially useful for performing complex analysis across data from a variety of sources. Metrics in Azure Monitor are lightweight and capable of supporting near real-time scenarios making them useful for alerting and fast detection of issues.

Logs are events that occurred within the system. They can contain different kinds of data and may be structured or free-form text with a timestamp. They may be created sporadically as events in the environment generate log entries, and a system under heavy load will typically generate more log volume. Azure resource logs can be sent to a Log Analytics workspace via the resource diagnostic settings. Azure Policy should be used to ensure diagnostic settings are configured appropriately for all resources.

Metrics are numerical values that describe some aspect of a system at a particular point in time. They are collected at regular intervals and are identified with a timestamp, a name, a value, and one or more defining labels. Metrics can be aggregated using a variety of algorithms, compared to other metrics, and analyzed for trends over time.

Logs and metrics are critical components of application-centric platform monitoring. Enforcing the collection of this data via policy at the platform level will ensure it is readily available for consumption by application teams and will prevent unintended gaps in observability across the platform.

## VM management

VM management configurations should be applied via policy to ensure consistent configuration across the platform. Adhering to the enterprise-scale design principle of using Azure-native platform services and capabilities whenever possible is an important aspect to this approach.

A VM management strategy should begin with backups to protect against data loss. Azure Backup is the Azure-native service for VM backup. The service provides independent and isolated backups to guard against unintended destruction of the data on VMs. Backups are stored in a Recovery Services vault with built-in management of recovery points. Azure Backup removes the need for managing third-party backup software and infrastructure. As with other Azure-native features, backup configurations can be set, audited, and enforced with Azure Policy, ensuring that services remain compliant with the organization's governance requirements. Enforce the use of Azure Backup on all VMs via policy.

Centralized Azure Automation accounts can provide application landing zones with easily consumable VM management services, while also providing central IT with the visibility and control required to ensure VM compliance with enterprise standards. Take advantage of Azure Automation VM update management and guest configuration features. Enforcing update management configurations through policy ensures that all VMs are included in the patch management regimen, provides application teams with the ability to manage patch deployment for their VMs, and provides visibility and enforcement capabilities to the central IT team across all VMs. Enabling guest configuration audit capabilities through policy helps application teams monitor their workloads for configuration drift with little effort.

## Monitoring and alerts

At the platform level, monitoring is focused on VM and resource health data in Azure Monitor. Azure resource diagnostic settings should be set via policy to export to the centralized Log Analytics workspace. Enable Azure Monitor for VMs via policy to provide performance, health, and dependency insights for VMs, virtual machine scale sets, and Azure Arc machines at scale. The application team is responsible for deploying and configuring application health monitoring via tools such as Application Insights.

You should also include service and resource health events as part of the overall platform monitoring solution. Tracking service and resource health from a platform perspective is an important component of resource management in Azure.

Alerting raises notifications about significant events. Azure Monitor provides a unified alerting experience across platform and resources, with activity log, metrics, and resource log signal types.

- Metric alerts in Azure Monitor work on top of multidimensional metrics. These metrics can be platform metrics, custom metrics, popular logs from Azure Monitor converted to metrics, or Application Insights metrics. Metric alerts are evaluated at regular intervals to check if conditions on one or more metric time-series are true and notify when the evaluations are met. Metric alerts are stateful, so they only send out notifications when the state changes.
- Log search rules are created by Azure alerts to automatically run specified log queries at regular intervals. If the log query results meet certain criteria, then an alert record is created.
- Activity log alerts activate when a new activity log event matches the conditions specified in the alert.

## Security monitoring

Azure Security Center also plays an important part in the enterprise-scale monitoring strategy. It can help monitor the security of VMs, networks, storage, data services, and applications. Security Center provides advanced threat detection by using machine learning and behavioral analytics to help identify active threats targeting Azure resources. It also provides threat protection that blocks malware or other unwanted code and reduces the surface area exposed to brute force and other network attacks. You should enable the Standard SKU for Security Center on all subscriptions via policy.
