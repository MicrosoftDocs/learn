You want to monitor the VMs that host your website, so you decide to quickly create a VM in the Azure portal and evaluate its built-in monitoring capabilities. In this unit, you use the Azure portal to create a Linux VM with recommended alerts and boot diagnostics enabled. As soon as the VM starts up, Azure automatically begins collecting basic metrics and activity logs. You can then view built-in metrics graphs, activity logs, and boot diagnostics.

## Create a VM and enable recommended alerts

1. Sign in to the [Azure portal](https://portal.azure.com?azure-portal=true), and in the Search field, enter *virtual machines*.
1. On the **Virtual machines** page, select **Create**, and then select **Azure virtual machine**.
1. On the **Basics** tab of the **Create a virtual machine** page:
   - In the **Subscription** field, select the correct subscription if not already selected.
   - Under **Resource group**:
     1. Select **Create new**.
     1. Under **Name**, enter *learn-monitor-vm-rg*.
     1. Select **OK**.
   - For **Virtual machine name**, enter *monitored-linux-vm*.
   - For **Image**, select **Ubuntu Server 24.04 LTS**, **x64**, **Gen2**, published by Canonical. Use the full server image for this exercise.
1. Leave the other settings at their current values, and select the **Monitoring** tab.
1. On the **Monitoring** tab, select **Enable recommended alert rules** if the option is available.
1. If the **Set up recommended alert rules** screen opens:
   1. Select all the listed alert rules if not already selected, and adjust the values if desired.
   1. Under **Notify me by**, select the checkbox next to **Email**, and enter an email address to receive alert notifications.
   1. Select **Save**.
1. Under **Diagnostics**, for **Boot diagnostics**, ensure that **Enable with managed storage account (recommended)** is selected.

   > [!NOTE]
   > Keep boot diagnostics enabled with managed storage. Boot diagnostics and host metrics don't require Azure Monitor Agent. Later in this module, you enable Azure Monitor Agent and associated data collection rules to collect guest performance data and Linux Syslog. Don't enable a separate OS guest diagnostics extension.

1. Select **Review + create** at the bottom of the page, and when validation passes, select **Create**.
1. On the **Generate new key pair** popup dialog box, select **Download private key and create resource**.

It can take a few minutes to create the VM. When you get the notification that the VM is created, select **Go to resource** to see basic metrics data.

If the creation screen didn't offer recommended alerts, open the VM's **Alerts** page and select **View + set up**. Configure the desired host alert rules and the email notification action group, then select **Save**. For details, see [Enable recommended alert rules](/azure/azure-monitor/alerts/alerts-manage-alert-rules#enable-recommended-alert-rules-in-the-azure-portal).

Record the alert rule and action group names and their resource groups. You use this information during cleanup and avoid creating another set of recommended alerts when you enable guest monitoring.

## Prepare the Log Analytics workspace

1. In the Azure portal, search for **Log Analytics workspaces** and select **Create**.
1. Select the same subscription and the dedicated **learn-monitor-vm-rg** resource group used for this exercise.
1. Enter an available workspace name, such as **learn-monitor-vm-law**. Record the name you use.
1. Select the VM's region. Using one region for this lab simplifies configuration; it isn't a universal requirement that a VM and its Log Analytics workspace share a region.
1. Select **Review + Create**, then **Create**.
1. Record the workspace name, region, and resource group. Explicitly select this workspace in both the performance-monitoring configuration and the Syslog DCR.

> [!IMPORTANT]
> Use a dedicated lab resource group. Record any resources the portal creates outside that group. Don't delete a shared workspace or action group during cleanup.

For more information, see [Create a Log Analytics workspace](/azure/azure-monitor/logs/quick-create-workspace) and [Azure Monitor Agent supported operating systems](/azure/azure-monitor/agents/azure-monitor-agent-supported-operating-systems#debian-based-distributions).

## View built-in metrics graphs

Once your VM is created, Azure starts collecting basic metrics data automatically. Built-in metrics graphs, along with the recommended alerts you enabled, can help you monitor whether and when your VM encounters health or performance issues. You can then use more advanced monitoring and analytics capabilities to investigate issue causes and remediation.

1. To view basic metrics graphs, on the VMs **Overview** page, select the **Monitoring** tab.

   :::image type="content" source="../media/select-monitoring.png" alt-text="Screenshot of a VM's Monitoring tab on its Overview page." lightbox="../media/select-monitoring.png":::

1. Under **Performance and utilization** > **Platform metrics**, review the following metrics graphs related to the VMs performance and utilization. Select **Show more metrics** if all the graphs don't appear immediately.

   - **VM Availability**
   - **CPU (average)**
   - **Disk bytes (total)**
   - **Network (total)**
   - **Disk operations/sec (average)**

   :::image type="content" source="../media/platform-metrics.png" alt-text="Screenshot of platform metrics graphs on a VM's Overview page." lightbox="../media/platform-metrics.png":::

You haven't configured AMA guest performance collection yet. In the next units, you enable logs-based VM insights monitoring and use its Performance views and Log Analytics to analyze guest data.

## View the activity log

You can view the VMs activity log by selecting **Activity log** from the VMs left navigation menu. You can also retrieve entries by using PowerShell or the Azure CLI.

:::image type="content" source="../media/activity-log.png" alt-text="Screenshot of the activity log for a VM." lightbox="../media/activity-log.png":::

## View boot diagnostics

You enabled boot diagnostics when you created the VM. You can view boot diagnostics to view boot data and troubleshoot startup issues.

1. In the left navigation menu for the VM, select **Boot diagnostics** under **Help**.
1. On the **Boot diagnostics** page, select **Screenshot** to see a startup screenshot from the VMs hypervisor. Select **Serial log** to view log messages created when the VM started.

   :::image type="content" source="../media/3-boot-diagnostics.png" alt-text="Screenshot of a VM's boot diagnostics image." lightbox="../media/3-boot-diagnostics.png":::
