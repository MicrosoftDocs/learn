


Azure File Sync is a service that allows you to cache Azure file shares on an on-premises Windows Server file server. With cloud tiering enabled, Azure File Sync helps ensure that a file server always has free available space while making more files available than a file server could store locally. It presents the whole folder structure and files as if they were available locally, although some files might be tiered to the Azure file share. If a user tries to access such a file, the file is recalled (transparently downloaded from the Azure file share) in the background and then presented to user. By doing that, File Sync transforms an on-premises Windows Server into a quick cache of your Azure file share. File Sync supports the multi-master model and can sync data between multiple file servers.

## Azure File Sync terminology

If you want to understand how File Sync works, you must understand the terms that relate to it. The diagram uses this terminology to depict how Azure File Sync works. 


![A diagram depicts how Azure File Sync works, using the process described in the following text.](../media/m11-azure-file-synchronization-components-007.png)


- The server running Windows Server in this diagram has the Azure File Sync agent and is registered with Azure File Sync.
- Next to this server are two sync groups: Accounting and Sales.
- The Accounting sync group has D:\Accounting as the server endpoint.
- The Sales sync group has D:\Sales as the server endpoint.
- Each sync group has a two-way interaction with the cloud endpoint, which means that the server endpoint syncs its content with the cloud endpoint content (the Azure file share is the cloud endpoint).
- Both cloud endpoints have a two-way interaction with the same Storage Sync Service.
- Azure File Sync uses the Storage Sync Service.
- Storage Sync Service has a two-way interaction with the Azure storage account, which symbolizes that the cloud endpoints (Azure file shares) are created in the Azure storage account.
- The storage account has two-way interaction with Azure Backup, which means the Azure storage account can be backed up by using Backup.

The following table describes the various components in the diagram.

|Component|Description|
|---------------------| ------------------------------------------------------------|
|Storage Sync Service|This is the top-level Azure resource for File Sync. It's used to create sync groups, which connect Azure storage accounts, Azure file shares (also called *cloud endpoints*), and *server endpoints* (file locations on a registered Windows Server file server).|
|Sync group|A *sync group* defines the sync topology for a set of files. Endpoints within a sync group are kept in sync with each other. If, for example, you have two distinct sets of files that you want to manage with File Sync, you need to create two sync groups and add different endpoints to each sync group. Storage Sync Service can have up to 100 sync groups, and a sync group can have up to 50 server endpoints. (A sync group always has one cloud endpoint).|
|Registered server|The registered server object represents a trust relationship between a server that's running Windows Server (or a cluster) and the Storage Sync Service. You can register up to 99 Windows Server computers per Storage Sync Service, regardless of their domain membership. Single servers that are running Windows Server (or a cluster) can be registered with only one Storage Sync Service at any given time.|
|Azure File Sync agent| The File Sync agent is a downloadable package that enables Windows Server to sync with an Azure file share. The File Sync agent updates regularly and has three main components: The background Windows service that monitors changes on server endpoints and initiates sync sessions to Azure. After detecting a change, the file is encrypted and syncs to the Azure file share. The File Sync file system filter, which is responsible for tiering files to Azure Files when cloud tiering is enabled for the server endpoint. Tiering occurs dynamically in the background. PowerShell management cmdlets, which you can use to manage File Sync.|
|Server endpoint|A *server endpoint* represents a specific location on a registered Windows Server computer, such as a folder or a volume. You can add multiple server endpoints for the same Windows Server computer, but they must be in different sync groups. Server endpoints can be on the same volume of the same Windows Server computer if their namespaces don't overlap. For example, D:\Folder1 and D:\Folder2 can be two server endpoints on the same Windows Server computer. You can configure cloud tiering individually for each server endpoint.|
|Cloud endpoint|A *cloud endpoint* is an Azure file share that's part of a sync group. The entire Azure file share syncs, but an Azure file share can be a member of only one sync group. If you add an Azure file share that has an existing set of files as a cloud endpoint to a sync group, the existing files will sync to server endpoints that you add to the same sync group.|

## Benefits of Azure File Sync

Azure File Sync provides your organization with a number of benefits, including multisite sync, cloud tiering and backup, and disaster recovery.

### Multisite sync

The File Sync agent syncs a server endpoint with an Azure file share. After you add, remove, or modify files, folders, or their permissions on a server endpoint, the agent detects the change and replicates it to the cloud. Changes are detected immediately and added files are visible on the Azure file share in a few seconds. Larger files take longer to become available based on their size and the speed of the internet connection.

When you have multiple server endpoints in the same sync group, the File Sync agent syncs their content regardless of endpoint locations—they can be on the same network, or in different parts of the world. In this way, File Sync can be used for multisite sync. Similar functionality provides the DFS Replication role service on Windows Server.

File Sync implements multi-master replication, which means that changes that occur at any server endpoint sync to all other endpoints in the same sync group.

File Sync doesn't provide locking, which means that if the same file is modified on multiple endpoints at the same time before the first modification syncs, a conflict occurs. File Sync detects such conflicts, which results in multiple copies of the file (conflicting file names include the name of the endpoint that caused the conflict).

### Cloud tiering

Cloud tiering is an optional feature that you can enable and configure for server endpoints. When cloud tiering isn't enabled, all files are kept both locally on the server endpoint and in the Azure file share. However, the disk space that's available locally limits a server endpoint, and you can run out of space when copying too many large files to a server endpoint.

With cloud tiering, you can define the percentage of free space that must always be available in the server endpoint. You can also define whether to locally store only recently accessed files. You can copy as many files as you want to a server endpoint, and all the files sync to the cloud endpoint. However, files that exceed the free space threshold for the volume or that haven't been accessed recently get removed from the local storage but remain on the Azure file share. Such files are still available and are displayed on the server endpoint as a reparse point with the offline attribute. Users can access them, but the files don't take up any space on the server endpoint.

### Cloud backup

The File Sync agent helps ensure that all server endpoint files sync to an Azure file share. You can create up to 200 Azure file share snapshots, which you can use to restore previous versions of any file; for example, by using the **Previous Versions** feature in File Explorer. Previous versions are also available for files that aren't cached on a server endpoint because of cloud tiering.

You can use Azure Backup to perform one scheduled daily backup of Azure file shares, or up to four on-demand daily backups. Azure Backup uses snapshots for creating an Azure file share backup. Based on your retention policy, an Azure file share backup can be preserved for up to 10 years.

### Disaster recovery

All server endpoint files sync to Azure file shares, which makes it possible to build a new server endpoint quickly—for example, if a disaster occurs or if you must add another server endpoint to your network. You only need to install the File Sync agent on a new Windows Server computer, register the server, and then add it as a server endpoint to the sync group. Regardless of the amount of data on an Azure file share, the sync agent first pulls down the entire namespace, which makes folder structure and files almost immediately displayed and available on the new server. This process is called *fast disaster recovery*, or a *rapid namespace restore*. While the sync agent starts to cache files on the server endpoint in the background, depending on cloud tiering settings users can already access the files. If they try accessing a file that isn't yet cached, the sync agent immediately and seamlessly recalls the file data from the Azure file share. A user can access and open the file without noticing that the file wasn't cached locally on the server endpoint.
