As part of the project to make your healthcare application highly available, you need to create and configure an Azure storage account. Recall that your application will allow doctors and consultants in the field to upload images from visits with patients. These images contain essential clinical information, and they must be available even if an Azure region fails.

Let's see how an Azure storage account is configured to allow for replication and high availability of data.

## Azure storage accounts
Azure storage accounts are used to house data objects, such as files, blobs, tables, and disks for virtual machines. The data that you store in a storage account can be accessed from any location globally via HTTP or HTTPS and is highly available and secure.

![The storage types that are accessible as read-access geo-redundant storage](../media/2-ra-grs-storage-account.png)

## Data redundancy

Data in Azure is replicated to ensure that it's always available, even if a datacenter or region becomes inaccessible or a specific piece of hardware fails. You have four replication options:

- Locally redundant storage (LRS)
- Zone-redundant storage (ZRS)
- Geographically redundant storage (GRS)
- Read-access geo-redundant storage (RA-GRS)

Each replication option provides a different level of redundancy and durability. The following sections describe these options in more detail.

### What is locally redundant storage (LRS)?

![An overview of locally redundant storage](../media/2-locally-redundant-storage.png)

Locally redundant storage replicates data and stores three copies across fault domains, or racks of hardware, within a single datacenter facility in one region. Data is replicated so that if there's a hardware fault or maintenance work, your data is still available and accessible.

LRS protects your data from hardware failures, but you aren't protected if there's a datacenter outage. For example, if Array 1 in UK South suffers a hardware failure, your data is still available on Array 2. If the entire datacenter suffers a failure, you would most likely lose your data.

LRS is the least expensive replication option available. It also offers the least durability, because you can potentially lose all your data during a datacenter outage, depending on the severity of the outage.

### What is zone-redundant storage (ZRS)?

![An overview of zone-redundant storage](../media/2-zone-redundant-storage.png)

Zone-redundant storage replicates your data across three storage clusters in a region. Each cluster is physically separated from the other two, which means that each cluster is supplied by separate utilities, such as power or networking.

If there's an outage in a datacenter, you can still access your data from another availability zone in that region. Data is normally replicated to two or three availability zones, depending on the region.

An availability zone (AZ) is a physical location that's made up of one or more datacenters in a region. There are typically two or three AZs per region, where each AZ is independent of the other AZs in the region.

ZRS offers 99.999999999999 percent durability of data. However, ZRS might not protect you from a regional outage, because all AZs reside in the same region. To migrate data to ZRS from either LRS or GRS requires some planning and manual migration. And it requires a tool such as AZCopy.

### What is geographically redundant storage (GRS)?

![An overview of geo-redundant storage](../media/2-geo-redundant-storage.png)

Geographically redundant, or geo-redundant, storage provides multiple levels of replication. Your data is replicated three times within the primary region, and then this set is replicated to a secondary region.

GRS provides the highest level of durability, because you finish with six copies of your data. Such durability means that even if there's a datacenter failure or regional issues in the primary region, your data is always available. If the primary region fails, Azure storage is still available in the secondary region. The secondary region is automatically paired to the primary region based on the primary region you selected. This pairing configuration can't be changed.

Keep in mind that your data in the secondary region is inaccessible until the primary region has failed across to the secondary region. At this point, the secondary region becomes the active region (primary), and your data becomes accessible.

### What is read-access geo-redundant storage (RA-GRS)?

![An overview of read-access geo-redundant storage](../media/2-ra-grs-redundant-storage.png)

Geo-redundant storage provides 99.9999999999999999 percent durability, because it replicates data and objects to a secondary region. When failover starts, DNS entries that point to the primary region are updated to point to the secondary region. Microsoft currently controls the DNS failover process.

When you use RA-GRS, you need to ensure that your application knows which endpoint it's interacting with. The secondary region has "-secondary" appended to the name of the endpoint.

RA-GRS is ideal for applications, which require high availability.

A new feature currently in preview allows you to start a failover between primary and secondary regions from the Azure portal, PowerShell, or the Azure CLI. When the primary endpoint becomes unavailable, you can fail over to the secondary endpoint.

After the failover and DNS endpoint updates are complete, the storage account is set back to LRS. You're responsible for reverting the replication settings from LRS to RA-GRS or GRS after the primary region becomes available again.

## When to use each type of redundant storage

The most appropriate use of each type of redundant storage is summarized in the following table:

| | LRS | ZRS | GRS | RA-GRS |
| ------| -------- | --------------- | --------------- | ------ |
|Overview | Replicates data in a single datacenter | Stores copies of data across multiple datacenters | Stores copies in a local datacenter, like LRS, but then stores three more copies in a datacenter in another region | Same as GRS, but offers read access in the secondary datacenter in the other region
| Data copies | 3 | 3 | 6 | 6
| Use case | Ensures that your data is highly available but, for compliance reasons, must be kept local | A higher durability option for block storage, where data can stay in only one region | Where you need to ensure that your data and systems are always available despite datacenter or region outages | Where your applications (especially those with many read requests) can read data from other regions, but also to ensure that read operations are always available even if the primary region is down

## Change replication strategy

After you've created an Azure storage account, you can change the replication strategy. You can switch the replication status of a storage account from LRS to GRS, or LRS to RA-GRS, and back again.
