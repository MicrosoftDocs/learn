



Another Azure storage type is called [Azure Ultra disk](/azure/virtual-machines/disks-types#ultra-disks). The significant difference between Azure storage offered so far and Ultra disk is that the disk capabilities are not bound to the disk size anymore. As a customer you can define these capabilities for Ultra disk:

- Size of a disk ranging from 4 GiB to 65,536 GiB
- IOPS range from 100 IOPS to 160K IOPS (maximum depends on VM types as well)
- Storage throughput from 300 MB/sec to 2,000 MB/sec

Ultra disk gives you the possibility to define a single disk that fulfills your size, IOPS, and disk throughput range. Instead of using logical volume managers like LVM or MDADM on top of Azure Premium Storage to construct volumes that fulfill IOPS and storage throughput requirements. You can run a configuration mix between Ultra disk and Premium Storage. As a result, you can limit the usage of Ultra disk to the performance-critical **/hana/data** and **/hana/log** volumes and cover the other volumes with Azure Premium Storage.

Another advantage of Ultra disk can be the better read latency in comparison to Premium Storage. The faster read latency can have advantages when you want to reduce the HANA start up times and the subsequent load of the data into memory. Advantages of Ultra disk storage also can be felt when HANA is writing savepoints. Since Premium Storage disks for **/hana/data** are usually not Write Accelerator cached, the write latency to **/hana/data** on Premium Storage compared to the Ultra disk is higher. It can be expected that savepoint writing with Ultra disk is performing better on Ultra disk.

> [!IMPORTANT]
> Ultra disk is not yet present in all the Azure regions and is also not yet supporting all VM types listed below. For detailed information about where Ultra disk is available and which VM families are supported, check the article [Azure managed disk types](/azure/virtual-machines/windows/disks-types).

## Production recommended storage solution with pure Ultra disk configuration

In this configuration, you keep the **/hana/data** and **/hana/log** volumes separately. The suggested values are derived out of the KPIs that SAP has to certify VM types for SAP HANA and storage configurations as recommended in the SAP TDI Storage Whitepaper.

The recommendations are often exceeding the SAP minimum requirements as stated earlier in this article. The listed recommendations are a compromise between the size recommendations by SAP and the maximum storage throughput the different VM types provide.

> [!NOTE]
> Azure Ultra disk is enforcing a minimum of 2 IOPS per Gigabyte capacity of a disk.

:::row:::
  :::column:::
    **VM SKU**
  :::column-end:::
  :::column:::
    **RAM**
  :::column-end:::
  :::column:::
    **Max. VM I/O Throughput**
  :::column-end:::
  :::column:::
    **/hana/data volume**
  :::column-end:::
  :::column:::
    **/hana/data I/O throughput**
  :::column-end:::
  :::column:::
    **/hana/data IOPS**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    E20ds\_v4
  :::column-end:::
  :::column:::
    160 GiB
  :::column-end:::
  :::column:::
    480 MB/s
  :::column-end:::
  :::column:::
    200 GB
  :::column-end:::
  :::column:::
    400 MBps
  :::column-end:::
  :::column:::
    2,500
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    E32ds\_v4
  :::column-end:::
  :::column:::
    256 GiB
  :::column-end:::
  :::column:::
    768 MB/s
  :::column-end:::
  :::column:::
    300 GB
  :::column-end:::
  :::column:::
    400 MBps
  :::column-end:::
  :::column:::
    2,500
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    E48ds\_v4
  :::column-end:::
  :::column:::
    384 GiB
  :::column-end:::
  :::column:::
    1152 MB/s
  :::column-end:::
  :::column:::
    460 GB
  :::column-end:::
  :::column:::
    400 MBps
  :::column-end:::
  :::column:::
    3,000
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    E64ds\_v4
  :::column-end:::
  :::column:::
    504 GiB
  :::column-end:::
  :::column:::
    1200 MB/s
  :::column-end:::
  :::column:::
    610 GB
  :::column-end:::
  :::column:::
    400 MBps
  :::column-end:::
  :::column:::
    3,500
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    E64s\_v3
  :::column-end:::
  :::column:::
    432 GiB
  :::column-end:::
  :::column:::
    1,200 MB/s
  :::column-end:::
  :::column:::
    610 GB
  :::column-end:::
  :::column:::
    400 MBps
  :::column-end:::
  :::column:::
    3,500
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    M32ts
  :::column-end:::
  :::column:::
    192 GiB
  :::column-end:::
  :::column:::
    500 MB/s
  :::column-end:::
  :::column:::
    250 GB
  :::column-end:::
  :::column:::
    400 MBps
  :::column-end:::
  :::column:::
    2,500
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    M32ls
  :::column-end:::
  :::column:::
    256 GiB
  :::column-end:::
  :::column:::
    500 MB/s
  :::column-end:::
  :::column:::
    300 GB
  :::column-end:::
  :::column:::
    400 MBps
  :::column-end:::
  :::column:::
    2,500
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    M64ls
  :::column-end:::
  :::column:::
    512 GiB
  :::column-end:::
  :::column:::
    1,000 MB/s
  :::column-end:::
  :::column:::
    620 GB
  :::column-end:::
  :::column:::
    400 MBps
  :::column-end:::
  :::column:::
    3,500
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    M32dms\_v2, M32ms\_v2
  :::column-end:::
  :::column:::
    875 GiB
  :::column-end:::
  :::column:::
    500 MB/s
  :::column-end:::
  :::column:::
    1,200 GB
  :::column-end:::
  :::column:::
    600 MBps
  :::column-end:::
  :::column:::
    5,000
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    M64s, M64ds\_v2, M64s\_v2
  :::column-end:::
  :::column:::
    1,024 GiB
  :::column-end:::
  :::column:::
    1,000 MB/s
  :::column-end:::
  :::column:::
    1,200 GB
  :::column-end:::
  :::column:::
    600 MBps
  :::column-end:::
  :::column:::
    5,000
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    M64ms, M64dms\_v2, M64ms\_v2
  :::column-end:::
  :::column:::
    1,792 GiB
  :::column-end:::
  :::column:::
    1,000 MB/s
  :::column-end:::
  :::column:::
    2,100 GB
  :::column-end:::
  :::column:::
    600 MBps
  :::column-end:::
  :::column:::
    5,000
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    M128s, M128ds\_v2, M128s\_v2
  :::column-end:::
  :::column:::
    2,048 GiB
  :::column-end:::
  :::column:::
    2,000 MB/s
  :::column-end:::
  :::column:::
    2,400 GB
  :::column-end:::
  :::column:::
    750 MBps
  :::column-end:::
  :::column:::
    7,000
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    M192ds\_v2, M192s\_v2
  :::column-end:::
  :::column:::
    2,048 GiB
  :::column-end:::
  :::column:::
    2,000 MB/s
  :::column-end:::
  :::column:::
    2,400 GB
  :::column-end:::
  :::column:::
    750 MBps
  :::column-end:::
  :::column:::
    7,000
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    M128ms, M128dms\_v2, M128ms\_v2
  :::column-end:::
  :::column:::
    3,892 GiB
  :::column-end:::
  :::column:::
    2,000 MB/s
  :::column-end:::
  :::column:::
    4,800 GB
  :::column-end:::
  :::column:::
    750 MBps
  :::column-end:::
  :::column:::
    9,600
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    M192dms\_v2, M192ms\_v2
  :::column-end:::
  :::column:::
    4,096 GiB
  :::column-end:::
  :::column:::
    2,000 MB/s
  :::column-end:::
  :::column:::
    4,800 GB
  :::column-end:::
  :::column:::
    750 MBps
  :::column-end:::
  :::column:::
    9,600
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    M208s\_v2
  :::column-end:::
  :::column:::
    2,850 GiB
  :::column-end:::
  :::column:::
    1,000 MB/s
  :::column-end:::
  :::column:::
    3,500 GB
  :::column-end:::
  :::column:::
    750 MBps
  :::column-end:::
  :::column:::
    7,000
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    M208ms\_v2
  :::column-end:::
  :::column:::
    5,700 GiB
  :::column-end:::
  :::column:::
    1,000 MB/s
  :::column-end:::
  :::column:::
    7,200 GB
  :::column-end:::
  :::column:::
    750 MBps
  :::column-end:::
  :::column:::
    14,400
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    M416s\_v2
  :::column-end:::
  :::column:::
    5,700 GiB
  :::column-end:::
  :::column:::
    2,000 MB/s
  :::column-end:::
  :::column:::
    7,200 GB
  :::column-end:::
  :::column:::
    1,000 MBps
  :::column-end:::
  :::column:::
    14,400
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    M416ms\_v2
  :::column-end:::
  :::column:::
    11,400 GiB
  :::column-end:::
  :::column:::
    2,000 MB/s
  :::column-end:::
  :::column:::
    14,400 GB
  :::column-end:::
  :::column:::
    1,500 MBps
  :::column-end:::
  :::column:::
    28,800
  :::column-end:::
:::row-end:::

**The values listed are intended to be a starting point and need to be evaluated against the real demands.** The advantage with Azure Ultra disk is that the values for IOPS and throughput can be adapted without the need to shut down the VM or halting the workload applied to the system.

> [!NOTE]
> So far, storage snapshots with Ultra disk storage are not available. This blocks the usage of VM snapshots with Azure Backup Services.
