One of the primary concerns for your organization is how to migrate its enterprise applications that require high-performance storage to Azure.

As part of the migration strategy, you propose the Azure Disk Storage solution to optimize performance and costs. This unit covers the various disk-storage types available in Azure.

## Ultra disks

Ultra disks provide the highest disk performance available in Azure. Choose them when you need the fastest storage performance, which includes high throughput, high IOPS (Input/output operations per second), and low latency.

The maximum performance of an Ultra disk depends on the size you select, as you can see from examples in this table:

| Disk size (GB) | IOPS | Throughput (MB/s) |
| --- | --- | --- |
| 4 | 1,200 | 300 |
| 8 | 2,400 | 600 |
| 16 | 4,800 | 1,200 |
| 32 | 9,600 | 2,400 |
| 64 | 19,200 | 4,000 |
| 128 | 38,400 | 4,000 |
| 256 | 76,800 | 4,000 |
| 512 | 153,600 | 4,000 |
| 1,024 - 65,536 (sizes in this range increase in 1-TiB increments) | 160,000 | 4,000 |

Ultra disks can have capacities from 4 GB up to 64 TB. A unique feature of Ultra disks is that you can adjust the IOPS and throughput values while they're running and without detaching them from the host virtual machine. Performance adjustments can take up to an hour to take effect.

Ultra disks have some limitations. For a complete list, see [Ultra disk Limitations](/azure/virtual-machines/disks-types#ultra-disk-limitations).

Some workloads place intensive loads on disk storage. For example, top-tier databases and SAP HANA (High-performance Analytic Appliance) need fast performance and are transaction heavy. If you have such a workload, and if Premium SSD managed disks are causing performance bottlenecks, consider using Ultra disks.

> [!NOTE]
> When you provision an instance of Azure Ultra Disk Storage, you can independently configure the size, IOPS, and throughput of the disk. You're charged for using Ultra Disk Storage based on the provisioned size, IOPS, and throughput.

## Premium SSD v2

Premium SSD managed disks are the next tier down from Ultra disks in terms of performance, but they still provide high throughput and IOPS with low latency. Like Ultra disks, the performance (capacity, throughput, and IOPS) of Premium SSD v2 managed disks can be independently configured at any time, making it easier for more scenarios to be cost efficient while meeting performance needs.

The following table provides an example of disk capacities and performance maximums.

|Disk size  |Maximum available IOPS  |Maximum available throughput (MB/s)  |
|---------|---------|---------|
|1 GiB-64 TiBs    |3,000-80,000 (Increases by 500 IOPS per GiB)        |125-1,200 (increases by 0.25 MB/s per set IOPS)         |

Unlike Premium SSD managed disks, Premium SSD v2 managed disks don't have dedicated sizes. You can set a Premium SSD v2 disk to any supported size you prefer, and make granular adjustments to the performance without downtime. Premium SSD v2 managed disks don't support host caching but, benefits significantly from lower latency, which addresses some of the same core problems that host caching addresses. The ability to adjust IOPS, throughput, and size at any time also means you can avoid the maintenance overhead of having to stripe disks to meet your needs.

Premium SSD v2 managed disks have some limitations. For a complete list, see [Premium SSD v2 Limitations](/azure/virtual-machines/disks-types#premium-ssd-v2-limitations).

Premium SSD v2 managed disks are suited for a broad range of workloads on virtual machines or stateful containers. Such as SQL server, Oracle, MariaDB, SAP, Cassandra, Mongo DB, big data analytics, and gaming,

## Premium SSD

Premium SSD managed disks are the next tier down from Premium SSD v2 managed disks in terms of performance, but they still provide high throughput and IOPS with low latency. Premium SSD doesn't have the current limitations of either Ultra Disks or Premium SSD v2. For example, they're available in all regions and can be used with virtual machines that are outside of availability zones.

To adjust the performance of a disk, you can change its performance tier. You can change the tier without detaching the disk from a virtual machine (VM) or shutting down the VM. Also, you can only use premium SSD managed disks with virtual machine sizes that are compatible with premium storage.

The following table contains examples that illustrate the high performance of premium SSD managed disks:

| Disk size name | Disk size | IOPS | Throughput (MB/s) |
| --- | --- | --- | --- |
| P4 | 32 GiB | 120 | 25 |
| P15 | 256 GiB | 1,100 | 125 |
| P40 | 2 TiB | 7,500 | 250 |
| P80 | 32 TiB | 20,000 | 900 |

With Premium SSD, these performance figures are guaranteed. There's no such guarantee for Standard tier disks because high demand can occasionally impact them.

If you need higher performance than standard disks provide, or if you can't sustain occasional drops in performance, use Premium SSD. Also use Premium SSD managed disks when you want the highest performance but can't use Ultra disks or Premium SSD v2 because of their current limitations. Premium SSD managed disks are a good fit for mission-critical workloads in medium and large organizations.

Azure Premium SSD disks support two bursting models, an on-demand bursting model and a credit-based model. The disk bursting models and their differences are covered in the section [Optimize performance and costs using performance-scaling options](../4-optimize-performance-and-costs-using-performance-scaling-options.yml).

## Standard SSD managed disks

Azure Standard SSD managed disks are a cost-effective storage option for VMs that need consistent performance at lower speeds. Standard SSD disks aren't as fast as Premium SSD disks or Ultra Disk Storage, but they still provide single-digit millisecond (ms) latencies and up to 6,000 IOPS and 750 MB/s of throughput. You can attach Standard SSD disks to any VM, regardless of its size.

The following table provides the performance characteristics of Standard SSD disks in several sizes:

| Disk size name | Disk size (GB) | IOPS | Throughput (MB/s) |
| --- | --- |--- | --- |
| E4 | 32 | 500 | 60 |
| E15 | 256 | 500 | 60 |
| E40 | 2,048 | 500 | 60 |
| E80 | 32,767 | 6,000 | 750 |

Use Standard SSD disks when you have budgetary constraints and a workload that isn't performance-intensive. For example, web servers, lightly used enterprise applications, and test servers all can run on Standard SSD disks. Standard SSD disks support credit-based disk bursting on P30 and smaller disks.

## Standard HDD managed disks

In Azure Standard HDD managed disks, data is stored on conventional magnetic disk drives that have moving spindles. Disks are slower and the variation in speeds is higher compared to solid-state drives (SSDs). Standard HDD disks are designed to deliver write latencies under 10 ms and read latencies under 20 ms for most operations. Like Standard SSD disks, you can use Standard HDD disks for any VM.

The following table provides the performance characteristics of Standard HDD disks in several sizes:

| Disk size name | Disk size (GB) | IOPS | Throughput (MB/s) |
| --- | --- |--- | --- |
| S4 | 32 | 500 | 60 |
| S15 | 256 | 500 | 60 |
| S40 | 2,048 | 500 | 60 |
| S80 | 32,767 | 2,000 | 500 |

Use Standard HDD disks when you want to minimize costs for less critical workloads and development or test environments.
