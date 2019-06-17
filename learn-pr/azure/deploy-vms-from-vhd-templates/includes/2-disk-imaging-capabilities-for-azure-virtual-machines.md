<introduction paragraph>

<chunk 1 title>

....

<chunk 2 title>

...

## Notes from design doc
**Disk imaging capabilities for Azure virtual machines**

In this unit, you will explore the features of Azure Virtual Hard Disks. By the end of this unit, you will be able to:

*   Understand the benefits of using Azure VHDs as a Golden Image to standardize your VM's base build.
*   Understand Specialized-vs-Generalized images.
*   Understand the approach and tools for generalizing a Windows Server
*   Understand the method and tools for generalizing a Linux VM

Cover the following points:

*   

What is an Azure Virtual Hard Disk (VHD)

    *   A VHD is a disk image file format for storing the complete contents of a hard drive in a storage account within Azure.
    *   It can be used as a template for deploying future Virtual Machines to minimize manual configuration, variance and error.
    *   This can be performed on both Windows VMs and Linux VMs.
*   

Purpose of Generalization

    *   Generalized images are intended to be used as templates for your VM and mass deploying it to one or many subsequent VMs so it can be reused for mass deployment without the possibility of duplication. To achieve this  generalization resets server-specific data such as:

    *   Hostname
    *   Users and Credentials
    *   Event Logs
    *   Security Identifiers
    *   Generalization is destructive, so take a VM backup first before generalization if you have a requirement to use VM again.
*   

What is a Specialized Virtual Disk

    *   A Specialized image is a gold image of your system, a snapshot.
    *   It is a point in time copy of your system.
*   

Where are VHD images stored

    *   VHD disk images are stored in an Azure Managed disk account.  A managed disk is an abstraction over page blobs, blob container storage, and Azure Storage accounts.  To learn more about managed disks click [here](https://docs.microsoft.com/azure/virtual-machines/windows/managed-disks-overview)

Ask three questions as a Knowledge Check

*   What is the tool for Generalizing a Windows Server
*   What is the tool for Generalizing a Linux VM
*   If you wanted to mass use a machine image for mass deploying new identical VM's would you select a Generalized or Specialized virtual disk?
