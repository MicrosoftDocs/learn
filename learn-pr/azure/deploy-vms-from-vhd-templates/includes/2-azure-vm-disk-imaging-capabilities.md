An Azure virtual machine runs in the cloud, in an Azure datacenter. When you create a virtual machine, you specify a virtual machine image to use. This image contains the operating system, and optionally other preconfigured software. Azure uses this image to create a new virtual hard disk (VHD) from which it can boot your virtual machine. You can then customize the virtual machine by configuring and installing additional applications, according to your requirements.

In the sample scenario, your organization is considering creating and configuring customized images that can be used to deploy servers. You want to know what customized images are, and how they can benefit the company.

In this unit you'll learn more about virtual hard disks, and how you can use them to create standard customized disks for building virtual machines for your own organization.

## What is an Azure virtual hard disk?

A virtual hard disk (VHD) is conceptually similar to a physical hard disk. You can use a VHD to host the operating system and run a virtual machine. A VHD can also hold databases, and other user-defined folders, files, and data. A VHD can hold anything that you can store on a physical hard disk. A virtual machine can contain multiple VHDs. Typically, a virtual machine has an *operating system VHD* on which the operating system is installed, and one or more *data VHDs* that contain the applications and other user-specific data used by the virtual machine.

The difference between a VHD and a physical hard disk is that a VHD is stored as a virtual file in Azure, rather than a piece of physical hardware.

Compared to physical disks, VHDs have several advantages, including:

- High availability - You can store a VHD as an Azure-managed disk. Managed disks are replicated across three datacenters. If one datacenter has connectivity issues, your VHD is still available in two other locations.
- Physical security - A VHD is stored in the cloud rather than as a device held on-premises. You can control who has access to a VHD using Azure's security features, and you can audit the changes made to a VHD. Managed VHDs are also encrypted, to protect them further. These features make it more difficult for a disk to be stolen or mislaid. It's also easier to track the provenance of a VHD, so you can be sure that it contains the correct software of a specific version.
- Durability - Because a VHD isn't a physical piece of hardware, it won't wear out or suffer from some form of media failure.
- Scalability - You can create many virtual machines from the same VHDs simultaneously with minimal contention (contrast this with attempting to set up 100 machines from the same DVD mounted as a shared device on your on-premises network).
- Cost and performance - Azure provides several different types of VHD, ranging from those stored on high-performance, dedicated SSDs, to lower-performance, lower-cost VHDs stored on shared hard disk drives. You can select the type of VHD depending on your throughput and cost requirements. 

## What is a virtual machine image?

If you consider a VHD to be similar to a physical disk, a virtual machine image is a template from which you can create the VHDs to run a virtual machine. The VHDs for a typical virtual machine image contain a preconfigured version of an operating system, such as Windows or a flavor of Linux.

The Azure Marketplace supplies many virtual machine images that you can use as a starting point for your own systems. Examples include various versions of Windows server, optionally with SQL Server installed, and Linux variants with software such as MySQL, MongoDB, Cassandra, or other databases already configured. For a complete list, visit the [Azure Marketplace virtual machine images page](https://azuremarketplace.microsoft.com/marketplace/apps?filters=virtual-machine-images).

You can also build your own virtual machine images and VHDs from scratch by using Microsoft Hyper-V. You can then upload these images to Azure for use by your virtual machines.

You can extend an existing virtual machine image with your own software. You can then use the image as a basis for deploying additional virtual machines in your organization. For example, if you have an in-house system that you need to roll out across all of your virtual machines, you can create an image that includes this system, and then build your virtual machines from this image.

## What is a generalized virtual image?

You can create your own custom virtual machine image in one of two ways:

- If you're building an image from scratch using Hyper-V, you first create a blank virtual disk, and then create a virtual machine with this disk. When you start the virtual machine, you install the operating system and any other additional software from source disks (typically DVDs) and other packages.
- If you're customizing an image from the Azure Marketplace, you build a virtual machine using an existing image. The image provides the operating system and base functionality, and you add your own software, operating system updates, and other packages as required. Unit 3 describes this process in more detail.

Having built and customized new virtual machine, you can then save the new image as a set of VHDs. However, you must perform some cleaning up first. This is because as you create virtual machine, the operating system data is updated with several items, including:

- The hostname of your virtual machine.
- The username and credentials you provided when you installed the operating system on the virtual machine.
- Log files.
- Security identifiers for various operating system services.

You must reset these items back to a default state before using the image to create further virtual machines, otherwise you may end up with multiple virtual machines having the same identities. The process of resetting this data is called *generalization*, and the result is a *generalized image*. The tools for preparing a virtual machine for generalization vary according to the operating system being installed and configured. For Windows, you use the **Microsoft System Preparation (Sysprep)** tool. For Linux, run the **Windows Azure Linux Agent (waagent)** utility.

When you create a new virtual machine using a generalized image, you have to supply items such as the hostname, user account details, and other information that was removed by the generalization process.

## What is a specialized virtual image?

A specialized virtual image is a copy of a live virtual machine once it has reached a specific state. For example, a specialized image might contain a copy of the configured operating system, software, user accounts, databases, connection information, and other data for your system. You can use a specialized virtual image as a backup of your system at a particular point in time. If you need to recover after a catastrophic failure, or you just need to roll back the virtual machine, you can restore your virtual machine from this image.

If you use a specialized image to create a new virtual machine, the new virtual machine will retain all of the data (including the host name, user accounts, and other settings) from the image.

## Storage of disk images

A managed image resource can be created from a generalized virtual machine (VM) that is stored as either a managed disk or an unmanaged disk in a storage account. The image can then be used to create multiple VMs.
