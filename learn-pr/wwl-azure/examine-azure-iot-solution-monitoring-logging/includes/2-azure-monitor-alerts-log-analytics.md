The Azure IoT Hub service uses Azure Monitor and Log Analytics to support IoT solution diagnostics and troubleshooting.

Azure Monitor maximizes the availability and performance of your applications and services by delivering a comprehensive solution for collecting, analyzing, and acting on telemetry from your cloud and on-premises environments. It helps you understand how your applications are performing and proactively identifies issues affecting them and the resources they depend on.

Just a few examples of what you can do with Azure Monitor include:

 -  Detect and diagnose issues across applications and dependencies with Application Insights.
 -  Correlate infrastructure issues with Azure Monitor for VMs and Azure Monitor for Containers.
 -  Drill into your monitoring data with Log Analytics for troubleshooting and deep diagnostics.
 -  Support operations at scale with smart alerts and automated actions.
 -  Create visualizations with Azure dashboards and workbooks.

## Overview

The following diagram gives a high-level view of Azure Monitor. At the center of the diagram are the data stores for metrics and logs, which are the two fundamental types of data used by Azure Monitor. On the left are the sources of monitoring data that populate these data stores. On the right are the different functions that Azure Monitor performs with this collected data such as analysis, alerting, and streaming to external systems.

:::image type="content" source="../media/m09-l01-monitoring-logging-azure-monitor-overview-7616d1b6.png" alt-text="Diagram that shows the different functions that Azure Monitor performs.":::


## Monitoring data platform

All data collected by Azure Monitor fits into one of two fundamental types, metrics and logs. Metrics are numerical values that describe some aspect of a system at a particular point in time. They are lightweight and capable of supporting near real-time scenarios. Logs contain different kinds of data organized into records with different sets of properties for each type. Telemetry such as events and traces are stored as logs in addition to performance data so that it can all be combined for analysis.

For many Azure resources, you'll see data collected by Azure Monitor right in their Overview page in the Azure portal. The Azure IoT Hub Overview page includes charts for **Device twin operation** and **Device to cloud messages**. Click on any of the graphs to open the data in metrics explorer in the Azure portal, which allows you to chart the values of multiple metrics over time. You can view the charts interactively or pin them to a dashboard to view them with other visualizations.

Log data collected by Azure Monitor can be analyzed with queries to quickly retrieve, consolidate, and analyze collected data. You can create and test queries using Log Analytics in the Azure portal and then either directly analyze the data using these tools or save queries for use with visualizations or alert rules.

Azure Monitor uses a version of the Kusto query language that is suitable for simple log queries but also includes advanced functionality such as aggregations, joins, and smart analytics.

## What data does Azure Monitor collect?

Azure Monitor can collect data from various sources. You can think of monitoring data for your applications in tiers ranging from your application, any operating system and services it relies on, down to the platform itself. Azure Monitor collects data from each of the following tiers:

 -  Application monitoring data: Data about the performance and functionality of the code you have written, regardless of its platform.
 -  Guest OS monitoring data: Data about the operating system on which your application is running. This OS could be running in Azure, another cloud, or on-premises.
 -  Azure resource monitoring data: Data about the operation of an Azure resource.
 -  Azure subscription monitoring data: Data about the operation and management of an Azure subscription, as well as data about the health and operation of Azure itself.
 -  Azure tenant monitoring data: Data about the operation of tenant-level Azure services, such as Azure Active Directory.

As soon as you create an Azure subscription and start adding resources such as virtual machines and web apps, Azure Monitor starts collecting data. Activity logs record when resources are created or modified. Metrics tell you how the resource is performing and the resources that it's consuming.

Extend the data you're collecting into the actual operation of the resources by enabling diagnostics and adding an agent to compute resources. This configuration will collect telemetry for the internal operation of the resource and allow you to configure different data sources to collect logs and metrics from Windows and Linux guest operating system.

## Responding to critical situations

In addition to allowing you to interactively analyze monitoring data, an effective monitoring solution must be able to proactively respond to critical conditions identified in the data that it collects. This response could be sending a text or mail to an administrator responsible for investigating an issue. Or you could launch an automated process that attempts to correct an error condition.

### Alerts

Alerts in Azure Monitor proactively notify you of critical conditions and potentially attempt to take corrective action. Alert rules based on metrics provide near real time alerting based on numeric values, while rules based on logs allow for complex logic across data from multiple sources.

Alert rules in Azure Monitor use action groups, which contain unique sets of recipients and actions that can be shared across multiple rules. Based on your requirements, action groups can perform such actions as using webhooks to have alerts start external actions or to integrate with your ITSM tools.

The unified alert experience in Azure Monitor includes alerts that were previously managed by Log Analytics and Application Insights. In the past, Azure Monitor, Application Insights, Log Analytics, and Service Health had separate alerting capabilities. Over time, Azure improved and combined both the user interface and different methods of alerting. The consolidation is still in process.

> [!NOTE]
> You can view classic alerts only in the classic alerts user screen in the Azure portal. You get this screen from the View classic alerts button on the Alerts blade of IoT Hub in the Azure portal.

#### Overview of alerts in Azure

The diagram below represents the flow of alerts.

:::image type="content" source="../media/m09-l01-monitoring-logging-alerts-flow-52464b0e.png" alt-text="Diagram that shows the flow of alerts in Azure and Azure Monitor.":::


Alert rules are separated from alerts and the actions taken when an alert fires. The alert rule captures the target and criteria for alerting. The alert rule can be in an enabled or a disabled state. Alerts only fire when enabled.

The following are key attributes of an alert rule:

 -  Target Resource: Defines the scope and signals available for alerting. A target can be any Azure resource. Example targets: a virtual machine, a storage account, a virtual machine scale set, a Log Analytics workspace, or an Application Insights resource. For certain resources (like virtual machines), you can specify multiple resources as the target of the alert rule.
 -  Signal: Emitted by the target resource. Signals can be of the following types: metric, activity log, Application Insights, and log.
 -  Criteria: A combination of signal and logic applied on a target resource. Examples:
    
     -  Percentage CPU &gt; 70%
     -  Server Response Time &gt; 4 ms
     -  Result count of a log query &gt; 100
 -  Alert Name: A specific name for the alert rule configured by the user.
 -  Alert Description: A description for the alert rule configured by the user.
 -  Severity: The severity of the alert after the criteria specified in the alert rule is met. Severity can range from 0 to 4.
    
     -  Sev 0 = Critical
     -  Sev 1 = Error
     -  Sev 2 = Warning
     -  Sev 3 = Informational
     -  Sev 4 = Verbose
 -  Action: A specific action taken when the alert is fired.

#### What you can alert on

You can alert on metrics and logs. These include but are not limited to:

 -  Metric values
 -  Log search queries
 -  Activity log events
 -  Health of the underlying Azure platform
 -  Tests for website availability
