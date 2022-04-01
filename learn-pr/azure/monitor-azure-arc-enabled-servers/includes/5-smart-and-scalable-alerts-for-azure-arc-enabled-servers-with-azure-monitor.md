Tailwind Manufacturing is interested in setting up a system of alerts to respond to operational and connectivity signals from its Azure Arc-enabled servers. In this unit, you’ll learn how Azure Monitor supports smart and scalable alerting through rules. Additionally, you’ll walk through the creation of an Azure Monitor Alert Rule for Azure Arc-enabled servers. 

## Overview of Azure Monitor alerts and alert rules

Alerts proactively notify you when issues are found with your infrastructure or application using your monitoring data in Azure Monitor. They allow you to identify and address issues before the users of your system notice them. The following diagram shows the core components of Azure Monitor alerts: alert rules, action groups, and monitor conditions. 

![](../media/image8.png)

Alert rules are separated from alerts and the actions taken when an alert fires. The alert rule captures the target and criteria for alerting. Key attributes of an alert include:

- **Target resource** defines the scope and signals available for alerting. A target can be any Azure resource. Azure Arc-enabled servers can be targets for Azure Monitor Alerts.
- **Signal** includes the metric, activity log, Application Insights, and log emitted by the target resource. An example could be the heartbeats emitted by or the CPU Utilization threshold of an Azure Arc-enabled server. 
- **Criteria** specifies the combination of signal and logic applied on a target resource. Examples include CPU utilization threshold passing 70% or logs less than 10 heartbeats over the last 24 hours.  
- **Alert name, Alert description, **and** Severity** are configured by the user. Severity ranges from 0 to 4, where Sev 0 is Critical, Sev 1 is Error, Sev 2 is Warning, Sev 3 is Informational, and Sev 4 is Verbose. 
- **Action **specifies the corresponding action group to be notified and respond. Main action types include Automation Runbook, Azure Function, ITSM, Logic App, Secure Webhook, and Webhook.

The default **Alerts** page provides a summary of alerts that are created within a particular time range. You can also manage the state of an alert to specify where it is in the resolution process. When the criteria specified in the alert rule is met, an alert is created or fired, and it has a status of New. You can change the status when you acknowledge an alert and when you close it. All state changes are stored in the history of the alert. 

You might want to query programmatically for alerts generated against your subscription. Through Azure Resource Graph, you can programmatically manage your alert instances. Additionally, you can use smart groups to reduce noise and improve troubleshooting. Smart groups are aggregations of alerts based on machine learning algorithms. 

Azure Monitor’s robust alert management and resource framework can be extended to reporting of hybrid and multicloud machines through Azure Arc-enabled servers. 

## Create an alert rule for Azure Arc-enabled servers

Follow these steps to define a new alert rule for Azure Arc-enabled servers. We assume that you have one or more Azure Arc-enabled servers with VM Insights enabled. 

1. From your browser, go to the [Azure portal](https://portal.azure.com/).
1. In the portal, browse **Monitor** and select **Alerts** from the left-navigation list.
1. From under the **Create** section, select **Alert Rule**.
1. From under the **Filter by Resource Type** section, select **Servers – Azure Arc**.
1. Select the target Azure Arc-enabled servers as the scope of the rule.
1. **Select the signal \LogicalDisk(\_Total)\% Disk Time (Azure.VM.Windows.GuestMetrics)**

![Graphical user interface  Description automatically generated](../media/image9.png)

7. Enter the **Threshold Value **of 0.5 above which the alert rule will be triggered and select **Done**.

![Graphical user interface, text, application  Description automatically generated](../media/image10.png)

8. Select **Create a new Action Group** to define the response to the alert.
1. For Basics, enter the Subscription, Resource Group, and Action Group Name.
1. For Notifications, select **Email Azure Resource Manager Role **and choose **Owner** from the dropdown options. 

![Graphical user interface, application  Description automatically generated](../media/image11.png)

11. Enter a **Notification Name** and select **Review + Create** for the Action Group. 
1. Select **Review + Create** for the alert rule. 