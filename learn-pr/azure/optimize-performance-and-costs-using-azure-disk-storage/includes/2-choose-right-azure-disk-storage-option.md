One of the primary concerns of your organization is to migrate to Azure your enterprise applications that require high-performance storage.

As a part of the migration strategy, you propose the Azure Disk Storage solution to optimize performance and costs. This unit covers the various disk storage types available in Azure.

## Ultra Disks

Of the various disks available in Azure, Ultra Disks provide the highest disk performance. Choose this option when you need the fastest storage performance in addition to high throughput, high I/O operations per second (IOPS), and low latency.

The performance of an Ultra Disk depends on the size of the disk you select. The following table provides examples.

| Disk size (GB) | IOPS | Throughput (mbps) |
| --- | --- |--- |
| 4 | 1,200 | 300 |
| 16 | 4,800 | 1,200 |
| 32 | 9,600 | 2,000 |
| 256 | 76,800 | 2,000 |
| Over 1,024 | 160,000 | 2,000 |

Ultra Disks can have a capacity ranging from 4 GB up to 64 TB. A unique feature of Ultra Disks is that you can adjust the IOPS and throughput values while they're running and without detaching them from the host VM. For example, depending on the sizes of the Ultra Disk, a single Ultra Disk can support a maximum of 160,000 IOPS. Performance adjustments can take up to an hour to take effect.

> [!Note]
> You can resize an Ultra Disk only four times during a 24-hour window, and it's possible that the performance resize operation might fail because of the lack of performance bandwidth capacity.

By default, Azure creates Ultra Disks with a 4K physical sector, which is compatible with most applications. For older applications that aren't compatible with a 4K physical sector, you can create a 512E sector size.

Ultra Disks are a new disk type and have some limitations:

- They're only available in a subset of Azure regions.
- You can only attach them to VMs that are in Availability Zones.
- You can only use them as data disks and use them as empty disks.
- They don't support disk snapshots, VM images, scale sets, Azure Disk Encryption, Azure Backup, or Azure Site Recovery.
- Ultra Disks don't support cached reads and writes operations.

Some workloads place intensive loads on disk storage. For example, top-tier databases and SAP HANA need fast performance and are transaction heavy. If you have such a workload and if Premium SSDs are causing performance bottlenecks, consider using Ultra Disks.

>[!Note]
>When you provision an Ultra Disk you can independently configure the size, IOPS, and throughput of the disk. You're charged for using Ultra Disks based on the provisioned size, IOPS, and throughput.

## Premium SSD

Premium SSDs provide high throughput and IOPS with low latency although they offer a slightly lower performance compared to Ultra Disks. Premium SSDs don't have the current limitations of Ultra Disks. For example, they're available in all regions and you can use them with VMs that are located outside of Availability Zones.

You can adjust the performance of Premium SSDs by first detaching these disks from their VMs. Also, you can use Premium SSDs only with larger VM sizes that are compatible with premium storage.

> [!Note]
> At the time of writing this module, Microsoft announced, in public preview, an option to adjust the performance tier on Premium SSDs while they're attached to VMs.

The following table provides examples that illustrate the high performance of Premium SSDs.

| Disk size name | Disk size | IOPS | Throughput (mbps) |
| --- | --- |--- | --- |
| P4 | 32 GiB | 120 | 25 |
| P15 | 256 GiB | 1,100 | 125 |
| P40 | 2 TiB | 7,500 | 250 |
| P80 | 32 TiB | 20,000 | 900 |

Premium SSDs are designed to provide consistent performance figures as the examples in the table depict, while Standard SSDs can be occasionally impacted by high demand.

If you need higher performance than what Standard SSDs provide or if you can't sustain occasional impacts to performance, use Premium SSDs. Also, use Premium SSDs when you want the highest possible performance, but you're not able to use Ultra Disks because of their current limitations. Premium SSDs are a good solution for mission-critical workloads in medium and large organizations.

Azure Premium SSDs support disk bursting, which allows you to achieve higher IOPS and throughput than your provisioned performance. For P20 disks and smaller, bursting is enabled by default with no additional costs.

>[!Note]
>You'll learn more about the Azure disk bursting functionality in the **Select a disk type for your workload** unit.

## Standard SSD

Standard SSDs in Azure are a cost-effective storage option for VMs that need consistent performance at lower speeds. Standard SSDs aren't as fast as Premium SSDs  or Ultra Disks, but they still provide single-digit millisecond latencies and up to 6,000 IOPS and 750 MBps of throughput. You can attach Standard SSDs to any VM, regardless of its size.

The following table provides the performance characteristics of Standard SSDs in several sizes.

| Disk size name | Disk size (GB) | IOPS | Throughput (mbps) |
| --- | --- |--- | --- |
| E4 | 32 | 500 | 60 |
| E15 | 256 | 500 | 60 |
| E40 | 2,048 | 500 | 60 |
| E80 | 32,767 | 6,000 | 750 |

Use Standard SSDs when you have budgetary constraints and a workload that isn't performance intensive. For example, web servers, lightly used enterprise applications, and test servers can all run on Standard SSDs.

## Standard HDD

In standard HDDs, data is stored on conventional magnetic disk drives with moving spindles. Disks are slower and the variation in speeds is higher compared to SSDs. Standard SSDs are designed to deliver write latencies under 10 ms and read latencies under 20 ms for most operations. Like Standard SSDs, you can use standard HDDs for any VM.

The following table provides the performance characteristics of standard HDDs in several sizes.

| Disk size name | Disk size (GB) | IOPS | Throughput (MBps) |
| --- | --- |--- | --- |
| S4 | 32 | 500 | 60 |
| S15 | 256 | 500 | 60 |
| S40 | 2,048 | 500 | 60 |
| S80 | 32,767 | 2,000 | 500 |

Use standard HDDs when you want to minimize costs for less critical workloads and development or test environments.

