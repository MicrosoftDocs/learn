Here, we discuss how you can decide if Azure Backup is the right choice for your data-protection needs. In this unit, we highlight common backup scenarios where Azure Backup provides benefits, such as:

* Ensuring availability of your data.
* Protecting your Azure workloads.
* Securing your data.

## Decision criteria

Azure Backup is an Azure service that provides secure and zero-infrastructure backup solutions for all Azure-managed data assets. It protects a wide range of enterprise workloads. Including, Azure Virtual Machines (VMs), Azure Disks, SQL and SAP databases, and Azure file shares and blobs.

The main criteria that we're evaluating are outlined in the following table. The table contains some key areas where Azure Backup can provide services to you for data protection.

| Criteria | Consideration |
| --- | --- |
| Azure workloads | Azure VMs, Azure Disks, SQL Server in Azure VMs, SAP HANA databases in Azure VMs, Azure Blobs, Azure Files shares, Azure Database for PostgreSQL.  |
| Compliance | Customer-defined backup policy with long-term retention across multiple zones or regions. |
| Operational recoveries |  With self-service backup and restores, the application administrator can take care of issues that might arise such as accidental deletion or data corruption. |

## Apply the criteria

In the introduction, we presented a scenario where your organization might have an application that relies on data from a back-end SQL Server installation. SQL Server is running on three Azure VMs. The data in the backup must be retained for up to 10 years to meet compliance requirements. You also want to be able to monitor the backups.

For this SQL Server availability-group scenario, a node registered for backup must use a Recovery Services vault in the same region and subscription as that node. Which nodes must be registered depends on the SQL Server version and the AG backup preference. If the nodes span regions or subscriptions, follow the [multi-region availability-group backup guidance](/azure/backup/backup-sql-server-on-availability-groups#configure-backups-for-a-multi-region-ag); protection in different vaults has separate recovery chains and additional operational considerations.

> [!NOTE]
> Cross Region Restore is a different capability. For supported SQL Server backups in a geo-redundant vault with Cross Region Restore enabled, you can restore eligible recovery points in the paired secondary region for drills, audits, or disaster recovery. It doesn't allow a vault to back up SQL availability-group nodes in another region or subscription. See [Cross Region Restore configuration](/azure/backup/backup-create-recovery-services-vault#set-cross-region-restore).

### Can Azure Backup protect the Azure VMs hosting the SQL Server instances?

Azure Backup is able to back up entire Windows and Linux VMs using backup extensions. As a result, you can back up the entire VM that hosts SQL Server. On supported Windows Azure VMs, the Microsoft Azure Recovery Services (MARS) agent can back up files and folders. System-state backup requires a Windows Server operating system supported for that feature in the MARS support matrix. MARS doesn't support Linux.

If your main concern is to only back up the SQL Server data, Azure Backup provides support for that as well. Azure Backup offers a stream-based, specialized solution to back up SQL Servers running in Azure VMs. This solution aligns with Azure Backup's benefits of zero-infrastructure backup, long-term retention, and central management.

Additionally, Azure Backup provides the following advantages specifically for SQL Server:

* Workload aware backups that support all backup types: full, differential, and log
* 15-minute recovery point objective (RPO) with frequent log backups
* Point-in-time recovery up to a second
* Individual database-level backup and restore

:::image type="content" source="../media/azure-backup-sql-overview.png" alt-text="Diagram that shows data and control paths between a SQL Server backup extension on an Azure VM and a Recovery Services vault.":::

### Does Azure Backup help with compliance?

You can implement required access-control mechanisms for your backups. Vaults (Recovery Services and Backup vaults) provide the management capabilities and are accessible through the Azure portal, including Resiliency and vault dashboards, and through supported SDKs, Azure CLI, and REST APIs. It's also an Azure role-based access control (Azure RBAC) boundary, providing you with the option to restrict access to backups only to authorized Backup Admins.

Short-term retention can be daily. Weekly, monthly, and yearly retention settings keep selected recovery points for longer periods. Backup frequency and retention are different: for example, SQL transaction-log backups can run every 15 minutes to support a 15-minute recovery point objective (RPO), while the backup policy separately defines how long recovery points are retained.

Long-term retention can be:

* **Planned (compliance requirements)**: If you know in advance that data is required years from the current time, use Long-term retention.
* **Unplanned (on-demand requirement)**: If you don't know in advance, then you can use on-demand backup with specific custom retention settings. Your policy settings don't impact these custom retention settings.
* **On-demand backup with custom retention**: For Azure VM backup, use an on-demand backup when you need a recovery point outside the scheduled policy, and specify the applicable retention for that backup. Standard policy permits one scheduled backup per day; Enhanced policy can schedule backups as frequently as every four hours. On-demand backup is therefore an option for an extra recovery point, not the only way to obtain multiple daily VM backups. Retention behavior for other workloads follows their workload-specific backup policies.

You can also implement policy management to help with compliance. Azure Backup Policies within each vault define when the backups should be triggered and how long they need to be retained. You can also manage these policies and apply them across multiple items.

### Does Azure Backup simplify monitoring and administration?

Azure Backup integrates with Log Analytics for monitoring and reporting and provides reports via Workbooks.

Azure Backup provides in-built job monitoring for operations such as configuring backup, backing up, restoring, deleting backups, and so on. Azure Backup is scoped to the vault, making it ideal for monitoring a single vault.

If you need to monitor operational activities at scale, Backup Explorer provides an aggregated view of your entire backup estate, enabling detailed drill-down analysis and troubleshooting. It's a built-in Azure Monitor workbook that provides a single, central location to help you monitor operational activities across the entire backup estate on Azure, spanning tenants, locations, subscriptions, resource groups, and vaults.
