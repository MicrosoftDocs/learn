## Disk performance measures

To choose the right disk type, it's important you understand the performance indicators. Performance is expressed based on the following performance indicators:

- **Input/output operations per second (IOPS)**. IOPS measure the rate at which the disk can complete a mix of read and write operations. Higher performance disks have higher IOPS values.
- **Throughput**. Throughput measures the rate at which data can be moved onto the disk from the host computer and off the disk to the host computer. Throughput is also called _data transfer rate_ and is measured in megabytes per second (MBps). Higher performance disks have higher throughput.
- **Latency**. Latency expresses the time it takes your app to send a request to the disk and get a response. Latency puts a limit on effective IOPS. For example, if your disk can handle 5000 IOPS but each operation takes 10 ms to process, your app will be capped to 100 operations per second due to the processing time. The latency is significantly improved if you enable ReadOnly host caching.

## IOPS vs. throughput

Throughput and IOPS have a direct relationship. Changing one will have a direct impact on the other. To get a theoretical limit of throughput, you can use the formula: IOPS x I/O size = throughput. It&#39;s important to consider both of these values when planning your application.

Now that you know which disks are available in the Azure, you need to match the disk with the right VM.

This is because VMs have their own storage IOPS limits, which combined with the disk IOPS can impact the overall application performance.

## Virtual Machine IO capping

If you don&#39;t size the VM correctly for the storage performance that an application requires, the VM itself become a bottleneck.

For example, suppose that your application makes a request that requires 15 000 IOPS. You have provisioned a Standard\_D8s\_v4 VM, with one P30 OS disk and two premium SSD data disks with P40 SKU. Each data disk can handle 7500 IOPS and eventually can meet the demand of the applications, but the VM itself has a maximum limit of 12800 IOPS, which is the actual IOPS that the application will get. The following figure illustrates this example.

![](RackMultipart20210505-4-dcihql_html_3c598c1975759fdb.png)

The scenario illustrated in the preceding example is known as VM IO Capped, when the application is requesting an amount of throughput and IOPS that the disk can manage, but the VM cannot handle this.

## Disk IO capping

You might come across other situations where the application demands are not satisfied, but this time the bottleneck might be caused from a wrong selection of the performance of the disks.

Continuing the same example where the application has demanded 15000 IOPS from the VM, you have chosen the following setup:

- Standard D16s\_v4 with 25600 IOPS
- P20 OS disk with 2300 IOPS
- Two P30 data disks, each with support of 5000 IOPS.

In this scenario, the application&#39;s demand will be broken down into three different requests:

- 2300 IOPS are requested from the OS disk
- 5000 IOPS are requested from each data disk.

The total IOPS that VM will return to application will be 12 300 as a sum of each IOPS provided by the OS and data disks.

This scenario is known as Disk IO capping, when the disk itself cannot meet the application demands.
