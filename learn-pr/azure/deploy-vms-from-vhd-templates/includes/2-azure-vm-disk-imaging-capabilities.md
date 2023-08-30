An Azure virtual machine runs in the cloud, in an Azure datacenter. When you create a virtual machine, you specify a virtual machine image to use. This image contains the operating system and (optionally) other preconfigured software. 

Azure uses this image to create a new virtual hard disk (VHD) from which it can start your virtual machine. You can then customize the virtual machine by configuring and installing additional applications, according to your requirements.

In the sample scenario, your organization is considering creating and configuring customized images that they can use to deploy servers. You want to know what customized images are and how they can benefit the company.

In this unit, you'll learn how you can use VHDs to create standard customized disks to build virtual machines for your organization.

## What is an Azure virtual hard disk?

A virtual hard disk is conceptually similar to a physical hard disk. You can use a VHD to host the operating system and run a virtual machine. A VHD can also hold databases and other user-defined folders, files, and data. A VHD can hold anything that you can store on a physical hard disk.

A virtual machine can contain multiple VHDs. Typically, a virtual machine has an *operating system VHD* on which the operating system is installed. It also has one or more *data VHDs* that contain the applications and other user-specific data the virtual machine uses.

The difference between a VHD and a physical hard disk is that a VHD is stored as a virtual file in Azure. It isn't a piece of physical hardware.

Compared to physical disks, VHDs have several advantages, including:

- **High availability**: Managed disks are designed for 99.999% availability. Managed disks achieve this availability by providing you with three replicas of your data, which allows for high durability. If one or even two replicas experience issues, the remaining replicas help ensure your data persistence and high tolerance against failures.
- **Physical security**: A VHD is stored in the cloud rather than as a device held on-premises. You can control who has access to a VHD by using Azure security features, and you can audit the changes made to a VHD. Managed VHDs are also encrypted. These features make it more difficult for a disk to be stolen or misplaced. It's also easier to track the provenance of a VHD, so you can be sure that it contains the correct software of a specific version.
- **Durability**: Because a VHD isn't a physical piece of hardware, it won't wear out or suffer from some form of media failure.
- **Scalability**: You can create many virtual machines from the same VHDs simultaneously with minimal contention. Contrast this with trying to set up 100 machines from the same DVD mounted as a shared device on your on-premises network.
- **Cost and performance**: Azure provides several different types of VHDs. They range from those stored on high-performance, dedicated SSDs, to lower-performance, lower-cost VHDs stored on shared hard disk drives. You can select the type of VHD that meets your throughput and cost requirements.

## What is a virtual machine image?

If you consider a VHD to be similar to a physical disk, a virtual machine image is a template from which you can create the VHDs to run a virtual machine. The VHDs for a typical virtual machine image contain a preconfigured version of an operating system.

Azure Marketplace supplies many virtual machine images that you can use as a starting point for your own systems. Examples include:

- Various versions of Windows Server, optionally with SQL Server installed
- Linux variants with software such as MySQL, MongoDB, Cassandra, or other databases already configured

For a complete list, visit the [Azure Marketplace virtual machine images page](https://azuremarketplace.microsoft.com/marketplace/apps?filters=virtual-machine-images).

You can also build your own virtual machine images and VHDs from scratch by using Microsoft Hyper-V. You can then upload these images to Azure so that your virtual machines can use them.

You can extend an existing virtual machine image with your own software. You can then use the image as a basis for deploying additional virtual machines in your organization. For example, if you have an in-house system that you need to roll out across all of your virtual machines, you can create an image that includes this system, then build your virtual machines from this image.

## What is a generalized image?

You can create your own custom virtual machine image in one of two ways:

- If you're building an image from scratch by using Hyper-V, you'll first create a blank virtual disk, then create a virtual machine with this disk. When you start the virtual machine, you'll install the operating system and any other additional software from source disks (typically DVDs) and other packages.
- If you're customizing an image from Azure Marketplace, you'll build a virtual machine by using an existing image. The image provides the operating system and base functionality. You can add your own software, operating system updates, and other packages as required. The next unit in this module describes this process in more detail.

After you build and customize a virtual machine, you can save the new image as a set of VHDs. However, you must do some cleaning up first. This is because as you create a virtual machine, the operating system data is updated with several items, including:

- The host name of your virtual machine.
- The username and credentials that you provided when you installed the operating system on the virtual machine.
- Log files.
- Security identifiers for various operating system services.

You must reset these items back to a default state before you use the image to create more virtual machines. Otherwise, you might end up with multiple virtual machines that have the same identities. The process of resetting this data is called *generalization*, and the result is a *generalized image*.

The tools for preparing a virtual machine for generalization vary according to the operating system that's being installed and configured. For Windows, use the Microsoft System Preparation (Sysprep) tool. For Linux, use the Microsoft Azure Linux VM Agent (waagent) tool.

When you create a new virtual machine by using a generalized image, you have to supply items such as the host name, user account details, and other information that the generalization process removed.

## What is a specialized virtual image?

A specialized virtual image is a copy of a live virtual machine after it has reached a specific state. For example, a specialized image might contain a copy of the configured operating system, software, user accounts, databases, connection information, and other data for your system.

You can use a specialized virtual image as a backup of your system at a particular point in time. If you need to recover after a catastrophic failure or you need to roll back the virtual machine, you can restore your virtual machine from this image.

If you use a specialized image to create a new virtual machine, the new virtual machine will retain all of the data from the image. That data includes the host name, user accounts, and other settings.

## Storage of disk images

You can create a managed image resource from a generalized virtual machine that's stored as either a managed disk or an unmanaged disk in a storage account. You can then use the image to create multiple virtual machines.
