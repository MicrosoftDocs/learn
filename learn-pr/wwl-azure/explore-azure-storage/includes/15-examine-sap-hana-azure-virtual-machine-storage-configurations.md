Azure provides different types of storage that are suitable for Azure Virtual Machines that are running SAP HANA. The **SAP HANA certified Azure storage types** that can be considered for SAP HANA deployments are:

- Azure premium SSD
- [Ultra disk](/azure/virtual-machines/linux/disks-enable-ultra-ssd)
- [Azure NetApp Files](https://azure.microsoft.com/services/netapp/)

To learn about these disk types, see the article [Azure managed disk types](/azure/virtual-machines/linux/disks-types).

Azure offers two deployment methods for VHDs on Azure Standard and premium storage v1/v2. If the overall scenario permits, take advantage of [Azure managed disk](https://azure.microsoft.com/services/managed-disks/) deployments.

For a list of storage types and their SLAs in IOPS and storage throughput, review the [Azure documentation for managed disks](https://azure.microsoft.com/pricing/details/managed-disks/).

> [!IMPORTANT]
> Independent of the Azure storage type chosen, the file system that is used on that storage needs to be supported by SAP for the specific operating system and DBMS. [SAP support note #2972496](https://launchpad.support.sap.com/#/notes/2972496) lists the supported file systems for different operating systems and databases, including SAP HANA. This applies to all volumes SAP HANA might access for reading and writing for whatever task. Specifically using NFS on Azure for SAP HANA, additional restrictions of NFS versions apply.

Azure provides different types of storage suitable for Azure Virtual Machines running SAP HANA. The minimum SAP HANA certified conditions for the different storage types are:

- Azure premium storage v1 - **/hana/log** is required to be supported by Azure [Write Accelerator](/azure/virtual-machines/linux/how-to-enable-write-accelerator). The **/hana/data** volume could be placed on premium storage v1 without Azure Write Accelerator or on Ultra disk. Azure premium storage v2 or Azure premium SSD v2 is not supporting the usage of Azure Write Accelerator
- Azure Ultra disk at least for the **/hana/log** volume. The **/hana/data** volume can be placed on either premium storage v1/v2 without Azure Write Accelerator or in order to get faster restart times Ultra disk
- **NFS v4.1** volumes on top of Azure NetApp Files for **/hana/log and /hana/data**. The volume of /hana/shared can use NFS v3 or NFS v4.1 protocol

It is supported to combine the usage of the different Azure block storages that are certified for HANA and NFS shares based on Azure NetApp Files. For example, it's possible to put **/hana/data** onto premium storage v1 or v2 and **/hana/log** can be placed on Ultra disk storage in order to get the required low latency. If you use a volume based on ANF for **/hana/data**, **/hana/log** volume can be placed on one of the HANA certified Azure block storage types as well. Using NFS on top of ANF for one of the volumes (like **/hana/data**) and Azure premium storage v1/v2 or Ultra disk for the other volume (like **/hana/log**) is **supported**.

In the on-premises world, you rarely had to care about the I/O subsystems and their capabilities. The reason was that the appliance vendor needed to make sure that the minimum storage requirements are met for SAP HANA. As you build the Azure infrastructure yourself, you should be aware of some of those requirements. Some of the minimum throughput characteristics that are asked are resulting in the need to:

- Enable read/write on **/hana/log** of a 250 MB/sec with 1 MB I/O sizes
- Enable read activity of at least 400 MB/sec for **/hana/data** for 16 MB and 64 MB I/O sizes
- Enable write activity of at least 250 MB/sec for **/hana/data** with 16 MB and 64 MB I/O sizes

Given that low storage latency is critical for DBMS systems, even as DBMS, like SAP HANA, keep data in-memory. The critical path in storage is usually around the transaction log writes of the DBMS systems. But also operations like writing savepoints or loading data in-memory after crash recovery can be critical. Therefore, it's **mandatory** to use Azure premium Disks for **/hana/data** and **/hana/log** volumes. In order to achieve the minimum throughput of **/hana/log** and **/hana/data** as desired by SAP, you need to build a RAID 0 using MDADM or LVM over multiple Azure premium storage v1/v2, Ultra disk, or ANF for /hana/data and /hana/log volumes.

> [!TIP]
> As stripe sizes for the RAID 0 the recommendation is to use 64 KB or 128 KB for **/hana/data**, and 32 KB for **/hana/log**.

> [!NOTE]
> You don't need to configure any redundancy level using RAID volumes since Azure premium and Standard storage keep three images of a VHD. The usage of a RAID volume is purely to configure volumes that provide sufficient I/O throughput.

Accumulating a number of Azure VHDs underneath a RAID, is accumulative from an IOPS and storage throughput side. So, if you put a RAID 0 over 3 x P30 Azure premium storage disks, it should give you three times the IOPS and three times the storage throughput of a single Azure premium storage P30 disk.

Also, keep the overall virtual machine I/O throughput in mind when sizing or deciding for a virtual machine. Overall virtual machine storage throughput is documented in the article [Memory optimized virtual machine sizes](/azure/virtual-machines/linux/sizes-memory).
