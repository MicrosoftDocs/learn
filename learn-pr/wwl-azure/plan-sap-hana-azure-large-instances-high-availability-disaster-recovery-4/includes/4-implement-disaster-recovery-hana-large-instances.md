HANA Large Instances offer a disaster recovery functionality between HANA Large Instance stamps in different Azure regions. For instance, if you deploy HANA Large Instance units in the US West region of Azure, you can use the HANA Large Instance units in the US East region as disaster recovery units. As mentioned earlier, disaster recovery is not configured automatically, because it requires you to pay for another HANA Large Instance unit in the DR region. The disaster recovery setup works for scale-up and scale-out setups.

In the scenarios deployed so far, customers use the unit in the DR region to run non-production systems that use an installed HANA instance. The HANA Large Instance unit needs to be of the same SKU as the SKU used for production purposes.

You then need to order a second set of disk volumes. The target disk volumes are the same size as the production volumes for the production instance in the disaster recovery units. These disk volumes are associated with the HANA Large Instance server unit in the disaster recovery site. The following volumes are replicated from the production region to the DR site:

 -  **/hana/data**
 -  **/hana/logbackups**
 -  **/hana/shared** (includes **/usr/sap**)

The **/hana/log** volume is not replicated because the SAP HANA transaction log is not needed in the way that the restore from those volumes is done.

The basis of the disaster recovery functionality offered is the storage replication functionality offered by the HANA Large Instance infrastructure. The functionality that is used on the storage side is not a constant stream of changes that replicate in an asynchronous manner as changes happen to the storage volume. Instead, it is a mechanism that relies on the fact that snapshots of these volumes are created regularly. The delta between an already replicated snapshot and a new snapshot that is not yet replicated is then transferred to the disaster recovery site into target disk volumes. These snapshots are stored on the volumes and, if there is a disaster recovery failover, need to be restored on those volumes.

The first transfer of the complete data of the volume should take place before the amount of data becomes smaller than the deltas between snapshots. As a result, the volumes in the DR site contain every one of the volume snapshots performed in the production site. Eventually, you can use that DR system to get to an earlier status to recover lost data, without rolling back the production system.

If there is an MCOD deployment with multiple independent SAP HANA instances on one HANA Large Instance unit, it is expected that all SAP HANA instances are getting storage replicated to the DR side.

In cases where you use HANA System Replication as high-availability functionality in your production site and use storage-based replication for the DR site, the volumes of both the nodes from the primary site to the DR instance are replicated. You must purchase additional storage (same size as of primary node) at the DR site to accommodate replication from both primary and secondary to the DR.

> [!NOTE]
> The HANA Large Instance storage replication functionality is mirroring and replicating storage snapshots. If you don't perform storage snapshots, there can't be any replication to the disaster recovery site. Storage snapshot execution is a prerequisite to storage replication to the disaster recovery site.
