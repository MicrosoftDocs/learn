## Azure VMs

You can use the Update Management solution to manage updates and patches for your virtual machines. For details, refer to [Manage updates and patches for your VMs](/azure/automation/update-management/manage-updates-for-vm).

## Update the monitoring configuration for SAP

Update the SAP monitoring configuration in any of the following scenarios:

 -  The joint Microsoft/SAP team extends the monitoring capabilities and requests more or fewer counters.
 -  Microsoft introduces a new version of Azure infrastructure that delivers the monitoring data, and the Azure Enhanced Monitoring Extension for SAP needs to be adapted to those changes.
 -  You add or remove data disks attached to your Azure VMs. In this scenario, update the collection of storage-related data. Changing your configuration by adding or deleting endpoints or by assigning IP addresses to a VM does not affect the monitoring configuration.
 -  You change the size of your Azure VM.
 -  You add new network interfaces to your Azure VM.

To update monitoring settings, redeploy the Azure Extension for SAP (by rerunning the PowerShell cmdlet **Set-AzVMAEMExtension** or the Azure CLI command `azure vm enable-aem`).
