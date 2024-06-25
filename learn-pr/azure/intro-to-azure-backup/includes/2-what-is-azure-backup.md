Let's start with a definition of Azure Backup and take a quick tour of the core features. This overview should help you see whether Azure Backup might be a good fit for your data protection needs.

## What is Azure Backup?

The Azure Backup service provides simple, secure, and cost-effective solutions to back up your data and recover it from the Microsoft Azure cloud.

:::image type="content" source="../media/azure-backup-overview.png" alt-text="Diagram of the Azure Backup service implementing backup agents in the on-premises environment to the cloud. Middle section displays the components of Azure Backup for security and scalability with an underlying bar indicating central management.":::

## Azure Backup definition

Azure Backup is an Azure service that provides cost effective, secure, and zero-infrastructure backup solutions for all Azure-managed data assets.

The centralized management interface makes it easy to define backup policies and protect a wide range of enterprise workloads, including Azure Virtual Machines, Azure Disks, SQL and SAP databases, Azure file shares, and blobs.

:::image type="content" source="../media/azure-backup-architecture.png" alt-text="Diagram of Azure Backup architecture displaying workloads at the bottom, feeding into the data plane above that, tying into the management plane with backup policies, Azure policies, Azure Monitor, and Azure Lighthouse services listed for management.":::

## When to think of Azure Backup?

As the IT admin of your organization, you are responsible for meeting the compliance needs for all the data assets of the firm; backup is a critical aspect of it. There are also various application admins in your company who need to do self-service backup and restore to take care of issues like data corruption or rogue admin scenarios. You are looking for an enterprise-class backup solution to protect all your workloads and manage them from a central place.

Azure Backup can provide back up services for the following data assets:

* On-premises files, folders, and system state
* Azure Virtual Machines (VMs)
* Azure Managed Disks
* Azure Files Shares
* SQL Server in Azure VMs
* SAP HANA databases in Azure VMs
* Azure Database for PostgreSQL servers
* Azure Blobs
* Azure Database for PostSQL - Flexible servers
* Azure Database for MySQL - Flexible servers
* Azure Kubernetes cluster

:::image type="content" source="../media/backup-center-jobs.png" alt-text="Screenshot of Azure Backup center displaying a list of backup jobs. The list displays the backup instance, data source, operation type, and status.":::

## Key features

Let's look at some key features of Azure Backup.

| Feature | Description | Usage |
| --- | --- | --- |
| Zero-infrastructure backup solution | No backup server or infrastructure needed like would be required for conventional backup solutions. Similarly, no backup storage needs to be deployed; it's automatically managed and scaled by Azure Backup. | Zero-infrastructure solution eliminates capital expenses and reduces operational expenses. It increases ease of use by automating storage management. |
| At-scale management | Natively manage your entire backup estate from a central console called Backup Center. Use APIs, PowerShell, and Azure CLI to automate Backup policy and security configurations. | Backup center simplifies data protection management at-scale by enabling you to discover, govern, monitor, operate, and optimize backup management, all from one unified console, helping you to drive operational efficiency with Azure.  |
| Security | Azure Backup provides built-in security to your backup environment, both when your data is in transit and at rest by using capabilities encryption, private endpoints, alerts, and so on. | Your backups are automatically secured against ransomware, malicious admins, and accidental deletions. |

## How do Recovery Time Objective and Recovery Point Objective work?

Recovery Time Objective (RTO) is the target time within which a business process must be restored after a disaster occurs to avoid unacceptable consequences. For instance, if a critical application goes down due to a server failure and the business can only tolerate a maximum of four hours of downtime, then the RTO is four hours.

The following example scenario describes both the RPO and RTO concepts:

Your organization has an RPO of one hour for your customer database, which means you perform backups every hour. If a data loss incident occurs, you'll lose not more than one hour of data. When you set RTO to three hours, then in the event of a system failure, you aim to restore access to the database within three hours to minimize the impact on operations.
