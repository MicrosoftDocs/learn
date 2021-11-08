[SAP Note \#1999351](https://launchpad.support.sap.com/#/notes/1999351) describes the process of troubleshooting issues with Azure Enhanced Monitoring. As the note states “to ensure full supportability of Azure for SAP workloads, it is crucial that the **AzureEnhancedMonitoring** service is correctly configured and that the Azure performance counters show up in the SAP OS monitor. In case there are no counters, supportability cannot be guaranteed.“

If some of the monitoring data is not delivered correctly, use the troubleshooting steps described here.

## Set-AzVMAEMExtension and Test-AzVMAEMExtension show warning messages stating that Standard Managed Disks are not supported

### Issue

When executing **Set-AzVMAEMExtension** or **Test-AzVMAEMExtension** messages like these are shown:

```
WARNING: [WARN] Standard Managed Disks are not supported. Extension will be installed but no disk metrics will be available.

WARNING: [WARN] Standard Managed Disks are not supported. Extension will be installed but no disk metrics will be available.

WARNING: [WARN] Standard Managed Disks are not supported. Extension will be installed but no disk metrics will be available.

```

Executing azperflib.exe indicates a non-healthy state.

### Solution

The messages are caused by the fact that Standard Managed Disks are not delivering the APIs used by the monitoring extension to check on statistics of the Standard Azure Storage Accounts. This is not a matter of concern. The reason for introducing the monitoring for Standard Disk Storage accounts was throttling of I/Os that occurred frequently. Managed disks will avoid such throttling by limiting the number of disks in a storage account. Therefore, not having that type of monitoring data is not critical.

## Windows performance counters do not show up at all

The AzureEnhancedMonitoring Windows service collects performance metrics in Azure. If the service has not been installed correctly or if it is not running in your VM, no performance metrics can be collected.

## The installation directory of the Azure Enhanced Monitoring Extension is empty

### Issue

The installation directory **C:\\Packages\\Plugins\\Microsoft.AzureCAT.AzureEnhancedMonitoring.AzureCATExtensionHandler\[version\]\\drop** is empty.

### Solution

The extension is not installed. Determine whether this is a proxy issue. You might need to restart the machine or rerun the **Set-AzVMAEMExtension** cmdlet.

## Service for Azure Enhanced Monitoring does not exist

### Issue

The **AzureEnhancedMonitoring** Windows service does not exist. Azperflib.exe output throws an error indicating that the service of the Azure Enhanced Monitoring Extension for SAP is not running.

### Solution

If the service does not exist, the Azure Enhanced Monitoring Extension for SAP has not been installed correctly. Reinstall the extension by using the steps described earlier. After you deploy the extension, after one hour, check again whether the Azure performance counters are provided in the Azure VM.

## Service for Azure Enhanced Monitoring exists, but fails to start

### Issue

The **AzureEnhancedMonitoring** Windows service exists and is enabled, but fails to start. For more information, check the application event log.

### Solution

The configuration is incorrect. Reinstall the extension by using the steps described earlier.

## Some Windows Azure performance counters are missing

The **AzureEnhancedMonitoring** Windows service collects performance metrics in Azure. The service gets data from several sources. Some configuration data is collected locally, and some performance metrics are read from Azure Diagnostics. Storage counters are used from your logging on the storage subscription level.

If troubleshooting by using [SAP Note \#1999351](https://launchpad.support.sap.com/#/notes/1999351) doesn't resolve the issue, reinstall the extension by using the steps described earlier. You might have to wait an hour because storage analytics or diagnostics counters might not be created immediately after they are enabled. If the problem persists, open an SAP customer support message on the component BC-OP-NT-AZR for Windows or BC-OP-LNX-AZR for a Linux virtual machine.

## Linux performance counters do not show up at all

Performance metrics in Azure are collected by a daemon. If the daemon is not running, no performance metrics can be collected.

## The installation directory of the Linux Azure Enhanced Monitoring extension is empty

### Issue

The directory **\\var\\lib\\waagent\\** does not have a subdirectory for the Azure Enhanced Monitoring extension.

### Solution

The extension is not installed. Determine whether this is a proxy issue (as described earlier). You might need to restart the machine and/or reinstall the extension by using the steps described earlier.

## Some Linux Azure performance counters are missing

Performance metrics in Azure are collected by a daemon, which gets data from several sources. Some configuration data is collected locally, and some performance metrics are read from Azure Diagnostics. Storage counters come from the logs in your storage subscription.

For a complete and up-to-date list of known issues, see [SAP Note \#1999351](https://launchpad.support.sap.com/#/notes/1999351), which has more troubleshooting information for Enhanced Azure Monitoring for SAP.

If troubleshooting by using [SAP Note \#1999351](https://launchpad.support.sap.com/#/notes/1999351) does not resolve the issue, reinstall the extension by using the steps described earlier. You might have to wait for an hour because storage analytics or diagnostics counters might not be created immediately after they are enabled. If the problem persists, open an SAP customer support message on the component BC-OP-NT-AZR for Windows or BC-OP-LNX-AZR for a Linux virtual machine.
