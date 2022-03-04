The data in your Azure storage account is always replicated to ensure durability and high availability. Azure Storage replication copies your data so that it is protected from planned and unplanned events. These events range from transient hardware failures, network or power outages, massive natural disasters, and so on. You can choose to replicate your data within the same data center, across zonal data centers within the same region, and even across regions. Replication ensures that your storage account meets the Service-Level Agreement (SLA) for Storage even in the face of failures.

## Comparison of replication options

The following table provides a short overview of the scope of durability and availability for different replication strategies.

:::row:::
  :::column:::
    
  :::column-end:::
  :::column:::
    **LRS**
  :::column-end:::
  :::column:::
    **ZRS**
  :::column-end:::
  :::column:::
    **GRS/RA-GRS**
  :::column-end:::
  :::column:::
    **GZRS/RA-GZRS**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    **Node unavailability within a data center**
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    **An entire data center (zonal or non-zonal) becomes unavailable**
  :::column-end:::
  :::column:::
    No
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    **A region-wide outage**
  :::column-end:::
  :::column:::
    No
  :::column-end:::
  :::column:::
    No
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    **Read access to your data (in a remote, geo-replicated region) in the event of region-wide unavailability**
  :::column-end:::
  :::column:::
    No
  :::column-end:::
  :::column:::
    No
  :::column-end:::
  :::column:::
    Yes (with RA-GRS)
  :::column-end:::
  :::column:::
    Yes (with RA-GZRS)
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    **Available in storage account types**
  :::column-end:::
  :::column:::
    GPv1, GPv2, Blob
  :::column-end:::
  :::column:::
    GPv2
  :::column-end:::
  :::column:::
    GPv1, GPv2, Blob
  :::column-end:::
  :::column:::
    GPv2
  :::column-end:::
:::row-end:::


## Locally redundant storage

LRS is the **lowest-cost replication option** and offers the least durability compared to other options. If a datacenter-level disaster (for example, fire or flooding) occurs, **all replicas may be lost or unrecoverable**.

Despite its limitations, LRS may be appropriate in these scenarios:

 -  When your application stores data that can be easily reconstructed if data loss occurs.
 -  When your data is constantly changing, for example a live feed, and storing the data is really not required.
 -  When your application is restricted to replicating data only within a country due to data governance requirements.

## Zone redundant storage

Zone Redundant Storage (ZRS) synchronously replicates your data across three (3) storage clusters in a single region. Each storage cluster is physically separated from the others and resides in its own availability zone. Each availability zone, and the ZRS cluster within it, is autonomous, with separate utilities and networking capabilities. Storing your data in a ZRS account ensures that you will be able access and manage your data if a zone becomes unavailable. ZRS provides excellent performance and low latency.

Here are a few of more things to know about ZRS:

 -  ZRS is not yet available in all regions.
 -  Changing to ZRS from another data replication option requires the physical data movement from a single storage stamp to multiple stamps within a region.

## Geo-redundant storage

Geo-redundant storage (GRS) **replicates your data to a secondary region** (hundreds of miles away from the primary location of the source data). GRS provides a higher level of durability **even if there is a regional outage**. GRS is designed to provide at least 99.99999999999999% **(16 9's) durability**. When your storage account has GRS enabled, then your data is durable even when there is a complete regional outage or a disaster where the primary region isn't recoverable.

For a storage account with GRS or RA-GRS enabled, all data is first replicated with locally redundant storage (LRS). An update is first committed to the primary location and replicated using LRS. The update is then replicated asynchronously to the secondary region using GRS. When data is written to the secondary location, it's also replicated within that location using LRS. Both the primary and secondary regions manage replicas across separate fault domains and upgrade domains within a storage scale unit. The storage scale unit is the basic replication unit within the datacenter. Replication at this level is provided by LRS. If you opt for GRS, you have two related options to choose from:

 -  **GRS** replicates your data to another data center in a secondary region, but that data is available to be read only if Microsoft initiates a failover from the primary to secondary region.
 -  **Read-access geo-redundant storage** (RA-GRS) is based on GRS. RA-GRS replicates your data to another data center in a secondary region, and also provides you with the option to read from the secondary region. With RA-GRS, you can read from the secondary regardless of whether Microsoft initiates a failover from the primary to the secondary.

## Geo-zone redundant storage

Geo-zone-redundant storage (GZRS) **combines the high availability of zone-redundant storage with protection from regional outages as provided by geo-redundant storage**. Data in a GZRS storage account is replicated across three Azure availability zones in the primary region and also replicated to a secondary geographic region for protection from regional disasters. Each Azure region is paired with another region within the same geography, together making a regional pair.

With a GZRS storage account, you can continue to read and write data if an availability zone becomes unavailable or is unrecoverable. Additionally, your data is also durable when a complete regional outage or a disaster in which the primary region isn’t recoverable. GZRS is designed to provide at least 99.99999999999999% (16 9's) durability of objects over a given year. GZRS also offers the same scalability targets as LRS, ZRS, GRS, or RA-GRS. You can optionally enable read access to data in the secondary region with read-access geo-zone-redundant storage (RA-GZRS).

Microsoft recommends using GZRS for applications requiring consistency, durability, high availability, excellent performance, and resilience for disaster recovery. Enable RA-GZRS for read access to a secondary region when there is a regional disaster.
