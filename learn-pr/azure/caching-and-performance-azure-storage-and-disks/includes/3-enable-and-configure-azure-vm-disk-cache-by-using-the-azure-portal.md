We've seen settings and properties you can select to predict your disk performance. Now, let's look at ways to improve that through *caching*.

## Disk caching

A cache is a specialized component that stores data, typically in memory, so that it can be accessed more quickly. The data in a cache is often data that has been read previously, or data that resulted from an earlier calculation. The goal is to access data faster than getting it from the disk.

Caching uses specialized (and sometimes expensive) temporary storage that has faster read and write performance than permanent storage. Because cache storage is often limited, you need to make decisions as to what data operations will benefit most from caching. But even where the cache can be made widely available, such as in Azure, it's still important to know the workload patterns of each disk before deciding which caching type to use.

**Read caching** tries to speed up data *retrieval*. Instead of reading from permanent storage, the data is read from the faster cache. Data reads hit the cache under the following conditions:

- The data has been read before and exists in the cache.
- The cache is large enough to hold all the data.

It's important to note that read caching helps when there is some *predictability* to the read queue, such as a set of sequential reads. For random I/O, where the data you're accessing is scattered across storage, caching will be of little or no benefit, and can even reduce disk performance.

**Write caching** tries to speed up *writing data* to persistent storage. By using a write cache, the app can consider the data to be saved. In reality, the data is queued in a cache, waiting to be written to a disk. As you can imagine, this mechanism can be a potential point of failure, such as when a system shuts down before the cached data is written. Some systems, such as SQL Server, handle writing cached data to persistent disk storage themselves.

### Azure disk caching

There are two types of disk caching that concern disk storage:

- Azure storage caching
- Azure virtual machine (VM) disk caching

Azure storage caching provides cache services for Azure Blob storage, Azure Files, and other content in Azure. Configuration of these types of cache is beyond the scope of this module.

Azure virtual machine disk caching is about optimizing read and write access to the virtual hard disk (VHD) files attached to Azure VMs. We'll focus on disk caching in this module.

Disk caching isn't supported for Ultra Disks or Premium SSD v2, however they benefit from significantly lower latency, which addresses some of the same core problems as disk caching.

### Azure virtual machine disk types

There are three types of disks used with Azure VMs:

- **OS disk**: When you create an Azure VM, Azure automatically attaches a VHD for the operating system (OS).

- **Temporary disk**: When you create an Azure VM, Azure also automatically adds a temporary disk. This disk is used for data, such as page and swap files. The data on this disk may be lost during maintenance or a VM redeploy. Don't use it for storing permanent data, such as database files or transaction logs.

- **Data disks**: A data disk is a VHD that's attached to a virtual machine to store application data or other data you need to keep.

OS disks and data disks take advantage of Azure VM disk caching. The cache size for a VM disk depends on the VM instance size and the number of disks mounted on the VM. You can enable caching for only up to 4 TiB sized disks.

## Cache options for Azure VMs

There are three common options for VM disk caching:

- **Read/write**: Write-back cache. Use this option only if your application properly handles writing cached data to persistent disks when needed.
- **Read-only**: Reads are done from the cache.
- **None**: No cache. Select this option for write-only and write-heavy disks. Log files are a good candidate because they're write-heavy operations.

Not every caching option is available for each type of disk. The following table shows you the caching options for each disk type:

|   | **Read-only** | **Read/write** | **None** |
|---|---|---|---|
| **OS disk** | yes | yes (default) | yes |
| **Data disk** | yes (default) | yes | yes |
| **Temp disk** | no  | no | no |

> [!NOTE]
> You can't change disk caching options for **L-Series** and **B-series** virtual machines.

## Performance considerations for Azure VM disk caching

So, how can your cache settings affect the performance of your workloads running on Azure VMs?

### OS disk

For a VM OS disk, the default behavior is to use the cache in read/write mode. If you have applications that store data files on the OS disk and the apps do lots of random read/write operations to data files, consider moving those files to a data disk that has the caching turned off. Why is that? Well, if the read queue does not contain sequential reads, caching will be of little or no benefit. The overhead of maintaining the cache as if the data was sequential can reduce disk performance.

### Data disks

For performance-sensitive applications, you should use data disks rather than the OS disk. Using separate disks allows you to configure the appropriate cache settings for each one.

For example, on Azure VMs running SQL Server, enabling **Read-only** caching on the data disks (for regular and TempDB data) can result in significant performance improvements. Log files, on the other hand, are good candidates for data disks with no caching.

> [!WARNING]
> Changing the cache setting of an Azure disk detaches and then reattaches the target disk. If it's the operating-system disk, the VM will restart. Stop all applications/services that might be affected by this disruption before changing the disk cache setting.

You can configure virtual machine disk cache settings with any of the following tools:

- Azure portal
- Azure CLI
- Azure PowerShell
- Resource Manager templates

## Use Azure portal to configure caching

When you provision a new VM using the Azure portal, you can't change the default caching configuration for the OS disk from read/write until the VM is deployed.

When you add a data disk to an existing VM, you can configure the cache option before the disk is deployed to the VM.

Next, let's create a VM and change the cache settings using the Azure portal.
