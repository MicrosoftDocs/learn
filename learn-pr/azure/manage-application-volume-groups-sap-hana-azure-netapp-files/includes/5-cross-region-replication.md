The Azure NetApp Files cross-region replication (CRR) functionality enables you to replicate volumes between supported cross-region replication pairs. This functionality allows you to replicate a volume from a source region to a volume in the destination region for disaster recovery (DR).

Instead of using HANA System Replication (HSR), you can use cross-region replication to protect a database without needing a HANA database server that runs all the time. You need to create replication destination volumes in a region supported for cross-region replication. Application volume group for SAP HANA ensures that the destination volumes are created with the correct volume type that meets all SAP HANA specific requirements.

The following diagram illustrates cross-region replication between the source and destination HANA servers:

:::image type="content" source="../media/cross-region-replication-architecture.png" alt-text="Diagram showing source region containing active HANA server and target region containing standby HANA server with DR volumes." border="true" lightbox="../media/cross-region-replication-architecture.png":::

To add volumes for an SAP HANA system as a DR system, you need to select the **Disaster recovery destination** option in the SAP HANA tab when creating a new application volume group. This configuration uses Azure NetApp Files cross-region replication functionality to replicate volumes from the source region to the destination region.
