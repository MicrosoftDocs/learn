The Azure Activity Log is a subscription log that provides insight into subscription-level events that occur in Azure. The events included are from Azure Resource Manager operational data, service health events, write operations taken on the resources in your subscription, and the status of activities performed in Azure. The Azure Activity Data connector uses Azure Policy to apply an Azure Subscription log-streaming pipeline that sends the event data to Log Analytics. 

> [!IMPORTANT]
> Prerequisites require your user to be assigned the owner role on the relevant subscription.

To deploy the *Azure Activity* connector, perform the following steps:

1. In the *Microsoft Sentinel* left menu, scroll down to **Content Management** and select **Content Hub**.

1. In the *Content Hub* page, type *Azure Activity* into the *Search* form, and select the **Azure Activity** solution.

1. In the **Azure Activity** solution details pane, select **Install**.

1. In the center *Content name* column, select the **Azure Activity** Data connector.

   > [!NOTE]
   > This solution installs these Content types: 12 Analytic rules, 14 Hunting queries, 1 Workbook, and the Azure Activity Data connector.

1. Select **Open connector page**.

1. In the *Instructions/Configuration* area, scroll down and under *2. Connect your subscriptions...* select **Launch Azure Policy Assignment Wizard**.

1. In the **Basics** tab, select the ellipsis button (...) under **Scope** and select your "Azure subscription" from the drop-down list and select **Select**.

1. Select the **Parameters** tab, choose your *yourName-sentinel* workspace from the **Primary Log Analytics workspace** drop-down list.

1. Select the **Remediation** tab and select the **Create a remediation task** checkbox. This action applies the subscription configuration to send the information to the Log Analytics workspace.

   > [!NOTE]
   > To apply the policy to your existing resources, you need to create a remediation task.

1. Select the **Review + Create** button to review the configuration.

1. Select **Create** to finish.

