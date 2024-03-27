The throughput of an Azure NetApp volume is a function of the volume size and Service level, as documented in [Service level for Azure NetApp Files](/azure/azure-netapp-files/azure-netapp-files-service-levels).

It is important to understand the performance relationship between the volume size and the physical limits for a Logical Interface (LIF) of the Storage Virtual Machine (SVM).

The table below demonstrates that it could make sense to create a large “Standard” volume to store backups and that it doesn't make sense to create an “Ultra” volume larger than 12 TB because the physical bandwidth capacity of a single LIF would be exceeded.

The maximum throughput for a Logical Interface and a single Linux session is between 1.2 and 1.4 GB/sec.

| Size | Throughput Standard | Throughput Premium | Throughput Ultra |
|-|-|-|-|
| 1 TB | 16 MB/sec | 64 MB/sec | 128 MB/sec |
| 2 TB | 32 MB/sec | 128 MB/sec | 256 MB/sec |
| 4 TB | 64 MB/sec | 256 MB/sec | 512 MB/sec |
| 10 TB | 160 MB/sec | 640 MB/sec | 1,280 MB/sec |
| 15 TB | 240 MB/sec | 960 MB/sec | 1,400 MB/sec |
| 20 TB | 320 MB/sec | 1,280 MB/sec | 1,400 MB/sec |
| 40 TB | 640 MB/sec | 1,400 MB/sec | 1,400 MB/sec |

> [!NOTE]
> write or single session read throughput limits (in case NFS mount option nconnect isn't used)

It is important to understand that the data is written to the same SSDs in the storage backend. The performance quota from the capacity pool was created to be able to manage the environment. The Storage KPIs are equal for all HANA database sizes. In almost all cases, this assumption doesn't reflect the reality and the customer expectation. The size of HANA systems doesn't necessarily mean that a small system requires low storage throughput, or that a large system requires high storage throughput. But generally, we can expect higher throughput requirements for larger HANA database instances. As a result of SAP's sizing rules for the underlying hardware, such larger HANA instances also provide more CPU resources and higher parallelism in tasks like loading data after an instance's restart. As a result, the volume sizes should be adapted to the customer expectations and requirements, and not only driven by pure capacity requirements.

As you design the infrastructure for SAP in Azure, you should be aware of SAP's minimum storage throughput requirements (for productions systems), which translates into minimum throughput characteristics of:

| Volume type and I/O type | Minimum KPI demanded by SAP | Premium service level | Ultra service level |
|-|-|-|-|
| Log Volume Write | 250 MB/sec | 4 TB | 2 TB |
| Data Volume Write | 250 MB/sec | 4 TB | 2 TB |
| Data Volume Read | 400 MB/sec | 6.3 TB | 3.2 TB |

Since all three KPIs are demanded, the **/hana/data** volume needs to be sized toward the larger capacity to fulfill the minimum read requirements.

For HANA systems, which aren't requiring high bandwidth, the ANF volume sizes can be smaller. And in case a HANA system requires more throughput the volume could be adapted by resizing the capacity online. No KPIs are defined for backup volumes. However, the backup volume throughput is essential for a well-performing environment. Log – and Data volume performance must be designed to the customer expectations.

> [!IMPORTANT]
> Independent of the capacity you deploy on a single NFS volume, the throughput, is expected to plateau in the range of 1.2-1.4 GB/sec bandwidth used by a consumer in a virtual machine. This has to do with the underlying architecture of the ANF offer and related Linux session limits around NFS. The performance and throughput numbers as documented in the article [Azure NetApp Files performance benchmarks for Linux](/azure/azure-netapp-files/performance-benchmarks-linux) were conducted against one shared NFS volume with multiple client virtual machines and as a result with multiple sessions. That scenario is different from the scenario we measure in SAP, where we measure throughput from a single virtual machine against an NFS volume hosted on ANF.

To meet the SAP minimum throughput requirements for data and log, and according to the guidelines for **/hana/shared**, the recommended sizes would look like:

| Volume | Size (Premium Storage tier) | Size (Ultra Storage tier) | Supported NFS protocol |
|-|-|-|-|
| **/hana/log** | 4 TiB | 2 TiB | v4.1 |
| **/hana/data** | 6.3 TiB | 3.2 TiB | v4.1 |
| **/hana/shared** scale-up | Min (1 TB, 1 x RAM) | Min (1 TB, 1 x RAM) | v3 or v4.1 |
| **/hana/shared** scale-out | 1 x RAM of worker node per 4 worker nodes | 1 x RAM of worker node per 4 worker nodes | v3 or v4.1 |
| **/hana/logbackup** | 3 x RAM | 3 x RAM | v3 or v4.1 |
| **/hana/backup** | 2 x RAM | 2 x RAM | v3 or v4.1 |

For all volumes, NFS v4.1 is highly recommended.

The sizes for the backup volumes are estimations. Exact requirements need to be defined based on workload and operation processes. For backups, you could consolidate many volumes for different SAP HANA instances to one (or two) larger volumes, which could have a lower service level of ANF.

> [!NOTE]
> The Azure NetApp Files, sizing recommendations stated in this document are targeting the minimum requirements SAP expresses towards their infrastructure providers. In real customer deployments and workload scenarios, that may not be enough. Use these recommendations as a starting point and adapt, based on the requirements of your specific workload.

Therefore you could consider to deploy similar throughput for the ANF volumes as listed for Ultra disk storage already. Also consider the sizes for the sizes listed for the volumes for the different virtual machine SKUs as done in the Ultra disk tables already.

> [!TIP]
> You can re-size Azure NetApp Files volumes dynamically, without the need to `unmount` the volumes, stop the virtual machines or stop SAP HANA. This allows flexibility to meet your application throughput demands, both expected and unforeseen.

Documentation on how to deploy an SAP HANA scale-out configuration with standby node using NFS v4.1 volumes that are hosted in ANF is published in [SAP HANA scale-out with standby node on Azure Virtual Machines with Azure NetApp Files on SUSE Linux Enterprise Server](/azure/virtual-machines/workloads/sap/sap-hana-scale-out-standby-netapp-files-suse).

[SAP on Azure NetApp Files Sizing Best Practices](https://techcommunity.microsoft.com/t5/running-sap-applications-on-the/sap-on-azure-netapp-files-sizing-best-practices/ba-p/3895300).
