Let's begin with an overview of Azure NetApp Files and its core features. This overview should help you decide whether Azure NetApp Files enables you to migrate your on-premises workloads to the cloud.

## What is shared file storage?

Many modern applications use one of the following storage technologies:

- **Block storage**: Data is divided into discrete chunks called *blocks* and stored on disk at the sector and track level. These blocks can either be addressed by the application directly or through a filesystem that organizes blocks into hierarchical directories (folders) and files.
- **Object storage**: Information is stored as unstructured data with no hierarchy.

Most organizations still have many applications and services that require shared access to files stored using a file system that enables hierarchical access to the data. Shared file storage is a way of storing file-based data in a networked environment so that the files are available to servers, applications, and users across the network. Most shared file storage is composed of network-attached storage (NAS) devices that use a shared file system.

There are two main file system protocols used for most shared file-storage implementations:

- **Network File System (NFS)**: most often used with the Linux operating system.
- **Server Message Block (SMB)**: Most often used with the Windows operating system.

Both NFS and SMB present logical drives organized in hierarchical structures on which the OS can store files in directories or folders.

## Azure NetApp Files

Azure NetApp Files is an Azure native, first-party, enterprise-class, high-performance, fully managed NAS file storage service.

Key attributes of Azure NetApp Files include:

- Performance, cost optimization, and scale
- Simplicity and availability
- Data management and security

## Optimize performance, cost, and scale

Azure NetApp Files is designed to provide high-performance file storage for enterprise workloads and to provide functionality to provide cost optimization and scale. 

### Performance

Azure NetApp Files is designed for the highest possible performance so that it can manage even the most demanding Windows and Linux workloads. This performance is achieved by running Azure NetApp Files instances on dedicated NetApp hardware running NetApp's proprietary ONTAP operating system, which is optimized for extremely high storage throughput and availability.

Azure NetApp Files performance is measured in three ways:

- **Input/output operations per second (IOPS)**: a storage-performance benchmark that measures the average number of read and write operations a storage device can perform per second. Azure NetApp Files offers up to 130,000 pure random writes and 460,000 pure random reads on its lowest performance tier. For higher performance tiers, Azure NetApp Files offers up to 474,000 pure random writes and approximately 709,000 pure random reads.
- **Throughput limits**: a storage-performance benchmark that measures a combination of read and write speeds. Azure NetApp Files can assign a maximum of 4,500 MiB/s to a regular size volume and 10,240 MiB/s to a large volume using the highest tier.
- **Latency**: the time required to access a particular storage location. Azure NetApp Files offers an average latency of less than 1 millisecond.

Azure NetApp Files provide fast and reliable all-flash performance with submillisecond latency by running performance-intensive workloads in the cloud with on-premises infrastructure-level performance.

Azure NetApp Files provide three flexible performance tiers (Standard, Premium, and Ultra). The performance tiers offer the ability to dynamically change service levels based on workload needs. Using Azure NetApp Files storage with cool access, you can configure inactive data to move from Azure NetApp Files Standard service-level storage (the hot tier) to an Azure storage account (the cool tier). Enabling cool access moves inactive data blocks from the volume and the volume's snapshots to the cool tier, resulting in cost savings.  You need to choose the right performance level for workloads and can always dynamically adjust performance based on workload needs to balance cost with changing requirements.

### Cost optimization

Understanding the cost model for Azure NetApp Files helps you manage your service expenses.
Azure NetApp Files is billed on provisioned storage capacity, which is allocated by creating capacity pools. Capacity pools are billed monthly based on a set cost per allocated GiB per hour. You can: 

- Save money by starting with a smaller storage footprint and lower entry point. Scale storage based on growth without high upfront costs.
- Reduce waste by creating larger, pooled capacity and performance budget, and share and distribute across volumes.
- Set quotas on storage usage for individual users and groups to control storage usage and optimize resource allocation.
- Use the cool access option of Azure NetApp Files to move inactive data transparently from Azure NetApp Files storage (the hot tier) to an Azure Storage account (the cool tier).

### Scale

Azure NetApp Files allows you to easily resize volumes from 50 GiB up to 100 TiB without downtime. You can scale storage as business needs grow without over-provisioning, avoiding upfront costs.

- Manage large datasets and high-performance workloads with ease by storing large volumes of data (up to 500 TiB) in a single volume.
- Easily migrate any workload of any size to the platform. Enjoy a seamless, cost-effective deployment and migration experience.

These features work together to provide a high-performance file storage solution for the demands of enterprise workloads. They help to ensure that your workloads experience optimal (low) storage latency, cost, and scale.

## Increase simplicity and availability

Azure NetApp Files is designed to provide simplicity and high availability for your file storage needs. Key features of Azure NetApp Files include:

- Azure NetApp Files enables you to provision and manage volumes quickly and easily without the need for dedicated hardware or complex configurations.
- Azure NetApp Files simplifies management and ensures consistency with other Azure services while providing a familiar interface and integration with existing tools and workflows.
- Azure NetApp Files provides a high-availability SLA that ensures that data is always available and accessible, avoiding downtime and disruption to business operations.
- Azure NetApp Files enables you to move their workloads to Azure quickly and easily without the need for costly and time-consuming application refactoring or redesign.
- Azure NetApp Files provides a simple-to-use and highly available file storage solution. 
- Azure NetApp Files ensures that your data is easy to manage and highly available, recoverable, and accessible to your applications. Availability and remote access can be improved by utilizing cross-region or cross-zone replication. 
- Application volume groups enable you to deploy all application volumes according to best practices in a single one-step and optimized workflow.

## Enhance data management and security

Azure NetApp Files is designed to securely manage your data.

### Security and compliance

Azure NetApp Files is purpose-built to offer high levels of security and compliance:

- **Security**: Azure NetApp Files offers FIPS-140-2-compliant data encryption at rest, role-based access control (RBAC), Microsoft Entra ID authentication, and export policies for network-based access control lists (ACLs). Azure NetApp Files also supports customer-managed keys.
- **Compliance**: Azure NetApp Files complies with leading industry certifications, such as the Health Insurance Portability and Accountability Act (HIPAA) and many other certifications.

### Data encryption

Azure NetApp Files ensures both data-in-transit and data-at-rest encryption features to make sure the information is safe and secure all the time. 

- **Data-in-transit encryption**: Ensures the confidentiality and integrity of data being transmitted for peace of mind that information is safe and secure.
- **Data-at-rest encryption**: Prevents unrestrained access to stored data, meets compliance requirements, and enhances data security.

## Protocols

Azure NetApp Files offers the widest choice of file protocols among public cloud NAS providers. Azure NetApp Files supports the following protocols:

- NFSv3.0
- NFSv4.1
- SMB 2.x
- SMB 3.x

Azure NetApp Files also supports dual-protocol access to NFSv3, NFSv4.1, and SMB volumes. You can create volumes that use both supported NFS and SMB at the same time. Using both protocols on a volume enables both Linux-based and Windows-based enterprise applications that rely on file-based datasets to simultaneously access and share that data. You can also create Azure NetApp Files volumes that allow simultaneous dual-protocol (NFSv4.1 and SMB) access with support for LDAP user mapping.

## Data management

Azure NetApp Files provides built-in data management and security capabilities to help ensure the secure storage, availability, and manageability of your data. 

### Volume access

Azure NetApp Files volumes are served from a bare-metal fleet powered by ONTAP residing in Azure datacenters, sold and supported by Microsoft. You can set up Azure NetApp Files volumes in just a few minutes. You can manage your volumes the same way you do any other Azure service such as through the Azure portal, Azure command-line interface (Azure CLI), Azure PowerShell, or Azure REST API.

### Efficient snapshots and backup

Quickly and easily back up data and restore it to a previous point in time, minimizing downtime and reducing the risk of data loss. Instantly restore data from a snapshot quickly and accurately.

Snapshots offer low overhead because of Azure NetApp Files' volume virtualization technology, using and manipulating pointers to the actual data blocks on disk. It does not rewrite or overwrite existing blocks. Instead it writes updated data to a new unused block and changes the pointers.

When you delete a volume, its snapshots are deleted, but backups remain.

### Cross-region and cross-zone replication

Azure NetApp Files replication functionality provides data protection through cross-region and cross-zone volume replication. This functionality can asynchronously replicate data from an Azure NetApp Files volume (source) in one region or zone to another Azure NetApp Files volume (destination) in another region or zone without any load on your application servers. This capability enables you to fail over your critical applications in case of a region-wide or zone-wide outage or disaster.