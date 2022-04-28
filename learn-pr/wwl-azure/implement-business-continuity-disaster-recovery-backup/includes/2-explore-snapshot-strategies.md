The frequency of snapshots for the different types depends on whether you use the SAP HANA Large Instance disaster recovery functionality. This functionality relies on storage snapshots, which might require special recommendations for the frequency and execution periods of the storage snapshots.

In the considerations and recommendations that follow, the assumption is that you do not use the disaster recovery functionality that SAP HANA Large Instances offers. Instead, you use the storage snapshots to have backups and be able to provide point-in-time recovery for the last 30 days. Given the limitations of the number of snapshots and space, consider the following requirements:

 -  The recovery time for point-in-time recovery.
 -  The space used.
 -  The recovery point and recovery time objectives for potential recovery from a disaster.
 -  The eventual execution of SAP HANA full-database backups against disks. Whenever a full-database backup against disks or the Backint interface is performed, the execution of the storage snapshots fails. If you plan to run full-database backups on top of storage snapshots, make sure that the execution of the storage snapshots is disabled during this time.
 -  The number of snapshots per volume. Although the hardware can sustain 255 snapshots per volume, you should stay well below this number. The recommendation is 250 or less.

If you don't use the disaster recovery functionality of SAP HANA Large Instances, the snapshot period is less frequent. In such cases, perform the combined snapshots on **/hana/data** and **/hana/shared**, which includes **/usr/sap**, in 12-hour or 24-hour periods. Keep the snapshots for a month. The same is true for the snapshots of the log backup volume. The execution of SAP HANA transaction log backups against the log backup volume occurs in 5-minute to 15-minute periods.

Scheduled storage snapshots are best performed by using cron. Use the same script for all backups and disaster recovery needs. Modify the script inputs to match the various requested backup times. These snapshots are all scheduled differently in cron depending on their execution time. It can be hourly, every 12 hours, daily, or weekly.

The following example shows a cron schedule in /etc/crontab:

```bash
00 1-23 * * * ./azure_hana_backup --type=hana --prefix=hourlyhana --frequency=15min --retention=48

10 00 * * * ./azure_hana_backup --type=hana --prefix=dailyhana --frequency=15min --retention=28

00,05,10,15,20,25,30,35,40,45,50,55 * * * * ./azure_hana_backup --type=logs --prefix=regularlogback --frequency=3min --retention=28

22 12 * * * ./azure_hana_backup --type=logs --prefix=dailylogback --frequency=3min --retention=28

30 00 * * * ./azure_hana_backup --type=boot --boottype=TypeI --prefix=dailyboot --frequency=15min --retention=28

```

In the previous example, an hourly combined snapshot covers the volumes that contain the **/hana/data** and **/hana/shared/SID**, which includes **/usr/sap**, locations. Use this type of snapshot for a faster point-in-time recovery within the past two days. There's also a daily snapshot on those volumes. So, you have two days of coverage by hourly snapshots plus four weeks of coverage by daily snapshots. The transaction log backup volume also is backed up daily. These backups are kept for four weeks.

As you see in the third line of crontab, the backup of the SAP HANA transaction log is scheduled to run every 5 minutes. The start times of the different cron jobs that run storage snapshots are staggered. In this way, the snapshots don't run all at once at a certain point in time.

In the following example, you perform a combined snapshot that covers the volumes that contain the **/hana/data** and **/hana/shared/SID**, which includes **/usr/sap**, locations on an hourly basis. You keep these snapshots for two days. The snapshots of the transaction log backup volumes run on a 5-minute basis and are kept for four hours. As before, the backup of the SAP HANA transaction log file is scheduled to run every 5 minutes.

The snapshot of the transaction log backup volume is performed with a 2-minute delay after the transaction log backup has started. Under normal circumstances, the SAP HANA transaction log backup finishes within those 2 minutes. As before, the volume that contains the boot LUN is backed up once per day by a storage snapshot and is kept for four weeks.

```bash
10 0-23 * * * ./azure_hana_backup --type=hana ==prefix=hourlyhana --frequency=15min --retention=48

0,5,10,15,20,25,30,35,40,45,50,55 * * * * ./azure_hana_backup --type=logs --prefix=regularlogback --frequency=3min --retention=28

2,7,12,17,22,27,32,37,42,47,52,57 * * * * ./azure_hana_backup --type=logs --prefix=logback --frequency=3min --retention=48

30 00 * * * ./azure_hana_backup --type=boot --boottype=TypeII --prefix=dailyboot --frequency=15min --retention=28

```

SAP HANA performs regular writes against the **/hana/log** volume to document the committed changes to the database. On a regular basis, SAP HANA writes a savepoint to the **/hana/data** volume. As specified in crontab, an SAP HANA transaction log backup runs every 5 minutes.

You also see that an SAP HANA snapshot runs every hour as a result of triggering a combined storage snapshot over the **/hana/data** and **/hana/shared/SID** volumes. After the SAP HANA snapshot succeeds, the combined storage snapshot runs. As instructed in crontab, the storage snapshot on the **/hana/logbackup** volume runs every 5 minutes, around 2 minutes after the SAP HANA transaction log backup.

> [!IMPORTANT]
> The use of storage snapshots for SAP HANA backups is valuable only when the snapshots are performed in conjunction with SAP HANA transaction log backups. These transaction log backups need to cover the time periods between the storage snapshots.

If you've set a commitment to users of a point-in-time recovery of 30 days, you need to:

 -  Access a combined storage snapshot over **/hana/data** and **/hana/shared/SID** that's 30 days old, in extreme cases.
 -  Have contiguous transaction log backups that cover the time between any of the combined storage snapshots. So, the oldest snapshot of the transaction log backup volume needs to be 30 days old. This isn't the case if you copy the transaction log backups to another NFS share that's located on Azure Storage. In that case, you might pull old transaction log backups from that NFS share.

To benefit from storage snapshots and the eventual storage replication of transaction log backups, change the location to which SAP HANA writes the transaction log backups. You can make this change in SAP HANA Studio.

Although SAP HANA backs up full log segments automatically, specify a log backup interval to be deterministic. This is especially true when you use the disaster recovery option because you usually want to run log backups with a deterministic period. In the following case, 15 minutes is set as the log backup interval.

You also can choose backups that are more frequent than every 15 minutes. A more frequent setting is often used in conjunction with disaster recovery functionality of SAP HANA Large Instances. Some customers perform transaction log backups every 5 minutes.

If the database has never been backed up, the final step is to perform a file-based database backup to create a single backup entry that must exist within the backup catalog. Otherwise, SAP HANA can't initiate your specified log backups.

## Monitor the number and size of snapshots on the disk volume

On a specific storage volume, you can monitor the number of snapshots and the storage consumption of those snapshots. The ls command doesn't show the snapshot directory or files. The Linux OS command du shows details about those storage snapshots because they're stored on the same volumes. Use the command with the following options:

 -  **du –sh .snapshot**: This option provides a total of all the snapshots within the snapshot directory.
 -  **du –sh --max-depth=1**: This option lists all the snapshots that are saved in the .snapshot folder and the size of each snapshot.
 -  **du –hc**: This option provides the total size used by all the snapshots.

Use these commands to make sure that the snapshots that are taken and stored don't consume all the storage on the volumes.

> [!NOTE]
> The snapshots of the boot LUN aren't visible with the previous commands.

## Get details of snapshots

To get more details on snapshots, use the script azure\_hana\_snapshot\_details. You can run this script in either location if there's an active server in the disaster recovery location. The script provides the following output, broken down by each volume that contains snapshots:

 -  The size of total snapshots in a volume
 -  The following details in each snapshot in that volume:
    
     -  Snapshot name
     -  Create time
     -  Size of the snapshot
     -  Frequency of the snapshot
     -  SAP HANA Backup ID associated with that snapshot, if relevant

## Reduce the number of snapshots on a server

As previously explained, you can reduce the number of certain labels of snapshots that you store. The last two parameters of the command to initiate a snapshot are the label and the number of snapshots you want to retain.

```bash
./azure_hana_backup --type=hana --prefix=dailyhana --frequency=15min --retention=28

```

In the previous example, the snapshot label is dailyhana. The number of snapshots with this label to be kept is 28. As you respond to disk space consumption, you might want to reduce the number of stored snapshots. An easy way to reduce the number of snapshots to 15, for example, is to run the script with the last parameter set to 15:

```bash
./azure_hana_backup --type=hana --prefix=dailyhana --frequency=15min --retention=15

```

If you run the script with this setting, the number of snapshots, which includes the new storage snapshot, is 15. The 15 most recent snapshots are kept, and the 15 older snapshots are deleted.

> [!NOTE]
> This script reduces the number of snapshots only if there are snapshots more than one hour old. The script doesn't delete snapshots that are less than one hour old. These restrictions are related to the optional disaster recovery functionality offered.

If you no longer want to maintain a set of snapshots with the backup prefix `dailyhana` in the syntax examples, run the script with 0 as the retention number. All snapshots that match that label are then removed. Removing all snapshots can affect the capabilities of HANA Large Instances disaster recovery functionality.

A second option to delete specific snapshots is to use the script azure\_hana\_snapshot\_delete. This script is designed to delete a snapshot or set of snapshots either by using the SAP HANA backup ID as found in SAP HANA Studio or through the snapshot name itself. Currently, the backup ID is only tied to the snapshots created for the SAP HANA snapshot type. Snapshot backups of the type logs and boot don't perform an SAP HANA snapshot, so there's no backup ID to be found for those snapshots. If the snapshot name is entered, it looks for all snapshots on the different volumes that match the entered snapshot name. Run the script as user root.

> [!IMPORTANT]
> If there's data that exists only on the snapshot you plan to delete, after the snapshot is deleted, that data is lost forever.

## File-level restore from a storage snapshot

For the snapshot types `hana` and `logs`, you can access the snapshots directly on the volumes in the .snapshot directory. There's a subdirectory for each of the snapshots. Copy each file in the state it was in at the point of the snapshot from that subdirectory into the actual directory structure.

In the current version of the script, there's no restore script provided for the snapshot restore as self-service. Snapshot restore can be performed as part of the self-service disaster recovery scripts at the disaster recovery site during failover. To restore a desired snapshot from the existing available snapshots, you must contact the Microsoft operations team by opening a service request.

> [!NOTE]
> Single file restore doesn't work for snapshots of the boot LUN independent of the type of the SAP HANA Large Instance units. The .snapshot directory isn't exposed in the boot LUN.

## Recover to the most recent SAP HANA snapshot

In a production-down scenario, the process of recovering from a storage snapshot can be started as a customer incident with Microsoft Azure Support. It's a high-urgency matter if data was deleted in a production system and the only way to retrieve it is to restore the production database.

In a different situation, a point-in-time recovery might be low urgency and planned days in advance. You can plan this recovery with SAP HANA on Azure instead of raising a high-priority flag. For example, you might plan to upgrade the SAP software by applying a new enhancement package. You then need to revert to a snapshot that represents the state before the enhancement package upgrade.

Before you send the request, you need to prepare. The SAP HANA on Azure team can then handle the request and provide the restored volumes. Afterward, you restore the SAP HANA database based on the snapshots.

To prepare for the request, follow these steps.

1.  **Decide which snapshot to restore**. Only the **hana/data** volume is restored unless you instruct otherwise.
2.  **Shut down the SAP HANA instance**.
3.  **Unmount the data volumes on each SAP HANA database node**. If the data volumes are still mounted to the operating system, the restoration of the snapshot fails.
4.  Open an Azure support request, and include instructions about the restoration of a specific snapshot:
    
     -  **During the restoration**: SAP HANA on Azure Service might ask you to attend a conference call to coordinate, verify, and confirm that the correct storage snapshot is restored.
     -  **After the restoration**: SAP HANA on Azure Service notifies you when the storage snapshot is restored.
5.  After the restoration process is complete, remount all the data volumes.

## Recover to another point in time

To restore to a certain point in time, see **Recover the database to the following point in time** in [Manual recovery guide for SAP HANA on Azure from a storage snapshot](https://github.com/Azure/hana-large-instances-self-service-scripts/blob/master/guides/Manual%20recovery%20of%20snapshot%20with%20HANA%20Studio.pdf).
