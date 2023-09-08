
Azure Service Health monitors the health of your cloud resources, including Log Analytics workspaces. When a Log Analytics workspace is healthy, data you collect from resources in your IT environment is available for querying and analysis in a relatively short period of time, measured as latency. When Azure Service Health detects average latency in your Log Analytics workspace, the workspace resource health status is Available.

To enable recommended alert rules:
1. In the Azure portal, navigate to the Log Analytics workspace. Under **Monitoring**, select the **Alerts** section and then under **Enable recommended alert** rules click **View + enable**.
1. This will bring up the **Enable recommended alert rules** page.

:::image type="content" source="../media/la-workspace3.png" alt-text="Screenshot of the Properties page of the Enable recommended alert rules page in a Log Analytics workspace with alert and notification settings configured." border="true":::

3. In the **Alert me if** section, select all the rules you want to enable.
1. In the **Notify me by** section, select the way you want to be notified if an alert is triggered.
1. Select **Use an existing action group**, and enter the details of the existing action group if you want to use an action group that already exists.
1. Select **Enable**.

If you want to create a new action group, you will perform the following steps before setting up the alert rules:
1. In the Azure portal, navigate to the Azure Monitor page.
1. In the navigation menu, select **Alerts**.
1. In the toolbar, select **Action groups**.
1. Select **+Create**.
1. Step through the Create action group wizard.
1. On the Notifications page, set the Notification type to **Email/SMS message/Push/Voice** and set Email to alerts@contoso.com.

If you want to create a new alert rule, perform the following steps:
1. In the Azure portal, navigate to the Log Analytics workspace. Under **Monitoring**, select the **Alerts** section. On the menu bar click the **Create** drop down and then click **Alert rule**.
1. On the **Condition** page select **Resource Health** and then click **Apply**. Once you select **Resource Health**, the rule triggers alerts for all status changes in all Log Analytics workspaces in the subscription by default. If necessary, you can edit and modify the scope and condition at this stage.
1. On the **Actions** page either select an existing action group or create a new action group.
1. On the **Details** page, specify the Resource Group, Alert rule name, and a description. 
1. Click **Review and Create**.
