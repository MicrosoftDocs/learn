The main goal of your organization is to migrate their critical workload in Azure, which require that you provide range of infrastructure requirements such as scalable performance, built in security, durability, and cost optimization.

Many of these infrastructure requirements are tied directly with the block storage, which is foundation of Azure managed disk.

The type and size of the disk that you select for your critical applications directly impact the performance and can generate higher cost if is not selected appropriately.

## Performance tiers for managed disks

You can adjust and balance the IOPS, throughput, and latency of your Azure disks by selecting the right performance tier. Selecting the right combination involves understanding what your application requirements are. High-I/O applications, such as database servers or online transactional processing systems will require higher IOPS, whereas more computational based applications might get by with much lower requirements.

You might also have applications that require on a temporary basis&#39;s higher demands on performance, without increasing the capacity of the disks.

You can change the performance tier on a Premium SSD when you need to meet higher performance demand.

For example, your marketing applications is provision to use Premium SSD disk with P4 performance tier that is limited to 120 IOPS and 25 MBps. Due the outgoing campaign, the interest for your marketing application has increased dramatically and you want to meet that higher capacity demands on a temporary basis. You can increase the performance tier of your P4 disk to higher tier for example P30 with 5000 IOPS and 200 MBps throughput. When your marketing campaign is over, you can change the disk tier back to original P4 tier. During the period when you use higher performance tier, you will be charged for the price of that tier, so in this example for the price of P30.

Changing the performance tier is currently supported only for Premium SSD disks and requires that the disk is dismounted when you perform the resizing operation.

## Change the performance tier without downtime on Premium Disks

You can also benefit from functionality to change the Premium SSD disk without downtime and without dismounting from the VM.

This functionality at the time of writing of this article is supported only in East US2 region and require that the VM is deployed using ARM template with 2020-12-01 API.

You can change the performance tier of the disk using PowerShell Azure CLI or Portal.

Use the following steps to change the disk performance tier:

Azure CLI

```bash
subscriptionId=\&lt;yourSubscriptionID\&gt;
resourceGroupName=\&lt;yourResourceGroupName\&gt;
diskName=\&lt;yourDiskName\&gt;
diskSize=\&lt;yourDiskSize\&gt;
performanceTier=\&lt;yourDesiredPerformanceTier\&gt;
region=EastUS2EUAP

az login
az account set --subscription $subscriptionId
az group deployment create -g $resourceGroupName \
--template-uri "https://raw.githubusercontent.com/Azure/azure-managed-disks-performance-tiers/main/CreateUpdateDataDiskWithTier.json" \
--parameters "region=$region" "diskName=$diskName" "performanceTier=$performanceTier" "dataDiskSizeInGb=$diskSize"
```

## Disk caching

A cache is a specialized component that stores data, typically in memory so that it can be accessed more quickly. The data in a cache is often data that has been read previously or data that resulted from an earlier calculation. The goal is to access data faster than getting it from the disk.

Caching uses specialized, and sometimes expensive, temporary storage that has faster read and write performance than permanent storage. Because cache storage is often limited, decisions need to be made as to what data operations will benefit most from caching. But even where the cache can be made widely available, such as in Azure, it&#39;s still important to know the workload patterns of each disk before deciding which caching type to use.

**Read caching**  tries to speed up data _retrieval_. Instead of reading from permanent storage, the data is read from the faster cache.

It&#39;s important to note that read caching helps when there is some _predictability_ to the read queue, such as a set of sequential reads. For random I/O, where the data you&#39;re accessing is scattered across storage, caching will be of little or no benefit and can even reduce disk performance.

**Write caching**  tries to speed up _writing data_ to persistent storage. By using a write cache, the app can consider the data to be saved.

In reality, the data is queued in a cache, waiting to be written to a disk. As you can imagine, this mechanism can be a potential point of failure, such as when a system shuts down before the cached data is written. Some systems, such as SQL Server, handle writing cached data to persistent disk storage themselves.

## Optimize for performance

Now that you understand how different performance indicators define the overall performance of the managed disk, lets examine some use case scenarios.

Suppose that you have a high demanding application that require instant response with very low latency.
The first step is to choose the right VM size that will provide high disk throughput. You can use Lsv2-series VMs that provide high throughput, low latency and support for multithreading. As general guides you should choose VM that offers IOPS greater than the application need.
Second, choose a disk that offers IOPS greater than your application requirement and has a scale limits that can meets highest peak demands of the application requirements.
Third, combine the performance of the VM and the disk, by ensuring that the IOPS limit of the VM size should be greater than total IOPS driven by storage disks attached to it.
You can improve the performance of the application if you choose multiple disk and stripe them together to get a combined higher IOPS and throughput limit. The striping on Windows is supported using Storage Space functionality, and on Linux using MDADM.
The stripe size can be tuned regarding the nature of the application. Smaller stripe size provides better performance for applications that use random small IO patters. Use larger stripe size for sequential large IO pattern, commonly used in Data Warehouse applications.
Applications that use multi-threading improve the IOPS and throughput limits. A multi-thread application benefit of multiple parallel jobs that can be handled by multi CPU and multi-core VMs.

>[Note!]
> Keep in mind that you cannot modify the nature how the application implements single threading or multi-threading. But you can still tune how multi-threading is altering the performance of the application, by for example configuring maximum number of processors can be used for parallel processing.

## Azure disk bursting

For unplanned scenarios where you need high performance for short period of time you can benefit from the disk bursting capabilities. Disk bursting can improve boot times, handle processing of small batch jobs, or deal with unexpected traffic spikes.

This functionality is available both for VMs and the disks and can be used independently.

### Virtual-machine-level bursting

The VM-level bursting only support credit-based model for bursting, that does not require any configuration. During the usage of the VM, it accumulates credits whenever the resource&#39;s IOPS or throughputs are being utilized below the resource&#39;s performance target. You can use these credits to burst performance for up to 30 minutes at the maximum burst rate.

### Disk-level bursting

Azure Premium SSD disk offer two models of bursting:

- **Credit-based bursting model.** You can use this model for short-term scaling for free and is enabled for defaults on Premium SSD 512 GiB disk and smaller. It used accumulated credit to burst up to 30 minutes at the maximum burst rate.
- **On-demand bursting model.** This is configurable bursting for Premium disk larger than 512 GiB and comes with additional cost. To configure on-demand bursting the disk has to be detached from a VM.

You can enable on-demand bursting with either PowerShell, Azure CLI, or ARM templates. The functionality can be enabled both on new and existing disks.

Use the following command to create an empty data disk with on-demand bursting:

PowerSehll

```powershell
Set-AzContext -SubscriptionName \&lt;yourSubscriptionName\&gt;
$diskConfig = New-AzDiskConfig -Location &#39;WestCentralUS&#39; -CreateOption Empty -DiskSizeGB 1024 -SkuName Premium\_LRS -BurstingEnabled $true
$dataDisk = New-AzDisk -ResourceGroupName \&lt;myResourceGroupDisk\&gt; -DiskName \&lt;myDataDisk\&gt; -Disk $diskConfig
```

>[Note!]: 
> For applications that frequently run beyond the provisioned performance target, use the functionality to change the performance tier instead on-demand bursting. This option is more cost effective than on-demand disk bursting.
