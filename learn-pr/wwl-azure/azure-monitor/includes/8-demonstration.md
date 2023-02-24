
Complete these try-this exercises to get some hands-on on experience with Azure.

## Task 1 - Activity Logs and Alerts

In this task, we will configure an alert.

1.  Sign into the **Portal**.
2.  Search for and launch **Monitor**.
3.  Review the capabilities of Monitor: **Monitor & Visualize Metrics**, **Query & Analyze Logs**, and **Setup Alerts & Actions**.
4.  Select **Activity log**.
5.  Under the filters, click **Timespan** and review the drop-down choices.
6.  Open an event and discuss.
7.  Back in the Monitor main page, click **Alerts** then click **+ New alert rule**.
8.  Under **Resource** click **Select**.
9.  Discuss how alerts can be scoped by subscription, resource type, and location.
10. Select a resource for the alert and then click **Done**.
11. Under **Condition** click **Add**.
12. Select a signal, such as **All Administrative operations**, and then click **Done**.
13. Under **Action group**, click **Create**. Review how action groups are used.
14. Under **Select an action type** review the various ways the action group can be alerted.
15. Select **Email/SMS/Push/Voice**.
16. Review the configuration choices and finish creating your action group.
17. Complete the **Alert details** and click **Create alert rule**.
18. On the **Alerts** page, review how you can search your alerts by resource and time range.

## Task 2 - Log Analytics

This lab requires a virtual machine in a running state.

In this task, we will configure Log Analytics and run a query.

1.  Sign into the **Portal**.
2.  Search for and launch **Log Analytics workspaces**.
3.  Click **Add** or **Create**.
4.  On the **Basics** tab, review and complete the required information.
5.  Under the Essentials view, review the **Pricing tier** detail (example: Pricing tier: Pay-as-you-go)
6.  Finish creating the workspace and wait for it to deploy.
7.  **Go to resource** and discuss how Log Analytics is used and configured.
8.  Under **Workspace Data Sources** select **Virtual machines**.
9.  Select a virtual machine and click **Connect**.
10. While you wait for the connection, under **Settings** click **Advanced settings**.
11. Click **Connected sources**. Discuss the possible sources like virtual machines and storage accounts.
12. Click **Data**. Review the different data sources.
13. Show how **Windows event logs** can be collected.
14. Save any changes you make.
15. Back at the Log Analytics workspace, Under **General** select **Logs**.
16. Review how log data is stored in tables and can be queried.
17. Select the **Event** table and then click **Run**.
18. Review the results.
