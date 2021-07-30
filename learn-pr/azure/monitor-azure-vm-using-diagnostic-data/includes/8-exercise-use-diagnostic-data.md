Azure enables you to take action on the metrics you're capturing. You can create alerts that email you, or start automations with runbooks.

Now, you'll create an alert based on your web server's CPU usage. If the CPU usage goes above the set threshold of 90 percent for five minutes, you get an email.

In this unit, you'll add an alert for your VM. Next, you'll cause the VM CPU usage to spike, and receive the alert email.

## Create an alert based on CPU usage

If CPU usage goes above 90 percent for one minute, you'd like to get a notification. 

1. Go to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) and sign in with the account that you used to enable the sandbox.

1. On the Azure portal menu, or from the **Home** page, select **Virtual machines**.

1. Select the **monitored-linux-vm** virtual machine that you created.

1. On the left menu pane, scroll down, and select **Metrics**.

1. Select **New alert rule**. The **Create alert rule** pane appears.

    ![Screenshot that shows the button for a new alert rule on the metrics pane.](../media/8-metrics-new-alert-rule-button.png)

### Select the resource

1. Under **Scope**, select the **Select resource** link.

1. In the **Filter by resource type** field, select **Virtual machines**.

1. Under **Resource**, select **monitored-linux-vm**.

    ![Screenshot that shows the VM selected on the pane for selecting a resource.](../media/8-alert-select-a-resource-vm.png)

1. Select **Done**.

### Create the condition

1. Under **Condition**, select the **Add condition** link. The **Select a signal** pane appears.

1. Under **Signal name**, select **Percentage CPU**. The **Configure signal logic** pane appears.

    ![Screenshot that shows "Percentage CPU" selected as the signal name](../media/8-configure-signal-logic-percentage-cpu.png)

1. Under **Alert logic**, enter the following values.

   |Field |value  |
   |---------|---------|
   |Operator |    Greater than or equal to     |
   |Aggregation type   |  Average       |
   |Threshold value   |    90     |

    ![Screenshot that shows the section for alert logic filled out.](../media/8-alert-logic.png)

1. Select **Done**. The **Create alert rule** pane appears.

### Add an action

1. Under **Actions**, select the **Add action groups** link. The **Add action groups** pane appears.

1. Select **Create action group**.

1. On the **Basics** tab, enter the following values for each setting.

    |Setting  |Value  |
    |---|---|
    | **Project details** |
    |Subscription       | Concierge Subscription               |
    |Resource group       | <rgn>[sandbox resource group name]</rgn> |
    | **Instance details** |
    |Action group name | Email alerts |

   ![Screenshot that shows the "Add action group" pane filled out.](../media/8-create-action-group-basics.png)

1. Select **Next: Notifications**, and enter the following values for each setting.

    |Setting  |Value  |
    |---|---|
    | **Notifications** |
    |Notification type      | Email/SMS/Push/Voice |
    |Name     | High CPU usage       |

    The **Email/SMS message/Push/Voice** pane appears.

   ![Screenshot that shows the notifications pane filled out with the information from the following table.](../media/8-create-action-group-notifications.png)

1. Tick the **Email** checkbox, and enter your email address to receive the alert notification. If this pane doesn't appear, select **Edit** for the notification type.
  
   ![Screenshot that shows the "Email/SMS/Push/Voice" pane ](../media/8-create-action-group-notifications-email.png)

1. Select **OK**.

1. Select **Review + create**, and then select **Create**. The **Create alert rule** pane appears.

### Enter alert rule details

1. Under **Alert rule details**, enter the following values.

    |Field  |Value  |
    |---|---|
    |Alert rule name | Web server CPU running hot    |
    |Description     | Email alert notifies when the CPU is over 90% |

   ![Screenshot that shows the fields for alert details.](../media/8-alert-rule-details.png)

1. Select **Create alert rule**.

Wait a few minutes for this rule to activate.

## Trigger the alert

1. Go to the VM **Overview** pane.

1. In the upper menu bar, select **Connect**, and then select **SSH**. The **Connect** pane for your VM appears.

   ![Screenshot that shows the "Connect" button on the VM overview pane](../media/8-vm-overview-connect-button.png)

1. Under step 4 (**Run the example command below to connect to your VM**), copy the **azureuser**@ and IP address that follows.

1. In Azure Cloud Shell to the right, enter **SSH**, and paste what you copied in the previous step. It should look like the following command.

    ```bash
    ssh azureuser@<ipaddress>
    ```

    If Cloud Shell times out, select **Reconnect**.

1. When you're prompted, enter **yes** to connect to the VM.
1. Run the following command to update the list of available updates.

    ```bash
    sudo apt-get update
    ```

1. Run the following command to install the stress tool on the VM.

    ```bash
    sudo apt-get install stress
    ```

1. Run the following command to stress the VM's CPU.

    ```bash
    sudo stress --cpu 16 -v -t 10m
    ```

1. Return to the Azure portal.

1. On the Azure portal menu, or from the **Home** page, select **Dashboard**, and then select **KPI Dashboard**.

1. On the **Max CPU percentage guest OS for monitored-linux-vm** graph, select the ellipses (**...**) on the upper right, and then select **Refresh**.

1. After a few minutes, the CPU should approach 100 percent, and you'll receive an alert email.

    ![Screenshot of the alert email.](../media/8-alert-email.png)
