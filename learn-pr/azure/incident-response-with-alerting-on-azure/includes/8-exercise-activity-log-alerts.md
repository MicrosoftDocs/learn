The shipping company for which you work wants to avoid any future issues with updates to its applications on the Azure platform. To improve the alerting capabilities within Azure, you can create activity log alerts.

Your goal is to set up a Linux virtual machine (VM) and create an activity log monitoring rule to detect when a VM is deleted. Then, delete the VM to trigger this alert.

## Create the Azure activity log monitor

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) with the same account you used to activate the sandbox.

1. Select your user icon in the top right corner, then go to **Switch directory** and **Switch** to **Microsoft Learn Sandbox**.

1. On the Azure portal resource menu or under **Azure services**, select **Monitor**. The **Overview** pane for Monitor appears.

1. In the Monitor menu, select **Alerts**. The **Monitor | Alerts** pane appears.

1. On the command bar, select **+ Create** and select **Alert rule** from the dropdown list. The **Create an alert rule** pane appears in the background with the **Scope** section open, and the **Select a resource** overlay pane on the right-hand side of your screen.

1. On the **Select a resource** overlay pane in the **Resource types** dropdown list, search for and select **Virtual machines**.

1. You want an alert when any virtual machine in your resource group is deleted. Select the box for the Sandbox resource group **learn-53f3da3b-946a-4d7d-974e-6ac534868856**, then select **Apply**.

    :::image type="content" source="../media/8-alert-resource.png" lightbox="../media/8-alert-resource.png" alt-text="Screenshot that shows the 'Select a resource' pane with the sandbox resource group selected.":::

1. Back on the **Create an alert rule** pane, the Scope target resource now shows **All Virtual machines**. Select the **Condition** tab.

1. On the **Condition** tab, select the **See all signals** link, which opens the **Select a signal** overlay pane to the right-hand side of your screen.

1. On the **Select a signal** overlay pane, search for and select **Delete Virtual Machine (Virtual Machines)**, then select **Apply**

    :::image type="content" source="../media/8-alert-signal.png" lightbox="../media/8-alert-signal.png" alt-text="Screenshot that shows the 'Select a signal' pane with 'Delete Virtual Machine (Virtual Machines)' selected.":::

1. You're back on the **Create an alert rule** pane. To receive alerts of all types, leave **Alert logic** settings at their default of **All selected**. Leave the **Create an alert rule** pane open for the next section.

## Add an email alert action

For the previous Azure Monitor alert, you didn't add any actions. You just viewed triggered alerts in the Azure portal. Actions let you send an email for notifications, to trigger an Azure function, or to call a webhook. In this exercise, we're adding an email alert when VMs are deleted.

1. On the **Create an alert rule** pane, select the **Next: Actions** button.

1. Close the **Use quick actions (preview)** overlay pane. Then, select **Use action group** on the **Actions** tab. The **Select action groups** overlay pane appears.

1. On the **Select action groups** overlay pane, select **+ Create action group**.

1. On the **Basics** tab, enter the following values for each setting.

    | Setting              | Value                                                       |
    |----------------------|-------------------------------------------------------------|
    | **Project details**  |                                                             |
    | Subscription         | **Concierge Subscription**                                  |
    | Resource group       | From the dropdown list, select your sandbox resource group. |
    | Region               | **Global** (default)                                        |
    | **Instance details** |                                                             |
    | Action group name    | **Alert the operations team**                               |
    | Display name         | **AlertOps**                                                |

    :::image type="content" source="../media/8-action-group-basics.png" lightbox="../media/8-action-group-basics.png" alt-text="Screenshot that shows the 'Create action group' pane with all Project details and Instance details entered.":::

1. Select **Next: Notifications** and enter the following values for each setting.

    | Setting           | Value                                   |
    |-------------------|-----------------------------------------|
    | Notification type | Select **Email/SMS message/Push/Voice** |
    | Name              | **VM was deleted**                      |

1. The **Email/SMS message/Push/Voice** overlay pane appears automatically on the right-hand side of the screen. If it didn't, select the **Edit** pencil icon.

1. On the **Email/SMS message/Push/Voice** overlay pane, select **Email**. Then, in the **Email** field, enter your email address and select **OK**.

    :::image type="content" source="../media/8-alert-action.png" lightbox="../media/8-alert-action.png" alt-text="Screenshot that shows the 'Email/SMS message/Push/Voice' pane with Email selected.":::

1. Back on the **Create action group** pane, select **Review + create** to validate your input.

1. Select **Create**.

1. The **Create an alert rule** pane reappears. Select **Next: Details** and enter the following values for each setting.

    | Setting         | Value                                       |
    |-----------------|---------------------------------------------|
    | Alert rule name | **VM was deleted**                          |
    | Description     | **A VM in your resource group was deleted** |

1. Expand the **Advanced options** section and confirm that **Enable alert rule upon creation** is selected.

    :::image type="content" source="../media/8-alert-details.png" lightbox="../media/8-alert-details.png" alt-text="Screenshot that shows a completed alert details section.":::

1. Select **Review + create** to validate your input, then select **Create**.

Recipients added to the configured action group (operations team) receive a notification:

* When they're added to the action group
* When the alert is activated
* When the alert is triggered

It can take up to five minutes for an activity log alert rule to become active. In this exercise, if you delete the virtual machine before the rule deploys, the alert rule might not be triggered. Because of this delay, you might not see the same results in the following steps after you delete the VM.

## Delete your virtual machine

To trigger an alert, you need to delete the Linux VM that you created in the previous exercise.

1. On the Azure portal menu or from the **Home** page, select **Virtual machines**.

1. Check the box for the **vm1** virtual machine.

1. Select **Delete** from the menu bar.

1. Enter *delete* to confirm deletion and select **Delete**.

    :::image type="content" source="../media/8-delete-vm.png" lightbox="../media/8-delete-vm.png" alt-text="Screenshot that shows the 'Delete Resources' pane with the VM selected.":::

1. In the title bar, select the **Notifications** icon and wait until **vm1** is successfully deleted.

## View your activity log alerts in Azure Monitor

In the exercise, you set up an Ubuntu VM and created an activity log rule to detect when the VM was deleted. You then deleted a VM from your resource group. Let's check whether an alert was triggered.

1. You should receive a notification email that reads, **Important notice: Azure Monitor alert VM was deleted was activated...** If not, open your email program and look for an email from azure-noreply@microsoft.com.

    :::image type="content" source="../media/8-alert-email.png" lightbox="../media/8-alert-email.png" alt-text="Screenshot that shows the email you receive when an alert fires.":::

1. On the Azure portal resource menu, select **Monitor**, and then select **Alerts** in the menu on the left.

1. You should have three verbose alerts that were generated by deleting **vm1**.

    :::image type="content" source="../media/8-alerts-pane.png" lightbox="../media/8-alerts-pane.png" alt-text="Screenshot that shows all alerts with Name, Severity, Alert condition, User response and Fired time.":::

1. Select the name of one of the alerts (For example, **VM was deleted**). An **Alert details** pane appears that shows more details about the event.

## Add an alert processing rule to the alert

We're going to schedule a one-time, overnight, planned maintenance. It starts in the evening and continues until the next morning.

1. In the Azure portal resource menu, select **Monitor**, select **Alerts** in the menu on the left, and select **Alert processing rules** in the menu bar.

1. Select **+ Create**.

1. Check the box for your sandbox resource group as the scope of the alert processing rule, then select **Apply**.

    :::image type="content" source="../media/8-alert-processing-rule-resource.png" lightbox="../media/8-alert-processing-rule-resource.png" alt-text="Screenshot that shows the selected resource group for the alert processing rule.":::

1. Select **Next: Rule settings**, then select **Suppress notifications**.

1. Select **Next: Scheduling**.

1. By default, the rule works all the time, unless you disable it. We're going to define the rule to suppress notifications for a one-time overnight planned maintenance.
Enter these settings for the scheduling of the alert processing rule:

    | Setting        | Value                         |
    |----------------|-------------------------------|
    | Apply the rule | At a specific time            |
    | Start          | Enter today's date at 10pm.   |
    | End            | Enter tomorrow's date at 7am. |
    | Time zone      | Select the local timezone.    |

    :::image type="content" source="../media/8-alert-processing-rule-schedule.png" lightbox="../media/8-alert-processing-rule-schedule.png" alt-text="Screenshot of the scheduling section of an alert processing rule.":::

1. Select **Next: Details** and enter these settings:

    | Setting        | Value                                                  |
    |----------------|--------------------------------------------------------|
    | Resource group | Select your sandbox resource group.                    |
    | Rule name      | **Planned Maintenance**                                |
    | Description    | **Suppress notifications during planned maintenance.** |

1. Select **Review + create** to validate your input, then select **Create**.
