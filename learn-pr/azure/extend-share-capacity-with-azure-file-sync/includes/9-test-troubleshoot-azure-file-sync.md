There are several ways to monitor Azure File Sync. You could use the Azure portal, Azure Monitor, or the Event log on one of the Windows servers. You could also monitor by adding Azure File Sync performance counters to Performance Monitor.

You've set up the Azure File Sync components in your Azure environment and on the target server. Now you want to ensure the environment functions correctly, and monitor replication and file copy jobs.

## Common issues

The rest of this unit you'll see how you can monitor and check for syncing issues. But first let's look at some common issues and how they could be resolved.

### Can't mount the Azure file share

If you're unable to mount your Azure file share on your Windows Server, it could be that your company's firewall rules are blocking network traffic. Azure needs to have port 445 open to connect to Azure datacenters. Azure also denies connections that aren't secure. So your on-premises Windows Server has to support SMB encryption. If that isn't possible, you can disable secure transfers on the Azure storage account, but your company has to accept the associated lack of security with this approach.

### Files or directory won't sync

The most common cause for files not syncing is invalid filenames. Using the assessment tool should help identify issues with existing file  names. However, if new files are created with invalid characters after the sync is set up, you'll need to identify them with the monitoring tools.

## Check the file share sync

To check that files are replicating, open two File Explorer sessions. In the first window, browse to the folder path that's synced to Azure. For your company, the path is C:\CADFolder.

In the second File Explorer window, add a network connection mapped to the Azure file share like `\\<your-azure-fileshare>.file.core.windows.net\foldername`.

In the first window, add a new text document in the CADFolder. Then edit the file to add some text. The file should appear in the mapped drive location within seconds. Open the file and check the contents match your local copy. If the contents match, the replication between Azure and the server endpoint is healthy.

## View server health and metrics for Storage Sync Service 

You can view **Server health**, **Server endpoint health**, and **Metrics** from the Storage Sync Service properties in the Azure portal.

- *Registered server health*: If the server state is *Online*, then it's communicating successfully with the service. If the server state is *Appears Offline*, the Storage Sync Monitor process service should be checked to ensure it's running on the server.
- *Server endpoint health*: Server endpoint health is calculated based on events logged in **Telemetry**. If there are any errors, the sync health state will be registered as *unhealthy*.
- *Metrics*: Various metrics can be viewed from within the Storage Sync Service. These metrics are:
    - *Bytes synced*: Size of data transferred
    - *Cloud tiering recall*: Size of data recalled
    - *Files not syncing* Count of files that are failing to sync
    - *Files synced*: Count of files transferred (upload and download)
    - *Server online status*: Count of heartbeats received from the server

## Use Azure Monitor

Azure Monitor allows you to view, analyze, and act on data in a central location in the portal. The Azure File Sync-specific metrics shown in Azure Monitor are:

- *Bytes synced*: Size of data transferred
- *Cloud tiering recall*: Size of data recalled
- *Files not syncing*: Count of files that are failing to sync
- *Files synced*: Count of files transferred (upload and download)
- *Server online status*: Count of heartbeats received from the server
- *Sync session result*: Sync session result, 1 = successful; 0 = failed sync

## View Windows Event Logs

The Telemetry Event Log is used to identify the registered server, sync, and cloud tiering health. Go to the Event Viewer, under the path **Applications and Services\Microsoft\FileSync\Agent**.

Each event log entry contains different event IDs that identify sync health, registered server health, and cloud tiering health issues.

- *Event ID 9102*: Logged after a sync session finishes. A result of **HRESULT=0** points to a success but anything else is classed as a failure.
- *Event ID 9302*: Logged every five to 10 minutes when there's an active sync in operation. A result of **AppliedItemCount > 0** means a sync is progressing successfully.
- *Event ID 9301*: Logged every 30 seconds when a server communicates with the service to query for jobs. A result of **GetNextJob = 0** means the service can communicate with Azure.
- *Event ID 9003, 9016, and 9029*: Logged to monitor cloud tiering when used.

## Use Performance Monitor in Windows Server

Performance Monitor, included in Windows Server, can be used to monitor many aspects of the server in real time, including Azure File Sync. After you open the Performance Monitor from the Microsoft Management Console, you'll find the counters to add are under the **AFS Bytes Transferred** and **AFS Sync Operations** parent objects. These counters both have submetrics like Bytes, count of downloaded or uploaded sync operations, and total.