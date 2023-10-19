You can quickly create an Azure VM by using the Azure portal, the Azure CLI, or PowerShell. In the Azure portal, you can enable boot diagnostics and recommended alerts when you create the VM. As soon as the VM starts up, Azure begins collecting basic metrics automatically, and you can view built-in metrics charts.

In this unit, you use the Azure portal to create a Linux VM with recommended alerts and boot diagnostics enabled. After you create the VM, you view the built-in metrics graphs, boot diagnostics, and activity logs.

## Create a VM

1. Sign in to the [Azure portal](https://portal.azure.com?azure-portal=true), and in the Search field, enter and select **virtual machines**.
1. On the **Virtual machines** page, select **Create**, and then select **Azure virtual machine**.
1. On the **Basics** tab of the **Create a virtual machine** page:
   - In the **Subscription** field, select the correct subscription if not already selected.
   - Under the **Resource group** field select **Create new**, enter *learn-monitor-vm-rg* under **Name**, and then select **OK**.
   - For **Virtual machine name**, enter *monitored-linux-vm*.
   - For **Image**, select **Ubuntu Server 20.04 LTS - x64 Gen2**.
1. Near the top of the page, select **Monitoring**.

   :::image type="content" source="../media/create-vm-basic.png" alt-text="Screenshot that shows the Basics tab of the Create a virtual machine page." lightbox="../media/create-vm-basic.png":::

1. On the **Monitoring** screen, select the checkbox next to **Enable recommended alert rules**.
1. On the **Set up recommended alert rules** screen:
   1. Select all the listed alert rules if not already selected.
   1. Under **Notify me by**, select the checkbox next to **Email**, and enter an email address to receive alert notifications.
   1. Select **Save**.
1. Under **Diagnostics**, next to **Boot diagnostics**, ensure that **Enable with managed storage account (recommended)** is selected.
1. Select **Review + create** at the bottom of the page, and when validation passes, select **Create**.

   :::image type="content" source="../media/create-vm-monitoring.png" alt-text="Screenshot that shows the Monitoring tab and alert rule configuration screen of the Create a virtual machine page." lightbox="../media/create-vm-monitoring.png":::

1. On the **Generate new key pair** popup, select **Download private key and create resource**.

It can take a few minutes to create the VM. When you get the notification that the VM is created, select **Go to resource**.

## View built-in metrics graphs

Once an Ubuntu or Windows VM is created, Azure starts collecting basic metrics data automatically. To view basic metrics graphs, on the VM's **Overview** page, select the **Monitoring** tab.

:::image type="content" source="../media/select-monitoring.png" alt-text="Screenshot that shows Monitoring tab on a VM's Overview screen." lightbox="../media/select-monitoring.png":::

Under **Performance and utilization** > **Platform metrics**, you can see the following useful graphs related to the VM's performance and utilization:

- **VM Availability**
- **CPU (average)**
- **Disk bytes (total)**
- **Network (total)**
- **Disk operations/sec (average)**

:::image type="content" source="../media/platform-metrics.png" alt-text="Screenshot that shows the platform metrics graphics on the VM Overview page." lightbox="../media/platform-metrics.png":::

Under **Guest OS metrics**, notice that guest OS metrics aren't being collected yet. In the next units, you configure VM Insights and data collection rules to collect guest OS metrics.

## View boot diagnostics

You enabled boot diagnostics when you created the VM. You can view boot diagnostics to troubleshoot VM boot issues.

1. In the left navigation menu for the VM, select **Boot diagnostics** under **Help**.
1. On the **Boot diagnostics** page, select **Screenshot** to see a startup screenshot from the VM's hypervisor. Select **Serial log** to view log messages created when the VM started.

   :::image type="content" source="../media/3-boot-diagnostics.png" alt-text="Screenshot that shows the boot diagnostic image captured." lightbox="../media/3-boot-diagnostics.png":::

## View the activity log

The Azure Monitor activity log is an Azure platform log that includes information like when your VM starts or is modified. You can view the VM's activity log in the Azure portal by selecting **Activity log** from the VM's left navigation menu. You can also retrieve entries with PowerShell and the Azure CLI. For more functionality, you can create diagnostic settings to send activity logs to the following destinations:

- Azure Monitor Logs, for more complex querying and alerting and for longer retention up to two years.
- Azure Storage, for cheaper, long-term archiving.
- Azure Event Hubs, to forward outside of Azure.

:::image type="content" source="../media/activity-log.png" alt-text="Screenshot of the activity log for a VM." lightbox="../media/activity-log.png":::
