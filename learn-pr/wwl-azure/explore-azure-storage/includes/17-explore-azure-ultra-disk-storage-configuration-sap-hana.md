Another Azure storage type is called [Azure Ultra disk](/azure/virtual-machines/disks-types#ultra-disks). The significant difference between Azure storage offered so far and Ultra disk is that the disk capabilities aren't bound to the disk size anymore. As a customer you can define these capabilities for Ultra disk:

- Size of a disk ranging from 4 GiB to 65,536 GiB
- IOPS range from 100 IOPS to 160K IOPS (maximum depends on virtual machine types as well)
- Storage throughput from 300 MB/sec to 2,000 MB/sec

Ultra disk gives you the possibility to define a single disk that fulfills your size, IOPS, and disk throughput range. Instead of using logical volume managers like LVM or MDADM on top of Azure Premium Storage to construct volumes that fulfill IOPS and storage throughput requirements. You can run a configuration mix between Ultra disk and Premium Storage. As a result, you can limit the usage of Ultra disk to the performance-critical **/hana/data** and **/hana/log** volumes and cover the other volumes with Azure Premium Storage.

Another advantage of Ultra disk can be the better read latency in comparison to Premium Storage. The faster read latency can have advantages when you want to reduce the HANA startup times and the subsequent load of the data into memory. Advantages of Ultra disk storage also can be felt when HANA is writing savepoints. Since Premium Storage disks for **/hana/data** are usually not Write Accelerator cached, the write latency to **/hana/data** on Premium Storage compared to the Ultra disk is higher. It can be expected that savepoint writing with Ultra disk is performing better on Ultra disk.

> [!IMPORTANT]
> Ultra disk isn't yet present in all the Azure regions and is also not yet supporting all virtual machine types listed below. For detailed information about where Ultra disk is available and which virtual machine families are supported, check the article [Azure managed disk types](/azure/virtual-machines/windows/disks-types).

## Production recommended storage solution with pure Ultra disk configuration

In this configuration, you keep the **/hana/data** and **/hana/log** volumes separately. The suggested values are derived out of the KPIs that SAP has to certify virtual machine types for SAP HANA and storage configurations as recommended in the SAP TDI Storage Whitepaper.

The recommendations are often exceeding the SAP minimum requirements as stated earlier in this article. The listed recommendations are a compromise between the size recommendations by SAP and the maximum storage throughput the different virtual machine types provide.

> [!NOTE]
> Azure Ultra disk is enforcing a minimum of 2 IOPS per Gigabyte capacity of a disk.

| VM SKU | RAM | Max. VM I/O Throughput | /hana/data volume | /hana/data I/O throughput | /hana/data IOPS |
|-|-|-|-|-|-|
| E20ds\_v4 | 160 GiB | 480 MB/s | 200 GB | 400 MBps | 2,500 |
| E32ds\_v4 | 256 GiB | 768 MB/s | 300 GB | 400 MBps | 2,500 |
| E48ds\_v4 | 384 GiB | 1152 MB/s | 460 GB | 400 MBps | 3,000 |
| E64ds\_v4 | 504 GiB | 1200 MB/s | 610 GB | 400 MBps | 3,500 |
| E64s\_v3 | 432 GiB | 1,200 MB/s | 610 GB | 400 MBps | 3,500 |
| M32ts | 192 GiB | 500 MB/s | 250 GB | 400 MBps | 2,500 |
| M32ls | 256 GiB | 500 MB/s | 300 GB | 400 MBps | 2,500 |
| M64ls | 512 GiB | 1,000 MB/s | 620 GB | 400 MBps | 3,500 |
| M32dms\_v2, M32ms\_v2 | 875 GiB | 500 MB/s | 1,200 GB | 600 MBps | 5,000 |
| M64s, M64ds\_v2, M64s\_v2 | 1,024 GiB | 1,000 MB/s | 1,200 GB | 600 MBps | 5,000 |
| M64ms, M64dms\_v2, M64ms\_v2 | 1,792 GiB | 1,000 MB/s | 2,100 GB | 600 MBps | 5,000 |
| M128s, M128ds\_v2, M128s\_v2 | 2,048 GiB | 2,000 MB/s | 2,400 GB | 750 MBps | 7,000 |
| M192ds\_v2, M192s\_v2 | 2,048 GiB | 2,000 MB/s | 2,400 GB | 750 MBps | 7,000 |
| M128ms, M128dms\_v2, M128ms\_v2 | 3,892 GiB | 2,000 MB/s | 4,800 GB | 750 MBps | 9,600 |
| M192dms\_v2, M192ms\_v2 | 4,096 GiB | 2,000 MB/s | 4,800 GB | 750 MBps | 9,600 |
| M208s\_v2 | 2,850 GiB | 1,000 MB/s | 3,500 GB | 750 MBps | 7,000 |
| M208ms\_v2 | 5,700 GiB | 1,000 MB/s | 7,200 GB | 750 MBps | 14,400 |
| M416s\_v2 | 5,700 GiB | 2,000 MB/s | 7,200 GB | 1,000 MBps | 14,400 |
| M416ms\_v2 | 11,400 GiB | 2,000 MB/s | 14,400 GB | 1,500 MBps | 28,800 |

**The values listed are intended to be a starting point and need to be evaluated against the real demands.** The advantage with Azure Ultra disk is that the values for IOPS and throughput can be adapted without the need to shut down the virtual machine or halting the workload applied to the system.

> [!NOTE]
> So far, storage snapshots with Ultra disk storage aren't available. This blocks the usage of virtual machine snapshots with Azure Backup Services.
