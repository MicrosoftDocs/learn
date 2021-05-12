One of the primary concerns of your organization is to migrate your enterprise applications that require high-performance storage to Azure.

As a part of the migration strategy, you propose the Azure Disk Storage solution to optimize performance and costs. This unit covers the various disk storage types available in Azure.

## Ultra Disks

Of the various disks available in Azure, Ultra Disks provide the highest disk performance. Choose this option when you need the fastest storage performance in addition to high throughput, high IOPS, and low latency.

The performance of an Ultra Disk depends on the size of the disk you select. The following table lists some examples.

| Disk size (GB) | IOPS | Throughput (MBps) |
| --- | --- |--- |
| 4 | 1,200 | 300 |
| 16 | 4,800 | 1,200 |
| 32 | 9,600 | 2,000 |
| 256 | 76,800 | 2,000 |
| Over 1,024 | 160,000 | 2,000 |

Ultra Disks can have a capacity ranging from 4 GB up to 64 TB. A unique feature of Ultra Disks is that you can adjust the IOPS and throughput values while they're running and without detaching them from the host virtual machine (VM). For example, depending on the sizes of the Ultra Disk, a single Ultra Disk can support up to maximum 160 000 IOPS limit. Performance adjustments can take up to an hour to take effect.
<!-- Replace "160 000" with "160,000". -->
> [!Note]
> You can resize an Ultra Disk only four times during a 24 hour window, and it is possible that the performance resize operation might fail due to lack of performance bandwidth capacity.

By default, Azure creates Ultra Disks with a 4k physical sector, which is compatible with most applications. For older applications that are not compatible with a 4K physical sector, you can create a 512E sector size.
<!-- Replace "4k" with "4K" -->
Ultra Disks are a new disk type and currently have some limitations:

- They're only available in a subset of Azure regions.
- You can only attach them to VMs that are in Availability Zones.
- You can only create use them as data disks and use them as empty disks.
- They don't support disk snapshots, VM images, scale sets, Azure Disk Encryption, Azure Backup, or Azure Site Recovery.
- Ultra Disks do not support cached reads and cached writes operations.

Some workloads place intensive loads on disk storage. For example, top-tier databases and SAP HANA need fast performance and are transaction heavy. If you have such a workload and if Premium SSDs are causing performance bottlenecks, consider using Ultra Disks.

>[Note!]
>You are charged for using Ultra Disks based on the provisioned size, provisioned IOPS, and provisioned throughput.

## Premium SSD

Premium SSDs provide high throughput and IOPS with low latency although they offer a slightly lower performance compared to Ultra Disks. Premium disks don't have the current limitations of Ultra Disks. For example, they're available in all regions and you can use them with VMs that are located outside of Availability Zones.

You can adjust performance of Premium SSDs by first detaching these disks from their VMs. Also, you can use Premium SSDs only with larger VM sizes that are compatible with premium storage.

> [Note!]
> At the time of writing this module, Microsoft announced in private preview, an option to adjust performance tier on Premium SSD disks while they are used within VMs.

The following table lists examples that illustrate the high performance of Premium SSDs:

| Disk size name | Disk size | IOPS | Throughput (MBps) |
| --- | --- |--- | --- |
| P4 | 32 GiB | 120 | 25 |
| P15 | 256 GiB | 1,100 | 125 |
| P40 | 2 TiB | 7,500 | 250 |
| P80 | 32 TiB | 20,000 | 900 |

Premium SSDs are designed to provide consistent performance figures as the examples in the table depict, whereas standard tier disks can be occasionally impacted by high demand.

If you need higher performance than what standard disks provide or if you can't sustain occasional impacts to performance, use Premium SSDs. Also, use Premium SSDs when you want the highest possible performance, but you are not able to use Ultra Disks because of their current limitations. Premium SSDs are a good solution for mission-critical workloads in medium and large organizations.

Azure Premium SSD disks support disk bursting, which offers higher IOPS and throughput performance than the actual performance tier of the selected disk. For P20 disks and smaller, bursting is enabled by default with no additional costs.

>[!Note]
>You will learn more about the Azure disk bursting functionality in the "Select a disk type for your workload" unit.

You can convert a disk to a Premium SSD at any time if the disk performance does not meet your requirements.

You can purchase Premium SSDs with Azure disk reservation by committing to a one-year capacity that offers reduced cost for disk SKU.

>[!Note]
> Reservation discounts are currently available for disks larger than P30 and are applied only for the disk SKU. Disk snapshots are charged at pay-as-you-go rates.

## Standard SSD

Standard SSDs in Azure are a cost-effective storage option for VMs that need consistent performance at lower speeds. Standard SSDs aren't as fast as Premium or Ultra Disks, but they still have latencies in the range of 1 millisecond to 10 milliseconds and up to 6,000 IOPS. You can attach Standard SSDs to any VM, irrespective of its size.

The following table has examples that illustrate the performance characteristics of Standard SSDs in several sizes.

| Disk size name | Disk size (GB) | IOPS | Throughput (MBps) |
| --- | --- |--- | --- |
| E4 | 32 | 500 | 60 |
| E15 | 256 | 500 | 60 |
| E40 | 2,048 | 500 | 60 |
| E80 | 32,767 | 6,000 | 750 |

Use Standard SSDs when you have budgetary constraints and a workload that isn't disk intensive. For example, web servers, lightly used enterprise applications, and test servers can all run on Standard SSDs.

## Standard HDD

In standard HDDs, data is stored on conventional magnetic disk drives with moving spindles. Disks are slower and the variation in speeds is higher compared to SSDs. However, latencies are under 10 ms for write operations and 20 ms for reads. Similar to Standard SSDs, you can use standard HDDs for any VM.

The following table illustrates the performance characteristics of standard HDDs in several sizes:

| Disk size name | Disk size (GB) | IOPS | Throughput (MBps) |
| --- | --- |--- | --- |
| S4 | 32 | 500 | 60 |
| S15 | 256 | 500 | 60 |
| S40 | 2,048 | 500 | 60 |
| S80 | 32,767 | 2,000 | 500 |

Use standard HDDs when you want to minimize costs for less critical workloads and development or test environments.

### Cost of Azure managed disks

Use the following consideration to estimate the price for Azure managed disks.

- **Disk Size**. The cost for the managed disk is the price that you pay for the provisioned size on a per hour basis. For example, if you provision 1 TiB (1024 GiB) Standard SSD disk, but you occupy 100 GiB, and you are using the disk for 1 month, you will have to pay for the monthly value for E30 offering.
- **Snapshots**. The snapshots are billed based on used capacity.
- **Outbound data transfers**. Transfer of the data within the same zone is free of charge, between zones, is charged per GB, and additional cost is generated between different regions.
- **Transactions**. For Standard SSD disks, they are billed based on the number of I/O operations that are less than or equal to 256 KiB of throughput. For Standard HDD disks, each I/O operation is considered as a transaction, regardless of the throughput.

Note: Premium SSD and Ultra Disks are not charged based on transactions.

The cost of Ultra Disks depends on its size and performance configurations. You are billed based on the provisioned size, provisioned IOPS, and provisioned throughput.
