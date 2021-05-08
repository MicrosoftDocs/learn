One of the primary concerns of your organization is to migrate your enterprise applications that require high-performance storage to Azure.

As a part of the migration strategy, you propose the Azure Disk Storage solution to optimize performance and costs. This unit covers the various disk storage types available in Azure.

## Ultra disks

Of the various disks available in Azure, ultra disks provide the highest disk performance. Choose this option when you need the fastest storage performance in addition to high throughput, high IOPS, and low latency.

The performance of an Ultra SSD depends on the size of the disk you select. The following table lists some examples.

| Disk size (GB) | IOPS | Throughput (MBps) |
| --- | --- |
| 4 | 1,200 | 300 |
| 16 | 4,800 | 1,200 |
| 32 | 9,600 | 2,000 |
| 256 | 76,800 | 2,000 |
| Over 1,024 | 160,000 | 2,000 |


Ultra disks can have a capacity ranging from 4 GB up to 64 TB. A unique feature of Ultra Disks is that you can adjust the IOPS and throughput values while they&#39;re running and without detaching them from the host virtual machine (VM). For example, depending on the sizes of the ultra disk, single ultra disk can support up to maximum 160 000 IOPS limit. Performance adjustments can take up to an hour to take effect.

Ultra disks are a new disk type and currently have some limitations:

- They&#39;re only available in a subset of Azure regions.
- You can only attach them to VMs that are in Availability Zones.
- You can only attach them to ES/DS v3 VMs.
- You can only create use them as data disks and use them as empty disks.
- They don&#39;t support disk snapshots, VM images, scale sets, Azure Disk Encryption, Azure Backup, or Azure Site Recovery.

Some workloads place intensive loads on disk storage. For example, top-tier databases and SAP HANA need fast performance and are transaction heavy. If you have such a workload and if premium SSDs are causing performance bottlenecks, consider using ultra disks.

## Premium SSD

Premium SSDs provide high throughput and IOPS with low latency although they offer a slightly lower performance compared to ultra disks.. Premium disks don&#39;t have the current limitations of ultra disks. For example, they&#39;re available in all regions and you can use them with VMs that are located outside of Availability Zones.

You can&#39;t adjust performance of premium SSDs without detaching these disks from their VM. Also, you can use premium SSDs only with larger VM sizes that are compatible with premium storage.

Note: At the time of writing this module, Microsoft announced in private preview, an option to adjust performance tier on premium SSD disks while they are used within VMs.

The following table lists examples that illustrate the high performance of premium SSDs:

| **PREMIUM SSD** |
| --- |
| **Disk size name** | **Disk size** | **IOPS** | **Throughput (MBps)** |
|
| |
|
| |
| P4 | 32 GiB | 120 | 25 |
| --- | --- | --- | --- |
| P15 | 256 GiB | 1,100 | 125 |
| --- | --- | --- | --- |
| P40 | 2 TiB | 7,500 | 250 |
| --- | --- | --- | --- |
| P80 | 32 TiB | 20,000 | 900 |
| --- | --- | --- | --- |
|
 |
 |
 |
 |
| --- | --- | --- | --- |

Premium SSDs are designed to provide consistent performance figures as the examples in the table depict, whereas standard tier disks can be occasionally impacted by high demand.

If you need higher performance than what standard disks provide or if you can&#39;t sustain occasional impacts to performance, use premium SSDs. Also, use premium SSDs when you want the highest possible performance, but you are not able to use ultra disks because of their current limitations. Premium SSDs are a good solution for mission-critical workloads in medium and large organizations.

You can convert a disk to a premium SSD at any time if the disk performance does not meet your requirements.

## Standard SSD

Standard SSDs in Azure are a cost-effective storage option for VMs that need consistent performance at lower speeds. Standard SSDs aren&#39;t as fast as premium or ultra disks, but they still have latencies in the range of 1 millisecond to 10 milliseconds and up to 6,000 IOPS. You can attach standard SSDs to any VM, irrespective of its size.

The following table has examples that illustrate the performance characteristics of standard SSDs in several sizes.

| **STANDARD SSD** |
| --- |
| **Disk size name** | **Disk size (GB)** | **IOPS** | **Throughput (MBps)** |
|
| |
|
| |
| E4 | 32 | 120 | 25 |
| --- | --- | --- | --- |
| E15 | 256 | 500 | 60 |
| --- | --- | --- | --- |
| E40 | 2,048 | 500 | 60 |
| --- | --- | --- | --- |
| E80 | 32,767 | 6,000 | 750 |
| --- | --- | --- | --- |
|
 |
 |
 |
 |
| --- | --- | --- | --- |

Use standard SSDs when you have budgetary constraints and a workload that isn&#39;t disk intensive. For example, web servers, lightly used enterprise applications, and test servers can all run on standard SSDs.

## Standard HDD

In standard HDDs, data is stored on conventional magnetic disk drives with moving spindles. Disks are slower and the variation in speeds is higher compared to SSDs. However, latencies are under 10 ms for write operations and 20 ms for reads. Similar to standard SSDs, you can use standard HDDs for any VM.

The following table illustrates the performance characteristics of standard HDDs in several sizes:

| **STANDARD HDD** |
| --- |
| **Disk size name** | **Disk size (GB)** | **IOPS** | **Throughput (MBps)** |
|
| |
|
| |
| S4 | 32 | 500 | 60 |
| --- | --- | --- | --- |
| S15 | 256 | 500 | 60 |
| --- | --- | --- | --- |
| S40 | 2,048 | 500 | 60 |
| --- | --- | --- | --- |
| S80 | 32,767 | 2,000 | 500 |
| --- | --- | --- | --- |
|
 |
 |
 |
 |
| --- | --- | --- | --- |

Use standard HDDs when you want to minimize costs for less critical workloads and development or test environments.

### Cost of Azure managed disks

Use the following consideration to estimate the price for Azure managed disks.

- **Disk Size.** The cost for the managed disk is the price that you pay for the provisioned size on a per hour basis. For example, if you provision 1 TiB (1024 GiB) Standard SSD disk, but you occupy 100 GiB, and you are using the disk for 1 month, you will have to pay for the monthly value for E30 offering.
- **Snapshots** : The snapshots are billed based on used capacity.
- **Outbound data transfers**. Transfer of the data within the same zone is free of charge, between zones, is charged per GB, and additional cost is generated between different regions.
- **Transactions**. For Standard SSD disks, they are billed based on the number of I/O operations that are less than or equal to 256 KiB of throughput. For Standard HDD disks, each IO operation is consider as a transaction, regardless of the throughput.

Note: Premium SSD and Ultra disks are not charged based on transactions.

The cost of ultra disks depends on its size and performance configurations. You are billed based on the provisioned size, provisioned IOPS, and provisioned throughput.
