The Azure Activity Log is a subscription log that provides insight into subscription-level events that occur in Azure. The events included are from Azure Resource Manager operational data, service health events, write operations taken on the resources in your subscription, and the status of activities performed in Azure.

> [!IMPORTANT]
> Prerequisites require your user to be assigned the owner role on the relevant subscription.

To view the connector page, do the following steps:

1. In the left menu pane, under **Configuration**, select **Data connectors**. The **Data connectors** pane appears.

1. In the *Search by name or provider* search box, search for and select **Azure Activity**. The **Azure Activity** details pane appears.

1. Select **Open connector page**.

1. In the Configuration area, scroll down and under "2. Connect your subscriptions..." select **Launch Azure Policy Assignment Wizard**.

1. In the **Basics** tab, select the ellipsis button (...) under **Scope** and select your "Azure subscription" from the drop-down list and click **Select**.

1. Select the **Parameters** tab, choose your *yourName-sentinel* workspace from the **Primary Log Analytics workspace** drop-down list.

1. Select the **Remediation** tab and select the **Create a remediation task** checkbox. This action applies the subscription configuration to send the information to the Log Analytics workspace.

   > [!NOTE]
   > To apply the policy to your existing resources, you need to create a remediation task.

1. Select the **Review + Create** button to review the configuration.

1. Select **Create** to finish.

