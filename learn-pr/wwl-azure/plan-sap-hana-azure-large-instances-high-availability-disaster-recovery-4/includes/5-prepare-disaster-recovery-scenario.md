In this scenario, you have a production system running on HANA Large Instances in the production Azure region. For the steps that follow, let's assume that the SID of that HANA system is "PRD," and that you have a non-production system running on HANA Large Instances in the DR Azure region. For the latter, let's assume that its SID is "TST."

If the server instance has not already been ordered with the additional storage volume set, SAP HANA on Azure Service Management attaches the additional set of volumes as a target for the production replica to the HANA Large Instance unit on which you're running the TST HANA instance. For that purpose, you need to provide the SID of your production HANA instance. After SAP HANA on Azure Service Management confirms the attachment of those volumes, you need to mount those volumes to the HANA Large Instance unit.

The next step is for you to install the second SAP HANA instance on the HANA Large Instance unit in the DR Azure region, where you run the TST HANA instance. The newly installed SAP HANA instance needs to have the same SID. The users created need to have the same UID and Group ID that the production instance has. If the installation succeeded, you need to:

 -  Implement the HLI storage snapshot preparation process described earlier.
 -  Use the HANABackupCustomerDetails.txt with the new HANA instance and verify whether connectivity into storage works correctly.
 -  Stop the newly installed SAP HANA instance on the HANA Large Instance unit in the DR Azure region.
 -  Unmount these PRD volumes and contact SAP HANA on Azure Service Management. The volumes can't stay mounted to the unit because they can't be accessible while functioning as a storage replication target.

The operations team establishes the replication relationship between the PRD volumes in the production Azure region and the PRD volumes in the DR Azure region.

> [!IMPORTANT]
> The **/hana/log** volume is not replicated because it is not necessary to restore the replicated SAP HANA database to a consistent state in the disaster recovery site.

Next, set up or adjust the storage snapshot backup schedule to get to your RTO and RPO in the disaster case. To minimize the recovery point objective, set the following replication intervals in the HANA Large Instance service:

 -  For the volumes covered by the combined snapshot (snapshot type HANA), set to replicate every 15 minutes to the equivalent storage volume targets in the disaster recovery site.
 -  For the transaction log backup volume (snapshot type logs), set to replicate every 3 minutes to the equivalent storage volume targets in the disaster recovery site.
 -  Perform a HANA type storage snapshot every 30 minutes to 1 hour.
 -  Perform SAP HANA transaction log backups every 5 minutes.
 -  Perform a logs type storage snapshot every 5-15 minutes. With this interval period, you achieve an RPO of around 15-25 minutes.

To achieve an even better RPO in the disaster recovery case, you can copy the HANA transaction log backups from SAP HANA on Azure (Large Instances) to the other Azure region. To achieve this further RPO reduction, perform the following steps:

1.  Back up the HANA transaction log as frequently as possible to **/hana/logbackups**.
2.  Use rsync to copy the transaction log backups to the NFS share-hosted Azure virtual machines. The VMs are in Azure virtual networks in the Azure production region and the DR regions. You need to connect both Azure virtual networks to the circuit connecting the production HANA Large Instances to Azure.
3.  Keep the transaction log backups in the region in the VM attached to the NFS exported storage.
4.  In a disaster failover case, supplement the transaction log backups you find on the **/hana/logbackups** volume with more recently taken transaction log backups on the NFS share in the disaster recovery site.
5.  Start a transaction log backup to restore to the latest backup that might be saved over to the DR region.

When HANA Large Instance operations confirm the replication relationship setup and you start the execution storage snapshot backups, the data replication begins.

As the replication progresses, the snapshots on the PRD volumes in the DR Azure regions are not restored. They are only stored. If the volumes are mounted in such a state, they represent the state in which you unmounted those volumes after the PRD SAP HANA instance was installed in the server unit in the DR Azure region. They also represent the storage backups that are not yet restored.

If there is a failover, you also can choose to restore to an older storage snapshot instead of the latest storage snapshot.

## Monitor disaster recovery replication

To monitor the status of your storage replication progress, run the script azure\_hana\_replication\_status. This command must be run from a unit that runs in the disaster recovery location to function as expected. The command works no matter whether replication is active. The command can be run for every HANA Large Instance unit of your tenant in the disaster recovery location. It can't be used to obtain details about the boot volume.
