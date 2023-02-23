
Azure NetApp Files is an enterprise-class, high-performance, fully managed NAS service for shared file storage. It's a first-party service, meaning you deploy and manage it through the Azure portal.

## Performance

Azure NetApp Files is designed for the highest possible performance so that it can manage even the most demanding Windows and Linux workloads. This performance is achieved by running Azure NetApp Files instances on dedicated NetApp hardware running NetApp's proprietary ONTAP operating system, which is optimized for extremely high storage throughput and availability.

Azure NetApp Files performance is measured in two ways:

* Input/output operations per second (IOPS). IOPS is a storage-performance benchmark that measures the average number of read and write operations a storage device can perform per second. Azure NetApp Files offers up to 320,000 IOPS on its lowest performance tier, and up to 450,000 IOPS on its highest tiers. By comparison, most solid-state drives (SSDs) have throughput measurements between 100,000 IOPS and 400,000 IOPS.
* Latency. Latency is the time required to access a particular storage location. Azure NetApp Files offers an average latency of less than 1 millisecond (ms). By comparison, regular hard drives have latencies between 1 ms and 10 ms, whereas SSDs have latencies between 0.05 ms and 0.15 ms.

Given these measurements, you can understand why Azure NetApp Files provides performance that is comparable to or even better than on-premises performance.

## Data management

Azure NetApp Files offers a complete range of data-management features such as near-instantaneous snapshots and volume cloning. These features improve data management without affecting performance.

### Instance access

Although Azure NetApp Files instances run on bare-metal NetApp devices, that hardware resides in an Azure datacenter and is configured to be a first-party Azure service that's sold and supported by Microsoft. This means that you can set up an Azure NetApp Files instance in just a few minutes. Also, because Azure NetApp Files is a full Azure service, you can manage your instances the same way you do any other Azure service such as the Azure portal, Azure command-line interface (Azure CLI), Azure PowerShell, or Azure REST API.

### Snapshots

An Azure NetApp Files snapshot is a point-in-time image of a volume. These snapshots have low overhead because of the way Azure NetApp Files performs volume virtualization. Like a database, this layer uses pointers to the actual data blocks on disk. However, unlike a database, it doesn't rewrite existing blocks. It writes updated data to a new block and changes the pointer.

The following diagram illustrates the snapshot process:

1. Time A. A snapshot (Snapshot 1) is created.
1. Time B. Changed data (B is now B1) is written to a new block and the pointer is updated. However, the snapshot pointer still points to the previously written block, giving you both a live view and a historical view of the data.
1. Time C. Another snapshot (Snapshot 2) is created. Now you have access to three generations of data—the live data, Snapshot 2, and Snapshot 1, in descending order of age, without taking up the volume space that three full copies would require.
 
:::image type="content" source="../media/2-what-is-azure-netapp-files-snapshots.png" alt-text="Diagram depicting how Azure NetApp Files snapshots work." lightbox="../media/2-what-is-azure-netapp-files-snapshots.png":::

An Azure NetApp Files snapshot only manipulates block pointers, creating a "frozen," read-only view of a volume. Actual data blocks aren't copied, which leads to two efficiencies:

* Speed. Creating a snapshot is near-instantaneous. No matter what volume size you're working with, creating a snapshot takes only a few seconds.
* Space. A snapshot consumes minimal storage space because it doesn't copy the data blocks of the entire volume. Two snapshots taken in sequence differ only by the blocks added or changed in the time interval between the two.
You can create up to 255 snapshots per volume. Creating a snapshot doesn't impact volume performance. You can create and maintain snapshots in two ways:
* Manual. Create on-demand snapshots by using the Azure portal, Azure CLI, Azure PowerShell, or Azure REST API.
* Automatic. Automate snapshot creation by using snapshot policies or a snapshot tool, such as AzAcSnap. You can set up snapshot policies by using the Azure portal, Azure CLI, Azure PowerShell, or Azure REST API.

## Cross-region replication

Azure NetApp Files replication functionality provides data protection through cross-region volume replication. You can asynchronously replicate data from an Azure NetApp Files volume (source) in one region to another Azure NetApp Files volume (destination) in another region. This capability enables you to failover your critical application if there is a region-wide outage or disasters.

## Data recovery

The point of creating volume snapshots is to recover data that has been corrupted or has been accidentally deleted, overwritten, or modified. Azure NetApp Files gives you three ways to recover data by using snapshots:

* Restore one or more files or directories from a snapshot.
* Restore a snapshot to a new volume. This is called cloning the volume because you're creating an identical copy of the volume in a new location.
* Restore a snapshot in-place. This is called reverting the volume, because it returns the volume to the state it was in when you created the snapshot.

## Azure NetApp Files with Azure VMware Solution

Azure NetApp Files provides enterprise class performance, availability, and data management, making it possible to easily scale your data storage based on shifting business needs. As your storage needs change, you can use Azure NetApp Files to scale storage with your Azure VMware Solution deployment without having to waste Azure VMware Solution CPU and memory costs, leading to lower TCO. Additionally, Azure NetApp Files offloads I/O and memory from Azure VMware solution which can improve Azure VMware Solution performance.
