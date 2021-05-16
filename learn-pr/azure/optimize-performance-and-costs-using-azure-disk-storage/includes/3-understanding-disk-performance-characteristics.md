Application performance often depends on how quickly it can read and write data. To understand how to improve application performance, you first must understand how performance is measured and the settings and choices that affect it.

## Disk performance measures

To choose the right disk type, it's important that you understand the performance indicators. The following indicators express performance:
<!--LM: IOPS is already spelled out in unit 2 so the acronym is ok here, unless you think it helps clarify the concept.-->
- Input/output operations per second (IOPS). IOPS measure the rate at which the disk can complete a mix of read and write operations. IOPS directly affects your application performance. Some applications, such as retail websites, need high IOPS to manage all the small and random I/O requests that must be processed quickly to keep the site responsive. Higher performance disks have higher IOPS values.
- Throughput. Throughput measures the rate at which data can be moved onto the disk from the host computer and off the disk to the host computer. Throughput is also called *data transfer rate* and is measured in megabytes per second (mbps). If your application is performing I/O with large blocks of data, it requires high throughput. Higher performance disks have higher throughput.
- Latency. Latency expresses the time it takes your app to send a request to the disk and receive a response. Latency puts a limit on effective IOPS. For example, if your disk can handle 5,000 IOPS but each operation takes 10 ms to process, your app will be capped to 100 operations per second because of the processing time. The latency is significantly improved if you enable ReadOnly host caching.
<!--LM: Use "handle" with caution for sensory language. If it makes sense to replace it (e.g., manage), please replace all instance.-->
## IOPS vs. throughput

Throughput and IOPS have a direct relationship. Changing one will have a direct impact on the other. To get a theoretical limit of throughput, you can use the following formula: IOPS x I/O size = throughput. It's important to consider both of these values when planning your application.

Now that you know which disks are available in Azure, you need to match the disk with the correct VM. VMs have their own storage IOPS limits, which can impact the overall application performance when combined with the disk IOPS.
<!--LM: Please note the change to lowercase "machine" in the following heading.-->
## Virtual machine IO capping

If you don't size the VM correctly for the storage performance that an application requires, the VM itself becomes a bottleneck.

For example, suppose that your application makes a request that requires 15,000 IOPS. You've provisioned a Standard_D8s_v3 VM, with one P30 OS disk and two premium SSD data disks with P40 SKU. Each data disk can handle 7,500 IOPS and eventually can meet the demand of the applications, but the VM itself has a maximum limit of 12,800 IOPS, which is the actual IOPS that the application will get. The following figure illustrates this example.
<!--LM: The figure will need descriptive alt text. For example, "The diagram depicts VM IO capping..."-->
:::image type="content" source="../media/03-vm-io-capping.PNG" alt-text="Diagram_for_VM-IO-capping." border="true":::

The scenario illustrated in the preceding example is known as VM IO Capped. In this scenario, the application is requesting an amount of throughput and IOPS that the disk can manage, but the VM can't accommodate these requirements.
<!--LM: Please replace "due to" with another appropriate phrase. "Because of" works too.-->
You can diagnose the performance issues caused by VM IO capping by using the following metrics:

- VM Cached IOPS Consumed Percentage
- VM Cached Bandwidth Consumed Percentage
- VM Uncached IOPS Consumed Percentage
- VM Uncached Bandwidth Consumed Percentage

## Disk IO capping

You might come across other situations where the storage solution doesn't meet the application demands. However, the bottleneck might be caused if an incorrect performance tier of the disks is selected.
<!--LM: Active voice would be even better but it might change the meaning "if you select the incorrect performance tier...-->
Consider the same example where the application requires 15,000 IOPS from the VM, and you've chosen the following setup:

- Standard D16s_v4 with 25,600 IOPS
- P20 OS disk with 2,300 IOPS
- Two P30 data disks, each with support of 5,000 IOPS

In this scenario, the application's demand will be divided into three different requests:
<!--LM: This is confusing with 2 bullet points but "three different requests"-->
- 2,300 IOPS are requested from the OS disk
- 5,000 IOPS are requested from each data disk

The total IOPS that VM will return to the application will be 12,300 as a sum of each IOPS provided by the OS and data disks.

This scenario is known as *disk IO capping*, when the disk itself can't meet the application demands.
<!--LM: The image will need descriptive alt text.-->
:::image type="content" source="../media/03-disk-io-capping.PNG" alt-text="Diagram_for_Disk-IO-capping." border="true":::

To diagnose disk IO capping, use the following metrics:

- Data Disk IOPS Consumed Percentage
- Data Disk Bandwidth Consumed Percentage
- OS Disk IOPS Consumed Percentage
- OS Disk Bandwidth Consumed Percentage

## Disk caching

A cache is a specialized component that stores data, typically in memory, so that the application can access the data more quickly. The data in a cache is often data that has been read previously or data that resulted from a previous calculation. The goal is that applications access data faster from the cache than from the disk.

Caching uses specialized, and sometimes expensive, temporary storage that has faster read and write performance compared to permanent storage. Because cache storage is often limited, you might need to decide which data operations will benefit most from caching. But even where the cache can be made widely available, such as in Azure, it's still important to know the workload patterns of each disk before deciding which caching type to use.

*Read caching* tries to speed up data *retrieval*. Instead of reading from permanent storage, the application reads the data from the faster cache.

It's important to note that read caching helps when there is some *predictability* to the read queue, such as a set of sequential reads. For random I/O, where the data you're accessing is scattered across storage, caching will be of little or no benefit and can even reduce disk performance.

*Write caching* tries to speed up *writing data* to persistent storage. By using a write cache, the app can consider the data to be saved.

In reality, the data is queued in a cache, waiting to be written to a disk. As you can imagine, this mechanism can be a potential point of failure, such as when a system shuts down before the cached data is written. Some systems, such as SQL Server, manage the task of writing cached data to persistent disk storage themselves.

## Cached and uncached limits of VMs

Now that you understand how caching can improve the performance for reading or writing on the disk, you should be aware of how caching affects VM performance.

The performance of the VM depends on the IOPS and throughput limits that are imposed based on the size of the VM. All VMs in the premium tier have different limits for IOPS and throughput based on cached and uncached configurations. You can improve the performance of the VM to meet the higher demand for IOPS and throughput by enabling VM host caching.

The following table lists examples that illustrate the difference in performance for cached and uncached disk throughput and bandwidth.

| VM size name |  Max cached and temp storage throughput: IOPS/mbps (cache size in GiB) | Max uncached disk throughput IOPS/mbps |
| --- | --- | --- |
| Standard_D2s_v3 | 4,000/32 (50) | 3,200/48 |
| Standard_D4s_v3 | 8,000/64 (100) | 6,400/96 |
| Standard_D8s_v3 | 16,000/128 (200) | 12,800/192 |
| Standard_D64s_v3 | 128,000/1024 (1600) | 80,000/1,200 |

Host caching can help you avoid VM bottleneck scenarios.
In the previous example of VM IO capping, the application required 15,000 IOPS. Both data disks can handle that demand, but the Standard_D8s_v3 VM can only offer 12,800 IOPS in the uncached state.
If you configure host caching on the Standard_D8s_v3 VM, you can get 16,000 cached IOPS, which is more than what the application demands.
