You want to monitor the VMs that host your website, so you decide to quickly create a VM in the Azure portal and evaluate its built-in monitoring capabilities. In this unit, you use the Azure portal to create a Linux VM with recommended alerts and boot diagnostics enabled. As soon as the VM starts up, Azure automatically begins collecting basic metrics and activity logs, and you can view built-in metrics graphs, activity logs, and boot diagnostics.

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
   - For **Image**, select **Ubuntu Server 20.04 LTS - x64 Gen2**.
1. Leave the other settings at their current values, and select the **Monitoring** tab.

   :::image type="content" source="../media/create-vm-basic.png" alt-text="Screenshot that shows the Basics tab of the Create a virtual machine page." lightbox="../media/create-vm-basic.png":::

1. On the **Monitoring** tab, select the checkbox next to **Enable recommended alert rules**.
1. On the **Set up recommended alert rules** screen:
   1. Select all the listed alert rules if not already selected, and adjust the values if desired.
   1. Under **Notify me by**, select the checkbox next to **Email**, and enter an email address to receive alert notifications.
   1. Select **Save**.
1. Under **Diagnostics**, for **Boot diagnostics**, ensure that **Enable with managed storage account (recommended)** is selected.

   > [!NOTE]
   > Don't select **Enable guest OS diagnostics**. The Linux Diagnostics Agent (LAD) is deprecated, and you can enable guest OS and client monitoring later.

1. Select **Review + create** at the bottom of the page, and when validation passes, select **Create**.

   :::image type="content" source="../media/create-vm-monitoring.png" alt-text="Screenshot that shows the Monitoring tab and alert rule configuration screen of the Create a virtual machine page." lightbox="../media/create-vm-monitoring.png":::

1. On the **Generate new key pair** popup dialog box, select **Download private key and create resource**.

It can take a few minutes to create the VM. When you get the notification that the VM is created, select **Go to resource** to see basic metrics data.

## View built-in metrics graphs

Once your VM is created, Azure starts collecting basic metrics data automatically. Built-in metrics graphs, along with the recommended alerts you enabled, can help you monitor whether and when your VM encounters health or performance issues. You can then use more advanced monitoring and analytics capabilities to investigate issue causes and remediation.

1. To view basic metrics graphs, on the VM's **Overview** page, select the **Monitoring** tab.

   :::image type="content" source="../media/select-monitoring.png" alt-text="Screenshot that shows Monitoring tab on a VM's Overview screen." lightbox="../media/select-monitoring.png":::

1. Under **Performance and utilization** > **Platform metrics**, review the following metrics graphs related to the VM's performance and utilization. Select **Show more metrics** if all the graphs don't appear immediately.

   - **VM Availability**
   - **CPU (average)**
   - **Disk bytes (total)**
   - **Network (total)**
   - **Disk operations/sec (average)**

   :::image type="content" source="../media/platform-metrics.png" alt-text="Screenshot that shows the platform metrics graphics on the VM Overview page." lightbox="../media/platform-metrics.png":::

1. Under **Guest OS metrics**, notice that guest OS metrics aren't being collected yet. In the next units, you configure VM insights and data collection rules to collect guest OS metrics.

## View the activity log

You can view the VM's activity log by selecting **Activity log** from the VM's left navigation menu. You can also retrieve entries by using PowerShell or the Azure CLI.

:::image type="content" source="../media/activity-log.png" alt-text="Screenshot of the activity log for a VM." lightbox="../media/activity-log.png":::

## View boot diagnostics

You enabled boot diagnostics when you created the VM. You can view boot diagnostics to view boot data and troubleshoot startup issues.

1. In the left navigation menu for the VM, select **Boot diagnostics** under **Help**.
1. On the **Boot diagnostics** page, select **Screenshot** to see a startup screenshot from the VM's hypervisor. Select **Serial log** to view log messages created when the VM started.

   :::image type="content" source="../media/3-boot-diagnostics.png" alt-text="Screenshot that shows the boot diagnostic image captured." lightbox="../media/3-boot-diagnostics.png":::

