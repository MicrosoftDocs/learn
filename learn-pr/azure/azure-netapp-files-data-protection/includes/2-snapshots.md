You can use a snapshot to create a new volume (clone), restore a file, or revert a volume. In specific application data stored on Azure NetApp Files volumes, extra steps might be required to ensure application consistency. Snapshots are also efficient in storage space; only delta blocks between snapshots and the active volume are kept. 

Watch this video to understand how snapshots work in Azure NetApp Files: 

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=14bdb1ed-3e45-447a-978d-a8af4b20bffa]

## Protect data with Snapshots 

Azure NetApp Files backup supports policy-based (scheduled) snapshots and manual (on-demand) snapshots at the volume level. 

You can use several methods to create and maintain snapshots: 

### Manually (on-demand)

- The Azure portal, REST API, Azure CLI, or PowerShell tools 
- Scripts  

### Automated

- Snapshot policies via the Azure portal, REST API, Azure CLI, or PowerShell tools
- Application consistent snapshot tooling, such as AzAcSnap

To learn more about how to manage snapshot policies, see [How to manage Azure NetApp Files snapshot policies](/azure/azure-netapp-files/snapshots-manage-policy).

## Efficient data restores 

Azure NetApp Files snapshots allow near-instantaneous, secure, and optionally user-managed restores. 

Restore a snapshot to a new volume to create an independent read-write volume. The restored volumes can be removed when the contents are no longer required. Depending on volume size and capacity, this process can take considerable time during which the parent volume and snapshot cannot be deleted. However, the volume can already be accessed after initial creation, while the copy process is in progress in the background. 

Revert a volume to a snapshot to restore the volume to a previous point-in-time very quickly. Beware that any snapshots taken after the snapshot selected for the revert will be lost, as that data didn't exist when the snapshot selected for revert was taken.

To reduce the risk of losing important snapshot data, go back in time in steps until you locate the correct snapshot. Each snapshot revert takes approximately 1-2 minutes. 

Watch this video to understand how to restore data in Azure NetApp Files with snapshots.

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=16e6a5ae-c852-4bb4-b6a1-dbc41dfc5d86]

To learn more, see [Ways to restore data from snapshots in Azure NetApp Files](/azure/azure-netapp-files/snapshots-introduction#ways-to-restore-data-from-snapshots).
