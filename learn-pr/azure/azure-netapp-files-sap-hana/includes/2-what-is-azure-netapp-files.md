Azure NetApp Files is an enterprise-class, high-performance, fully managed, first-party NAS service for shared file storage, deployed and managed through the Azure portal.

## Performance

Azure NetApp Files is designed to meet the highest possible performance requirements so that it can manage even the most demanding Windows and Linux workloads. This performance is achieved by running Azure NetApp Files on dedicated bare metal fleets running NetApp's proprietary ONTAP operating system, which is optimized for extremely high storage throughput and availability.

Azure NetApp Files performance is measured in two ways:

- Input/output operations per second (IOPS). IOPS is a storage-performance benchmark that measures the average number of read and write operations a storage volume can perform per second. Azure NetApp Files volumes offer up to 320,000 IOPS on its lowest performance tier and up to 450,000 IOPS on its highest tiers. This translates to up to 4.500 MiB/s throughput per provisioned volume, depending on volume size and service level.
- Latency. Latency is the time required to access a particular storage location. Azure NetApp Files offers an average latency of less than 1 millisecond. Maintaining low storage latency is key to successful deployments of SAP HANA. To optimize VM and volume placement in the Azure infrastructure, you can use application volume group.

Given the strict performance requirements of SAP HANA, it's vital to deploy VMs and storage resources in close proximity to each other in the Azure infrastructure. Application volume group for SAP HANA provides functionality to streamline the deployment of Azure NetApp Files volumes in a single atomic operation while ensuring volumes are placed in optimal locations for the best possible results.

## Data management

Azure NetApp Files offers a complete range of data management features such as near-instantaneous snapshots for primary data protection and instant data recovery, volume cloning for frequent copies of production data for test/dev purposes, storage-based data replication to another zone or region and backup integration for application-consistent data protection. These features improve data management without impacting storage and application performance.  

Volume size and performance can be adjusted on the fly (i.e. without service interruption) to allow you to dynamically optimize cost to the changing application demands.

### Volume access

Azure NetApp Files runs on bare metal fleet in Azure datacenters and is a first-party Azure service sold and supported by Microsoft. This means that you can set up an Azure NetApp Files volume in just a few minutes. Also, because Azure NetApp Files is a full Azure service, you can manage your volume the same way you do any other Azure service such as the Azure portal, Azure command-line interface (Azure CLI), Azure PowerShell, or Azure REST API.

### Snapshots

Azure NetApp Files snapshots are point-in-time images of a volume. These snapshots have low overhead because of the way Azure NetApp Files performs volume virtualization. Snapshots utilize pointer manipulation to the actual data blocks on disk. However, unlike a database, it doesn't rewrite existing blocks. New blocks are written to unused locations in the system. Pointers are updated to reflect the changes while snapshots maintain point-in-time representations of the data present in the system at the time the snapshots were taken.

The following diagram illustrates the snapshot process:

1. A snapshot (`Snapshot1`) is created.

   [![Diagram showing snapshot creation.](../media/2-single-file-snapshot-restore-one.png)](../media/2-single-file-snapshot-restore-one.png#lightbox)

2. Changed data (`file2` is updated and `file4` is added) is written to a new block; the pointer is updated. The snapshot pointer still points to the previously written block, giving you both a live view and a historical view of the data.

   [![Diagram showing two file changes.](../media/2-single-file-snapshot-restore-two.png)](../media/2-single-file-snapshot-restore-two.png#lightbox)

3. Another snapshot (`Snapshot2`) is created, providing access to three generations of data: the live data, `Snapshot2`, and `Snapshot1`. The snapshots are presented in descending order of age without taking up the volume space that three full copies require.

   [![Diagram showing changes captured with Snapshot2.](../media/2-single-file-snapshot-restore-three.png)](../media/2-single-file-snapshot-restore-three.png#lightbox)

An Azure NetApp Files snapshot only manipulates block pointers, creating a "frozen," read-only view of a volume. By design snapshots cannot be modified, only deleted once they expire useful life on the system.

Actual data blocks aren't copied, which leads to two efficiencies:

- **Speed**: Creating a snapshot is near-instantaneous. No matter the volume size, creating a snapshot takes only a few seconds. Reverting a volume to a snapshot is also near-instantaneous, supporting fast data recovery in case of a corruption or malicious hijack event.
- **Space**: A snapshot consumes minimal storage space because it doesn't copy the data blocks of the entire volume. Two snapshots taken in sequence differ only by the blocks added or changed in the time interval between the two.
You can create up to 255 snapshots per volume. Creating a snapshot doesn't impact volume performance. You can create and maintain snapshots in two ways:
- **Manual**: Create on-demand snapshots by using the Azure portal, Azure CLI, Azure PowerShell, or Azure REST API.
- **Automatic**: Automated snapshot creation. You can set up snapshot policies by using the Azure portal, Azure CLI, Azure PowerShell, or Azure REST API.

### Cross-region replication

Azure NetApp Files replication functionality provides data protection through cross-region volume replication. You can asynchronously replicate data from an Azure NetApp Files volume (source) in one region to another Azure NetApp Files volume (destination) in another region. This capability enables you to failover your critical application in the event of a region-wide outage or disasters and utilize the remote location for cloning the replicated data for up-to-date test/dev processing.

### Cross-zone replication

Azure NetApp Files also supports replication to another zone in the same region, which can be utilized to protect against zonal outages. No VMs need to be running at the destination location during normal operation. Only if an outage occurs do the destination volumes need to be mounted to VMs in the destination zone for swift service restoration.

### Data recovery

The point of creating volume snapshots is to recover data that has been corrupted or has been accidentally deleted, overwritten, or modified. Azure NetApp Files gives you three ways to recover data by using snapshots:

- Restore one or more files or directories from a snapshot.
- Restore a snapshot to a new volume. This is called cloning the volume because you're creating an identical copy of the volume in a new location.
- Restore a snapshot in-place. This is called reverting the volume, because it returns the volume to the state it was in when you created the snapshot.

## Application volume groups

Azure NetApp Files offers application volume groups designed effectively facilitate SAP HANA workloads on Azure NetApp Files. Application volumes group enables you to simplify the deployment process for SAP HANA while also benefitting from increased storage performance and lowest possible latency by applying logic to select optimal volume locations and storage endpoints as well as setting per volume QoS values to meet SAP HANA performance KPIs.

Azure NetApp Files application volume group for SAP HANA allows you to focus on your application demands instead of managing technical settings such as individual QoS or sizes for volumes.