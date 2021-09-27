Use **Azure File Sync** to centralize your organization's file shares in Azure Files, while keeping the flexibility, performance, and compatibility of an on-premises file server. Azure File Sync transforms Windows Server into a quick cache of your Azure file share. You can use any protocol that's available on Windows Server to access your data locally, including SMB, NFS, and FTPS. You can have as many caches as you need across the world.

:::image type="content" source="../media/file-sync-1d3fd2e7.png" alt-text="Illustration depicting that Azure File Sync can be used to cache an organization's file shares in Azure Files. Different graphics represent different geographic locations like Mexico, Munich, Seattle, and a branch office, with Azure represented by a standard cloud icon.":::


There are many uses and advantages to file sync.

 -  **Lift and shift**. The ability to move applications that require access between Azure and on-premises systems. Provide write access to the same data across Windows Servers and Azure Files. This enables companies with multiple offices have a need to share files with all offices.
 -  **Branch Offices**. Branch offices need to backup files, or you need to setup a new server that will connect to Azure storage.
 -  **Backup and Disaster Recovery**. Once File Sync is implemented, Azure Backup will back up your on-premises data. Also, you can restore file metadata immediately and recall data as needed for rapid disaster recovery.
 -  **File Archiving**. Only recently accessed data is located on local servers. Non-used data moves to Azure in what is called Cloud Tiering.

> [!NOTE]
> Cloud tiering is an optional feature of Azure File Sync in which frequently accessed files are cached locally on the server while all other files are tiered to Azure Files based on policy settings. When a file is tiered, the Azure File Sync file system replaces the file locally with a pointer, or reparse point. The reparse point represents a URL to the file in Azure Files. When a user opens a tiered file, Azure File Sync seamlessly recalls the file data from Azure Files without the user needing to know that the file is actually stored in Azure. Cloud Tiering files will have greyed icons with an offline O file attribute to let the user know the file is only in Azure.
