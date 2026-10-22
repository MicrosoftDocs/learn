Let's take a look at how Azure Backup works to provide the data protection you need. Particularly, let's look at how the different aspects of the backup service make it easy to back up various types of data, and how it offers security for your backups as well. In this unit, we cover the following aspects of the Azure Backup Service:

- **Workload integration layer**: Backup integrates with each workload through the appropriate method, such as VM extensions, database-aware backup, or native storage-platform capabilities.
- **Data Plane - Access Tiers**: There are three access tiers where the backups could be stored:
  - Snapshot tier
  - Standard tier
  - Archive tier
- **Data Plane: Availability and Security**: For vaulted backup data, the selected redundancy option provides local redundancy, cross-zone replication, or replication to a paired secondary region.
- **Management plane: Recovery Services vault, Backup vault, and Resiliency**: Vaults manage backup policies and protected items. Resiliency provides centralized management and monitoring across your backup estate.

## What data is backed up and how?

The simplest explanation of Azure Backup is that it backs up data, machine state, and workloads running on on-premises machines and VM instances to the Azure cloud. Azure Backup uses Recovery Services vaults and Backup vaults to manage protection; where backup data is stored depends on the workload and backup tier.

For on-premises Windows machines, you can back up directly to Azure with the Azure Backup Microsoft Azure Recovery Services (MARS) agent. Alternatively, you can back up these Windows machines to a backup server, perhaps a System Center Data Protection Manager (DPM) or Microsoft Azure Backup Server (MABS). You can then back that server up to a Recovery Services vault in Azure.

You can back up supported Azure VMs directly. By default, Azure Backup uses the Azure VM agent and a backup extension for application-consistent or file-system-consistent snapshots. If you only want to back up files and folders on a supported Windows Azure VM, you can use the MARS agent; MARS doesn't support Linux.

Recovery Services vaults and Backup vaults manage backup policies, protected items, and recovery points for their supported workloads. Vaulted backup stores an isolated copy of protected data in Azure Backup-managed storage. Operational protection can instead retain data or snapshots in the customer's subscription without creating a vaulted copy.

### Supported backup types

Backup types depend on the workload. Azure VM backup uses an initial full backup followed by incremental backups that transfer changed blocks. DPM/MABS use incremental backups for disk backups and backups to Azure. Workload-aware SQL Server backup in Azure VMs instead uses the full, differential, and transaction log backup types described next.

Azure Backup supports the following SQL Server database backup types:

| Type | Description | Schedule |
| --- | --- | --- |
| Full | Backs up the database and the log information needed to recover that backup. | Schedule full backups daily or weekly. |
| Differential | Backs up changes since the most recent full backup. | Schedule differential backups on days without a scheduled full backup. |
| Transaction log | Captures transaction-log changes to support point-in-time recovery for eligible databases. | Schedule log backups as frequently as every 15 minutes. |

Azure VM backup has separate scheduling and disk-selection options:

| Feature | Description |
| --- | --- |
| Multiple scheduled backups per day | The Enhanced VM backup policy supports an hourly schedule with intervals of 4, 6, 8, 12, or 24 hours. The minimum interval is four hours, not one hour. |
| Selective disk backup | Standard and Enhanced VM backup policies support selective disk backup. In the Azure portal, Standard policy supports choosing OS-disk-only backup; Enhanced policy supports selecting individual data disks. Use the supported Azure CLI or PowerShell options for other disk-selection configurations. |

For details, see [Enhanced VM backup policy](/azure/backup/backup-azure-vms-enhanced-policy) and [selective disk backup](/azure/backup/selective-disk-backup-restore).

## Workload integration

Azure Backup integrates with workloads in different ways:

- **VM and database workloads**: Extension-based Azure VM backup can create application-consistent or file-system-consistent snapshots. Workload-aware backup for SQL Server and SAP HANA databases in Azure VMs uses database backup streams.
- **Azure Files**: Backup uses Azure Files snapshot APIs directly; you don't deploy a worker VM or VM backup extension for the file share.
- **Azure Blobs**: Operational backup uses blob-platform protection features, including point-in-time restore, versioning, change feed, and soft delete. Vaulted backup uses object replication to create an isolated backup copy.

> [!NOTE]
> For supported VM and disk configurations, the Enhanced VM backup policy also supports agentless multidisk crash-consistent backup. This mode doesn't require the VM agent or snapshot extension, but it doesn't provide application-consistent or file-system-consistent backups. Check the [supported scenarios](/azure/backup/backup-azure-vms-agentless-multi-disk-crash-consistent-overview) before selecting it.

Vaulted backup transfers protected data to Azure Backup-managed storage. Operational protection can keep the data in the source environment, as described in the access-tier section.

## Data plane: Access tiers

There are three access tiers where the backups can be stored:

- **Snapshot tier**: Supported workloads, such as Azure VMs and Azure Files, can retain point-in-time snapshots for quick recovery. Azure VM backup snapshots are retained in the customer's subscription; Azure Files backup uses file-share snapshots. Azure Blob operational backup isn't snapshot-based: it uses native storage features such as point-in-time restore and versioning.

- **Vault-standard tier**: For supported workloads configured for vaulted backup, this tier stores an isolated copy of backup data in Azure Backup-managed storage. Supporting snapshots or operational backup doesn't automatically mean that a workload has a vaulted copy as well.

    > [!NOTE]
    > Azure Disk Backup currently supports operational incremental snapshots only; these snapshots aren't copied to vault storage. Azure Blob operational backup keeps data in the source storage account, while vaulted Blob backup is a separate protection option. A vault can manage protection without holding a backup copy of the data.

- **Archive tier**: Customers rely on Azure Backup for storing backup data, including their Long-Term Retention (LTR) backup data, with retention needs defined in the organization's compliance rules. In most cases, the older backup data is rarely accessed and is only stored for compliance needs.

    Azure Backup supports backup of long-term retention points in the archive tier.

All tiers offer different recovery time objectives (RTO) and are priced differently.

:::image type="content" source="../media/data-plane.png" alt-text="Diagram that shows on-premises and Azure workloads connected to snapshot and vault storage, replication, and built-in security.":::

## Data plane: Availability and security

Vaulted backup data is replicated according to the vault's storage redundancy setting. Locally redundant storage (LRS) keeps replicas in the primary region without guaranteeing distribution across availability zones. Zone-redundant storage (ZRS) replicates data across availability zones in the primary region. Geo-redundant storage (GRS) also replicates data to a paired secondary region.

> [!NOTE]
> Vault storage redundancy applies to backup data stored in the vault, not to operational backups such as Azure Disk Backup snapshots or Azure Blob operational backup. For supported workloads and regions, Archive tier requires an LRS or GRS vault; Archive tier isn't supported in vaults configured with ZRS. For details, see [Archive tier support](/azure/backup/archive-tier-support#supported-workloads).

Encryption and Azure role-based access control (RBAC) help protect backup data and control who can perform backup and restore operations. For supported vaulted backups, soft delete retains deleted backup data for 14 days by default, with no additional retention charge for that default period. You can configure a retention period from 14 to 180 days; retention beyond the free duration incurs regular backup charges.

> [!NOTE]
> Azure Backup soft delete doesn't currently apply to operational backups of Azure Blobs or Azure Files shares. Native blob or file-share soft delete is a separate storage capability. Operational disk and VM backup snapshots can be deleted directly before the soft-delete retention period ends, and their underlying snapshot resource charges continue. Don't assume the vaulted-backup recovery and pricing behavior applies to every operational backup.

Azure Backup also supports a backup data lifecycle-management scenario that allows you to comply with retention policies.

:::image type="content" source="../media/built-in-security.png" alt-text="Illustration of Azure Backup security features: Azure RBAC, encryption, and soft delete.":::

## Management plane: Recovery Services vault and Backup vault

Azure Backup uses Recovery Services vaults and Backup vaults to orchestrate and manage backups. For vaulted backup, an isolated copy of the protected data is stored in Azure Backup-managed storage. Operational protection can instead retain data or snapshots in the customer's subscription without creating a vaulted copy. The vault provides an interface for the user to interact with the backup service. Azure Backup Policies within each vault define when the backups should get triggered and how long they need to be retained.

You can use a single vault or multiple vaults to organize and manage your backup. If you manage your workloads with a single subscription and single resource, you can use a single vault to monitor and manage your backup estate. If your workloads are spread across multiple subscriptions, you can create multiple vaults with one or more vaults per subscription.

:::image type="content" source="../media/backup-vaults.png" alt-text="Diagram that shows Recovery Services vaults and backup policies managed through the Azure portal, SDK, and CLI.":::

Use Resiliency in the Azure portal to manage and monitor protection across workload types, vaults, subscriptions, regions, and Azure Lighthouse tenants. Resiliency extends the capabilities previously available in Azure Business Continuity Center. For the legacy Backup center experience, open **Resiliency** and use **Help** > **Go to Backup Center**.

> [!NOTE]
> This screenshot shows the legacy Backup center experience. For current centralized backup management, search for **Resiliency** in the Azure portal. Legacy Backup center is available from Resiliency through **Help** > **Go to Backup Center**.

:::image type="content" source="../media/backup-center.png" alt-text="Screenshot of legacy Backup center showing Azure VM backup jobs and backup instance protection states.":::
