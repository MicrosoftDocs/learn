By migrating your organization's critical workload to Azure, you'll be able to provide a range of infrastructure requirements such as scalable performance, built-in security, durability, and cost optimization.

Many of these infrastructure requirements are directly associated with block storage, which is the foundation of Azure managed disks.

The type and size of the disk that you select for your critical applications directly impacts the performance and can generate higher costs if you do not select the appropriate option. 

## Performance tiers for managed disks

You can adjust and balance the IOPS, throughput, and latency of your Azure disks by selecting the right performance tier. To select the right combination, you should be aware of your application requirements. High-I/O applications, such as database servers or online transactional processing systems, will require higher IOPS, whereas more computational-based applications might work well with much lower requirements.

You might also have applications that require, on a temporary basis's, higher demands on performance, without increasing the capacity of the disks.

You can change the performance tier on ultra and premium SSD disks when you need to meet a higher performance demand.
For example, your marketing applications are provisioned to use a Premium SSD disk with a P4 performance tier that is limited to 120 IOPS and 25 MBps. Because of the outgoing marketing campaign, the interest for your marketing application has increased dramatically and you want to meet the higher capacity demands on a temporary basis. You can increase the performance tier of your P4 disk to an higher tier, such as P30 with 5000 IOPS and 200 MBps throughput. When your marketing campaign is over, you can change the disk tier back to the original P4 tier. During the period when you use a higher performance tier, you will be charged for the price of that tier. In this example, you will be charged the price of P30.

Azure currently support modifications to the performance tier for ultra disks without dismounting it from the VM. For premium SSD disks this functionality is offered in preview in limited number of regions.

## Change the performance tier on premium disks while in use by the VMs

You can change the performance tier of a premium SSD without downtime and without dismounting from the VM.

At the time of writing of this content, Azure supports this functionality only in East US2 region and requires that you deploy the VM by using an Azure Resource Manager template with the 2020-12-01 API.

You can change the performance tier of the disk by using the PowerShell Azure command-line interface (Azure CLI) or the Azure portal. 

Use the following commands to change the disk performance tier:

Azure CLI

```bash
subscriptionId="yourSubscriptionID"
resourceGroupName="yourResourceGroupName"
diskName="yourDiskName"
diskSize="yourDiskSize"
performanceTier="yourDesiredPerformanceTier"
region=EastUS2EUAP

az login
az account set --subscription $subscriptionId
az group deployment create -g $resourceGroupName \
--template-uri "https://raw.githubusercontent.com/Azure/azure-managed-disks-performance-tiers/main/CreateUpdateDataDiskWithTier.json" \
--parameters "region=$region" "diskName=$diskName" "performanceTier=$performanceTier" "dataDiskSizeInGb=$diskSize"
```

## Optimize for performance

Now that you understand how different performance indicators define the overall performance of the managed disk, let's examine some use case scenarios.
Suppose that you have a high-demanding application that requires an instant response with very low latency.

As the first step, you must choose the right VM size that will provide high-disk throughput. You can use the Lsv2-series VMs that provide high throughput, low latency, and support for multithreading. As a general guide, you should choose a VM that offers greater IOPS than what the application needs.

Second, choose a disk that offers an IOPS greater than your application's requirement and has a scale limit that can meet the highest estimated peak demands of the application.

Third, combine the performance of the VM and the disk by ensuring that the IOPS limit of the VM size is greater than the total IOPS driven by the storage disks attached to it. 

Understand the application demands by measuring the performance requirements during normal, peak, and off-hours workload periods. Depends on the operating system you can use PerfMon tool on Windows and iostat on Linux, to capture importan counters that indicate the performance of the application.

| **Counter** | **Description** | **PerfMon** | **Iostat** |
| --- | --- | --- | --- |
| **IOPS or Transactions per second** | Number of I/O requests issued to the storage disk per second. | Disk Reads/sec
 Disk Writes/sec | tps
 r/s
 w/s |
| **Disk Reads and Writes** | % of Reads and Write operations performed on the disk. | % Disk Read Time % Disk Write Time | r/s w/s |
| **Throughput** | Amount of data read from or written to the disk per second. | Disk Read Bytes/sec Disk Write Bytes/sec | kB\_read/s kB\_wrtn/s |
| **Latency** | Total time to complete a disk IO request. | Average Disk sec/Read Average disk sec/Write | await svctm |
| **IO size** | The size of I/O requests issues to the storage disks. | Average Disk Bytes/Read  Average Disk Bytes/Write | avgrq-sz |
| **Queue Depth** | Number of outstanding I/O requests waiting to be read from or written to the storage disk. | Current Disk Queue Length | avgqu-sz |
| **Max. Memory** | Amount of memory required to run application smoothly | % Committed Bytes in Use | Use vmstat |
| **Max. CPU** | Amount CPU required to run application smoothly | % Processor time | %util |

### Disk striping
You can improve the performance of the application if you choose multiple disks and stripe them together to get a combined higher IOPS and throughput limit. You can implement the striping on Windows by using the Storage Spaces functionality, and on Linux by using Multiple Disk and Device Management (MDADM).

You can modify the stripe size based on the application type and reuirements. A smaller stripe size provides better performance for applications that use random small IO patterns. Use a larger stripe size for sequential large IO pattern, commonly used in data warehouse applications.

### Multi-threading

Applications that use multi-threading improve the IOPS and throughput limits. A multi-thread application provides the benefit of multiple parallel jobs that multi CPU and multi-core VMs can handle.

> [!Note]
> Remember that you cannot modify how the application implements single threading or multi-threading. But you can still tune how multi-threading alters the performance of the application. For example, you can configure the maximum number of processors that the application uses for parallel processing.

## Azure disk bursting

For unplanned scenarios where you need high performance for a short period of time, you can benefit from the disk bursting capabilities. Disk bursting can improve boot times, manage processing of small-batch jobs, and deal with unexpected traffic spikes.

Azure provides this functionality both for VMs and the disks, you can use it independently.

### Virtual-machine-level bursting

VM-level bursting only supports the credit-based model for bursting, which does not require any configuration. During the VM usage, it accumulates credits whenever the resource&#39;s IOPS or throughputs are being utilized below the resource&#39;s performance target. You can use these credits to burst performance for up to 30 minutes at the maximum burst rate.

### Disk-level bursting

Azure Premium SSD disks offer two models of bursting:

- **Credit-based bursting model.** You can use this model for short-term scaling. This model is free and enabled by default on Premium SSD 512 GiB disks and smaller. It uses accumulated credit to burst up to 30 minutes at the maximum burst rate.
- **On-demand bursting model.** This is configurable bursting for Premium disks larger than 512 GiB and comes with additional cost. To configure on-demand bursting, you must detach the disk from the VM.

You can enable on-demand bursting with either PowerShell, Azure CLI, or Azure Resource Manager templates. You can enable The functionality both on new and existing disks.

Use the following command to create an empty data disk with on-demand bursting:

PowerSehll

```powershell
Set-AzContext -SubscriptionName "yourSubscriptionName"
$diskConfig = New-AzDiskConfig -Location "WestCentralUS" -CreateOption Empty -DiskSizeGB 1024 -SkuName Premium_LRS -BurstingEnabled $true
$dataDisk = New-AzDisk -ResourceGroupName "myResourceGroupDisk" -DiskName "myDataDisk" -Disk $diskConfig
```

> [!Note]:
> For applications that frequently run beyond the provisioned performance target, use the functionality to change the performance tier instead on-demand bursting. This option is more cost effective than on-demand disk bursting.
