In this exercise, you view your Microsoft Entra sign-in logs, select columns and filter data for the logs, and then download the logs. You also view your Microsoft Entra instance audit logs through the **Users** menu.

In this exercise, you'll:

- Create a Log Analytics workspace.
- Create a Diagnostic setting.



## Create a Log Analytics workspace

To create a Log Analytics workspace:

1. In the Azure portal, click **Create a resource**.
    :::image type="content" source="../media/create-a-resource-portal-home.png" alt-text="Screenshot that shows the option to create a resource.":::
1. In the search-textbox, type **log analytics workspace**.
1. Click **Log Analytics Workspace**.
1. Click **Create**.

    :::image type="content" source="../media/create-log-analytics-workspace.png" alt-text="Screenshot that shows the option to create a Log Analytics workspace.":::
1. On the **Create Log Analytics workspace** page:
    :::image type="content" source="../media/review-and-create-log-analytics-workspace.png" alt-text="Screenshot that shows the dialog to review and create a Log Analytics workspace.":::
    1. Under the **Resource group** textbox, click **Create new** to create a new resource.
    1. In the **Name** textbox, type **Resource1**, ad then click **OK**, to create the resource. 
    1. In the **Name** textbox, type **Workspace1**.
    1. Click **Review + Create**.
1. Click **Create**.

You need to wait a moment now until Azure has finished creating your Log Analytics workspace.
:::image type="content" source="../media/log-analytics-workspace-deployment-complete.png" alt-text="Screenshot that shows a confirmation of the creation of a Log Analytics workspace.":::




## Create a Diagnostic setting

To create a Diagnostic setting:
:::image type="content" source="../media/create-diagnostic-setting.png" alt-text="Screenshot that shows the configuration of a new diagnostic setting.":::

1. In the Azure portal, navigate to the [Diagnostic settings](https://portal.azure.com/#view/Microsoft_AAD_IAM/ActiveDirectoryMenuBlade/~/DiagnosticSettings).
1. On the **Diagnostic settings** page, click **Add diagnostic settings**.
1. In the **Diagnostic setting name** textbox, type **Diagnostic Setting 1**.
1. Under **Logs**, select **SignInLogs**.
1. Under **Destination details**, select **Send to Log Analytics workspace**.
1. Select **Azure subscription 1** as **Subscription**.
1. Select **Workspace1** as **Log analytics workspace**.
1. Click **Save**.

Your log data is typically accessible within 15 minutes.
To verify, whether the log data has been, synchronized, check the **LogManagement** section in log analytics. The logs you've configured will be displayed as soon as the data has been synchronized.


:::image type="content" source="../media/verify-logs-data.png" alt-text="Screenshot that shows how to verify whether the logs data is available.":::

 
