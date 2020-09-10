# Hybrid-cloud files and data

One of the biggest challenges that Tailwind Traders faces with its existing file server infrastructure is ensuring that the same file share content is reliably available in each branch office. Some smaller branch offices, such as the Tailwind Traders retail outlet in Wangaratta, Australia, don’t have local file server endpoints. This means that retail outlets file and folder access occurs across a VPN connection to a file server in the Melbourne Office.

Another challenge for Tailwind Traders is that users are creating new files all the time. This means that the volumes that host the file shares regularly end up full and require administrator intervention to free up disk space. This storage problem isn’t limited to the volumes that host file shares. Several on-premises SQL databases keep expanding to the point that they consume existing storage capacity and database administrators must regularly add storage.

In this unit, you’ll learn how certain hybrid technologies allow Tailwind Traders to address their file server and SQL database replication and storage challenges.

## What is Azure File Share?

[Azure File Share](https://docs.microsoft.com/azure/storage/files/storage-how-to-create-file-share) allows you to create a secure SMB 3.0 file share hosted in Azure. You can integrate Azure Files with Azure Active Directory and Azure AD Connect to allow people to use their on-premises account credentials or their Azure AD credentials to securely access the Azure File Share endpoint. Azure File Shares can also be configured to support access control list (ACL) permissions. This allows you to limit access to files and folders in the same manner that you would use when securing files and folders for an on-premises file server. As Azure Files is backed by Azure Storage, Azure File Shares can store substantially more files and folders than their on-premises counterparts. Azure File Shares can also be backed up by using Azure Backup, with files and folders backed up and recovered in the cloud instead of requiring a separate on-premises backup and recovery solution. Figure 14 depicts clients connecting to Azure File Shares.

:::image type="content" source="../media/image14.png" alt-text="Clients connect to Azure File Shares using authentication of credentials synchronized to an Azure AD tenant." border="false":::

Figure 14. Azure File Shares.

An Azure File Share endpoint might provide a solution to some of the challenges that Tailwind Traders faces. Specifically, placing a file share in Azure can serve as an easy replacement for branch office retail locations, such as the Wangaratta site, to use the Azure File Share instead of making a VPN connection to a file server in the Melbourne Office. Azure File Share endpoints can be used in conjunction with Azure File Sync, which you’ll learn about in the next section.

## What is Azure File Sync?

[Azure File Sync](https://docs.microsoft.com/azure/storage/files/storage-sync-files-deployment-guide) allows you to deploy distributed file shares across branch offices where files are replicated automatically to each endpoint and are backed by an Azure File Share. Azure File Sync also allows you to configure cloud tiering. *Cloud tiering* allows you to specify that only files that have been accessed recently be kept on the local file server, with placeholders replacing files tiered to the Azure File Share. The Azure File Share, which has substantially more storage than a local file share, will keep a full copy of all files written to the file share, including those that are no longer present on-premises because of cloud tiering. If a user attempts to open a placeholder file, which to the user appears the same as a normal file, the file is replicated back from the Azure File share and opens normally for the user.

When you configure cloud tiering, you can specify that a certain amount of disk space remain free on the volume that hosts the share. You can also specify that files that haven’t been accessed in a certain amount of time are automatically tiered, or enable both options at the same time. Figure 15 depicts a basic Azure File Sync deployment.

:::image type="content" source="../media/image15.png" alt-text="On-premises file servers synchronize with Azure File shares in the cloud through storage sync agents." border="false":::

Figure 15. Azure File Sync.

Tailwind Traders currently uses a distributed file system (DFS) to replicate a set of file shares across their locations in Australia and New Zealand. Azure File Sync would allow them to replace DFS as the file-replication mechanism. The advantage of doing this is that it would also allow Tailwind Traders to enable cloud tiering, which would solve their problems regarding file servers’ space constraints when new files are created and stored on a regular basis.

## What are SQL Stretch Databases?

[Microsoft SQL Server Stretch Databases](https://docs.microsoft.com/sql/sql-server/stretch-database/stretch-database) allow you to automatically migrate rarely accessed data transparently and securely to Azure. When a query is made against data that’s been migrated to Azure, the query results return, but there’s an increased delay over query time compared to data retrieved from tables stored on-premises.

SQL Server Stretch Database has the advantage over other solutions of removing infrequently accessed data from the database in that the data itself remains online. It’s not necessary to modify any existing queries and the application remains unaware of the data’s location.

Tailwind Traders can enable Stretch Database on databases where they’ve had to keep adding storage to accommodate table growth. When Stretch Database is enabled, infrequently accessed table data will be transparently migrated to Azure on a continuous basis. This allows new data to be written to tables, remaining on-premises and close to the application performing the query while shifting colder data into Azure.

## Knowledge check

Tailwind Traders needs to ensure that the volumes on file servers don’t run out of disk space. At present, natural activity at Tailwind Traders offices weekly adds approximately 500 megabytes (MB) of data to the volumes that host important company. Historically, this has meant that IT pros must remove approximately 100 gigabytes (GB) of old files every few months to allow sufficient storage space for new files.

Tailwind Traders has configured Azure File Sync for all existing file shares and the file shares have all replicated to corresponding Azure File Shares in Azure. Which of the following strategies should Tailwind Traders pursue to ensure that it won’t be necessary to remove disused files and folders from file servers in future?

1\. Enable deduplication on each file server that’s configured with Azure File Sync. \[Incorrect. While deduplication saves space, it won’t stop all the available space on the file share from eventually being consumed.\]

2\. Enable cloud tiering on the Azure File Share. \[Incorrect. You don’t enable cloud tiering on the Azure File Share, because the file share hosts the primary copy of all files. You enable cloud tiering on each file server that participates in Azure File Sync as a way of ensuring that the volumes that host the file shares don’t run out of storage space.\]

3\. Enable cloud tiering on each file server file share that’s configured with Azure File Sync. \[Correct. When you enable cloud tiering, you can specify an amount of free space that must be kept available or specify that files that haven’t been accessed for a certain amount of time be automatically tiered, or both. If you specify that a certain amount of free space must be kept available on the volume, any time the limit is approached, the least recently accessed files on the volume will automatically be tiered to the Azure File Share.\]