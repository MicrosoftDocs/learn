Let's start by defining Azure Backup and taking a quick tour of the core features. This overview should help you decide whether Azure Backup might be a good fit for your data-protection needs.

## What is Azure Backup?

The Azure Backup service provides simple, secure, and cost-effective solutions to back up your data and recover it from the Microsoft Azure cloud.

:::image type="content" source="../media/azure-backup-overview.png" alt-text="Diagram that shows Azure Backup protecting on-premises and cloud workloads with centralized management, security, and storage tiering.":::

## Azure Backup definition

Azure Backup is an Azure service that provides cost effective, secure, and zero-infrastructure backup solutions for supported Azure-managed data assets.

The centralized management interface makes it easy to define backup policies and protect a wide range of enterprise workloads, including Azure Virtual Machines, Azure Disks, SQL and SAP databases, Azure file shares, and blobs.

:::image type="content" source="../media/azure-backup-architecture.png" alt-text="Diagram that shows Azure Backup workloads connected to the data plane for storage and security and the management plane for policies.":::

## When to use Azure Backup

As the IT admin of your organization, you're responsible for meeting the compliance needs for all the data assets of the firm, and backup is a critical aspect. There are also various application admins in your company who need to do self-service backup and restore to take care of issues like data corruption or rogue-admin scenarios. You're looking for an enterprise-class backup solution to protect all your workloads and manage them from a central place.

Azure Backup can provide backup services for the following data assets:

* On-premises files, folders, and system state
* Azure Virtual Machines (VMs)
* Azure Managed Disks
* Azure Files Shares
* SQL Server in Azure VMs
* SAP HANA (High-performance Analytic Appliance) databases in Azure VMs
* Azure Blobs
* Azure Database for PostgreSQL - Flexible servers
* Azure Kubernetes cluster

> [!NOTE]
> This screenshot shows the legacy Backup center experience. For current centralized backup management, search for **Resiliency** in the Azure portal. Legacy Backup center is available from Resiliency through **Help** > **Go to Backup Center**.

:::image type="content" source="../media/backup-center-jobs.png" alt-text="Screenshot of legacy Backup center listing backup jobs, their data sources, operations, and completion status.":::

## Key features

Let's look at some key features of Azure Backup.

| Feature | Description | Usage |
| --- | --- | --- |
| Zero-infrastructure backup solution | Unlike conventional backup solutions, no backup server or infrastructure is needed. Similarly, no backup storage needs to be deployed, because Azure Backup automatically manages and scales it. | Zero-infrastructure solution eliminates capital expenses and reduces operational expenses. It increases ease of use by automating storage management. |
| At-scale management | Use Resiliency in the Azure portal for centralized backup management and monitoring. Use APIs, PowerShell, and Azure CLI to automate backup policy and security configuration. | Manage protection across workload types, vaults, subscriptions, regions, and Azure Lighthouse tenants from a unified experience. |
| Security | Azure Backup provides built-in security to your backup environment, both when your data is in transit and at rest by using capabilities encryption, private endpoints, alerts, and so on. | Protection depends on the workload and configuration. Use supported soft-delete, immutability, and multi-user authorization controls, together with separate administrative permissions, to help protect against accidental or malicious deletion. |

## How do Recovery Time Objective and Recovery Point Objective work?

Recovery Time Objective (RTO) is the target time within which a business process must be restored after a disaster occurs to avoid unacceptable consequences. For instance, if a critical application goes down due to a server failure and the business can only tolerate a maximum of four hours of downtime, then the RTO is four hours.

Recovery Point Objective (RPO) is the maximum amount of data loss, measured in time, that your organization can sustain during an event.

The following example scenario describes both the RPO and RTO concepts:

Your organization has an RPO of one hour for your customer database, which means you perform backups every hour. If a data-loss incident occurs, you lose not more than one hour of data. When you set RTO to three hours, then if a system failure occurs, you aim to restore access to the database within three hours to minimize the impact on operations.
