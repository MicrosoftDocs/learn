As part of the project to configure your healthcare application to be highly available, you need to create and configure an Azure storage account. You can use Read-Access Geo-Replica-Storage (RA-GRS), to enable the storage account to fail over to another region, if an Azure region failure occurs.

## Azure storage accounts
Azure storage accounts are used to house all data objects such as files, blobs, tables, and disks for virtual machines. The data you store in a storage account can be accessed from any location globally via HTTP or HTTPS and is highly available and secure.

![High-level overview of storage account contents](../media/2-ra-grs-storage-account.png)

## Data redundancy

Data in Azure is replicated to ensure it's always available if a datacenter or region becomes inaccessible, or a specific piece of hardware fails. There are four different replication options available:

- Locally redundant storage (LRS)
- Zone redundant storage (ZRS)
- Geographically redundant storage (GRS)
- Read-access geo-redundant storage (RA-GRS)

Each replication option provides a different level of redundancy and durability. The following sections describe these options in more detail.

### What is locally redundant storage (LRS)?

![Overview of Locally redundant storage](../media/2-locally-redundant-storage.png)

Locally redundant storage replicates data and stores three copies across fault domains (fault domains are racks of hardware) within a single datacenter facility in one region. Data is replicated so that if there's a hardware fault or maintenance work, your data is still available and accessible.

LRS protects your data from hardware failures, but you won't be protected if there was a datacenter outage. For example, if Array 1 in UK South suffers a hardware failure, your data is still available on Array 2. If the entire datacenter suffers a failure, you would most likely lose your data.

LRS is the cheapest replication option available and offers the least amount of durability because if there was a data center outage, you could potentially lose all your data depending on the severity of the outage.

### What is Zone redundant storage (ZRS)?

![Overview of Zone-redundant storage](../media/2-zone-redundant-storage.png)

Zone redundant storage replicates your data across three storage clusters in a region. Each cluster is physically separated from the other two clusters, meaning each cluster is supplied by separate utilities such as power, networking, and so on.

If there was an outage in a datacenter, you could still access your data from another availability zone in that region. Data is normally replicated to two or three availability zones depending on the region.

An Availability Zone (AZ) is a physical location made up of one or more datacenters in a region. There are typically 2-3 AZs per region, where each AZ is independent of the other AZs in the region.

ZRS provides you with 99.999999999999% durability of data. However, ZRS might not protect you from a regional outage, as all AZs reside in the same region. To migrate data to ZRS from either LRS or GRS, require some planning and manual migration, using tools such as AZCopy.

### What is Geographically Redundant Storage (GRS)?

![Overview of Geo-redundant storage](../media/2-geo-redundant-storage.png)

Geo-redundant storage provides multiple levels of replication. Your data is replicated three times within the primary region, and then this set is replicated to a secondary region.

GRS provides you with the highest level of durability as you finish with six copies of your data. This durability means that even if there's a datacenter failure or regional issues in the primary region, your data is always available. If the primary region fails, Azure storage is still available in the secondary region. The secondary region is automatically paired to the primary region based on the primary region you selected. This pairing configuration can't be changed.

Keep in mind that your data in the secondary region is not accessible until the primary region has failed across to the secondary region. At this point, the secondary region becomes the active region (Primary), and your data becomes accessible.

### What is Read-access Geo-redundant storage (RA-GRS)?

![Overview of RA-Geo-redundant storage](../media/2-ra-grs-redundant-storage.png)

Geo-redundant storage provides 99.9999999999999999% durability as it replicates data and objects to a secondary region. When failover starts, DNS entries pointing to the primary region are updated to point to the secondary region. Microsoft currently controls the DNS failover process.

When using RA-GRS, you need to ensure your application knows which endpoint it's interacting with. The secondary region will have "-secondary" appended to the name of the endpoint.

RA-GRS is ideal for applications, which require high-availability

A new feature currently in preview allows you to initiate failover between primary and secondary regions from the Portal, Powershell, or Azure CLI. When the primary endpoint becomes unavailable, you can fail over to the secondary endpoint.

Once failover and DNS endpoint updates are complete, the storage account is set back to LRS. You are responsible for reverting the replication settings from LRS to RAGRS or GRS once the primary region becomes available again.

## When to use different types of redundant storage

The following table summarizes the scenarios in which it's most appropriate to use the different typed of redundant storage.

| | LRS | ZRS | GRS | RA-GRS |
| ------| -------- | --------------- | --------------- | ------ |
|Overview | Replicates data in a single datacenter | Stores copies of data across multiple datacenters | Stores copies in local datacenter like LRS, but then a further 3 copies in a datacenter in another region | Same as GRS, but you have read access in the secondary datacenter in the other region
| Data copies | 3 | 3 | 6 | 6
| Use case | To ensure your data is highly available, but for compliance reasons need to be kept local | A higher durability option for block storage, where data can only stay in one region | Where you need to ensure your data and systems are always available despite datacenter or region outages | Used for scenarios where your applications can read data from other regions, especially for applications with many read requests, but also to ensure read operations are always available even in the event the primary region is down

## Change replication strategy

After you've created an Azure storage account, you can change the replication strategy. You can switch the replication status of a storage account from LRS to GRS, or LRS to RA-GRS, and back again.
