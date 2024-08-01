Let's take a look at how Azure Backup works to provide the data protection you need. Particularly, how the different aspects of the backup service make it easy to back up various types of data and how it offers security for your backups as well. In this unit, we discover the following aspects of the Azure Backup Service:

- **Workload integration layer - Backup Extension**. Integration with the actual workload, such as Azure virtual machines (VM) or Azure Blobs, happens at this layer.
- **Data Plane - Access Tiers**. Three access tiers where the backups could be stored:
  - Snapshot tier
  - Standard tier
  - Archive tier
- **Data Plane - Availability and Security**. The backup data is replicated across zones or regions, based on the redundancy specified by the user.
- **Management Plane – Recovery Services vault/Backup vault and Backup center**. Vault provides an interface for the user to interact with the backup service.

## What data is backed up and how?

The simplest explanation of Azure Backup is that it backs up data, machine state, and workloads, running on on-premises machines and VM instances to the Azure cloud. Azure Backup stores the backed-up data in Recovery Services vaults and Backup vaults.

For on-premises Windows machines, you can back up directly to Azure with the Azure Backup Microsoft Azure Recovery Services (MARS) agent. Alternatively, you can back up these Windows machines to a backup server, perhaps a System Center Data Protection Manager (DPM), or Microsoft Azure Backup Server (MABS). You can then back up that server to a Recovery Services vault in Azure.

If you're using Azure VMs, you can back them up directly. Azure Backup installs a backup extension to the Azure VM agent that's running on the VM, which allows backing up the entire VM. If you only want to back up the files and folders on the VM, you can do so by running the MARS agent.

Azure Backup stores backed-up data in vaults: Recovery Services vaults and Backup vaults. A vault is an online-storage entity in Azure that's used to hold data such as backup copies, recovery points, and backup policies.

### Supported backup types

Azure Backup supports full backups and incremental backups. Your initial backup is a full backup type. The incremental backup is used by DPM/MABS for disk backups, and used in all backups to Azure. As the name suggests, incremental backups only focus on the blocks of data that changed since the previous backup.

Azure Backup also supports SQL Server backup types. The following table outlines the support for SQL Server type backups:

| Type | Description | Usage |
| --- | --- | --- |
| Full | A full database backup backs up the entire database. It contains all the data in a specific database or in a set of filegroups or files. A full backup also contains enough logs to recover that data. | At most, you can trigger one full backup per day. You can choose to make a full backup on a daily or weekly interval. |
| Differential | A differential backup is based on the most recent, previous full-data backup. It captures only the data that changed since the full backup. | At most, you can trigger one differential backup per day. You can't configure a full backup and a differential backup on the same day. |
| Multiple backups per day | Back up Azure VMs hourly with a minimum recovery point objective (RPO) of 4 hours and a maximum of 24 hours. |	You can use Enhanced backup policy to set the backup schedule to 4, 6, 8, 12, and 24 hours, respectively for new Azure offerings, such as  Trusted Launch VM. |
| Selective disk backup | Selectively back up a subset of the data disks that are attached to your VM, and then restore a subset of the disks that are available in a recovery point, both from instant restore and vault tier. It helps you manage critical data in a subset of the VM disks and use database backup solutions when you want to back up only their OS disk to reduce cost. | Azure Backup provides Selective Disk backup and restore capability using Enhanced backup policy. |
| Transaction Log | A log backup enables point-in-time restoration up to a specific second. | At most, you can configure transactional log backups every 15 minutes. |

## Workload integration layer - Backup Extension

A backup extension specific to each workload is installed on the source VM or a worker VM. At the time of backup, as defined by the user in the Backup Policy, the backup extension generates the backup, which could be:

- **Storage**: snapshots when using an Azure VM or Azure Files.

- **Stream backup** for databases like SQL or High-performance Analytic Appliance (HANA) running in VMs.

The backup data is eventually transferred to Azure Backup managed storage in the data plane by using secure Azure networks Network Security Groups (NSG), Firewalls, or more sophisticated private endpoints.

## Data Plane - Access Tiers

There are three access tiers where the backups could be stored:

- **Snapshot tier**: (Workload-specific term) In the first phase of a virtual machine backup, the snapshot is taken and stored along with the disk. This form of storage is referred to as a snapshot tier. Restoring a snapshot tier is faster than restoring from a vault, because it eliminates the wait time for snapshots to be copied from the vault before triggering the restore operation. The snapshots of the VM/Azure Files/Azure Blobs/and so on are retained in the customer’s subscription itself in a specified resource group. This container ensures that restores are quick, because the backup/snapshot is available locally to the customer.

- **Vault-Standard tier**: Backup data for all workloads supported by Azure Backup is stored in vaults, which hold backup storage, an autoscaling set of storage accounts managed by Azure Backup. The Vault-Standard tier is an online storage tier that allows you to store an isolated copy of backup data in a Microsoft-managed tenant, thus creating an extra layer of protection. For workloads where snapshot tier is supported, there's a copy of the backup data in both the snapshot tier and the vault-standard tier. The vault-standard tier ensures that backup data is available even if the data source being backed up is deleted or compromised.

- **Archive tier**: Customers rely on Azure Backup for storing backup data, including their Long-Term Retention (LTR) backup data with retention needs defined in the organization's compliance rules. In most cases, the older backup data is rarely accessed and is only stored for compliance needs.

    Azure Backup supports backup of long-term retention points in the archive tier.

All tiers offer different recovery time objectives (RTO) and are priced differently.

:::image type="content" source="../media/data-plane.png" alt-text="Diagram of the various workloads such as on-premises server, Azure VMs, Azure files, etc. feeding into the data plane where the access tiers are located.":::

## Data Plane - Availability and Security

The backup data is replicated across zones or regions, based on the redundancy specified by the user. You can choose from locally redundant storage (LRS), Geo-redundant storage (GRS), or zone-redundant storage (ZRS). These options provide you with highly available data storage capabilities.

The data is kept safe by encrypting it and implementing Azure role-based access control (RBAC). You choose who can perform backup and restore operations. Azure Backup also provides protection against malicious deletion of your backup by using soft-delete operations. A deleted backup is stored for 14 days, free of charge, which allows you to recover the backup if needed.

Azure Backup also supports a backup data lifecycle management scenario that allows you to comply with retention policies.

:::image type="content" source="../media/built-in-security.png" alt-text="Graphic displaying the three security options of Azure RBAC, encryption, and soft delete as icons.":::

## Management Plane – Recovery Services vault/Backup vault and Backup center

Azure Backup uses Recovery Services vaults and Backup vaults to orchestrate and manage backups. It also uses vaults to store backed-up data. The vault provides an interface for the user to interact with the backup service. Azure Backup Policies within each vault define when the backups should get triggered and how long they need to be retained.

You can use a single vault or multiple vaults to organize and manage your backup. If you manage your workloads with a single subscription and single resource, you can use a single vault to monitor and manage your backup estate. If your workloads are spread across multiple subscriptions, you can create multiple vaults with one or more vaults per subscription.

:::image type="content" source="../media/backup-vaults.png" alt-text="Diagram of the management plane. The recovery services vault shows the options for backup policies and management with the portal, SDK, or the Command-line interface (CLI).":::

Backup center allows you to have a single pane of glass to manage all tasks related to backups. Backup center is designed to function well across a large and distributed Azure environment. You can use Backup center to efficiently manage backups spanning multiple workload types, vaults, subscriptions, regions, and Azure Lighthouse tenants.

:::image type="content" source="../media/backup-center.png" alt-text="Screenshot of the Backup center user interface in the Azure portal. This image is displaying backup information for Azure Virtual machines related to jobs and backup instances.":::
