Azure provides different types of storage that are suitable for Azure VMs that are running SAP HANA. The **SAP HANA certified Azure storage types** that can be considered for SAP HANA deployments are:

- Azure Premium SSD
- [Ultra disk](/azure/virtual-machines/linux/disks-enable-ultra-ssd)
- [Azure NetApp Files](https://azure.microsoft.com/services/netapp/)

To learn about these disk types, see the article [Azure managed disk types](/azure/virtual-machines/linux/disks-types).

Azure offers two deployment methods for VHDs on Azure Standard and Premium Storage. If the overall scenario permits, take advantage of [Azure managed disk](https://azure.microsoft.com/services/managed-disks/) deployments.

For a list of storage types and their SLAs in IOPS and storage throughput, review the [Azure documentation for managed disks](https://azure.microsoft.com/pricing/details/managed-disks/).

Azure provides different types of storage suitable for Azure VMs running SAP HANA. The SAP HANA certified Azure storage types that you can consider for SAP HANA deployments are:

- **Azure Premium SSD** \- **/hana/log** is required to be cached with Azure [Write Accelerator](/azure/virtual-machines/linux/how-to-enable-write-accelerator). The **/hana/data** volume can be placed on Premium SSD without Azure Write Accelerator or on Ultra disk.
- **Azure Ultra disk** \- Azure Ultra disk for the **/hana/log** volume. The **/hana/data** volume can be placed on a Premium SSD without Azure Write Accelerator or an Ultra disk for faster restart times.
- **Azure NetApp Files** \- requires **NFS v4.1** volumes on top of Azure NetApp Files for **/hana/log** and **/hana/data**.

Some of the storage types can be combined. E.g., it is possible to put **/hana/data** onto Premium Storage and **/hana/log** can be placed on Ultra disk storage in order to get the required low latency. However, it is not recommended to mix NFS volumes, e.g. **/hana/data**, and use one of the other certified storage types for **/hana/log.**

In the on-premises world, you rarely had to care about the I/O subsystems and their capabilities. The reason was that the appliance vendor needed to make sure that the minimum storage requirements are met for SAP HANA. As you build the Azure infrastructure yourself, you should be aware of some of those requirements. Some of the minimum throughput characteristics that are asked are resulting in the need to:

- Enable read/write on **/hana/log** of a 250 MB/sec with 1 MB I/O sizes
- Enable read activity of at least 400 MB/sec for **/hana/data** for 16 MB and 64 MB I/O sizes
- Enable write activity of at least 250 MB/sec for **/hana/data** with 16 MB and 64 MB I/O sizes

Given that low storage latency is critical for DBMS systems, even as DBMS, like SAP HANA, keep data in-memory. The critical path in storage is usually around the transaction log writes of the DBMS systems. But also operations like writing savepoints or loading data in-memory after crash recovery can be critical. Therefore, it is **mandatory** to leverage Azure Premium Disks for **/hana/data** and **/hana/log** volumes. In order to achieve the minimum throughput of **/hana/log** and **/hana/data** as desired by SAP, you need to build a RAID 0 using MDADM or LVM over multiple Azure Premium Storage disks. And use the RAID volumes as **/hana/data** and **/hana/log** volumes.

> [!TIP]
> As stripe sizes for the RAID 0 the recommendation is to use 64 KB or 128 KB for **/hana/data**, and 32 KB for **/hana/log**.

> [!NOTE]
> You don't need to configure any redundancy level using RAID volumes since Azure Premium and Standard storage keep three images of a VHD. The usage of a RAID volume is purely to configure volumes that provide sufficient I/O throughput.

Accumulating a number of Azure VHDs underneath a RAID, is accumulative from an IOPS and storage throughput side. So, if you put a RAID 0 over 3 x P30 Azure Premium Storage disks, it should give you three times the IOPS and three times the storage throughput of a single Azure Premium Storage P30 disk.

Also, keep the overall VM I/O throughput in mind when sizing or deciding for a VM. Overall VM storage throughput is documented in the article [Memory optimized virtual machine sizes](/azure/virtual-machines/linux/sizes-memory).
