


Contoso, like many companies, has multiple file servers in separate locations. With DFS, you can replicate folder content between file servers, and publish file shares in a single namespace. Windows Server has the following two DFS-related role services:

- DFS Namespaces. DFS Namespaces (DFS-N) enables you to group shared folders that are on different servers into one or more logically structured namespaces. Each namespace presents to users as a single shared folder with a series of subfolders. However, the underlying structure of the namespace can consist of numerous file shares that are on different servers in multiple sites.
- DFS Replication. DFS Replication is a multi-master replication engine that you can use to sync folders on multiple servers across local area network (LAN) or wide area network (WAN) network connections. It uses the remote differential compression (RDC) protocol to update only the portions of files that have changed since the last replication. DFS Replication can be used with DFS Namespaces or by itself.

## DFS and Azure File Sync

File Sync is compatible with DFS-N and DFSR. You can install the File Sync agent on DFSR servers, and then sync data between those server endpoints and the cloud endpoint. DFSR and File Sync are both replication solutions that can work side by side. However, File Sync often replaces DFSR because it has other advantages, such as syncing files to an Azure file share (where it can be backed up centrally), rapid namespace restoration, and cloud tiering. However, there are scenarios where you would want to use DFSR and File Sync together, such as:

- You're in the process of migrating from a DFSR deployment to a File Sync deployment. After migration is complete, you retire DFSR.
- Some of the DFSR servers in a replication group don't have internet connectivity. File Sync requires internet connectivity.
- You need to have one-way replication. For example, you're consolidating data from branch servers to a single hub server from which you want to sync it with an Azure file share by using File Sync. The folder on the hub server into which you're consolidating data can be a server endpoint in a single Azure sync group.

If you want to use File Sync and DFSR side by side, you must:

- Disable File Sync cloud tiering on volumes with DFSR-replicated folders.
- Not configure DFSR read-only replication folders as server endpoints.

## Migrate from DFSR to Azure File Sync

To migrate a DFSR deployment to File Sync, you must perform the following high-level steps:

1. Create an Azure storage account, an Azure file share, and a Storage Sync Service resource in your Azure subscription.
2. Create a Storage Sync Service sync group to represent the DFSR topology that you're replacing. In DFSR, replication groups define the replication topology. You must define the same topology in File Sync by using sync groups.
3. Install the File Sync agent on the DFSR server that has all the data that you want to migrate.
4. Register the server in File Sync, and then create the first server endpoint. Don't enable cloud tiering for the first server endpoint.
5. Wait until all the server endpoint data syncs to the Azure file share (cloud endpoint).
6. Install and register the File Sync agent on each remaining DFSR server.
7. Disable DFSR.
8. Create a server endpoint on each of the DFSR servers. Don't enable cloud tiering.
9. Ensure that the sync completes, and then test your topology as desired.
10. Retire DFSR.
11. You can now enable cloud tiering on any server endpoint you wish.
