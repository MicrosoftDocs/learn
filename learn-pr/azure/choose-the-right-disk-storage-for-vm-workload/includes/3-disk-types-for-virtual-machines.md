After you've chosen whether to use managed or unmanaged disks, next you have to pick the best disk type for your virtual machines.

Here, you'll learn about the performance and behavior of each disk type so that you can make the right choice.

## Disk performance measures

To choose the right disk type, it's critical to understand its performance. Performance is expressed in two key measures:

- **Input/output operations per second (IOPS)**. IOPS measure the rate at which the disk can complete a mix of read and write operations. Higher performance disks have higher IOPS values.
- **Throughput**. Throughput measures the rate at which data can be moved onto the disk from the host computer and off the disk to the host computer. Throughput is also called *data transfer rate* and is measured in megabytes per second (MBps). Higher performance disks have higher throughput.

For physical disks, solid-state disks (SSDs) usually realize higher IOPS and throughput than hard disk drives (HDDs). Virtual disks that you can choose for an Azure virtual machine are based on SSDs of several types or HDDs. Their performance varies widely based on the disk type that you choose. Let's examine the types that are available.

## Ultra Disks

Ultra Disks provide the highest disk performance available in Azure. Choose them when you need the fastest storage performance, which includes high throughput, high IOPS, and low latency.

The performance of an Ultra Disks depends on the size you select, as you can see from examples in this table:

| Disk size (GB) | IOPS | Throughput (MBps) |
| --- | --- | --- |
| 4 | 1,200 | 300 |
| 16 | 4,800 | 1,200 |
| 32 | 9,600 | 2,000 |
| 256 | 76,800 | 2,000 |
| Over 1,024 | 160,000 | 2,000 |
| | |

Ultra Disks can have capacities from 4 GB up to 64 TB. A unique feature of Ultra Disks is that you can adjust the IOPS and throughput values while they're running and without detaching them from the host virtual machine. Performance adjustments can take up to an hour to take effect.

Ultra Disks are a new disk type and currently have some limitations:

- They can only be attached to virtual machines that are in availability zones.
- They can only be used as data disks and can only be created as empty disks.
- They don't support disk snapshots, virtual machine images, Azure Disk Encryption, Azure Backup, or Azure Site Recovery.

Some workloads place intensive loads on disk storage. For example, top-tier databases and SAP HANA need fast performance and are transaction heavy. If you have such a workload, and if Premium SSDs have caused performance bottlenecks, consider using Ultra Disks.

## Premium SSD

Premium SSDs are the next tier down from Ultra Disks in terms of performance, but they still provide high throughput and IOPS with low latency. Premium disks don't have the current limitations of Ultra Disks. For example, they're available in all regions and can be used with virtual machines that are outside of availability zones.

You can't adjust performance without detaching these disks from their virtual machine. Also, you can only use premium SSDs with larger virtual machine sizes, which are compatible with premium storage.

This table has examples that illustrate the high performance of premium SSDs:

| Disk size name | Disk size | IOPS | Throughput (MBps) |
| --- | --- | --- | --- |
| P4 | 32 GiB | 120 | 25 |
| P15 | 256 GiB | 1,100 | 125 |
| P40 | 2 TiB | 7,500 | 250 |
| P80 | 32 TiB | 20,000 | 900 |
| | | |

With Premium SSDs, these performance figures are guaranteed. There's no such guarantee for standard tier disks, which can be impacted occasionally by high demand.

If you need higher performance than standard disks provide, or if you can't sustain occasional drops in performance, use Premium SSDs. Also use Premium SSDs when you want the highest performance but can't use Ultra disks because of their current limitations. Premium SSDs are a good fit for mission-critical workloads in medium and large organizations.

You can migrate a disk to a Premium SSD at any time, if you've found that its performance isn't good enough.

![Creating a premium SSD.](../media/3-create-premium-ssd.png)

## Standard SSD

Standard SSDs in Azure are a cost-effective storage option for virtual machines that need consistent performance at lower speeds. Standard SSDs aren't as fast as premium or Ultra Disks, but they still have latencies in the range of 1 millisecond to 10 milliseconds and up to 6,000 IOPS. They're available to attach to any virtual machine, no matter what size it is.

This table has examples that illustrate the performance characteristics of Standard SSDs in several sizes:

| Disk size name | Disk size (GB) | IOPS | Throughput (MBps) |
| --- | --- | --- | --- |
| E4 | 32 | 120 | 25 |
| E15 | 256 | 500 | 60 |
| E40 | 2,048 | 500 | 60 |
| E80 | 32,767 | 6,000 | 750 |
| | | |

These performance figures aren't guaranteed but are achieved 99% of the time.

Use Standard SSDs when you have budgetary constraints and a workload that isn't disk intensive. For example, web servers, lightly used enterprise applications, and test servers can all run on standard SSDs.

![Selecting a size for a standard SSD.](../media/3-select-standard-ssd-size.png)

## Standard HDD

If you choose to use Standard HDDs, data is stored on conventional magnetic disk drives with moving spindles. Disks are slower and speeds are more variable than for SSDs, but latencies are under 10 ms for write operations and 20 ms for reads. As for Standard SSDs, you can use Standard HDDs for any virtual machine.

This table illustrates the performance characteristics of standard HDDs in several sizes:

| Disk size name | Disk size (GB) | IOPS | Throughput (MBps) |
| --- | --- | --- | --- |
| S4 | 32 | 500 | 60 |
| S15 | 256 | 500 | 60 |
| S40 | 2,048 | 500 | 60 |
| S80 | 32,767 | 2,000 | 500 |
| | | |

Use Standard HDDs when you want to minimize costs for less critical workloads and development or test environments.
