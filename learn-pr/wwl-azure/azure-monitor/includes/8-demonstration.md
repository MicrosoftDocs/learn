Complete these try-this exercises to get some hands-on on experience with Azure.

## Task 1 - Activity Logs and Alerts

In this task, we will configure an alert.

1. Sign into the **Portal**.
1. Search for and launch **Monitor**.
1. Review the capabilities of Monitor: **Monitor &amp; Visualize Metrics**, **Query &amp; Analyze Logs**, and **Setup Alerts &amp; Actions**.
1. Select **Activity log**.
1. Under the filters, click **Timespan** and review the drop-down choices.
1. Open an event and discuss.
1. Back in the Monitor main page, click **Alerts** then click **+ New alert rule**.
1. Under **Resource** click **Select**.
1. Discuss how alerts can be scoped by subscription, resource type, and location.
1. Select a resource for the alert and then click **Done**.
1. Under **Condition** click **Add**.
1. Select a signal, such as **All Administrative operations**, and then click **Done**.
1. Under **Action group**, click **Create**. Review how action groups are used.
1. Under **Select an action type** review the various ways the action group can be alerted.
1. Select **Email/SMS/Push/Voice**.
1. Review the configuration choices and finish creating your action group.
1. Complete the **Alert details** and click **Create alert rule**.
1. On the **Alerts** page, review how you can search your alerts by resource and time range.

## Task 2 - Log Analytics

This lab requires a virtual machine in a running state.

In this task, we will configure Log Analytics and run a query.

1. Sign into the **Portal**.
1. Search for and launch **Log Analytics workspaces**.
1. Click **Add** or **Create**.
1. On the **Basics** tab, review and complete the required information.
1. Under the Essentials view, review the **Pricing tier** detail (example: Pricing tier: Pay-as-you-go)
1. Finish creating the workspace and wait for it to deploy.
1. **Go to resource** and discuss how Log Analytics is used and configured.
1. Under **Workspace Data Sources** select **Virtual machines**.
1. Select a virtual machine and click **Connect**.
1. While you wait for the connection, under **Settings** click **Advanced settings**.
1. Click **Connected sources**. Discuss the possible sources like virtual machines and storage accounts.
1. Click **Data**. Review the different data sources.
1. Show how **Windows event logs** can be collected.
1. Save any changes you make.
1. Back at the Log Analytics workspace, Under **General** select **Logs**.
1. Review how log data is stored in tables and can be queried.
1. Select the **Event** table and then click **Run**.
1. Review the results.
