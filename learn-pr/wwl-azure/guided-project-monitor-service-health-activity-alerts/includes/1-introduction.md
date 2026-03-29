This guided project focuses on monitoring Azure using Service Health alerts, Activity Log alerts, and action groups.

Azure Monitor provides several alert types that notify you about issues without requiring paid compute resources. Service Health alerts watch for platform-level incidents and planned maintenance. Activity Log alerts fire when management operations — like resource deletion — occur. Action groups define who gets notified and how.

## Scenario

Your operations team wants to know immediately when Azure platform issues occur or when someone deletes a critical resource. You set up an action group with email notification, create a Service Health alert for platform incidents, and create an Activity Log alert for resource deletions. Together, these give the team proactive visibility into both platform and operational events.

- Exercise 1 - Create an action group and verify email delivery.
- Exercise 2 - Create a Service Health alert for platform incidents.
- Exercise 3 - Create an Activity Log alert for resource deletions.

:::image type="content" source="../media/overview-architecture.png" alt-text="Diagram showing the monitoring pipeline from Azure events through alert rules and action groups to email notifications." border="false":::

By the end of this project, you have a working notification pipeline that alerts your team about Azure service issues and unexpected infrastructure changes.

> [!NOTE]
> This is a guided project module where you complete a project by following step-by-step instructions.

## Skilling areas

In this project, you practice skills in the following areas:

**Configure action groups**
+ Create an action group with email notification.
+ Test the action group to verify delivery.

**Create Service Health alerts**
+ Navigate Azure Service Health.
+ Configure an alert for service incidents and planned maintenance.
+ Scope the alert to specific regions.

**Create Activity Log alerts**
+ Configure an alert condition for resource deletion events.
+ Attach an action group to an alert rule.
+ Review alert rule configuration in the portal.

> [!IMPORTANT]
> This project uses the Azure portal for every step. No prior Azure experience is required.
