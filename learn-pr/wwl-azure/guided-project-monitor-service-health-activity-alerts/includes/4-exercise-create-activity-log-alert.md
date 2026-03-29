This guided project consists of the following exercises:

 - Create an action group
 - Create a Service Health alert
 - **Create an Activity Log alert**

In this exercise, you create an Activity Log alert that fires when any resource is deleted in your resource group, then review both alert rules to confirm they're configured correctly. This gives your operations team real-time awareness of infrastructure changes.

This exercise includes the following tasks:

 - Open the alert creation page
 - Configure the alert condition
 - Attach the action group and create
 - Review alert rule details

**Outcome:** An Activity Log alert that notifies the team when any resource is deleted in the monitoring resource group.

## Task 1: Open the alert creation page

Activity Log alerts monitor Azure management operations such as resource creation, modification, and deletion. Unlike metric alerts, they don't require a running resource to monitor, which makes them free and immediately useful.

1.  In the portal search bar, search for **Monitor** and select **Monitor**.
2.  In the left menu, select **Alerts**.
3.  Select **+ Create** and then select **Alert rule**.

## Task 2: Configure the alert condition

Set up the alert to fire when a resource deletion event occurs in your resource group. This gives the operations team visibility into unexpected changes.

1.  For **Scope**, select **Select scope**.
2.  Filter by resource type **Resource groups** and select **rg-gp-monitoring-alerts**. Select **Apply**.
3.  Select the **Condition** tab.
4.  For **Signal name**, search for and select **Delete resource group** from the Activity Log signals.
5.  Leave the default settings for the signal configuration.

> [!NOTE]
> **Validation step:** Confirm the alert condition is set to detect **Delete resource group** Activity Log events.

## Task 3: Attach the action group and create

Link the alert to your action group and finalize the rule. When a matching Activity Log event occurs, the email notification will fire automatically.

1.  Select the **Actions** tab.
2.  Select **Select action groups** and choose **ag-gp-ops-email**.
3.  Select the **Details** tab.
4.  For **Resource group**, select **rg-gp-monitoring-alerts**.
5.  For **Alert rule name**, enter **ar-gp-activity-delete**.
6.  For **Severity**, select **Sev 2 - Warning**.
7.  Make sure **Enable alert rule upon creation** is checked.
8.  Select **Review + create** and then select **Create**.
9.  Return to **Monitor** > **Alerts** > **Alert rules** and confirm both alert rules appear in the list.

> [!NOTE]
> **Validation step:** Confirm both **ar-gp-service-health** and **ar-gp-activity-delete** alert rules appear in the list.

## Task 4: Review alert rule details

Examine the alert rules you created to understand how Azure displays their configuration. In a real operations environment, you would regularly review alert rules to confirm they cover the right signals and notify the right teams.

1.  In the alert rules list, select **ar-gp-service-health** to open its details.
2.  Review the **Condition** section to confirm it monitors **Service issue** and **Planned maintenance** events.
3.  Review the **Actions** section to confirm it uses the **ag-gp-ops-email** action group.
4.  Select **Back** to return to the alert rules list.
5.  Select **ar-gp-activity-delete** and review its condition and action group.
6.  Note the **Severity** level (Sev 2 - Warning) and confirm the rule is **Enabled**.
7.  Select **Back** to return to the alert rules list.

> [!NOTE]
> **Validation step:** Confirm both alert rules are enabled, with correct conditions and action groups attached.

> [!NOTE]
