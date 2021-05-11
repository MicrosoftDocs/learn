Application performance often depends on how quickly it can read and write data. In order to understand how to improve that performance, you first have to understand how performance is measured and the settings and choices that affect it.

## Disk performance measures

To choose the right disk type, it's important you understand the performance indicators. Performance is expressed based on the following performance indicators:

- **Input/output operations per second (IOPS)**. IOPS measure the rate at which the disk can complete a mix of read and write operations. IOPS directly affects your application performance. Some applications, such as retail websites, need high IOPS to handle all the small and random I/O requests that must be processed quickly to keep the site responsive. Higher performance disks have higher IOPS values.
- **Throughput**. Throughput measures the rate at which data can be moved onto the disk from the host computer and off the disk to the host computer. Throughput is also called _data transfer rate_ and is measured in megabytes per second (MBps). If your application is performing I/O with large blocks of data, it requires high throughput. Higher performance disks have higher throughput.
- **Latency**. Latency expresses the time it takes your app to send a request to the disk and get a response. Latency puts a limit on effective IOPS. For example, if your disk can handle 5000 IOPS but each operation takes 10 ms to process, your app will be capped to 100 operations per second due to the processing time. The latency is significantly improved if you enable ReadOnly host caching.

## IOPS vs. throughput

Throughput and IOPS have a direct relationship. Changing one will have a direct impact on the other. To get a theoretical limit of throughput, you can use the formula: IOPS x I/O size = throughput. It's important to consider both of these values when planning your application.

Now that you know which disks are available in the Azure, you need to match the disk with the right VM.

This is because VMs have their own storage IOPS limits, which combined with the disk IOPS can impact the overall application performance.

## Virtual Machine IO capping

If you don't size the VM correctly for the storage performance that an application requires, the VM itself become a bottleneck.

For example, suppose that your application makes a request that requires 15 000 IOPS. You have provisioned a Standard_D8s_v3 VM, with one P30 OS disk and two premium SSD data disks with P40 SKU. Each data disk can handle 7500 IOPS and eventually can meet the demand of the applications, but the VM itself has a maximum limit of 12800 IOPS, which is the actual IOPS that the application will get. The following figure illustrates this example.

![](RackMultipart20210505-4-dcihql_html_3c598c1975759fdb.png)

The scenario illustrated in the preceding example is known as VM IO Capped. In this scenario, the application is requesting an amount of throughput and IOPS that the disk can manage, but the VM cannot accomodate these requirements.

You can diagnose the performance issues due to VM IO capping by using the following metrics:

- VM Cached IOPS Consumed Percentage
- VM Cached Bandwidth Consumed Percentage
- VM Uncached IOPS Consumed Percentage
- VM Uncached Bandwidth Consumed Percentage

## Disk IO capping

You might come across other situations where the storage solution does not meet the application demands. However, this time the bottleneck might be caused because of the selection of an incorrect performance tier of the disks.

Consider the same example where the application requires 15000 IOPS from the VM, and you have chosen the following setup:

- Standard D16s_v4 with 25600 IOPS
- P20 OS disk with 2300 IOPS
- Two P30 data disks, each with support of 5000 IOPS.

In this scenario, the application's demand will be broken down into three different requests:

- 2300 IOPS are requested from the OS disk
- 5000 IOPS are requested from each data disk.

The total IOPS that VM will return to application will be 12 300 as a sum of each IOPS provided by the OS and data disks.

This scenario is known as *disk IO capping*, when the disk itself cannot meet the application demands.

To diagnose disk IO capping, use the following metrics:

- Data Disk IOPS Consumed Percentage
- Data Disk Bandwidth Consumed Percentage
- OS Disk IOPS Consumed Percentage
- OS Disk Bandwidth Consumed Percentage

## Disk caching

A cache is a specialized component that stores data, typically in memory, so that the application can access the data more quickly. The data in a cache is often data that has been read previously or data that resulted from an earlier calculation. The goal is that applications access data faster than getting it from the disk.

Caching uses specialized, and sometimes expensive, temporary storage that has faster read and write performance compared to permanent storage. Because cache storage is often limited, you might need to decide which data operations will benefit most from caching. But even where the cache can be made widely available, such as in Azure, it's still important to know the workload patterns of each disk before deciding which caching type to use.

**Read caching** tries to speed up data *retrieval*. Instead of reading from permanent storage, the application reads the data from the faster cache.

It's important to note that read caching helps when there is some _predictability_ to the read queue, such as a set of sequential reads. For random I/O, where the data you're accessing is scattered across storage, caching will be of little or no benefit and can even reduce disk performance.

**Write caching**  tries to speed up *writing data* to persistent storage. By using a write cache, the app can consider the data to be saved.

In reality, the data is queued in a cache, waiting to be written to a disk. As you can imagine, this mechanism can be a potential point of failure, such as when a system shuts down before the cached data is written. Some systems, such as SQL Server, manage the task of writing cached data to persistent disk storage themselves.

## Cached and uncached limits of VMs

Now that you understand how caching can improve the performance for reading or writing on the disk, you should be aware of how caching affects VM performance.

The performance of the VM, depends on the IOPS and throughput limits that are imposed based on the size of the VM. All VMs in the premium tier have different limits for IOPS and throughput based on cached and uncached configurations. You can improve the performance of the VM to meet the higher demand for IOPS and throughput by enabling VM host caching.

The following table lists examples that illustrate the difference in performance for cached and uncached disk throughput and bandwith:

| VM size name |  Max cached and temp storage throughput: IOPS/MBps (cache size in GiB) | Max uncached disk throughput IOPS/MBps |
| --- | --- | --- |
| Standard_D2s_v3 | 4000/32 (50) | 3200/48 |
| Standard_D4s_v3 | 8000/64 (100) | 6400/96 |
| Standard_D8s_v3 | 16000/128 (200) | 12800/192 |
| Standard_D64s_v3 | 128000/1024 (1600) | 80000/1200 | <!--Marjan, please check if there is an extra zero in 128000/1024 (1600)-->

Host caching can help you avoid VM bottlneck scenarios.
In the earlier example of VM IO capping, the application required 15000 IOPS. Both data disks can handle that demand, but the Standard_D8s_v3 VM can only offer 12800 IOPS in the uncached state.
If you configure host caching on the Standard_D8s_v3 VM, you can get 16000 cached IOPS, which is more than what the application demands.
