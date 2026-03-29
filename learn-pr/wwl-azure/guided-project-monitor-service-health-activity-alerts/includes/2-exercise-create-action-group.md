This guided project consists of the following exercises:

 - **Create an action group**
 - Create a Service Health alert
 - Create an Activity Log alert

In this exercise, you create an action group with email notification and send a test message to verify delivery. Action groups are the notification backbone for Azure alerts—you set them up once and reuse them across multiple alert rules.

This exercise includes the following tasks:

 - Prepare the environment
 - Create the action group
 - Test the action group

**Outcome:** An action group configured to send email notifications when alerts fire.

> [!TIP]
> Pause after each major action and confirm the page status before moving on. This habit prevents compounding mistakes.

## Task 1: Prepare the environment

Set up your Azure environment before you begin. You create a resource group to organize the monitoring resources for this project together.

> [!WARNING]
> This project creates Azure resources that are free or near-free, but you should still complete the clean-up unit when you're done to avoid unintended expenses.

1.  Sign in to the [Azure portal](https://portal.azure.com) with an account that has permissions to create monitoring resources.
2.  In the portal search bar, search for **Resource groups** and select **Resource groups**.
3.  Select **+ Create**. Name the resource group **rg-gp-monitoring-alerts**, choose your preferred region, and select **Review + create** then **Create**.
4.  Note the email address you want to use for alert notifications.

## Task 2: Create the action group

Create an action group that defines who gets notified and how. Action groups are reusable notification channels that you attach to alert rules, so the same team can be notified by multiple different alerts.

1.  In the portal search bar, search for **Monitor** and select **Monitor**.
2.  In the left menu, select **Alerts**.
3.  Select **Action groups** from the top menu bar.
4.  Select **+ Create**.
5.  On the Basics tab, select **rg-gp-monitoring-alerts** as the resource group.
6.  For **Action group name**, enter **ag-gp-ops-email**.
7.  For **Display name**, enter **OpsEmail**.
8.  Select the **Notifications** tab.
9.  For **Notification type**, select **Email/SMS message/Push/Voice**.
10. For **Name**, enter **ops-team-email**.
11. In the panel that opens, check **Email** and enter your email address. Select **OK**.
12. Select **Review + create** and then select **Create**.

> [!NOTE]
> **Validation step:** Confirm the **ag-gp-ops-email** action group is created with email notification configured.

> [!NOTE]
> Each exercise includes validation steps like this one. Track your results as you go—you'll review them all in the validation unit at the end of this module.

## Task 3: Test the action group

Send a test notification to verify the action group delivers email successfully. In production environments, you should always test notification channels before relying on them for incident response.

1.  After the action group is created, select **ag-gp-ops-email** from the action groups list to open it.
2.  In the top menu bar, select **Test action group**.
3.  For **Select sample type**, choose **Service Health**.
4.  Make sure the **ops-team-email** notification is checked.
5.  Select **Test**.
6.  Wait for the test results to appear. Confirm the **Status** column shows **Success**.
7.  Check your email inbox for the test notification from Azure. Open the email and review its content—this is the same format you would receive during a real incident.

> [!NOTE]
> **Validation step:** Confirm the test notification status shows **Success** and you received the email notification.

> [!NOTE]
