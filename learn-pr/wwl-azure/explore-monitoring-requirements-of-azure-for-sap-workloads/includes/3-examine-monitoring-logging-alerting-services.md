Azure Monitor is one of the core components in the comprehensive collection for Microsoft cloud-based monitoring. It provides a solution for SAP workloads running in Azure, and for your on-premises datacenter. Other Azure manageability features that belong in the same category include:

- **Azure Advisor**. Uses resource usage data to make recommendations for optimizing performance, security, and availability.
- **Azure Service Health**. Reports platform-related issues that might affect your resources.
- **Azure Activity Log**. Tracks events representing operations that alter the state of your resources; such as configuration changes, service health incidents, and autoscale operations.

These core features complement several other services that deliver more focused, deep monitoring:

## Deep infrastructure and application monitoring

Monitoring the performance, availability, and usage of web-based applications, regardless of their location, these services also provide analytics capabilities targeting Azure infrastructure. Some of the prime examples include:

- **Azure Application Insights**.
- **Log Analytics** combined with such management solutions as **Container Monitoring** and **Service Map**.
- Network monitoring tools such as:

  - **Network Watcher**
  - **Network Performance Monitor**
  - **ExpressRoute Monitor**
  - **DNS Analytics**
  - **Service Endpoint Monitor**

Tasks like configuring alerts, designing custom dashboards, and analyzing metrics are carried out similarly in core and deep monitoring services. This means that you can view and configure performance-related settings for a wide range of Azure resources in the same consistent manner. With Azure Monitor, you have a single point of reference for the most relevant configuration settings and monitoring data. Thisn't only improves your user experience but also helps you maintain a consistent configuration across your entire subscription.

Additionally, many customers use SAP Landscape Management (LaMa) to operate and monitor their SAP landscape. Since version 3.0 SP05, SAP LaMa includes a connector to Azure by default.

## Explore Azure Monitor support for alerting

Azure Monitor also offers comprehensive support for alerting. It allows you to configure four types of alerts:

- **Classic metric alerts** with the minimum frequency of 5 minutes.
- **Near real-time metric alerts** with the minimum frequency of 1 minute. This allows for triggering a metric-based alert within 1 minute following a change in metrics that satisfies the alert condition, making the Azure Monitor-based approach suitable for time-critical scenarios. Near real-time metrics offer several other advantages:

  - Support for action groups, which are collections of settings that designate recipients of alert notifications and the corresponding notification actions. The action types include initiating a voice call or a text, sending an email, calling a webhook, forwarding data to an IT Service Management tool such as ServiceNow, calling an Azure App Service app, or invoking an Automation runbook. Creating action groups allows you to reuse the same notification settings for multiple alerts.
  - Alerts that consider conditions of two or more metrics.
  - Multi-dimensional metric-based alerts that allow you to generate alerts based on one or more dimensions of a metric. A dimension identifies a subset of related metrics based on a key-value pair. For example, for a Windows Server, the metric “Available disk space” can have a dimension named “Drive”, with its values representing individual drive letters.
  - Alerts that support such conditions as average and total, in addition to minimum, and maximum values available with classic metric alerts.
- **Classic activity log alerts** parsing streaming log data, responding to events such as a Service Health incident or deletion of an Azure Virtual Machine.
- **Activity log alerts**, which function similarly to classic activity log alerts but support configuration by using Azure Resource Manager templates.

## Optional demo

- [Demonstration: Create an alert rule](https://github.com/MicrosoftLearning/AZ-120-Planning-and-Administering-Microsoft-Azure-for-SAP-Workloads/blob/master/Demos/demo-create-alert-rule.md)
