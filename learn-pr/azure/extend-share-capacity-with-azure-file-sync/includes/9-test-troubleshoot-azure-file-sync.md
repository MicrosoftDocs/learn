There are several ways to monitor Azure File Sync. You could use the Azure portal, Azure Monitor, or the event log on one of the Windows Server computers. You could also monitor Azure File Sync by adding Azure File Sync performance counters to Performance Monitor.

You set up the Azure File Sync components in your Azure environment and on the target server. Now, you want to ensure the environment functions correctly and monitor replication and file-copy jobs.

## Common problems

Later in this unit, you see how you can monitor Azure File Sync and check for syncing problems. But first, look at some common problems and how they could be resolved.

### Can't mount the Azure file share

If you're unable to mount your Azure file share on Windows Server, it could be that your company's firewall rules are blocking network traffic. Azure needs to have port 445 open to connect to Azure data centers. Azure also denies connections that aren't secure, so your on-premises Windows Server computer has to support SMB encryption. If that isn't possible, you can disable secure transfers on the Azure storage account, but your company has to accept the associated lack of security if you use this approach.

### Files or directory won't sync

The most common cause for files not syncing is invalid file names. The assessment tool can help you identify problems with existing file names. However, if new files are created with invalid characters after the sync is set up, you need to identify them with the monitoring tools.

## Check the file share sync

To check that files are replicating, open two File Explorer sessions. In the first window, browse to the folder path that syncs to Azure.

In the second File Explorer window, add a network connection that maps to the Azure file share, like `\\<your-azure-file-share>.file.core.windows.net\foldername`.

In the first window, add a new text document in the *CADFolder*, then add some text to the file. The file should appear in the mapped drive location within seconds. Open the file and check whether the contents match the contents of your local copy. If the contents match, the replication between Azure and the server endpoint is healthy.

## View server health and metrics for Storage Sync Service

You can view server health, server endpoint health, and metrics in the Storage Sync Service properties in the Azure portal.

- **Registered server health**: If the server state is **Online**, it's communicating successfully with the service. If the server state is **Appears Offline**, check the Storage Sync Monitor process service to ensure that it's running on the server.
- **Server endpoint health**: Server endpoint health is calculated based on events logged in **Telemetry**. If there are any errors, the sync health state registers as **unhealthy**.
- **Metrics**: You can view various metrics from within the Storage Sync Service. The metrics are:
  - **Bytes synced**: Size of data transferred
  - **Cloud tiering recall**: Size of data recalled
  - **Files not syncing**: Count of files that are failing to sync
  - **Files synced**: Count of files transferred (upload and download)
  - **Server online status**: Count of heartbeats received from the server

## Use Azure Monitor

Azure Monitor allows you to view, analyze, and act on data in a central location in the portal. Here are the metrics shown in Azure Monitor that are specific to Azure File Sync:

- **Bytes synced**: Size of data transferred
- **Cloud tiering recall**: Size of data recalled
- **Files not syncing**: Count of files that are failing to sync
- **Files synced**: Count of files transferred (upload and download)
- **Server online status**: Count of heartbeats received from the server
- **Sync session result**: Sync session result (1 = successful. 0 = failed sync)

## View Windows Event logs

The Telemetry Event Log identifies the registered server, sync, and cloud tiering health. Go to the Event Viewer, under the path **Applications and Services\Microsoft\FileSync\Agent**.

Each event log entry contains various event IDs that identify sync health, registered server health, and cloud tiering health problems.

- Event ID 9102: Logged after a sync session finishes. A result of **HRESULT=0** indicates a successful sync. Anything else indicates a failure.
- Event ID 9302: Logged every 5 to 10 minutes when there's an active sync in progress. A result of **AppliedItemCount > 0** means a sync is progressing successfully.
- Event ID 9301: Logged every 30 seconds when a server communicates with the service to query for jobs. A result of **GetNextJob = 0** means the service can communicate with Azure.
- Event IDs 9003, 9016, and 9029: Logged to monitor cloud tiering, when tiering is used.

## Use Performance Monitor in Windows Server

You can use Performance Monitor, which is included in Windows Server, to monitor many aspects of the server in real time, including Azure File Sync. Open Performance Monitor from the Microsoft Management Console. The counters you need to add are under the **AFS Bytes Transferred** and **AFS Sync Operations** parent objects. These counters both have submetrics, like bytes, count of downloaded or uploaded sync operations, and total.
