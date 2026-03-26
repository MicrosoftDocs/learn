Azure Storage keeps multiple copies of data to protect against hardware failures, outages, and regional disasters. Redundancy choices determine availability, durability, and cost.

When selecting a redundancy option, balance lower cost against higher availability. Key decision factors include:

 -  How your data is replicated in the primary region.
 -  Whether your data is replicated to a second region that is geographically distant to the primary region, to protect against regional disasters.
 -  Whether your application requires read access to the replicated data in the secondary region if the primary region becomes unavailable.

## Redundancy in the primary region

Data in Azure Storage is always replicated three times in the primary region. Primary-region options are locally redundant storage (LRS) and zone-redundant storage (ZRS).

### Locally redundant storage

Locally redundant storage (LRS) replicates your data three times within a single data center in the primary region. LRS provides at least 11 nines of durability (99.999999999%) of objects over a given year.

:::image type="content" source="../media/locally-redundant-storage.png" alt-text="Diagram showing the structure used for locally redundant storage.":::


LRS is the lowest-cost option and protects against server rack and drive failures in one datacenter. Because all replicas stay in that datacenter, a datacenter-level disaster can still cause data loss. For stronger resilience, use ZRS, GRS, or GZRS.

### Zone-redundant storage

For Availability Zone-enabled Regions, zone-redundant storage (ZRS) replicates your Azure Storage data synchronously across three Azure availability zones in the primary region. ZRS offers durability for Azure Storage data objects of at least 12 nines (99.9999999999%) over a given year.

:::image type="content" source="../media/zone-redundant-storage.png" alt-text="Diagram showing ZRS, with a copy of data stored in each of three availability zones.":::


With ZRS, data stays available for read and write operations even if one zone is unavailable. Azure performs networking updates, such as DNS repointing, during recovery.

Microsoft recommends ZRS for high availability in-region scenarios and for requirements that keep replication within a country or region.

## Redundancy in a secondary region

For higher durability, you can replicate data to a secondary region that is geographically distant from the primary region.

When you create a storage account, you choose the primary region. Azure assigns the paired secondary region based on region pairs.

Secondary-region options are geo-redundant storage (GRS) and geo-zone-redundant storage (GZRS). GRS uses LRS in both regions, while GZRS uses ZRS in the primary region and LRS in the secondary region.

By default, secondary-region data isn't readable unless failover occurs. If the primary region is unavailable, you can fail over so the secondary region becomes primary.

> [!IMPORTANT]
> Because data is replicated to the secondary region asynchronously, a failure that affects the primary region may result in data loss if the primary region can't be recovered. The interval between the most recent writes to the primary region and the last write to the secondary region is known as the recovery point objective (RPO). The RPO indicates the point in time to which data can be recovered. Azure Storage typically has an RPO of less than 15 minutes, although there's currently no SLA on how long it takes to replicate data to the secondary region.

### Geo-redundant storage

GRS copies data synchronously three times in the primary region (LRS), then asynchronously to the secondary region (also LRS). It provides at least 16 nines of durability over a year.

:::image type="content" source="../media/geo-redundant-storage.png" alt-text="Diagram showing GRS, with primary region LRS replicating data to LRS in a second region.":::


### Geo-zone-redundant storage

GZRS combines zone-level resilience in the primary region with geo-replication to a secondary region. Data is copied across three availability zones in the primary region and replicated to the paired secondary region using LRS. Microsoft recommends GZRS for workloads that need maximum consistency, availability, and disaster recovery resilience.

:::image type="content" source="../media/geo-zone-redundant-storage.png" alt-text="Diagram showing GZRS, with primary region ZRS replicating data to LRS in a second region.":::


GZRS is designed to provide at least 16 nines (99.99999999999999%) of durability of objects over a given year.

## Read access to data in the secondary region

GRS and GZRS protect against regional outages by replicating data to a secondary location. To read secondary-region data before failover, enable read-access geo-redundant storage (RA-GRS) or read-access geo-zone-redundant storage (RA-GZRS).

> [!IMPORTANT]
> Remember that the data in your secondary region may not be up-to-date due to RPO.

