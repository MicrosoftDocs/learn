By migrating your organization's critical workload to Azure, you can provide a range of infrastructure requirements such as scalable performance, built-in security, durability, and cost optimization.

Many of these infrastructure requirements are directly associated with block storage, which is the foundation of Azure Disk Storage.

The type and size of the disk that you select for your critical applications directly impacts the performance and can generate higher costs if you don't select the appropriate option.

To enable you to optimize performance and costs, Azure Disk Storage also offers capabilities that allow you to scale your performance cost-effectively to meet your workloads needs and keep costs under control.

## Performance tiers for Azure Disk Storage

You can adjust and balance the IOPS, throughput, and latency of your Azure disks by selecting the right performance tier for your needs. To select the right combination, you should be aware of your application requirements. High-I/O applications, such as database servers or online transactional processing systems, will require higher IOPS, while more computational-based applications might work well with much lower requirements.

You might have events – like a seasonal promotion or performance testing - where the application requires, on a temporary basis, higher demands on performance. You can change the performance tier on Premium SSDs without increasing the size of the disks when you need to meet a higher performance demand, allowing you to optimize costs. For example, your marketing applications are provisioned to use a Premium SSD disk with a P4 performance tier that's limited to 120 IOPS and 25 MBps. Because of a seasonal sale, the interest for your marketing application has increased dramatically and you want to meet the higher capacity demands on a temporary basis. You can increase the performance tier of your P4 disk to a higher tier, such as P30 with 5,000 IOPS and 200 MBps throughput. When your marketing campaign is over, you can change the disk tier back to the original P4 tier. During the period when you use a higher performance tier, you'll be charged for the price of that tier. In this example, you'll be charged the price of P30.

On Premium SSDs, Azure offers this functionality in preview to a limited number of regions. Azure also currently supports the ability to dynamically change your performance for Ultra Disks without dismounting it from the VM.

## Change the performance tier on Premium SSDs while in use by the VMs

You can change the performance tier of a Premium SSD without downtime and without dismounting it from the VM.

At the time of writing of this content, Azure supports this functionality in preview only in East US2 region and requires that you deploy the VM by using an Azure Resource Manager template with the 2020-12-01 API.

You can change the performance tier of the disk by using the Azure command-line interface (Azure CLI) or the Azure portal.
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

## Azure disk bursting

For unplanned scenarios where you need high performance for a short period of time, you can benefit from the disk bursting capabilities. Disk bursting can improve boot times, manage processing of small-batch jobs, and deal with unexpected traffic spikes.

Azure provides this functionality both for VMs and the disks, and you can use it independently.

### Virtual machine bursting

VM bursting only supports the credit-based model for bursting, which doesn't require any configuration. During the VM usage, it accumulates credits whenever the resource's IOPS or throughputs are less than the resource's performance target. You can use these credits to burst performance for up to 30 minutes at the maximum burst rate.

### Disk bursting

Azure Premium SSDs offer two models of bursting:

- Credit-based bursting model. You can use this model for short-term performance scaling. This model is free and enabled by default on Premium SSDs 512 GiB disks and smaller and Standard SSDs 1TiB disks and smaller. It uses accumulated credit to burst up to 30 minutes at the maximum burst rate.
- On-demand bursting model (currently in preview). This is configurable bursting for Premium SSDs larger than 512 GiB and comes with an additional cost. To configure on-demand bursting, you must detach the disk from the VM.

You can enable on-demand bursting by using PowerShell, Azure CLI, or Azure Resource Manager templates. You can enable this functionality on new and existing disks.

Use the following command to create an empty data disk with on-demand bursting:

PowerShell

```powershell
Set-AzContext -SubscriptionName "yourSubscriptionName"
$diskConfig = New-AzDiskConfig -Location "WestCentralUS" -CreateOption Empty -DiskSizeGB 1024 -SkuName Premium_LRS -BurstingEnabled $true
$dataDisk = New-AzDisk -ResourceGroupName "myResourceGroupDisk" -DiskName "myDataDisk" -Disk $diskConfig
```

> [!Note]
> For applications where you need higher sustained performance, use the functionality to change the performance tier instead of disk bursting. This option is more cost effective than disk bursting.


## Optimize performance and costs with the most optimal option 

Now that you understand how different performance indicators define the overall performance of the disk, let's examine some use case scenarios.

- Planned versus unplanned performance scaling: If you have a planned event needing a sustained increase in disk performance, such as in your case a marketing campaign, use performance tiers to better accommodate the increased load. However, if you are unable to plan ahead or accurately predict the performance pattern of your workloads, disk bursting would be a better choice as it provides you with a higher allowance beyond your provisioned target.
- Duration: For scenarios where high demand results from short-running jobs or jitters in IO scheduling, on-demand disk bursting will be more cost-efficient as you will only pay for the burst transactions. If your workload does not exceed the provisioned target, you only pay for the burst enablement fee, which is a small fraction of the disk cost. In contrast, if you expect your workload to burst for days or even longer, performance tiers will be the better option. 

|              | Credit-based bursting                               | On-demand bursting                                  | Changing performance tier |
| ------------ | --------------------------------------------------- | --------------------------------------------------- | ---------------------------------------------------------------------- |
| Scenario     | Ideal for short-term scaling (30 minutes or less)   | Ideal for short-term scaling (Not time restricted)  | Ideal if your workload would otherwise continually be running in burst |
| Cost         | Free                                                | Cost is variable, see the [Billing](https://docs.microsoft.com/azure/virtual-machines/disk-bursting#billing) section for details                                                                                      | The cost of each performance tier is fixed, see [Managed Disks pricing](https://azure.microsoft.com/pricing/details/managed-disks/) for details |
| Availability | Only available for premium and standard SSDs 512 GiB and smaller | Only available for premium SSDs larger than 512 GiB | Available to all premium SSD sizes     |
| Enablement   | Enabled by default on eligible disks                | Must be enabled by user                             | User must manually change their tier                                  |
