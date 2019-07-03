As part of the project for a finance company that needs to look into configuring images which can be used to deploy servers using a customized image, you need to understand how you can create customized images. You need to understand what customized images are and how they can benefit a company.

## Disk imaging capabilities for Azure virtual machines

### What is an Azure Virtual Hard Disk (VHD)

You can think of an Azure virtual hard disk (VHD) like a physical disk but virtualized which are stored as page blobs, which are IO storage object in Azure. 

Azure VHD's have several features:

- Highly available and durable
    - With managed disks, data is highly available because data is replicated three times across datacenters, meaning if one datacenter had issues, your data is still available in two other locations

- Scalable
    - VHDs can be easily scaled out and use in scale sets

- Images
    - Azure VHDs spport creating a managed custom image. You can create an image from your VHD in a storage account or you can create an image from a generalized (sysprepped) VM

### Purpose of Generalization

By using Generalized images, you can use this image as a  template for VM deployment or for mass deployments.  These images can be customized, generalized and then used as a template.  This ensures you have the same image deployed with the same software installed across your environment.  With generalized deployments, you can be sure that there is no possibility of duplication because generalization resets server-specific data such as:

- Hostname
- Users and Credentials
- Event Logs
- Security Identifiers
- Generalization is destructive, so take a VM backup first before generalization if you have a requirement to use VM again.

To generalize a VM, you would run Sysprep on a Windows Server. Sysprep removes server specfic information from the image which allows you to use that image for mass deployment.

You need to be aware that when you generalize a VM, the change can't be reversed. So you should take a copy of the VM you wish to generalize and then customize the copy.

To generalize a Windows VM, follow these steps:
- Login into the Windows server
- Open a command prompt as an administrator and browse to the directory \system32\sysprep, and run sysprep.exe.
- Select Enter System Out-of-Box Experience (OOBE) and select the Generalize check box.
- Select Shutdown.

Once you have generalized the VM, you can then create an image.  By creating an image, it  ensures that the image includes all of the disks associated with the VM.

You can create an image from the generalized VM using either the Azure portal or powershell

## What is a Specialized Virtual Disk

A specialized disk is a copy of a virtual hard disk from an existing VM which contains user accounts, applications and any other configuration on the original VM.

Using a specialized VHD to create a new VM, the new VM will retain the computer name of the original VM. The new VM will also retain other computer-specific information.

One way to move an on-premises Hyper-V Windows virtual machine (VM) with all its user accounts, policies and applications fully intact up to Azure, is to create a specialized disk of the VM’s operating system virtual hard disk (VHD). This specialized VHD is then uploaded to Azure, after being properly prepped to work in the Azure environment and attached to a new VM.

## Where are VHD images stored

VHD disk images are stored in an Azure Managed disk account. A managed disk is an abstraction over page blobs, blob container storage, and Azure Storage accounts.



