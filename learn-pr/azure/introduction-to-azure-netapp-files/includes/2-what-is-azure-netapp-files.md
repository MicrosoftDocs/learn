Let's start with a quick overview of Azure NetApp Files and its core features. This overview should help you decide whether Azure NetApp Files enables you to migrate your on-premises workloads to the cloud.

## What is shared file storage?

Many modern applications use one of the following storage technologies:

- Block storage. Data is divided into discrete chunks called *blocks* and stored on disk at the sector and track level.
- Object storage. Information is stored as unstructured data with no hierarchy.

However, most organizations still have many applications and services that require shared access to files stored using a file system that enables hierarchical access to the data. *Shared file storage* is a way of storing file-based data in a networked environment so that the files are available to servers, applications, and users across the network. Most shared file storage is composed of network-attached storage (NAS) devices that use a shared file system.

There are two main file system protocols used for most shared file-storage implementations:

- Network File System (NFS). Most often used with the Linux operating system.
- Server Message Block (SMB). Most often used with the Windows operating system.

## Azure NetApp Files definition

Azure NetApp Files is an enterprise-class, high-performance, fully managed NAS service for shared file storage. It's a first-party service, meaning you deploy and manage it through the Azure portal.

## Performance

Azure NetApp Files is designed for the highest possible performance so that it can manage even the most demanding Windows and Linux workloads. This performance is achieved by running Azure NetApp Files instances on dedicated NetApp hardware running NetApp's proprietary ONTAP operating system, which is optimized for extremely high storage throughput and availability.

Azure NetApp Files performance is measured in two ways:

- Input/output operations per second (IOPS). IOPS is a storage-performance benchmark that measures the average number of read and write operations a storage device can perform per second. Azure NetApp Files offers up to 320,000 IOPS on its lowest performance tier, and up to 450,000 IOPS on its highest tiers. By comparison, most solid-state drives (SSDs) have throughput measurements between 100,000 IOPS and 400,000 IOPS.
- Latency. Latency is the time required to access a particular storage location. Azure NetApp Files offers an average latency of less than 1 millisecond (ms). By comparison, regular hard drives have latencies between 1 ms and 10 ms, whereas SSDs have latencies between 0.05 ms and 0.15 ms.

Given these measurements, you can understand why Azure NetApp Files provides performance that is comparable to or even better than on-premises performance.

## Security and compliance

Azure NetApp Files is purpose-built to offer high levels of security, compliance, and availability:

- Security. Azure NetApp Files offers FIPS-140-2-compliant data encryption at rest, role-based access control (RBAC), Microsoft Active Directory authentication, and export policies for network-based access control lists (ACLs).
- Compliance. Azure NetApp Files complies with leading industry certifications, such as the Health Insurance Portability and Accountability Act (HIPAA).
- Availability. The Azure NetApp Files Service Level Agreement (SLA) guarantees at least 99.99% availability.

## Protocols

Azure NetApp Files offers the widest choice of file protocols among public cloud NAS providers. Azure NetApp Files supports the following protocols:

- NFS 3.0
- NFS 4.1
- SMB 2.x
- SMB 3.x

Azure NetApp Files already supports dual-protocol access to NFSv3 and SMB volumes as of July 2020. You can now create an Azure NetApp Files volume that allows simultaneous dual-protocol (NFSv4.1 and SMB) access with support for LDAP user mapping. This feature enables use cases where you might have a Linux-based workload using NFSv4.1 for its access, and the workload generates and stores data in an Azure NetApp Files volume.

Azure NetApp Files also supports creating volumes that can use both NFS 3.0 and SMB at the same time. Using both protocols on a volume enables both Linux-based and Windows-based enterprise applications that rely on file-based datasets to simultaneously access and share that data.

## Data management

Azure NetApp Files offers a complete range of data-management features such as near-instantaneous snapshots and volume cloning. These features improve data management without impacting performance.

### Instance access

Although Azure NetApp Files instances run on bare-metal NetApp devices, that hardware resides in an Azure datacenter and is configured to be a first-party Azure service that's sold and supported by Microsoft. This means that you can set up an Azure NetApp Files instance in just a few minutes. Also, because Azure NetApp Files is a full Azure service, you can manage your instances the same way you do any other Azure service such as the Azure portal, Azure command-line interface (Azure CLI), Azure PowerShell, or Azure REST API.

### Snapshots

An Azure NetApp Files *snapshot* is a point-in-time image of a volume. These snapshots have low overhead because of the way Azure NetApp Files performs volume virtualization. Like a database, this layer uses pointers to the actual data blocks on disk. However, unlike a database, it doesn't rewrite existing blocks. It writes updated data to a new block and changes the pointer.

The following diagram illustrates the snapshot process:

1. Time A. A snapshot (Snapshot 1) is created.
2. Time B. Changed data (B is now B1) is written to a new block and the pointer is updated. However, the snapshot pointer still points to the previously written block, giving you both a live view and a historical view of the data.
3. Time C. Another snapshot (Snapshot 2) is created. Now you have access to three generations of data—the live data, Snapshot 2, and Snapshot 1, in descending order of age, without taking up the volume space that three full copies would require.

:::image type="content" source="../media/2-what-is-azure-netapp-files-snapshots.png" alt-text="Diagram depicting how Azure NetApp Files snapshots work." lightbox="../media/2-what-is-azure-netapp-files-snapshots.png":::

An Azure NetApp Files snapshot only manipulates block pointers, creating a "frozen," read-only view of a volume. Actual data blocks aren't copied, which leads to two efficiencies:

- Speed. Creating a snapshot is near-instantaneous. No matter what volume size you're working with, creating a snapshot takes only a few seconds.
- Space. A snapshot consumes minimal storage space because it doesn't copy the data blocks of the entire volume. Two snapshots taken in sequence differ only by the blocks added or changed in the time interval between the two.

You can create up to 255 snapshots per volume. Creating a snapshot doesn't impact volume performance. You can create and maintain snapshots in two ways:

- Manual. Create on-demand snapshots by using the Azure portal, Azure CLI, Azure PowerShell, or Azure REST API.
- Automatic. Automate snapshot creation by using snapshot policies or a snapshot tool, such as AzAcSnap. You can set up snapshot policies by using the Azure portal, Azure CLI, Azure PowerShell, or Azure REST API.

### Cross-region Replication

Azure NetApp Files replication functionality provides data protection through cross-region volume replication. You can asynchronously replicate data from an Azure NetApp Files volume (source) in one region to another Azure NetApp Files volume (destination) in another region. This capability enables you to failover your critical application if there's a region-wide outage or disaster.

### Data recovery

The point of creating volume snapshots is to recover data that has been corrupted or has been accidentally deleted, overwritten, or modified. Azure NetApp Files gives you three ways to recover data by using snapshots:

- Restore one or more files or directories from a snapshot.
- Restore a snapshot to a new volume. Called *cloning* the volume, because you're creating an identical copy of the volume in a new location.
- Restore a snapshot in-place. Called *reverting* the volume, because it returns the volume to the state it was in when you created the snapshot.

## How to give your web development team access to the same data

It's likely that your organization's web development team uses various operating systems. For example:

- Linux. Your backend development team might use computers running the Linux operating system.
- Windows. Your frontend development team might use PCs running Windows.
- macOS. Your design team might use Macs running the macOS operating system.

Azure NetApp Files enables enterprise teams that use different operating systems to access the same data. Although each team would usually work on separate aspects of the website, if the website data files reside on the same volume, then you need to configure that volume to allow access from computers running Linux, Windows, and macOS.

You can accomplish this goal in Azure NetApp Files by configuring the volume to simultaneously use both NFS (supported by Linux) and SMB (supported by Windows and macOS).
