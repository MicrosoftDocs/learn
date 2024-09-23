Here, we'll discuss how you can decide if Azure Backup is the right choice for your data protection needs. We'll highlight common backup scenarios where Azure Backup provides benefits, such as:

* Ensuring availability of your data.
* Protecting your Azure workloads.
* Securing your data.

## Decision criteria

Azure Backup is an Azure service that provides secure and zero-infrastructure backup solutions for all Azure-managed data assets. It protects a wide range of enterprise workloads, including Azure Virtual Machines, Azure Disks, SQL and SAP databases, Azure file shares and blobs.

The main criteria that we're evaluating are outlined in the following table. The table contains some key areas where Azure Backup can provide services to you for data protection.

| Criteria | Consideration |
| --- | --- |
| Azure workloads | Azure VM, Azure Disks, SQL Server, or SAP HANA database running in Azure VM, Azure Blobs, Azure Disks, Azure Database for PostgreSQL.  |
| Compliance | Customer-defined backup policy with long-term retention across multiple zones or regions. |
| Operational recoveries |  With self-service backup and restores, the application administrator can take care of issues that might arise such as accidental deletion or data corruption. |

## Apply the criteria

In the introduction, we presented a scenario where your organization might have an application that's relying on data from a back-end SQL Server installation. SQL Server is running on three Azure VMs. The data in the backup must be retained for up to 10 years to meet compliance requirements. You also want to be able to monitor the backups.

Before we dive into how Azure Backup can help meet these needs, it's important to understand what's not currently supported. If your three Azure VMs are deployed across multiple subscriptions or regions, you should be aware that Azure Backup doesn’t support cross-region backup for most workloads. However, it does support cross-region restore in a paired secondary region.

### Can Azure Backup protect the Azure VMs hosting the SQL Server instances?

Azure Backup is able to back up entire Windows and Linux VMs using backup extensions. As a result, you can back up the entire VM that is hosting SQL Server. If you only want to back up the files, folders, and system state on the Azure VMs, you can use the Microsoft Azure Recovery Services (MARS) agent.

If your main concern is to only back up the SQL Server data, Azure Backup provides support for that as well. Azure Backup offers a stream-based, specialized solution to back up SQL Servers running in Azure VMs. This solution aligns with Azure Backup's benefits of zero-infrastructure backup, long-term retention, and central management.

Additionally, Azure Backup provides the following advantages specifically for SQL Server:

* Workload aware backups that support all backup types: full, differential, and log
* 15-minute recovery point objective (RPO) with frequent log backups
* Point-in-time recovery up to a second
* Individual database-level backup and restore

:::image type="content" source="../media/azure-backup-sql-overview.png" alt-text="Diagram of SQL Server hosted on an Azure VM and being backed up to a Recovery Services Vaults in Azure Backup. Displayed are also a data path and controls arrow depicting two-way flow for the data path and control path flow from Azure Backup to the backup extension on the VM.":::

### Does Azure Backup help with compliance?

You can implement required access control mechanisms for your backups. Vaults (Recovery Services and Backup vaults) provide the management capabilities and are accessible via the Azure portal, Backup Center, Vault dashboards, SDK, CLI, and even REST APIs. It's also an Azure role-based access control (Azure RBAC) boundary, providing you with the option to restrict access to backups only to authorized Backup Admins.

Short-term retention can be "minutes" or "daily." Retention for "Weekly," "monthly," or "yearly" backup points is referred to as *Long-term retention*.

Long-term retention can be:

* **Planned (compliance requirements)**: If you know in advance that data is required years from the current time, use Long-term retention.
* **Unplanned (on-demand requirement)**: If you don't know in advance, then you can use on-demand backup with specific custom retention settings (these custom retention settings aren't impacted by policy settings).
* **On-demand backup with custom retention**: If you need to take a backup not scheduled via backup policy, then you can use an on-demand backup. It can be useful for taking backups that don’t fit your scheduled backup or for taking granular backup (for example, multiple IaaS VM backups per day since scheduled backup permits only one backup per day). It's important to note that the retention policy defined in scheduled policy doesn't apply to on-demand backups.

You can also implement policy management to help with compliance. Azure Backup Policies within each vault define when the backups should be triggered and how long they need to be retained. You can also manage these policies and apply them across multiple items.

### Does Azure Backup simplify monitoring and administration?

**Monitoring and Reporting**: Azure Backup integrates with Log Analytics and provides the ability to see reports via Workbooks as well.

Azure Backup provides in-built job monitoring for operations such as configuring backup, backing up, restore, delete backup, and so on. It's scoped to the vault and ideal for monitoring a single vault.

If you need to monitor operational activities at scale, Backup Explorer provides an aggregated view of your entire backup estate, enabling detailed drill-down analysis and troubleshooting. It's a built-in Azure Monitor workbook that gives a single, central location to help you monitor operational activities across the entire backup estate on Azure, spanning tenants, locations, subscriptions, resource groups, and vaults.
