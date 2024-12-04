After you incorporate the best sizing, networking, and management practices into your Azure Linux VM deployment plan, consider performance and functionality. This unit explains how to optimize network and storage resources for Azure Linux VM deployments.

## Optimize network performance

To optimize network performance for Azure Linux VMs, you can use kernel-based network optimizations and implement accelerated networking if available.

### Kernel-based network optimizations

Linux kernels released after September 2017 include network optimization options that enable Azure Linux VMs to achieve higher network throughput. You can get significant throughput performance by using the latest Linux kernel.

New and existing Azure VMs can also benefit from installing the latest [Linux Integration Services (LIS)](https://www.microsoft.com/download/details.aspx?id=55106). Throughput optimization is part of LIS beginning with version 4.2, and subsequent versions contain further improvements.

### Accelerated networking

You can implement accelerated networking to minimize latency, maximize throughput, and lower CPU utilization. Accelerated networking uses the host hardware's single-root I/O virtualization (SR-IOV) capabilities to improve network performance.

Without accelerated networking, all networking traffic in and out of the VM must traverse the host and the virtual switch. With accelerated networking, network traffic that arrives at the VM's network interface forwards directly to the VM, bypassing the host.

Accelerated networking applies only to the VM it's enabled on. For best results, enable this feature on Azure VMs that are connected to the same virtual network. For communicating across virtual networks or in hybrid scenarios, this feature has minimal impact on overall latency.

Azure supports accelerated networking for most general-purpose and compute-optimized–instance sizes that have two or more vCPUs. VM instances that use hyperthreading support accelerated networking on instances that have four or more vCPUs.

## Optimize storage performance

Every Azure Linux VM has at least the following two virtual disks:

- The OS disk, labeled as `/dev/sda`, has a maximum capacity of 2 tebibytes (TiB) for disks in the Master Boot Record (MBR) format or 4 TiB for disks in the GUID Partition Table (GPT) format. The image you use to provision the Azure VM determines the default size.

  Avoid storing data and installing applications on the OS disk, because it's optimized for fast boot rather than running non-OS workloads.

- A temporary disk labeled as `/dev/sdb` and mounted to `/mnt` provides temporary storage. The disk's size and performance depend on the VM size, and its primary purpose is to store a swap file.

  - The temporary disk serves as short-term storage for data that can either be discarded or easily recreated. Don't use the temporary disk to store files that must persist across operations like resizing, redeployment, or restarts.

  - To implement the optimal configuration for a swap file, use cloud-init for images that support it. Use the Azure VM Linux Agent for images that don't support cloud-init.

### Virtual data disks

For storing data and installing applications, you can create virtual disks, attach them to an Azure VM, and mount them within the OS. You can add more disks as needed according to your storage and *input/output per second (IOPS)* requirements. Keep the following considerations in mind:

- The maximum number of disks you can attach to an Azure VM depends on the VM size.
- The maximum number of IOPS an Azure VM supports depends not only on the aggregate throughput of its disks, but also on the VM's maximum IOPS throughput, which the VM size determines. The effective throughput is the lower of the two values.

To provide storage for an Azure VM, you can use Azure-managed block-level storage volumes. Azure-managed disks support the following five disk types to address specific customer scenarios:

- **Ultra Disks** for I/O-intensive workloads such as SAP HANA, top-tier databases such as SQL and Oracle, and other transaction-heavy workloads.
- **Premium solid-state drives (SSDs) v2** for production and performance-sensitive workloads that consistently require low latency, high IOPS, and high throughput.
- **Premium SSDs** for production and performance-sensitive workloads.
- **Standard SSDs** for web servers, lightly used enterprise applications, and development or test scenarios.
- **Standard hard disk drives (HDDs)** for backups and noncritical data with infrequent access.

### Write barriers for Premium SSDs

To achieve the highest IOPS on Premium SSD disks that have their caches set to `ReadOnly` or `None`, disable write barriers while mounting the file system in Linux. You don't need barriers, because writes to Premium Storage–backed disks are durable for these cache settings. If caching is set to `Read/Write`, keep barriers enabled to ensure write durability.

- If you use reiserFS file system, disable barriers by using the mount option `barrier=none`.
- If you use ext3/ext4, disable barriers by using the mount option `barrier=0`.
- If you use XFS, disable barriers by using the mount option `nobarrier`. 

### I/O scheduling algorithm for Premium SSDs

The Linux kernel offers two sets of disk I/O schedulers to reorder requests, one for the older `blk` subsystem, and one for the newer `blk-mq` subsystem. For Azure Premium storage disks, use a scheduler that passes the scheduling decisions to the underlying virtualization platform.

- For Linux kernels that use the `blk` subsystem, choose the `noop` scheduler. 
- For Linux kernels that use the `blk-mq` subsystem, choose the `none` scheduler. 

### Multi-disk configurations

If your workloads require more IOPS than a single disk can provide, use a software Redundant Array of Independent Disks (RAID) configuration that combines multiple disks. Azure offers disk resiliency at the storage fabric layer, so you can focus on performance by implementing a RAID-0 stripe.

As an alternative, you can install Logical Volume Manager (LVM) and use it to combine multiple virtual disks into a single-striped logical storage volume. In this configuration, reads and writes are distributed to multiple disks contained in the volume group, similar to RAID-0. For performance reasons, you might want to stripe your logical volumes so reads and writes use all of your attached data disks.
