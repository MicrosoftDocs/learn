One of the primary concerns for your organization is how to migrate its enterprise applications that require high-performance storage to Azure.

As part of the migration strategy, you propose the Azure Disk Storage solution to optimize performance and costs. This unit covers the various disk-storage types available in Azure.

## Ultra Disk Storage

Of the various disks available in Azure, Azure Ultra Disk Storage provides the highest disk performance. Choose this option when you need the fastest storage performance in addition to high throughput, high input/output operations per second (IOPS), and low latency.

The performance you'll get with Ultra Disk Storage depends on the disk size you choose. The following table provides examples. The table shows disk size in gigabytes (GB) and throughput in megabytes per second (MBps).

| Disk size (GB) | IOPS | Throughput (MBps) |
| --- | --- |--- |
| 4 | 1,200 | 300 |
| 16 | 4,800 | 1,200 |
| 32 | 9,600 | 2,000 |
| 256 | 76,800 | 2,000 |
| Over 1,024 | 160,000 | 2,000 |

Ultra Disk Storage can have a capacity ranging from 4 GB up to 64 terabytes (TB). A unique feature of Ultra Disk Storage is that you can adjust the IOPS and throughput values while they're running and without detaching the disk from the host VM. For example, depending on the sizes of the disks you choose in Ultra Disk Storage, a single instance of Ultra Disk Storage can support a maximum of 160,000 IOPS. Performance adjustments might take up to an hour to take effect.

> [!NOTE]
> You can resize an instance of Ultra Disk Storage only four times in a 24-hour window. Also, it's possible that the performance-resize operation might fail because of a lack of performance bandwidth capacity.

By default, Azure creates instances of Ultra Disk Storage with a 4-KB physical sector, which is compatible with most applications. For earlier versions of applications that aren't compatible with a 4-KB physical sector, you can create a 512-byte emulation (512e) sector size.

Ultra Disk Storage is a new disk type in Azure and has some limitations:

- It's available only in a subset of Azure regions.
- You can attach Ultra Disk Storage only to VMs that are in Azure availability zones.
- You can use Ultra Disk Storage only as data disks and as empty disks.
- Ultra Disk Storage doesn't support disk snapshots, VM images, virtual machine scale sets, Azure Disk Encryption, Azure Backup, or Azure Site Recovery.
- Ultra Disk Storage doesn't support cached read and write operations.

Some workloads place intensive workloads on disk storage. For example, top-tier databases and SAP HANA need fast performance and are transaction heavy. If you have such a workload and if Azure Premium SSD disks are causing performance bottlenecks, consider using Azure Ultra Disk Storage.

> [!NOTE]
> When you provision an instance of Azure Ultra Disk Storage, you can independently configure the size, IOPS, and throughput of the disk. You're charged for using Ultra Disk Storage based on the provisioned size, IOPS, and throughput.

## Premium SSD managed disks

Azure Premium SSD managed disks provide high throughput and IOPS with low latency, although they offer a slightly lower performance compared to Ultra Disk Storage. Premium SSD disks don't have the current limitations of Ultra Disk Storage. For example, they're available in all regions and you can use them with VMs that are located outside Azure availability zones.

You can adjust the performance of Premium SSD disks by first detaching the disks from their VMs. Also, you can use Premium SSD disks only with larger VM sizes that are compatible with Premium storage.

> [!NOTE]
> In May 2021, Microsoft announced a preview option to adjust the performance tier on Premium SSD disks while they're attached to VMs.

The following table provides examples that illustrate the high performance of Premium SSD disks. Disk sizes in this table include gibibytes (GiB) and tebibytes (TiB).

| Disk size name | Disk size | IOPS | Throughput (MBps) |
| --- | --- |--- | --- |
| P4 | 32 GiB | 120 | 25 |
| P15 | 256 GiB | 1,100 | 125 |
| P40 | 2 TiB | 7,500 | 250 |
| P80 | 32 TiB | 20,000 | 900 |

Premium SSD disks are designed to provide consistent performance figures, as the examples in the table depict. Azure Standard SSD managed disks occasionally might be affected by high demand.

If you need higher performance than what Standard SSD disks provide, or if you can't sustain the occasional effect on performance, use Premium SSD disks. Also use Premium SSD disks when you want the highest possible performance, but you're not able to use Ultra Disk Storage because of its current limitations. Premium SSD disks are a good solution for mission-critical workloads in medium and large organizations.

Azure Premium SSD disks support disk bursting, with which you can achieve higher IOPS and throughput than with your provisioned performance. For P20 disks and smaller disks, bursting is enabled by default with no additional cost.

> [!NOTE]
> You'll learn more about the Azure disk bursting functionality in [Optimize performance and costs using performance-scaling options](../4-optimize-performance-and-costs-using-performance-scaling-options.yml).

## Standard SSD managed disks

Azure Standard SSD managed disks are a cost-effective storage option for VMs that need consistent performance at lower speeds. Standard SSD disks aren't as fast as Premium SSD disks or Ultra Disk Storage, but they still provide single-digit millisecond (ms) latencies and up to 6,000 IOPS and 750 MBps of throughput. You can attach Standard SSD disks to any VM, regardless of its size.

The following table provides the performance characteristics of Standard SSD disks in several sizes:

| Disk size name | Disk size (GB) | IOPS | Throughput (MBps) |
| --- | --- |--- | --- |
| E4 | 32 | 500 | 60 |
| E15 | 256 | 500 | 60 |
| E40 | 2,048 | 500 | 60 |
| E80 | 32,767 | 6,000 | 750 |

Use Standard SSD disks when you have budgetary constraints and a workload that isn't performance-intensive. For example, web servers, lightly used enterprise applications, and test servers all can run on Standard SSD disks. Standard SSD disks support disk bursting on P30 and smaller disks.

## Standard HDD managed disks

In Azure Standard HDD managed disks, data is stored on conventional magnetic disk drives that have moving spindles. Disks are slower and the variation in speeds is higher compared to solid-state drives (SSDs). Standard SSD disks are designed to deliver write latencies under 10 ms and read latencies under 20 ms for most operations. Like Standard SSD disks, you can use Standard HDD disks for any VM.

The following table provides the performance characteristics of Standard HDD disks in several sizes:

| Disk size name | Disk size (GB) | IOPS | Throughput (MBps) |
| --- | --- |--- | --- |
| S4 | 32 | 500 | 60 |
| S15 | 256 | 500 | 60 |
| S40 | 2,048 | 500 | 60 |
| S80 | 32,767 | 2,000 | 500 |

Use Standard HDD disks when you want to minimize costs for less critical workloads and development or test environments.
