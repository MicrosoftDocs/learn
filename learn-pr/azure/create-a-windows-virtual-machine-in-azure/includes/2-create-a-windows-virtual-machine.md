## Motivation

Your company has decided to manage the video data from their traffic cameras in Azure using VMs. In order to run the multiple codecs we will first need to create the VMs. We will also need to connect and interact with the the VMs. In this unit, you will learn how to create a VM using the Portal, you will configure the VM for Remote Desktop Protocol, select a VM image and choose the proper storage option.

## Introduction to Windows Virtual Machines in Azure

Azure VMs are an on demand, scalable cloud computing resource, they are similar to virtual machines hosted in Windows Hyper-V in that they include a processor, memory, storage, and networking resources. You can start and stop virtual machines at will just like with Hyper-V. You can manage an Azure VM from the Portal, with Azure Powershell or with the Azure CLI. You can also use a Remote Desktop Protocol (RDP) client to connect directly to the Windows user interface (UI) and use the VM as if you were signed in to a local Windows computer.

<!-- this seems weirdly out-of-place --> Azure-hosted VMs also have some features, such as power management, that are not available on a Hyper-V hosted virtual machine.

<!-- this is also weirdly out-of-place and not really introductory material for Azure VMs --> [!Note] Azure-hosted VMs may not be suitable for very demanding, low latency workloads.

## Creating resources for a Windows VM

When creating a Windows VM in Azure, you need to create a resource group to host the VM. The Resource Group is like a container that holds other resources. In the case of virtual machines those resources would include things like:

* The virtual machine itself
* VM storage
* Virtual network
* Network interface
* Subnet
* Public IP address

When you create a new VM, you can either use an existing resource group or create a new one.

Deleting a resource group deletes all the resources in that group.

## Choose the VM image

Selecting an image is one of the first and most important decisions you'll need to make when creating a VM. An image is one or more virtual hard disks (VHDs) that is used to create the virtual machine. The VHDs already include an Operating System (OS) and often other software such as development tools or web hosting environments.

Really, anything that a computer can have installed can be included in an image. This is extremely powerful because it means that you can create a virtual machine from an image that is preconfigured to exactly the tasks you need (like hosting an ASP.Net core app) in minutes.

You can even create and upload your own images, though that is outside the scope of this module.

[!Note] You may also notice something called "Virtual Machine (classic)". This is a legacy deployment option that is supported for customers that already have instances created. For new workloads you'll always want the feature call "Azure Virtual Machine" or for short: "Virtual Machines")

## Sizing your VM
<!-- B-series might be a better size to say is entry-point as the A-series is being discontinued eventually. Without more information, I'm not sure this section helps. Maybe give examples of a couple of sizes and the differences between some of the groupings - like storage optimized vs memory optimized? -->

Just as a physical machine has a certain amount of memory and CPU power, so does a virtual machine. Azure offers a range of VMs of differing sizes at different price points. These VMs start with A-Series entry-level development and test sizes, through the D-Series for general-purpose compute, to the H-Series for high-performance computational needs, or even the N-series for graphics processor unit (GPU)-optimized roles.

As you'll see later in the module, we can change the size of a VM later, but that requires shutting it down, which could result in downtime for our workloads.

## Choosing storage options

The next choice when specifying a VM is the hard drive technology. Options are a traditional platter-based hard disk drive (HDD), or a more modern solid state (SSD) drive. SSD storage does cost more to use but gives better performance, particularly in environments that support high levels of data transfer or frequent IO.

[!Note] Applications in Azure Virtual Machines can also connect to other forms of persistence in Azure like CosmosDb and Blob Storage.

## Summary

You have reviewed the options that you must consider when specifying a Windows VM in Azure. In the following exercise, you will use the Azure portal to create a VM and check that it is running.