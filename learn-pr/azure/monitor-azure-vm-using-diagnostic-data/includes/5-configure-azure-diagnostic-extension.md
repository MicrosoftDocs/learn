If you need to capture more detailed performance metrics, or need them in near real time, install the Azure Diagnostic extension. After it's installed, you can configure it to capture what you need.

Your band is on tour next month, and you have identified specific metrics you want to use to monitor the health of your virtual machine (VM). The metrics that you want to monitor go beyond the basic metrics available in the Azure portal. You've decided to enable guest diagnostics to get more data.

In this unit, you'll see how to install the Azure diagnostics extension to monitor the health of a VM. You'll learn how to enable guest diagnostics when you create a VM and for an already created VM.

## Installing the Azure diagnostics extension

The Azure diagnostics extension allows you to collect real-time performance metrics from the guest operating system, along with log events, and store the results in an Azure storage account.

You can add the extension for Linux or Windows when you create the VM in Azure. In the Monitoring section, you set **OS guest diagnostics** to **On**.

![Screenshot of the Create a VM Management page, showing the OS guest diagnostics option selected.](../media/5-add-diagnostics-on-creation.png)

If you've already created the VM, the easiest way to add the extension is by going to **Diagnostic settings** for the VM. Select the storage account, and then select **Enable guest-level monitoring**.

![Screenshot of the diagnostic settings page, showing the enable page](../media/5-enable-diagnostics-portal.png)

You can also add the extension by using Azure CLI or PowerShell. In Azure CLI, you'd use the command `az vm boot-diagnostics enable`. In PowerShell, you'd use the `Set-AzVMBootDiagnostic` command.

The extension allows you to collect data about the CPU, disk, and memory values of the VM.

## Configuring the extension

You have different configuration options depending on the OS installed on the VM. At the basic level, these options are:

|Windows  |Linux  |
|---------|---------|
|Performance counters: CPU, Memory, Disk, Network, APS.NET, SQL Server *(60-second sample)*    |  Metrics: Processor, Memory, Network, Filesystem, Disk *(15-second sample)*      |
|Logs: Application, Security, System, Event tracing    | Syslog        |
|Crash dumps     | Not available        |
|Sink data: Azure Monitor, Application Insights     | Not available        |

However you can choose to collect custom metrics like percentage of free disk space on Windows, or the amount of swap available on Linux.

You can configure the extension in the Azure portal. The configuration is changed in the same place for both operation systems, on the **Diagnostic settings** page.

![Screenshot of the diagnostics settings page](../media/5-diagnostics-settings-on.png)

Because each feature provides specific information, you choose the ones that meet your needs. When you've collected diagnostic logs for a VM, you have a few places you can use them:

   - Keep the logs in a storage account for auditing or manual inspection of application issues.
   - Use third-party services to ingest the logs (Event Hubs, Power BI).
   - Use Azure Monitor to analyze the logs.

