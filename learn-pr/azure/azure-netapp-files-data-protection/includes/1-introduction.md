There are four key areas of Azure NetApp Files data protection: 

## Snapshots

An Azure NetApp Files snapshot is a point-in-time file system (volume) image. Snapshots are ideal to serve as an online backup. Azure NetApp Files snapshot technology delivers stability, scalability, and swift recoverability without impacting performance. 

### Benefits

- Snapshots are efficient and frequent primary data protection for fast recovery from data corruption or loss.
- With snapshots, you can revert a complete volume to a point-in-time snapshot in seconds.
- You can restore a snapshot to new volume (clone) in seconds to test or develop with current data.
- Create application-consistent snapshots with the AzAcSnap integration and third-party backup tools.

## Backups

Azure NetApp Files supports a fully managed backup solution for long-term recovery, archive, and compliance. Backups can be restored to new volumes in the same region as the backup. 

### Highlights

- Backups created by Azure NetApp Files are stored in Azure storage. 
- Backups are independent of volume snapshots that are available for near-term recovery or cloning.
- You can retain daily, weekly, monthly backups for extended periods of time on cost-efficient cloud storage without media management,

## Cross-region replication 

Using snapshot technology, you can replicate your Azure NetApp Files across designated Azure regions to protect your data from unforeseeable regional failures. 

### Primary benefits 

- Disaster recovery across regions.
- Data availability and redundancy for remote data processing and user access.
- Cross-region replication provides efficient storage-based data replication without load on compute infrastructure.

## Cross-zone replication 

Cross-zone replication uses availability zones and same replication engine as cross-region replication. 

### Key attributes

- Data availability and redundancy across zones within regions.
- Bring data into same zone as compute for lowest latency-envelope.
- Efficient storage-based data replication without load on compute infrastructure.
- Lower TCO due to absence of data transfer fees.

To learn which data protection option is best for you, see [Understand data protection and disaster recovery options in Azure NetApp Files](/azure/azure-netapp-files/data-protection-disaster-recovery-options). 