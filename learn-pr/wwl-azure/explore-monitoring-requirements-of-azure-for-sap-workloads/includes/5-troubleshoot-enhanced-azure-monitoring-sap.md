[SAP Note \#1999351](https://me.sap.com/notes/1999351) describes the process of troubleshooting issues with the Azure Extension for SAP. As the note states “to ensure full supportability of Azure for SAP workloads, it's crucial that the **AzureEnhancedMonitoring** service is correctly configured and that the Azure performance counters show up in the SAP OS monitor. In case there are no counters, supportability can't be guaranteed.“

If some of the monitoring data isn't delivered correctly, use the troubleshooting steps described here.

## Set-AzVMAEMExtension and Test-AzVMAEMExtension show warning messages stating that Standard Managed Disks aren't supported

### Issue

When executing **Set-AzVMAEMExtension** or **Test-AzVMAEMExtension** messages like these are shown:

```
WARNING: [WARN] Standard Managed Disks aren't supported. Extension will be installed but no disk metrics will be available.

WARNING: [WARN] Standard Managed Disks aren't supported. Extension will be installed but no disk metrics will be available.

WARNING: [WARN] Standard Managed Disks aren't supported. Extension will be installed but no disk metrics will be available.
```

Executing azperflib.exe indicates a non-healthy state.

### Solution

Standard Managed Disks aren't delivering the APIs used by the monitoring extension to check on statistics of the Standard Azure Storage Accounts. This message isn't a matter of concern. The reason for introducing the monitoring for Standard Disk Storage accounts was throttling of I/Os that occurred frequently. Managed disks avoid such throttling by limiting the number of disks in a storage account. Therefore, not having that type of monitoring data isn't critical.

## Windows performance counters don't show up at all

The **AzureEnhancedMonitoring** Windows service collects performance metrics in Azure. If the service isn't installed correctly or if it isn't running in your virtual machine, no performance metrics can be collected.

## The installation directory of the Azure Extension for SAP is empty

### Issue

The installation directory **C:\\Packages\\Plugins\\Microsoft.AzureCAT.AzureEnhancedMonitoring.AzureCATExtensionHandler\[version\]\\drop** is empty.

### Solution

The extension isn't installed. Determine whether this problem is a proxy issue. You might need to restart the machine or rerun the **Set-AzVMAEMExtension** cmdlet.

## Service for the Azure Extension for SAP doesn't exist

### Issue

The **AzureEnhancedMonitoring** Windows service doesn't exist. Azperflib.exe output throws an error indicating that the service of the Azure Extension for SAP isn't running.

### Solution

If the service doesn't exist, the Azure Extension for SAP isn't installed correctly. Reinstall the extension by using the steps described earlier. After you deploy the extension, after one hour, check again whether the Azure performance counters are provided in the Azure Virtual Machine.

## Service for the Azure Extension for SAP exists, but fails to start

### Issue

The **AzureEnhancedMonitoring** Windows service exists and is enabled, but fails to start. For more information, check the Application event log.

### Solution

The configuration is incorrect. Reinstall the extension by using the steps described earlier.

## Some Windows Azure performance counters are missing

The **AzureEnhancedMonitoring** Windows service collects performance metrics in Azure. The service gets data from several sources. Some configuration data is collected locally, and some performance metrics are read from Azure Diagnostics. Storage counters are used from your logging on the storage subscription level.

If troubleshooting by using [SAP Note \#1999351](https://me.sap.com/notes/1999351) doesn't resolve the issue, reinstall the extension by using the steps described earlier. You might have to wait an hour because storage analytics or diagnostics counters might not be created immediately after they're enabled. If the problem persists, open an SAP customer support message on the component BC-OP-NT-AZR for Windows or BC-OP-LNX-AZR for a Linux virtual machine.

## Linux performance counters don't show up at all

A Daemon collects performance metrics in Azure. If the daemon isn't running, no performance metrics can be collected.

## The installation directory of the Linux Azure Extension for SAP is empty

### Issue

The directory **\\var\\lib\\waagent\\** doesn't have a subdirectory for the Azure Extension for SAP.

### Solution

The extension isn't installed. Determine whether this problem is a proxy issue (as described earlier). You might need to restart the machine and/or reinstall the extension by using the steps described earlier.

## Some Linux Azure performance counters are missing

A Daemon collects performance metrics in Azure, and gets data from several sources. Some configuration data is collected locally, and some performance metrics are read from Azure Diagnostics. Storage counters come from the logs in your storage subscription.

For a complete and up-to-date list of known issues, see [SAP Note \#1999351](https://me.sap.com/notes/1999351), which has more troubleshooting information for the Azure Extension for SAP.

If troubleshooting by using [SAP Note \#1999351](https://me.sap.com/notes/1999351) doesn't resolve the issue, reinstall the extension by using the steps described earlier. You might have to wait for an hour because storage analytics or diagnostics counters might not be created immediately after they're enabled. If the problem persists, open an SAP customer support message on the component BC-OP-NT-AZR for Windows or BC-OP-LNX-AZR for a Linux virtual machine.
