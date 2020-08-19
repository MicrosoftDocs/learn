_What you cannot see, you cannot measure. What you cannot measure, you cannot improve._ Management and monitoring within Enterprise Scale is focused on ensuring observability is a foundational component of platform design. The centralized approach to logging that is on by default across the Azure estate will prevent gaps in observability that can place and organization at risk.

Platform-level holistic (horizontal) resource monitoring and alerting must be designed, deployed, and integrated. Operational tasks such as patching, and backup must also be defined and streamlined. Security operations, monitoring, and logging must be integrated with resources on Azure and any existing on-premises systems. All subscription activity logs that capture control plane operations across resources should be streamed into Log Analytics to make them available for query and analysis, subject to role-based access control (RBAC) permissions.

![Enterprise Scale management and monitoring diagram](../media/management-and-monitoring.png)

## Log Analytics workspace design

Centralized logging is critical to the visibility that is required by the operations management teams. The centralization of logging drives reports about change management, service health, configuration, and most other aspects of IT operations. Converging on a centralized Log Analytics workspace model reduces administrative effort and reduces the chances for gaps in observability.​ The Enterprise Scale workspace design recommendation is to use a single Log Analytics workspace to manage platforms centrally, except where role-based access control (RBAC) and data sovereignty requirements mandate separate workspaces.

In the context of the Enterprise Scale architecture, centralized logging is primarily concerned with platform operations. This platform focus does not preclude the use of the same workspace for VM-based application logging. With a workspace configured in resource-centric access control mode, granular RBAC is enforced to ensure app teams will only have access to the logs from their resources. In this model, app teams benefit from the use of existing platform infrastructure by reducing their management overhead. For any non-compute resources, application teams can use their own Log Analytics workspaces for diagnostic logs and metrics.

## Auditing and log retention

The Activity log is a platform log in Azure that provides insight into subscription-level events. The activity log contains all write operations (PUT, POST, DELETE) for subscription resources. These operations includes such information as when a resource is modified or when a VM is started. The Activity log can be viewed in the Azure portal or entries can be retrieved with PowerShell and CLI. Subscription diagnostic settings should be configured via policy to send log data to the centralized Log Analytics workspace. This configuration provides a central view across subscriptions and provides the ability to retain log data past the default 90 days.

When a customer requires log data retention greater than two years, the subscription diagnostic setting should also be configured for export to Azure storage. Use immutable storage with WORM (write once, read many) policy to make data non-erasable and non-modifiable for a user-specified interval.

## Dashboards and visualization

Providing the various teams within an organization with curated, timely, and easily consumable data that is relevant to them is an important aspect of operationalizing an Azure estate. A centralized approach to visualization will simplify the onboarding experience for application teams and will ensure a degree of consistency across the enterprise.

Azure Workbooks are the platform visualization capability where current development efforts are focused.
Workbooks provide a flexible canvas for data analysis and the creation of rich visual reports within the Azure portal. They can tap into multiple data sources from across Azure and combine them into unified interactive experiences.

Workbooks can query data from multiple sources within Azure. Authors of workbooks can transform this data to provide insights into the availability, performance, usage, and overall health of the underlying components. For instance, analyzing performance logs from VMs to identify high CPU or low memory instances and displaying the results as a grid in an interactive report.

But the real power of workbooks is the ability to combine data from disparate sources within a single report. This ability allows for the creation of composite resource views or joins across resources enabling richer data and insights that would otherwise be impossible.

Workbooks are currently compatible with the following data sources:

- Logs
- Metrics
- Azure Resource Graph
- Alerts (Preview)
- Workload Health (Preview)
- Azure Resource Health (Preview)
- Azure Data Explorer (Preview)

A curated set of dashboards should be built for specific personas within the organization's operating model.

## Logs and metrics

All data collected by Azure Monitor fits into one of two fundamental types, Metrics and Logs. Logs in Azure Monitor are especially useful for performing complex analysis across data from a variety of sources. Metrics in Azure Monitor are lightweight and capable of supporting near real-time scenarios making them useful for alerting and fast detection of issues.

Logs are events that occurred within the system. They can contain different kinds of data and may be structured or free form text with a timestamp. They may be created sporadically as events in the environment generate log entries, and a system under heavy load will typically generate more log volume. Azure resource logs can be sent to a Log Analytics workspace via the resource diagnostic settings. Azure Policy should be used to ensure diagnostic settings are configured appropriately for all resources.

Metrics are numerical values that describe some aspect of a system at a particular point in time. They are collected at regular intervals and are identified with a timestamp, a name, a value, and one or more defining labels. Metrics can be aggregated using a variety of algorithms, compared to other metrics, and analyzed for trends over time.

Logs and metrics are critical components of application-centric platform monitoring. Enforcing the collection of this data via policy at the platform level will ensure it is readily available for consumption by application teams and will prevent unintended gaps in observability across the platform.

## VM management

VM management configurations should be applied via Policy to ensure consistent configuration across the platform. Adhering to the Enterprise Scale design principle of using Azure-native platform services and capabilities whenever possible is an important aspect to this approach.

A VM management strategy should begin with backups to protect against data loss. Azure Backup is the Azure-native service for VM backup. The service provides independent and isolated backups to guard against unintended destruction of the data on VMs. Backups are stored in a Recovery Services vault with built-in management of recovery points. Azure Backup removes the need for managing third-party backup software and infrastructure. As with other Azure-native features, backup configurations can be set, audited, and enforced with Azure Policy, ensuring that services remain compliant with the organization's governance requirements. Enterprise Scale recommends enforcing use of Azure Backup on all VMs via policy.

Centralized Azure Automation accounts can provide application landing zones with easily consumable VM management services, while also providing Central IT with the visibility and control required to ensure VM compliance with enterprise standards. Enterprise Scale recommends using Azure Automation VM update management and guest configuration features. Enforcing update management configurations through policy ensures that all VMs are included in the patch management regimen, provides application teams with the ability to manage patch deployment for their VMs, and provides visibility and enforcement capabilities to the Central IT team across all VMs. Enabling guest configuration audit capabilities through policy helps app team workloads to immediately monitor their workloads for configuration drift with little effort.

## Monitoring and alerts

At the platform level, monitoring is focused on VM and resource health data in Azure Monitor. Azure resource diagnostic settings should be set via policy to export to the centralized Log Analytics workspace. Azure Monitor for VMs should be enabled via policy to provide performance, health, and dependency insights for VMs, virtual machine scale sets, and Azure Arc machines at scale. Application health monitoring, through tools such as Application Insights, would be the responsibility of the application team to deploy and configure.

It is also recommended to include service and resource health events as part of the overall platform monitoring solution. Tracking service and resource health from the platform perspective is an important component of resource management in Azure.

The goal of alerting is notification for significant events. Azure Monitor provides a unified alerting experience across platform and resources, with activity log, metrics, and resource log signal types.

- Metric alerts in Azure Monitor work on top of multi-dimensional metrics. These metrics could be platform metrics, custom metrics, popular logs from Azure Monitor converted to metrics and Application Insights metrics. Metric alerts evaluate at regular intervals to check if conditions on one or more metric time-series are true and notify when the evaluations are met. Metric alerts are stateful, that is, they only send out notifications when the state changes.
- Log search rules are created by Azure Alerts to automatically run specified log queries at regular intervals. If the results of the log query match particular criteria, then an alert record is created.
- Activity log alerts are alerts that activate when a new activity log event occurs that matches the conditions specified in the alert.

## Security monitoring

Azure Security Center also plays an important part in the Enterprise Scale monitoring strategy. It can help monitor the security of VMs, networks, storage, data services, and applications. Security Center provides advanced threat detection by using machine learning and behavioral analytics to help identify active threats targeting Azure resources. It also provides threat protection that blocks malware or other unwanted code and reduces the surface area exposed to brute force and other network attacks. Enterprise Scale recommends enabling the Standard SKU for Security Center on all subscriptions via policy.
