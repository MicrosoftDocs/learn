Azure Administrators are familiar with Azure Files and the Azure File Sync agent. They know how to implement fully managed file shares in the cloud by using industry standard protocols. They understand how to use Azure File Sync to cache Azure Files shares on an on-premises Windows Server or cloud virtual machine.

In this module, you learned when to use Azure File shares and how this feature compares to blobs and disks. You also reviewed Azure File features such as snapshots and soft delete. You learned how Azure File Sync can be used with on-premises data stores. You also were introduced to the Storage Explorer.

The main takeaways for this module are:

- Azure Files provides the SMB and NFS protocols, client libraries, and a REST interface that allows access from anywhere to stored files.

- Azure Files is ideal to lift and shift an application to the cloud that already uses the native file system APIs. Share data between the app and other applications running in Azure.

- Azure Files offers two industry-standard file system protocols for mounting Azure file shares: the Server Message Block (SMB) protocol and the Network File System (NFS) protocol.

- Azure Files offers two types of file shares: standard and premium. The premium tier stores data on modern solid-state drives (SSDs), while the standard tier uses hard disk drives (HDDs).

- File share snapshots capture a point-in-time, read-only copy of your data.

- Soft delete allows you to recover your file share when it's deleted by an application or other storage account user.

- Azure Storage Explorer is a standalone application that makes it easy to work with stored data on Windows, macOS, and Linux. 

- Azure File Sync enables you to cache file shares on an on-premises Windows Server or cloud virtual machine. 


## Learn more with documentation

- [Azure Files documentation](/azure/storage/files/). This page is your starting point for all things related to Azure Files. 

- [Azure File Sync documentation](/azure/storage/file-sync/). This page is your starting point for all things related to Azure File Sync. 
  
## Learn more with self-paced training

- [Introduction to Azure Files](/training/modules/introduction-to-azure-files/). In this module, you learn how you can meet your storage needs with Azure Files and Azure File Sync.

- [Implement a hybrid file server infrastructure](/training/modules/implement-hybrid-file-server-infrastructure/). In this module, you learn to deploy Azure File Sync and use Storage Migration Services to migrate file servers to Azure.

