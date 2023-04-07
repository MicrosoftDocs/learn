To conclude your planning for Linux deployments on Azure VMs, you need to consider performance and functionality optimizations—in particular, network and storage resources. 

## Optimize network performance of Azure VMs running Linux

Now that you’ve incorporated the best manageability practices into your plan, your next step is to optimize network performance. This includes leveraging kernel-based network optimizations and implementing accelerated networking.

### Leverage kernel-based network optimizations

Linux kernels that have been released after September 2017 include new network optimization options that enable Azure VMs running Linux to achieve higher network throughput. You can achieve significant throughput performance by using the latest Linux kernel. New and existing Azure VMs can also benefit from installing the latest Linux Integration Services (LIS). Throughput optimization is part of LIS beginning with version 4.2, although subsequent versions contain further improvements.

[!NOTE] For details regarding validating Azure Linux kernel versions and installing the latest LIS, refer to the Linux VM section of the [Optimize network throughput for Azure virtual machines](https://learn.microsoft.com/en-us/azure/virtual-network/virtual-network-optimize-network-bandwidth) Microsoft Learn article.

### Implement accelerated networking

In addition to using the latest version of the Linux kernel and LIS, you should implement accelerated networking. This feature utilizes the host hardware’s single-root I/O virtualization (SR-IOV) capabilities to improve network performance, resulting in minimized latency, maximized throughput, and lower CPU utilization. 

Without accelerated networking, all networking traffic in and out of the VM must traverse the host and the virtual switch. With accelerated networking, network traffic arrives at the VM's network interface and then gets forwarded directly to the VM, bypassing the host.

The benefits of accelerated networking only apply to the VM on which it's enabled. For the best results, enable this feature on Azure VMs connected to the same virtual network. When communicating across virtual networks or in hybrid scenarios, this feature has minimal impact on overall latency.

Azure supports accelerated networking for most general-purpose and compute-optimized–instance sizes with two or more vCPUs. On instances that support hyperthreading, accelerated networking is supported on VM instances with four or more vCPUs.

[!NOTE] For details regarding Azure VM sizes that support accelerated networking, refer to the [Sizes for virtual machines in Azure](https://learn.microsoft.com/en-us/azure/virtual-machines/sizes?toc=%2Fazure%2Fvirtual-network%2Ftoc.json) Microsoft Learn article. For the list of Linux distributions that support accelerated networking, refer to the [Accelerated Networking (AccelNet) overview](https://learn.microsoft.com/en-us/azure/virtual-network/accelerated-networking-overview) Microsoft Learn article.

[!NOTE] For the instructions to enable accelerated networking, refer to the [Use Azure CLI to create a Windows or Linux VM with Accelerated Networking](https://learn.microsoft.com/en-us/azure/virtual-network/create-vm-accelerated-networking-cli) Microsoft Learn article.

## Optimize storage performance of Azure VMs running Linux

Now that you have planned for network and storage resources, you are ready to plan for storage performance optimization. However, there are several factors you’ll need to consider.

### Assess virtual disks options

Azure uses and manages block-level storage volumes that you can use with Azure VMs. A managed disk is similar to a physical disk, but also similar to virtual hard disks (VHDs) in that they present the underlying storage to an Azure VM. 

Azure-managed disks support the following five disk types, each of which is intended to address a specific customer scenario:

- **Ultra Disks**. Use this disk type for I/O-intensive workloads such as SAP HANA, top-tier databases such as SQL and Oracle, and other transaction-heavy workloads.
- **Premium solid-state drives (SSD) v2**. Use this type of disk for production and performance-sensitive workloads that consistently require low latency, high I/O operations per second (IOPS), and high throughput.
- **Premium SSDs**. Use this disk type for production and performance-sensitive workloads.
- **Standard SSDs**. Use this type of disk for web servers, lightly used enterprise applications, and development or test scenarios.
- **Standard hard disk drives (HDDs)**. Finally, use this disk type for backups, and disks with non-critical data, infrequent access.

For details regarding performance and capacity characteristics of each disk type, refer to the [Azure managed disk types](https://learn.microsoft.com/en-us/azure/virtual-machines/disks-types) Microsoft Learn article.

### Configure virtual disks

At a minimum, every Azure VM has two virtual disks: 

- The OS disk, labeled as /dev/sda, with a maximum capacity of 4 tebibytes (TiB) for disks in the Master Boot Record (MBR) format or 2 TiB for disks in the GUID Partition Table (GPT) format. The default size is determined by the image from which you provision the Azure VM.
- A temporary disk that provides temporary storage, labeled as /dev/sdb, and mounted to /mnt. Its size and performance depend on the VM size. Its primary purpose is to store a swap file.

The temporary disk serves as short-term storage for data that can either be discarded or easily recreated. Do not use it to store files that must persist across operations such as resizing, redeployment, or restarts during maintenance events.

Avoid storing data and installing applications on the OS disk because it’s optimized for fast boot rather than running non-operating–system workloads. Instead, create data disks, attach them to the Azure VM, and mount them within the OS. Add extra disks as needed according to your storage and IOPS requirements. Keep in mind that the maximum number of disks you can attach to an Azure VM depends on its size.

[!NOTE] The maximum number of IOPS supported by an Azure VM depends not only on the aggregate throughput of its disks but also on the maximum IOPS throughput of the VM, which is determined by its size. The effective throughput is the lower of the two numbers.

### Disable barriers

To achieve the highest IOPS on Premium SSD disks, where their cache settings have been set to either ReadOnly or None, disable barriers while mounting the file system in Linux. You don’t need barriers because writes to Premium Storage–backed disks are durable for these cache settings.

- If you use reiserFS, disable barriers using the mount option barrier=none.
- If you use ext3/ext4, disable barriers using the mount option barrier=0.
- If you use XFS, disable barriers using the mount option nobarrier. 

[!NOTE] If caching is set to read/write, barriers should remain enabled to ensure write durability.

### Configure a swap file

There are two main approaches to implementing the optimal configuration of a swap file:

- Use the Azure VM Linux Agent for images that don’t support cloud-init.

- For implementation details, refer to the [Optimize your Linux VM on Azure](https://learn.microsoft.com/en-us/previous-versions/azure/virtual-machines/linux/optimization) Microsoft Learn article.

- Use cloud-init for images that support it.

### Adjust the I/O scheduling algorithm

The Linux kernel offers two sets of disk I/O schedulers to reorder requests: one for the older ‘blk’ subsystem, and one for the newer ‘blk-mq’ subsystem. When using Azure Premium storage disks, consider choosing a scheduler that passes the scheduling decisions to the underlying virtualization platform:

- For Linux kernels using the ‘blk’ subsystem, choose the “noop” scheduler. 
- For Linux kernels using the ‘blk-mq’ subsystem, choose the “none” scheduler. 

For implementation details, consult your Linux Distro documentation.

### Implement multi-disk configurations

If your workloads require more IOPS than a single disk can provide, use a software Redundant Array of Independent Disks (RAID) configuration that combines multiple disks. Because Azure offers disk resiliency at the storage fabric layer, you can focus on performance by implementing a RAID-0 stripe.  For implementation details, refer to the [Configure Software RAID on Linux](https://learn.microsoft.com/en-us/previous-versions/azure/virtual-machines/linux/configure-raid?toc=%2Fazure%2Fvirtual-machines%2Flinux%2Ftoc.json) Microsoft Learn article.

As an alternative to a traditional RAID configuration, you can install Logical Volume Manager (LVM) and use it to combine multiple virtual disks into a single-striped logical storage volume. In this configuration, reads and writes are distributed to multiple disks contained in the volume group, similar to RAID-0. For performance reasons, you might want to stripe your logical volumes so that reads and writes utilize all your attached data disks. For implementation details, refer to the [Configure LVM on a Linux VM in Azure](https://learn.microsoft.com/en-us/previous-versions/azure/virtual-machines/linux/configure-lvm) Microsoft Learn article.
