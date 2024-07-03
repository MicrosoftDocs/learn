Since the monitoring demands by SAP were specific to SAP applications, Microsoft initially decided not to generically implement the required functionality into Azure. The decisions on which monitoring components to deploy is left to the customer, along with setting the configurations to their Azure Virtual Machines. However, deployment and lifecycle management of the monitoring components can be mostly automated by Azure.

The solution developed to enable SAP Monitoring is based on the concept of Azure Virtual Machine Agent and its extensions. The principal idea behind this concept is to allow (in cases like the Azure Extension for SAP), the deployment of special functionality into a virtual machine and the configuration of such software at deployment time. The extension is required for SAP workloads to be supported on Azure Virtual Machines.

The 'Azure Virtual Machine Agent' that enables handling of specific Azure Virtual Machine Extensions within the virtual machine is injected into Windows virtual machines by default on virtual machine creation. When virtual machines are SUSE, Red Hat, or Oracle Linux, the virtual machine agent is already part of the Azure Marketplace image. If custom images, the virtual machine Agent must be installed manually.

Any interaction between the Azure Extension for SAP and the SAP system takes place via the SAP Host Agent. The Host Agent is a standalone component that doesn't have a direct dependency on the SAP kernel, which eliminates the need to update it during the SAP system updates.

The SAP monitoring tools SAPOSCOL or SAP Host Agent retrieves Azure Virtual Machine telemetry via the Azure Extension for SAP. The extension allows SAP to collect important performance counters and display those via SAP transactions ST06 and OS07. The extension feeds Azure monitoring statistics into the SAP application for operating system monitoring and DBA Cockpit functions. This data helps to investigate performance issues and provides a basis for capacity planning.

To enable the extension, you can use Azure PowerShell (`Set-AzVMAEMExtension`) or Azure CLI (`az vm aem set`). To verify the extension functionality on an Azure Windows virtual machine, you can use the azperflib.exe executable. The output of azperflib.exe shows all populated Azure performance counters for SAP. At the bottom of the list of collected counters, you'll find a summary and a health indicator that reflects the status of the Monitoring extension. To verify the extension functionality on a Linux Azure Virtual Machine, examine the content of the **/var/lib/AzureEnhancedMonitor/PerfCounters** file.

You'll need to update the SAP monitoring configuration in situations where the joint Microsoft and SAP team extends the monitoring capabilities, resulting in changes to the number and type of performance counters being collected or Microsoft introduces a new version of the underlying Azure infrastructure that delivers the monitoring data. If you change the number of disks attached to the Azure Virtual Machine hosting the SAP workload, add new network interfaces to it, or change its size an update of the configuration will be required. To update the monitoring configuration, repeat the same sequence of steps you used to install the extension.

## Azure Monitor for SAP Solutions

Azure Monitor for SAP Solutions has been released to assist with monitoring SAP on Azure deployments. Azure Monitor for SAP Solutions, collects data from your Azure infrastructure and databases in one central location, and visually correlates data for faster troubleshooting. You can monitor different components of an SAP landscape (such as Azure Virtual Machines, high-availability clusters, SAP HANA databases etc.) by adding the corresponding provider. Azure Monitor for SAP Solutions monitors SAP HANA network utilization, Linux Network packets in/out, and Network bytes in/out.

### Supported infrastructure

- Azure Virtual Machine

### Supported provider types

- SAP NetWeaver
- SAP HANA
- Microsoft SQL Server
- High-availability cluster
- Operating system (OS)

Azure Monitor for SAP Solutions uses existing Azure Monitoring capabilities such as Log Analytics and Workbooks to provide extra monitoring capabilities.

For more information, see [Azure Monitor for SAP Solutions providers](/azure/virtual-machines/workloads/sap/azure-monitor-providers).
