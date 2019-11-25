# Module Design

## Title

Deploy Azure virtual machines from VHD templates

## Role(s)

- Solution Architect
- Administrator

## Level

- Beginner

## Product(s)

- Azure virtual machines
- Sysprep – used to generalize a Windows VM
- Azure managed disks

## Prerequisites

- Basic knowledge of Azure virtual machines

## Summary

Standardize and automate your virtual machine deployments to minimize manual configuration, variance, and error.

## Learning objectives

- Identify the methods to create a specialized VHD
- Create a virtual machine from an existing managed disk
- Create a virtual machine image
- Create a virtual machine from an existing virtual machine image

## Chunk your content into subtasks

Identify the subtasks of *Deploy Azure virtual machines from VHD templates*

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- |---|---|---|---|
| Features of Azure Virtual Hard Disks (VHD) | Review the concepts and components of Azure VHDs for creating machine images | Knowledge Check | Identify the methods to create a specialized VHD | Yes |
| How to Generalize a Windows Server or Linux VM and create an image of a VM  | Customized image with their organizational standards included, and need a method to store and create virtual machines from these images | Exercise | Create a virtual machine from an existing managed disk. Create a virtual machine from an existing virtual machine image | Yes
| Create a virtual machine image | Create a virtual machine from an existing virtual machine image  | Exercise | Create a virtual machine from an existing virtual machine image | Yes


## Outline the units

1. **Introduction**

    An organization is building out a new environment on Azure that uses virtual machines. They would like to have a customized image with their organizational standards included and need a method to store and create virtual machines from these images.

1. **Disk imaging capabilities for Azure virtual machines**

    In this unit, you will explore the features of Azure Virtual Hard Disks. By the end of this unit, you will be able to:

    - Understand the benefits of using Azure VHDs as a Golden Image to standardize your VM's base build.
    - Understand Specialized-vs-Generalized images.
    - Understand the approach and tools for generalizing a Windows Server
    - Understand the method and tools for generalizing a Linux VM

    Cover the following points:

    - What is an Azure Virtual Hard Disk (VHD)
      - A VHD is a disk image file format for storing the complete contents of a hard drive in a storage account within Azure. 
      - It can be used as a template for deploying future Virtual Machines to minimize manual configuration, variance and error.
      - This can be performed on both Windows VMs and Linux VMs.

    - Purpose of Generalization
      - Generalized images are intended to be used as templates for your VM and mass deploying it to one or many subsequent VMs so it can be reused for mass deployment without the possibility of duplication. To achieve this  generalization resets server-specific data such as:
        - Hostname
        - Users and Credentials
        - Event Logs
        - Security Identifiers
        - Generalization is destructive, so take a VM backup first before generalization if you have a requirement to use VM again.

    - What is a Specialized Virtual Disk
      - A Specialized image is a gold image of your system, a snapshot.
      - It is a point in time copy of your system. 

    - Where are VHD images stored
      - VHD disk images are stored in an Azure Managed disk account.  A managed disk is an abstraction over page blobs, blob container storage, and Azure Storage accounts.  To learn more about managed disks click [here](https://docs.microsoft.com/azure/virtual-machines/windows/managed-disks-overview)

    Ask three questions as a Knowledge Check
      - What is the tool for Generalizing a Windows Server
      - What is the tool for Generalizing a Linux VM
      - If you wanted to mass use a machine image for mass deploying new identical VM's would you select a Generalized or Specialized virtual disk? 

1. **Generalize a server and create an image of a VM**

    (This unit will use zone pivots for the Linux and Windows instructions)

    In this unit, you will learn the approaches for generalizing a Windows Server or Linux VM. By the end of this unit, you will be able to:

    - Understand the method and tools for generalizing a Windows Server
    - Understand the method and tools for generalizing a Linux VM
    - Understand the method and tools for creating an image from the generalized Windows Server or Linux VM. 

    - How to Generalize a Windows Server 
      - Native to Windows is 'System Preparation Tool' (aka. Sysprep). This will generalize and shut down the machine. Once it is deallocated, the image can be captured to be reused.

    - How to Generalize a Linux VM
      - Within a Linux VM the Windows Azure Agent 'waagent' can be used using the syntax `waagent -deprovision+user -force` as root via ssh.
      - This command does not guarantee the image is cleared of all sensitive information.  The `+user` parameter removes the last provisioned user account. To keep user credentials in the image, use only the `-deprovision` setting.
      - To learn how to install waagent click [here](https://docs.microsoft.com/azure/virtual-machines/extensions/agent-linux)

    - Approaches to creating an image
      - Images can be created in a variety of ways:
        - Via the Portal
        Open the Azure portal.
          - In the menu on the left, select Virtual machines and then select the VM from the list.
          - In the Virtual machine page for the VM, on the upper menu, select Capture.
          - The Create Image page appears.
          - For Name, either accept the pre-populated name or enter a name that you would like to use for the image.
          - For Resource group, either select Create new and enter a name, or select Use existing and select a resource group to use from the drop-down list.
          - If you want to delete the source VM after the image has been created, select Automatically delete this virtual machine after creating the image.
          - If you want the ability to use the image in any availability zone, select On for Zone resiliency.
          - Select Create to create the image.
          - After the image is created, you can find it as an Image resource in the list of resources in the resource group.
        - Using PowerShell [Link](https://docs.microsoft.com/azure/virtual-machines/windows/capture-image-resource#create-an-image-of-a-vm-using-powershell)
        - From a snapshot created,  this gives you the ability to failback as you still have the original VHD. 

1. **Exercise - Create an image of an Azure VM from the Azure CLI and provision a new VM.**

    (Exercise uses zone pivots for Windows and Linux; each pivot starts by running a script to create a VM).

    You need to take an existing VM and turn it into a reusable custom image that you can use to create new VM instances. To complete the example in this tutorial, you must have an existing virtual machine. If needed, this [script](https://docs.microsoft.com/azure/virtual-machines/scripts/virtual-machines-linux-cli-sample-create-vm-nginx) sample can create one for you. When working through the tutorial, replace the resource group and VM names and IPs where needed.

    Windows pivot

    1. Open Cloud shell
    1. Run script to deploy source VM
    1. Use Azure portal to launch RDP connection to VM
    1. Run sysprep to generalize the VM

    Linux pivot

    1. Open Cloud Shell
    1. Run script to deploy source VM
    1. Connect to the VM 
         `ssh azureuser@52.174.34.95`
    1. Deprovision the VM 
         `sudo waagent -deprovision+user -force; exit`

    Common pivot

    1. Deallocate and mark the VM as generalized
         `az vm deallocate --resource-group myResourceGroup --name myVM`
    1. Set the state of the VM as generalized so the Azure platform knows the VM has been generalized
         `az vm generalize --resource-group myResourceGroup --name myVM`
    1. Create the image
         `az image create --resource-group myResourceGroup --name myImage --source myVM` 
    1. Create VMs from the image 

          ```
          az vm create \
            --resource-group myResourceGroup \
            --name myVMfromImage \
            --image myImage \
            --admin-username azureuser \
            --generate-ssh-keys
          ```

1. **Summary + Cleanup**

    How did you solve the problem in the initial scenario with the knowledge learned in the module?

    - Identified the methods to create a Specialized and Generalized VHD.
    - Identified the steps to Generalize a Windows Server and a Linux VM
    - Created a VHD image of a running machine 
    - Created a VHD image from a snapshiop]
    - Created instances from the VHD images

    Clean up

    - Remove instances and associated storage and snapshots from Azure Portal

## Notes

Capture Windows VM to image - https://docs.microsoft.com/azure/virtual-machines/windows/capture-image-resource

Capture Linux VM to image - https://docs.microsoft.com/azure/virtual-machines/linux/capture-image

Create Windows VM from specialized disk - https://docs.microsoft.com/azure/virtual-machines/windows/create-vm-specialized
