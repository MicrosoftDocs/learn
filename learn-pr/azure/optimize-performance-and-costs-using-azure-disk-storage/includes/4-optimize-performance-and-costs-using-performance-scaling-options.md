By migrating your organization's critical workload to Azure, you can provide a range of infrastructure requirements, like scalable performance, built-in security, durability, and cost optimization.

Many of these infrastructure requirements are directly associated with block storage, which is the foundation of Azure Disk Storage.

The type and size of the disk you select for your critical applications directly affects the applications' performance and can generate higher costs if you don't select the appropriate option.

To help you optimize performance and costs, Azure Disk Storage also offers capabilities that you can use to cost-effectively scale your performance to meet your workloads needs and keep costs under control.

The following sections discussing performance options don't apply to Ultra disks or Premium SSD v2 managed disks. The performance attributes of Ultra disks and Premium SSD v2 managed disks can be independently adjusted as needed, and these disks don't have tiers or bursting.

## Performance tiers for Azure Disk Storage

For Premium SSD managed disks only, you can adjust and balance the IOPS and throughput of your disks by selecting the right performance tier for your needs. To select the right combination, you should be aware of your application requirements. Applications that have high I/O, like database servers or online transactional processing systems, will require higher IOPS.

You might have planned events, like a seasonal promotion or performance testing, during which the application requires higher demands on performance on a temporary basis. To optimize costs, you can change the performance tier on Premium SSD disks without increasing the size of the disks when you need to meet a higher performance demand. For example, your marketing applications are provisioned to use a Premium SSD disk with a P4 performance tier that's limited to 120 IOPS and 25 MBps. Because of a seasonal sale, the interest for your marketing application has increased dramatically, and you want to meet the higher capacity demands on a temporary basis. You can increase the performance tier of your P4 disk to a higher tier, such as P30 with 5,000 IOPS and 200 MBps of throughput. When your marketing campaign is over, you can change the disk tier back to the original P4 tier. During the period when you use a higher performance tier, you'll be charged for the price of that tier. In this example, you'll be charged the price of a P30.

## Change the performance tier on Premium SSD disks while they are in use

You can change the performance tier of a Premium SSD disk without downtime and without dismounting the disk from the VM.

You can change the performance tier of the disk by using the Azure CLI or the Azure portal.

In the Azure CLI, use the following commands to change the disk performance tier:

```azurecli
subscriptionId="yourSubscriptionID"
resourceGroupName="yourResourceGroupName"
diskName="yourDiskName"
performanceTier="yourDesiredPerformanceTier"


az login
az account set --subscription $subscriptionId

az disk update -n $diskName -g $resourceGroupName --set tier=$performanceTier
```

## Azure disk bursting

For unplanned events requiring high performance for a short period of time, you can benefit from the disk bursting capabilities of Azure disks. Disk bursting can improve boot times, manage processing of small-batch jobs, and deal with unexpected traffic spikes.

Azure provides this functionality both for VMs and for disks, and you can use it independently.

### VM bursting

VM bursting supports only the credit-based model for bursting, which doesn't require any configuration. While a VM is used, it accumulates credits when the resource's IOPS or throughput are less than the resource's performance target. You can use these credits to burst performance for up to 30 minutes at the maximum burst rate.

### Disk bursting

Disk Storage has two models of bursting:

- **Credit-based bursting model**. A credit-based model, where the disk will burst only if it has burst credits accumulated in its credit bucket. This model does not incur additional charges when the disk bursts. Credit-based bursting is only available for Premium SSD managed disks 512 GiB and smaller, and standard SSDs 1024 GiB and smaller.
- **On-demand bursting model**. An on-demand bursting model, where the disk bursts whenever its needs exceed its current capacity. This model incurs additional charges anytime the disk bursts. On-demand bursting is only available for Premium SSD managed disks larger than 512 GiB. To configure on-demand bursting, you must detach the disk from the VM.

You can enable on-demand bursting by using Azure PowerShell, the Azure CLI, or an ARM template. You can enable this functionality on new and existing disks.

In Azure PowerShell, use the following command to create an empty data disk with on-demand bursting:

```azurepowershell
Set-AzContext -SubscriptionName "yourSubscriptionName"
$diskConfig = New-AzDiskConfig -Location "WestCentralUS" -CreateOption Empty -DiskSizeGB 1024 -SkuName Premium_LRS -BurstingEnabled $true
$dataDisk = New-AzDisk -ResourceGroupName "myResourceGroupDisk" -DiskName "myDataDisk" -Disk $diskConfig
```

> [!NOTE]
> When you need higher sustained performance in your application, use the functionality to change the performance tier instead of disk bursting. This option is more cost-effective than disk bursting.

## Optimize performance and costs with the optimal option

Now that you understand how different performance indicators define the overall performance of an Azure disk, let's examine some use-case scenarios:

- **Planned versus unplanned performance scaling**: If you have a planned event like a marketing campaign that requires a sustained increase in disk performance, use performance tiers to better accommodate the increased load. However, if you can't plan ahead or can't accurately predict the performance pattern of your workloads, disk bursting would be a better choice because it provides you with a higher allowance beyond your provisioned target.
- **Duration**: For scenarios in which high demand results from short-running jobs or jitters in I/O scheduling, on-demand disk bursting will be more cost-efficient because you pay only for the burst transactions. If your workload doesn't exceed the provisioned target, you pay only for the burst-enablement fee, which is a small fraction of the disk cost. In contrast, if you expect your workload to burst for days or even longer, performance tiers will be the better option.

|&nbsp;              | Credit-based bursting                               | On-demand bursting                                  | Changing performance tier |
| ------------ | --------------------------------------------------- | --------------------------------------------------- | ---------------------------------------------------------------------- |
| Scenario     | Ideal for short-term scaling (30 minutes or less).   | Ideal for short-term scaling (not time restricted).  | Ideal if your workload would otherwise continually be running in burst. |
| Cost         | Free.                                                | Cost is variable. See [Billing](/azure/virtual-machines/disk-bursting#billing) for details.                                                                                      | The cost of each performance tier is fixed. See [Managed Disks pricing](https://azure.microsoft.com/pricing/details/managed-disks/) for details. |
| Availability | Only available for Premium SSD disks and Standard SSD disks 512 GiB and smaller. | Only available for Premium SSD disks larger than 512 GiB. | Available for all Premium SSD disk sizes.     |
| Enablement   | Enabled by default on eligible disks.                | Must be enabled by user.                             | User must manually change the tier.                                  |
