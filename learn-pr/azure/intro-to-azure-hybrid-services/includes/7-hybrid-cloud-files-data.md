
Tailwind Traders must ensure that the same file share content is reliably available in each branch office. However, its existing file server infrastructure makes that a challenge. Some smaller branch offices, such as the company's retail outlet in Wangaratta, Australia, don't have local file server endpoints. Access for retail outlets to files and folders occurs across a VPN connection to a file server in the Melbourne office.

Another challenge for Tailwind Traders is that users are creating new files all the time. The volumes that host the file shares regularly end up full and require administrator intervention to free up disk space. 

This storage problem isn't limited to the volumes that host file shares. Several on-premises SQL databases keep expanding to the point that they consume existing storage capacity and database administrators must regularly add storage.

In this unit, you'll learn how certain hybrid technologies allow Tailwind Traders to address its challenges with file server and SQL database replication and storage.

## What is an Azure file share?

An Azure file share allows you to create a secure SMB 3.0 file share hosted in Azure. You can integrate Azure Files with Azure Active Directory (Azure AD) and Azure AD Connect to allow people to use their on-premises account credentials or their Azure AD credentials to securely access the Azure file share endpoint. 

You can also configure Azure file shares to support access control list (ACL) permissions. This allows you to limit access to files and folders in the same way that you would secure files and folders for an on-premises file server. 

Because Azure Files is backed by Azure Storage, Azure file shares can store substantially more files and folders than their on-premises counterparts. You can also back up Azure file shares by using Azure Backup, with files and folders backed up and recovered in the cloud instead of requiring a separate on-premises backup and recovery solution. 

The following image shows clients connecting to Azure file shares.

:::image type="content" source="../media/7-client-connect.png" alt-text="Diagram showing clients connected to Azure file shares by using authentication of credentials synchronized to an Azure AD tenant." border="false" lightbox="../media/7-client-connect.png":::

An Azure file share endpoint might provide a solution to some of the challenges that Tailwind Traders faces. Specifically, placing a file share in Azure can serve as an easy replacement for branch-office retail locations, such as the Wangaratta site, to use instead of making a VPN connection to a file server in the Melbourne Office. Azure file share endpoints can be used in conjunction with Azure File Sync, which you'll learn about in the next section.

## What is Azure File Sync?

Azure File Sync allows you to deploy distributed file shares across branch offices, where files are replicated automatically to each endpoint and are backed by an Azure file share. You can also use Azure File Sync to configure cloud tiering. *Cloud tiering* allows you to specify that only files that have been accessed recently are kept on the local file server. Placeholders replace files tiered to the Azure file share. 

The Azure file share, which has substantially more storage than a local file share, will keep a full copy of all files written to it, including those that are no longer present on-premises because of cloud tiering. If a user tries to open a placeholder file that appears the same as a normal file, the file is replicated back from the Azure file share and opens normally for the user.

When you configure cloud tiering, you can specify that a certain amount of disk space remains free on the volume that hosts the share. You can also specify that files that haven't been accessed in a certain amount of time are automatically tiered. Or you can enable both options at the same time. 

The following image shows a basic Azure File Sync deployment.

:::image type="content" source="../media/7-sync-deployment.png" alt-text="Diagram showing on-premises file servers synchronized with Azure file shares in the cloud through storage sync agents." border="false" lightbox="../media/7-sync-deployment.png":::

Tailwind Traders currently uses a distributed file system (DFS) to replicate a set of file shares across its locations in Australia and New Zealand. Azure File Sync would allow the company to replace DFS as the file-replication mechanism. The advantage is that it would allow Tailwind Traders to enable cloud tiering, which would solve its problems regarding file servers' space constraints when new files are created and stored on a regular basis.

## What is SQL Stretch Database?

Microsoft SQL Server Stretch Database allows you to automatically migrate rarely accessed data transparently and securely to Azure. When a query is made against data that's been migrated to Azure, the query results return, but there's an increased delay over query time compared to data retrieved from tables stored on-premises.

The advantage of SQL Server Stretch Database over other solutions in removing infrequently accessed data from the database is that the data itself remains online. It's not necessary to modify any existing queries, and the application remains unaware of the location of data.

Tailwind Traders can enable Stretch Database on databases where the company has had to keep adding storage to accommodate table growth. When Stretch Database is enabled, infrequently accessed table data will be transparently migrated to Azure on a continuous basis. This allows new data to be written to tables, remaining on-premises and close to the application that's performing the query while shifting colder data into Azure.
