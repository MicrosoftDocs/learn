Azure Monitor is a powerful reporting and analytics tool. Use it for insights into the behavior and running of your environment and applications. You're then able to respond proactively to faults in your system.

Following the downtime faced by your customers, you'd like to set up monitoring on your key resources in Azure. With the monitoring in place, you'd like to make sure the write people are being alerted, at the right level.

In this unit, you'll see how Azure Monitor receives resource data, what makes up an alert, and how and when to use one. Finally, you'll learn how to create and manage your own alerts.

## Data types in Azure Monitor

Azure Monitor receives data from multiple target resources such as applications, operating systems, Azure resources, Azure subscriptions, or Azure tenants. The nature of the resource defines which data types are available. A data type will be one of metric, log, or metric and log.

- The focus for **metric** based data types is the numerical time-sensitive values that represent some aspect of the target resource.
- The focus for **log** based data types is the querying of content data held in structured, record-based, log files that are relevant to the target resource.

![An image representing the target resources feeding into Azure Monitor and the two principle signal types: metrics and logs](../media/2-azure-resource-signal-types.svg)

You'll learn about the three different signal types that you can use to monitor your environment:

- **Metric** alerts allow you to have an alert trigger when a specified threshold is exceeded. For example, when CPU usage is greater than 95%.
- **Activity log** alerts allow you to have an alert when Azure resources change state. For example, when a resource is deleted.
- **Log** alerts allow you to have alerts based on things written to log files. For example, when a webserver has returned a number of 404 or 500 responses.

## Composition of an alert rule

![Image of the create rule page for Azure Monitor in the portal](../media/2-creating-an-alert.png)

Every alert or notification available in Azure Monitor is the product of a rule. Some of these rules are built into the Azure platform. You use alert rules to create custom alerts and notifications. No matter which target resource or data source you use, the composition of an alert rule remains the same.

- **RESOURCE**
  - The **target resource** to be used for the alert rule. It's possible to assign multiple target resources to a single alert rule. The type of resource will define the available signal types.
- **CONDITION**
  - The **signal type** to be used to assess the rule. The signal type can be: metric, activity log, or logs. There are others but they're not covered in this module.
    - The **alert logic** applied to the data that's supplied via the signal type. The structure of the alert logic will change depending on the signal type.
- **ACTIONS**
  - The **action**, for instance sending an email, SMS or using a webhook, and/or 
  - An **action group**, which typically contains a unique set of recipients for the action.
- **ALERT DETAILS**
  - An **alert name** and an **alert description** that should specify its purpose.
  - The **severity** of the alert if the criteria or logic test evaluates 'true'. Severity is defined by five levels. The severity levels are:
    - **0**: Critical
    - **1**: Error
    - **2**: Warning
    - **3**: Informational
    - **4**: Verbose

## Scope of alert rules

You can get monitoring data from across most of the Azure services, and report on it using the Azure Monitor pipeline. In the Azure Monitor pipeline, you can create alert rules for, but are not limited to: metric values, log search queries, activity log events, the health of the underlying Azure platform, and tests for website availability.

The following alerting capabilities aren't yet available for the generation of monitoring data:

- Activity log-based service health alerts.
- Web availability tests using Application Insights.

## Managing alert rules

Not every alert rule you create needs to run forever. Azure Monitor allows you to specify one or more alert rules and enable or disable them as needed.

As an Azure solution architect, you would use Azure Monitor to enable tightly focused and specific alerts before any application change, and disable them after a successful deployment.

## Alert summary view

By default, the alerts page will show a visual summary of all alerts. Note that classic alerts aren't shown in the view. You can apply filters to the view using one or more of the following three categories: subscriptions, resource groups, or time ranges. Only alerts that match these criteria will be included in the view. The following constraints apply:

- **Subscriptions**: you're limited to reporting on a maximum of five subscriptions.
- **Resource groups**: you can only have one resource group.
- **Time ranges**: these ranges support the past hour, the past 24 hours, the past 7 days, and the past 30 days.

### Understanding the alert state in the resolution process

You control the alert state to manage and specify where you are in the alert resolution process.  Currently, there are three states: new, acknowledged, and closed.

- Every new alert will have an alert state of **New**: this state means that the issue has been detected but not yet reviewed.
- After an administrator has reviewed the alert and is working on it, the alert state will change to **Acknowledged**.
- When the issue has been resolved, the alert state is set to **Closed**.

### Filtering alerts

From the alert summary window, you'll see a satellite view of the alerts being reported in Azure Monitor. You filter this view to reduce the volume of alerts being reported to a specific subset that you're interested in.
The following can be used to filter the view:

- **Smart groups**: if enabled.
- **Resource type**: only applicable when used with a resource group.
- **Resource**: only applicable when a resource type has been specified.
- **Severity**: used to identify the severity assigned by the alert rule.
- **Monitor condition**: set by the system and indicates if the alert is fired or resolved.
- **Alert state**: use this state to typically find the new and recognized alerts.