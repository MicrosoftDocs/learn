The shipping company that you work for wants to avoid any future issues with updates to its applications on the Azure platform. To improve the alerting capabilities within Azure, you'll use activity log alerts.

Your goal is to set up the Linux VM and create an activity log monitoring rule to detect when a VM is deleted. You'll then delete the VM to trigger this alert.

## Create the Azure activity log monitor

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) by using the same account that you activated the sandbox with.

1. On the Azure portal menu, select **Monitor**. The **Overview** pane for Monitor appears.

1. In the left menu pane, select **Alerts**. The **Alerts** pane for Monitor appears.

1. On the top menu bar, select **New alert rule**. The **Create alert rule** pane appears.

1. Under the **Scope** section, select **Select resource**. The **Select a resource** pane appears.

1. The **Filter by subscription** dropdown list should already be populated with **Concierge Subscription**. In the **Filter by resource type** dropdown list, select **Virtual machines**.

1. You want alerts when any virtual machine in your resource group is deleted. Select the **<rgn>[sandbox resource group name]</rgn>** resource group, and then select **Done**. The **Create alert rule** pane reappears.

   <!-- ![Screenshot that shows the page for selecting a resource.](../media/7-alert-select-resource.png) -->

1. In the **Condition** section, select **Add condition**. The **Configure signal logic** pane appears.

1. In the **Search by signal name** box, enter **Delete**. Select **Delete Virtual Machine (Microsoft.Compute/virtualMachines)**.

    <!-- ![Screenshot that shows the pane for creating a rule.](../media/7-conf-signal-logic.png) -->

1. You want to receive alerts of all types. Leave **Alert logic** settings at their default of **All**, and then select **Done**.

    <!-- ![Screenshot that shows the settings for metric condition logic.](../media/7-activity-log-logic.png) -->

## Add an email alert action

For the previous Azure Monitor alert, you didn't add any actions. You just viewed triggered alerts in the Azure portal. Actions enable you to send emails for notifications, trigger an Azure function, or call a webhook. You'll now add an email alert when VMs are deleted.

1. Under **Actions**, select **Add action groups**. The **Select an action group to attach to this alert rule** pane appears.

1. Select **Create action group**. The **Create action group** pane appears.

1. On the **Basics** tab, enter the following values for each setting.

    | Setting | Value |
    |---------|---------|
    | **Project details** |
    | Subscription | **Concierge Subscription** |
    | Resource group | From the dropdown list, name of your sandbox resource group |
    | **Instance details** |
    | Action group name | **Alert the operations team** |
    | Display name | **AlertOpsTeam** |

1. Select the **Notifications** tab, and enter the following values for each setting.

    | Setting | Value |
    |---------|---------|
    | **Notifications** |
    | Notification type | Select **Email/SMS message/Push/Voice** |
    | Name | **VM was deleted** |

1. Select the **Edit** pencil icon. The **Email/SMS message/Push/Voice** pane appears.

1. Select **Email**, and in the **Email** box, enter your email address, and then select **OK**.

    <!-- ![Screenshot that shows adding an action group and an email alert.](../media/7-email-setup.png) -->

1. On the **Create action group** pane, select **Review + create**.

1. Now that you've defined the rule, select **Create**.

1. The **Create alert rule** pane reappears. Under **Alert rule details**, enter the following values for each setting.

    | Setting | Value |
    |---------|---------|
    | Alert rule name | **VM was deleted** |
    | Description | **A VM in your resource group was deleted** |
    | Save alert rule to resource group | *default resource group* |
    | Enable alert rule upon creation | **Check - Yes**

   <!-- ![Screenshot that shows a completed alert details section.](../media/7-all-vm-alert-details.png) -->

1. Now that you've defined the rule, select **Create alert rule**.

Recipients added to the action group will receive a notification when they're added to the action group, when the alert is activated, and when the alert is triggered.

It can take up to five minutes for an activity log alert rule to become active. In this exercise, if you delete the virtual machine before this time, the alert rule might not be triggered. Because of this delay, you might not see the same results in the following steps after you delete the VM.

## Delete your virtual machine

To trigger the alert, you need to delete the virtual machine that you created earlier.

1. On the Azure portal menu or from the **Home** page, select **Virtual machines**. This action shows a list of the virtual machines.

1. Select the **vm1** virtual machine.

1. From the menu bar, select **Delete**. The **Delete Resources** pane appears.

1. To confirm the deletion, enter **yes**.

1. Select **Delete**.

## View your activity log alerts in Azure Monitor

In the example, you set up an Ubuntu VM, and you created an activity log rule to detect when the VM was deleted. You then deleted a VM from your resource group. You now need to check if an alert was triggered.

1. Open your email program. You should have received an email from azure-noreply@microsoft.com.

    ![Screenshot of alert email.](../media/7-alert-email.png)

1. On the Azure portal menu, select **Monitor**, and then select **Alerts**.

1. You should see the Sev4 alerts generated from the deletion of the VM.

    ![Screenshot that shows a completed alert details section.](../media/7-vm-rg-deleted-alert.png)

The alert list now shows an alert for the VM that you deleted. The affected resource column tells you which VM was removed.
