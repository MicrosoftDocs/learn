When you've deployed the VM, the Azure VM Agent is automatically installed within the guest OS. The agent is required in order to install the Azure Enhanced Monitoring Extension for SAP, which is available in the Azure Extension Repository. Installation of the extension can be performed by using PowerShell or Azure CLI.

There are two versions of the VM Extension for SAP. Check the prerequisites for SAP and required minimum versions of SAP Kernel and SAP Host Agent in the resources listed in [SAP resources](https://docs.microsoft.com/azure/virtual-machines/workloads/sap/vm-extension-for-sap#42ee2bdb-1efc-4ec7-ab31-fe4c22769b94).

## **Standard version of VM Extension for SAP**

This version is the current standard VM Extension for SAP covered in this module. There are some exceptions where Microsoft recommends to install the new VM Extension for SAP.

## **New version of VM Extension for SAP**

This version is the new Azure VM extension for SAP solutions. With further improvements and new Azure Offerings the new extension was built to be able to monitor all Azure resources of a virtual machine. This extension needs internet access to the URL "management.azure.com". It supports additional storage options, for example Standard Disks and operating systems. Choose the new version of the VM Extension if one of the following applies:

 -  You want to install the VM extension with Terraform, Azure Resource Manager Templates or with other means than Azure CLI or Azure PowerShell.
 -  You want to install the extension on SUSE SLES 15 or higher.
 -  You want to install the extension on Red Hat Enterprise Linux 8.1 or higher.
 -  You want to use Azure Ultra Disk or Standard Managed Disks.
 -  Microsoft or SAP support asks you to install the new extension.

## **Recommendation**

The Standard version of the extension is currently recommended for each installation where none of the use cases for the new version of the extension apply.
