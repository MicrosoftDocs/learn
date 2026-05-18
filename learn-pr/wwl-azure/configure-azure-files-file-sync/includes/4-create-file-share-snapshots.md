Azure Files provides the capability to take share [snapshots of file shares](/azure/storage/files/storage-snapshots-files). Share snapshots provide point-in-time copies of your Azure file shares that protect against accidental deletion and enable recovery from application errors. 

:::image type="content" source="../media/file-share-snapshot-cbda2136.png" alt-text="Screenshot of a file share snapshot that shows the snapshot name and date it was created."::: 

## Things to know about file share snapshots
* Snapshots are incremental, read-only point-in-time copies at the share level.
* To reduce time and cost only captures from the last snapshot.
* Same experience for SMB and NFS shares in all Azure public regions.
* Snapshot adds a unique timestamp to the share URI.
* Uses the shares redundancy settings.
* Up to 200 snapshots per file share for low-RPO recovery points.
* Snapshots persist until deleted. Deleting the share deletes all snapshots.
* Azure Backup can lease snapshots to help prevent accidental deletion.
* Restore a file, folder, or full share; full restore requires only the latest snapshot.

### Things to consider when using file share snapshots
File share snapshots can help you protect and recover your data. As you review the benefits, consider where snapshots fit into your Azure Files setup.

| Benefit | Description |
| --- | --- |
| Protect against application error and data corruption | File-share workloads constantly read and write data. If a misconfiguration, bad deployment, or software bug overwrites or corrupts data, a snapshot lets you roll the share back to a known-good point in time. Take a snapshot before releasing new code so you have a clean restore point if something goes wrong. |
| Protect against accidental deletions or unintended changes | If a file is changed, snapshots give you a quick way to restore an earlier version. Use snapshots to roll back to the last good copy when something unexpected happens. |
| Support backup and recovery | Create snapshots on a schedule to build a backup history for your file share. Keeping prior versions makes it easier to meet audit needs and recover data after mistakes or a broader outage. |

For automated snapshot creation or integration with existing scripts, PowerShell and Azure CLI provide programmatic access to snapshot operations. Both tools support adding metadata to snapshots and can be scheduled through Azure Automation, GitHub Actions, or any continuous integration system. 


