There are two cases to consider:

 -  You need the SAP HANA database to go back to the latest status of data. In this case, there's a self-service script with which you can perform the failover without the need to contact Microsoft. For the failback, you need to work with Microsoft.
 -  You want to restore to a storage snapshot that's not the latest replicated snapshot. In this case, you need to work with Microsoft.

> [!NOTE]
> The following steps must be done on the HANA Large Instance unit, which represents the DR unit.

To restore to the latest replicated storage snapshots, follow the steps in **Perform full DR failover - azure\_hana\_dr\_failover** in the [Manual Recovery Guide for SAP HANA on Azure from Storage Snapshot](https://github.com/Azure/hana-large-instances-self-service-scripts/blob/master/guides/Manual%20recovery%20of%20snapshot%20with%20HANA%20Studio.pdf).

If you want to have multiple SAP HANA instances failed over, run the azure\_hana\_dr\_failover command several times. When requested, enter the SAP HANA SID you want to fail over and restore.

You can test the DR failover also without impacting the actual replication relationship. To perform a test failover, follow the steps in **Perform a test DR failover - azure\_hana\_test\_dr\_failover** in [Microsoft snapshot tools for SAP HANA on Azure](https://github.com/Azure/hana-large-instances-self-service-scripts/blob/master/snapshot_tools_v4.3/Microsoft%20Snapshot%20Tools%20for%20SAP%20HANA%20on%20Azure%20v4.3.md).

> [!IMPORTANT]
> Do not run any production transactions on the instance that you created in the DR site through the process of testing a failover. The command azure\_hana\_test\_dr\_failover creates a set of volumes that have no relationship to the primary site. As a result, synchronization back to the primary site is not possible.

If you want to have multiple SAP HANA instances to test, run the script several times. When requested, enter the SAP HANA SID of the instance you want to test for failover.

If you need to fail over to the DR site to rescue some data that was deleted hours ago and need the DR volumes to be set to an earlier snapshot, this procedure applies.

1.  Shut down the nonproduction instance of HANA on the disaster recovery unit of HANA Large Instances that you're running. A dormant HANA production instance is preinstalled.
2.  Make sure that no SAP HANA processes are running. Use the following command for this check:
    
    ```bash
    /usr/sap/hostctrl/exe/sapcontrol –nr [HANA instance number] - function GetProcessList
    
    ```
    
    The output should show you the hdbdaemon process in a stopped state and no other HANA processes in a running or started state.
3.  Determine to which snapshot name or SAP HANA backup ID you want to have the disaster recovery site restored. In real disaster recovery cases, this snapshot is usually the latest snapshot. If you need to recover lost data, pick an earlier snapshot.
4.  Contact Azure Support through a high-priority support request. Ask for the restore of that snapshot with the name and date of the snapshot or the HANA backup ID on the DR site. The default is that the operations side restores the **/hana/data** volume only. If you want to have the **/hana/logbackups** volumes too, you need to specifically state that. Do not restore the **/hana/shared** volume. Instead, choose specific files like global.ini out of the .snapshot directory and its subdirectories after you remount the **/hana/shared** volume for PRD. On the operations side, the following steps occur:
    
     -  The replication of snapshots from the production volume to the disaster recovery volumes is stopped. This disruption might have already happened if an outage at the production site is the reason you need to perform the disaster recovery procedure.
     -  The storage snapshot name or snapshot with the backup ID you chose is restored on the disaster recovery volumes.
     -  After the restore, the disaster recovery volumes are available to be mounted to the HANA Large Instance units in the disaster recovery region.
5.  Mount the disaster recovery volumes to the HANA Large Instance unit in the disaster recovery site.
6.  Start the dormant SAP HANA production instance.
7.  If you chose to copy transaction log backup logs to reduce the RPO time, merge the transaction log backups into the newly mounted DR **/hana/logbackups** directory. Don't overwrite existing backups. Copy newer backups that weren't replicated with the latest replication of a storage snapshot.
8.  You can also restore single files out of the snapshots that weren't replicated to the **/hana/shared/PRD** volume in the DR Azure region.

The following steps show how to recover the SAP HANA production instance based on the restored storage snapshot and the transaction log backups that are available.

1.  Change the backup location to **/hana/logbackups** by using SAP HANA Studio.
2.  SAP HANA scans through the backup file locations and suggests the most recent transaction log backup to restore to. The scan can take a few minutes until a screen like the following appears:
3.  Adjust some of the default settings:
    
     -  Clear **Use Delta Backups**.
     -  Select **Initialize Log Area**.
4.  Select **Finish**.

A progress window should appear. If the restore stops responding at the Finish screen and doesn't show the progress screen, confirm that all the SAP HANA instances on the worker nodes are running. If necessary, start the SAP HANA instances manually.
