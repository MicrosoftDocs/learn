[Azure File Sync](/azure/storage/file-sync/file-sync-introduction) enables you to cache several Azure Files shares on an on-premises Windows Server or cloud virtual machine. You can use Azure File Sync to centralize your organization's file shares in Azure Files, while keeping the flexibility, performance, and compatibility of an on-premises file server. 

Azure File Sync consists of five main components that work together to synchronize files between on-premises Windows Servers and Azure file shares.

:::image type="content" source="../media/file-sync-1d3fd2e7.png" alt-text="Illustration that depicts how Azure File Sync can be used to cache an organization's file shares in Azure Files." border="false":::

- The **Storage Sync Service** is the primary Azure resource responsible for managing file synchronization. It can support up to 100 sync groups, operates within a single Azure region, and allows for up to 99 registered Windows Servers.
  
- The **sync group** establishes the synchronization setup, containing one cloud endpoint (Azure file share) and up to 50 server endpoints. Server endpoints are specific NTFS paths on registered Windows Servers, but cannot be on the system volume, and cloud tiering is not supported there.
  
- The **cloud endpoint** is an Azure file share that participates in the sync group. Only one cloud endpoint is allowed per sync group.
  
- The **server endpoint** is a path on a registered Windows Server that syncs with the cloud endpoint. The server endpoint must be an NTFS-formatted volume, and can’t be a system volume.
  
- The **Azure File Sync Agent** is installed on each Windows Server. The agent is a background Windows service for sync operations and management tasks. 


### Things to know about Azure File Sync

Let's take a look at the characteristics of Azure File Sync.

- Azure File Sync transforms Windows Server into a quick cache of your Azure Files shares.

- You can use any protocol that's available on Windows Server to access your data locally with Azure File Sync, including SMB, NFS, and FTPS.

- Azure File Sync supports as many caches as you need around the world.

- There is a maximum of 100 sync groups per Storage Sync Service, and 50 server endpoints per sync group.

### Things to consider when using Azure File Sync

There are many advantages to using Azure File Sync. Consider the following scenarios, and think about how you can use Azure File Sync with your Azure Files shares.

- **Consider application lift and shift**. Use Azure File Sync to move applications that require access between Azure and on-premises systems. Provide write access to the same data across Windows Servers and Azure Files. 

- **Consider support for branch offices**. Support your branch offices that need to back up files by using Azure File Sync. Use the service to set up a new server that connects to Azure storage.

- **Consider backup and disaster recovery**. After you implement Azure File Sync, Azure Backup backs up your on-premises data. Restore file metadata immediately and recall data as needed for rapid disaster recovery.

- **Consider file archiving with cloud tiering**. Azure File Sync stores only recently accessed data on local servers. Implement cloud tiering so older data moves to Azure Files.
