> [!NOTE]
> *Azure Monitoring Extension*, *Enhanced Monitoring*, and *Azure Extension for SAP* describe one and the same item. It describes a virtual machine extension that needs to be deployed by you to provide some basic data about the Azure infrastructure to the SAP Host Agent. SAP Notes might refer to it as *Monitoring Extension* or *Enhanced monitoring*. In Azure, we're referring to it as *Azure Extension for SAP.*

When you've deployed the virtual machine, the Azure Virtual Machine Agent is automatically installed within the guest OS. The agent is required in order to install the Azure Extension for SAP, which is available in the Azure Extension Repository. Installation of the extension can be performed by using PowerShell or Azure CLI.

:::image border="false" type="content" source="../media/azure-extension-for-sap-animated-09db31af.gif" alt-text="Diagram showing S A P SAPOSCOL / S A P Host Control process reads, writes and requests Azure Monitor for SAP and Windows Azure Diagnostic Agent Extension data.":::

There are two versions of the Azure Extension for SAP. Check the prerequisites for SAP and required minimum versions of SAP Kernel and SAP Host Agent in the resources listed in [SAP resources](/azure/virtual-machines/workloads/sap/vm-extension-for-sap#42ee2bdb-1efc-4ec7-ab31-fe4c22769b94).

## **Standard version of Azure Extension for SAP**

This version is the current standard Azure Extension for SAPcovered in this module. There are some exceptions where Microsoft recommends installing the new Azure Extension for SAP.

## **New version of Azure Extension for SAP**

This version is the new Azure Extension for SAP. With further improvements and new Azure offerings the new extension was built to be able to monitor all Azure resources on a virtual machine. This extension needs internet access to the URL "management.azure.com". It supports extra storage options, for example Standard Disks and operating systems. Choose the new version of the Azure Extension for SAP if one of the following applies:

- You want to install the Azure Extension for SAP with Terraform, Azure Resource Manager Templates or with other means than Azure CLI or Azure PowerShell.
- You want to install the extension on SUSE SLES 15 or higher.
- You want to install the extension on Red Hat Enterprise Linux 8.1 or higher.
- You want to use Azure Ultra Disk or Standard Managed Disks.
- Microsoft or SAP support asks you to install the new extension.

## **Recommendation**

The Standard version of the Azure Extension for SAP is currently recommended for each installation where none of the use cases for the new version of the extension apply.
