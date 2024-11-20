Just like any other computer, virtual machines in Azure use disks as a place to store the operating system, applications, and data. 

### Things to know about virtual machine storage and disks

All Azure virtual machines have at least two disks: an operating system disk and a temporary disk. Virtual machines can also have one or more data disks. All disks are stored as virtual hard disks (VHDs). A VHD is like a physical disk in an on-premises server but, virtualized. 

:::image type="content" source="../media/virtual-machine-disks-ff57089c.png" alt-text="Diagram that shows disks used by an Azure virtual machine, including disks for the OS, data, and temporary storage." border="false":::

#### Operating system disk

Every virtual machine has one attached operating system disk. The OS disk has a preinstalled operating system, which is selected when the virtual machine is created. The OS disk is registered as a SATA drive (Serial Advanced Technology Attachment) and labeled as the `C:` drive by default.

#### Temporary disk

Data on a temporary disk might be lost during a maintenance event or when you redeploy a virtual machine. During a standard reboot of the virtual machine, the data on the temporary drive should persist. However, there are cases where the data might not persist, such as moving to a new host. Therefore, any data on the temporary drive shouldn't be data that's critical to the system.

- On Windows virtual machines, the temporary disk is labeled as the `D:` drive by default. This drive is used for storing the **pagefile.sys** file.
- On Linux virtual machines, the temporary disk is typically `/dev/sdb`. Azure Linux Agent formats this disk and mounts it to `/mnt`.

> [!Important]
> Don't store data on the temporary disk. This disk provides temporary storage for applications and processes and is intended to only store data like page or swap files.

#### Data disks

A data disk is a managed disk attached to a virtual machine to store application data or other data you need to keep. Data disks are registered as SCSI drives and are labeled with a letter you choose. The size of a virtual machine determines how many data disks you can attach and the type of storage you can use to host the data disks.

### Things to consider when choosing storage for your virtual machines

Review the following considerations about using Azure Storage and Azure Managed Disks with your virtual machines.

- **Consider Azure Premium Storage**. You can choose Premium Storage to gain high-performance, low-latency disk support for your virtual machines with input/output (I/O)-intensive workloads. Virtual machine disks that use Premium Storage store data on solid-state drives (SSDs). To take advantage of the speed and performance of premium storage disks, you can migrate existing virtual machine disks to Premium Storage.

- **Consider multiple Storage disks**. In Azure, you can attach several Premium Storage disks to a virtual machine. Using multiple disks gives your applications up to 256 TB of storage per virtual machine. With Premium Storage, your applications can achieve 80,000 I/O operations per second (IOPS) per virtual machine, and a disk throughput of up to 2,000 megabytes per second (MB/s) per virtual machine. Read operations completed with Premium Storage yield low latencies.

- **Consider managed disks**. An Azure-managed disk is a VHD. Azure-managed disks are stored as page blobs, which are a random IO storage object in Azure. The disk is described as _managed_ because it's an abstraction over page blobs, blob containers, and Azure storage accounts. With managed disks, you provision the disk, and Azure takes care of the rest. When you choose to use Azure-managed disks with your workloads, Azure creates and manages the disk for you. The available types of disks are Ultra Solid State Drives (SSD), Premium SSD, Standard SSD, and Standard Hard Disk Drives (HDD).

   > [!NOTE]
   > Managed disks are required for the single instance virtual machine SLA.

- **Consider migrating to Premium Storage**. For the best performance for your application, we recommend that you migrate any virtual machine disk that requires high IOPS to Premium Storage. If your disk doesn't require high IOPS, you can help limit costs by keeping it in standard Azure Storage. 