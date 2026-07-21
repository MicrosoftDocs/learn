In some situations, you might want to combine an HA setup of HANA system replication with a disaster-recovery (DR) setup using cross-region replication. Depending on the specific usage pattern and service-level agreement (SLA), two setup options for replication are possible.

### Replicate only the primary HANA database volumes

In this scenario, you typically don't change roles for primary and secondary systems. A takeover is done only in an emergency case. As such, the application-consistent snapshot backups required for cross-region replication are taken mostly on the primary host. This is the case because only the primary HANA database can be used to create a backup.

The following diagram describes this scenario:

:::image type="content" source="../media/high-availability-disaster-recovery-primary-replication.png" alt-text="Diagram showing SAP HANA HA and DR architecture where only primary volumes are replicated to the DR region using cross-region replication." border="true" lightbox="../media/high-availability-disaster-recovery-primary-replication.png":::

In this scenario, a DR setup must include only the volumes of the primary HANA system. With the daily replication of the primary data volume and the log backups of both the primary and secondary systems, the system can be recovered at the DR site. In the diagram, a single volume is used for the log backups of the primary and secondary systems.

In case of a takeover by the secondary HSR host, the backups taken in the secondary system aren't replicated, but log backups of the secondary continue to be replicated. If a disaster happens, the system at the DR site can still be recovered using the old snapshot backup from the former primary and the replicated log backups from both hosts. RTO increases because more logs are to be recovered, depending on how long the HSR pair runs in the takeover mode. If the takeover mode is significantly longer and RTO becomes a problem, you need to set up a new cross-region replication including the data volume of the secondary system.

### Replicate both primary and secondary HANA database volumes

For reasons other than HA, you might want to periodically switch roles between the primary and secondary HANA systems. In this scenario, application-consistent backups must be created on both HANA hosts.

The following diagram describes this scenario:

:::image type="content" source="../media/high-availability-disaster-recovery-both-volumes.png" alt-text="Diagram showing SAP HANA HA and DR architecture where both primary and secondary volumes are replicated to the DR region." border="true" lightbox="../media/high-availability-disaster-recovery-both-volumes.png":::

In this scenario, you might want to replicate both sets of volumes from the primary and secondary HANA systems as shown in the diagram.

To create the volumes for the secondary replication target, the naming convention is adapted. To distinguish between the replication of the primary and secondary database, the prefix changes from `DR` to `DR2` for the secondary HANA system.
