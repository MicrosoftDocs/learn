Azure File Sync allows you to centralize your organization's SMB file shares in Azure Files while keeping the flexibility, performance, and compatibility of an on-premises Windows file server. Azure File Sync can turn Windows Server into a quick cache of your SMB Azure file shares.

Common reasons customers use Azure File Sync:

- Centralize file share backups in Azure to optimize cost and manageability
- Free up on-premises storage capacity to avoid buying more storage
- Maintain on-premises file share performance for frequently used files
- Migrate on-premises file shares to Azure Files
- Provide low latency, multi-site access for file shares

## Cloud tiering

With cloud tiering enabled in Azure File Sync, your most frequently accessed files are cached on your local server and your least frequently accessed files are tiered to the cloud. You can control how much local disk space is used for caching. You can quickly recall tiered files on demand, making the experience seamless while allowing you to cut down on costs because you only need to store a fraction of your data on-premises.

## Multi-site access and sync

Azure File Sync is ideal for distributed access scenarios. For each of your offices, you can provision a local Windows Server as part of your Azure File Sync deployment to provide fast access near where the data is being used. Changes made to a server in one office automatically sync to the servers in all other offices.

## Business continuity and disaster recovery

Because Azure contains resilient copies of your data, you can recover quickly from a failed server. Rather than restoring from a local backup, you can provision another Windows Server, install the Azure File Sync agent on it, then add it to your Azure File Sync deployment.

## Cloud-side backup

Azure file shares have native snapshot capabilities, and you can automate the process using Azure Backup to schedule your backups and manage their retention. Azure Backup also integrates with your on-premises servers, so when you restore to the cloud, these changes are automatically downloaded on your Windows Servers.
