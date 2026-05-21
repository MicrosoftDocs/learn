## Azure Storage Mover

Azure Storage Mover is Microsoft's fully managed migration service for files and folders. It supports on-premises NFS and SMB sources, AWS S3 buckets, and even Azure-to-Azure migrations. Because it's the recommended tool for most file and object migration scenarios, this module dedicates a separate unit to it. Find detailed guidance on architecture, agent deployment, and job orchestration in the next section.

## Azure File Sync

Azure File Sync is a service that can be deployed on Windows Server to synchronize file shares between on-premises and Azure Files. It's designed for continuous synchronization but can also be used for one-time synchronization.

Learn more: [Introduction to Azure File Sync](/azure/storage/file-sync/file-sync-introduction)

## Storage Migration Service

Storage Migration Service (SMS) is a Windows Server feature managed through Windows Admin Center. It's designed specifically for migrating Windows file servers, including their shares, permissions, and configuration, to Azure or to newer on-premises servers.

SMS is the recommended tool when you migrate Windows file servers where preserving the server identity (name, IP address) is important for seamless application and user cutover. It supports migration from:

- Windows Server (2003 and later)
- Windows Failover Cluster file server resources
- Samba (Linux) servers
- NetApp FAS arrays

The migration follows a three-phase process:

1. **Inventory**: SMS scans the source server and records its files, shares, and configuration.
2. **Transfer**: SMS copies data, shares, and ACLs from source to destination. Run multiple transfer passes to capture changes.
3. **Cutover**: The destination server assumes the identity (name and IP addresses) of the source server, making the transition transparent to users and applications.

> [!NOTE]
> Storage Migration Service migrates to Windows Server destinations or Azure VMs. For migration directly to Azure Files, use Azure File Sync or Azure Storage Mover instead.

Learn more: [Storage Migration Service overview](/windows-server/storage/storage-migration-service/overview) and [Use Storage Migration Service to migrate a server](/windows-server/storage/storage-migration-service/migrate-data)

## Data Box Gateway

Data Box Gateway is a service that runs locally and automatically sends data written locally to Azure. It's designed for continuous data feeds into Azure.

> [!NOTE]
> Data Box Gateway has restrictions on maximum file size.

Learn more: [Azure Data Box Gateway overview](/azure/databox-gateway/data-box-gateway-overview) and [Azure Data Box Gateway limits](/azure/databox-gateway/data-box-gateway-limits)

## Azure Data Factory

Azure Data Factory supports data migrations but requires you to build data pipelines. This approach might be reasonable for specific use cases, but for pure file or object migrations, other tools are simpler.

Learn more: [Migrate data from data lake and data warehouse to Azure](/azure/data-factory/data-migration-guidance-overview)

## AzCopy

AzCopy copies data between local drives, Amazon S3, Google Cloud Storage, and Azure Storage accounts. For transfers between Azure Storage accounts, data moves within Azure rather than through your local computer, which improves performance.

> [!NOTE]
> AzCopy is an unmanaged tool. You need to implement proper error handling and recover from any errors during transfer.

> [!NOTE]
> AzCopy has limitations with a large number of objects. Plan your migrations in smaller batches.

Learn more: [Copy or move data to Azure Storage by using AzCopy v10](/azure/storage/common/storage-use-azcopy-v10) and [Optimize the performance of AzCopy v10 with Azure Storage](/azure/storage/common/storage-use-azcopy-optimize)
