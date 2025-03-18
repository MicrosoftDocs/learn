Activity log alerts allow you to be notified when a specific event happens on some Azure resource. For example, you can be notified when someone creates a new virtual machine (VM) in a subscription. 

An activity log can also include alerts for Azure service health. A company can get notifications when service issues or planned maintenance happens on the Azure platform.

As an Azure solution architect, you want to explore the capability to monitor selected Azure resources within your subscription. You want to understand how you can use the resources to improve your team's responsiveness and the stability of your systems.

In this unit, you explore the two different kinds of activity log alerts. Now that you're aware of the different kinds of alerts you can use in Azure Monitor, you want to know how you can trigger actions for your alerts. Actions might include sending an email or creating an IT Service Management (ITSM) support ticket.

## When to use activity log alerts

So far, you learned about two different types of alerts supported in Azure Monitor. *Metric alerts* are ideally suited to monitoring for threshold breaches or spotting trends; *Log search alerts* allow for greater analytical monitoring of historical data.

*Activity log alerts* are designed to work with Azure resources. Typically, you create this type of log to receive notifications when specific changes occur on a resource within your Azure subscription.

There are two types of activity log alerts:

- **Specific operations**: Applies to resources within your Azure subscription, and often has a scope with specific resources or a resource group. You use this type when you need to receive an alert that reports a change to an aspect of your subscription. For example, you can receive an alert if a VM is deleted or new roles are assigned to a user.
- **Service health events**: Include notice of incidents and maintenance of target resources.

## Composition of an activity log alert

It's important to note that activity log alerts monitor events only in the subscription where the alert was created.

Activity log alerts are based on events. The best approach for defining them is to use Azure Monitor to filter all the events in your subscription until you find the one that you want. To begin the creation process, you then select **Add activity log alert**.

Like the previous alerts, activity log alerts have their own attributes:

- **Category**: Administrative, service health, autoscale, policy, or recommendation
- **Scope**: Resource level, resource group level, or subscription level
- **Resource group**: Where the alert rule is saved
- **Resource type**: Namespace for the target of the alert
- **Operation name**: Operation name
- **Level**: Verbose, informational, warning, error, or critical
- **Status**: Started, failed, or succeeded
- **Event initiated by**: Email address or Microsoft Entra identifier (known as the "caller") for the user

### Create a resource-specific log alert

When you create your activity log alert, you select **Activity Log** for the signal type. You then see all the available alerts for the resource you select. The following image shows all the administrative alerts for Azure VMs. In this example, an alert is triggered when a VM is powered off.

Changing the monitor service enables you to reduce the list of options. Selecting **Administrative** filters all the signals to show only admin-related signals.

![Screenshot of the signal logic for activity log alerts related to VMs.](../media/6-example-activity-log-alert.png)

### Create a service health alert

Service health alerts aren't like all the other alert types you learned about in this module so far. To create a new alert, search for and select **Service Health** in the Azure portal. Next, select **Health alerts**. After you select **Create service health alert**, the steps to create the alert are similar to the steps used to create other alerts.

:::image type="content" source="../media/6-service-health-alerts.png" alt-text="Screenshot that shows how to create a new service health alert.":::

The only difference is that you no longer need to select a resource, because the alert is for a whole region in Azure. What you can select is the kind of health event on which you want to be alerted. You can select service issues, planned maintenance, health advisories, or choose all of the events. The remaining steps of performing actions and naming the alerts are the same.
