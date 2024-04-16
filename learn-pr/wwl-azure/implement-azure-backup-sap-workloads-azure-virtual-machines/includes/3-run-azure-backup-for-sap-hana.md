

SAP HANA databases are critical workloads that require a low recovery-point objective (RPO) and long-term retention. Azure Backup provides RPO of up to 15 minutes for some workloads and options for long-term retention SAP HANA databases running on Azure VMs.

At a high level, the infrastructure, configuration, and tasks need to be completed for Azure Backup for SAP HANA on Azure VMs are as follows:

1. Set up the database for backup with the pre-registration script.
1. Create and configure a Recovery Services vault.
1. Discover databases on your VM.
1. Configure backups and create backup policy.
1. Run an on-demand backup job.

Let's look at each task in more detail.

## 1. Set up the database for backup with the pre-registration script

For Windows VMs, the **VM Snapshot** extension is installed. For Windows VMs that are running, Azure Backup coordinates with the Windows Volume Shadow Copy Service (VSS) to take an app-consistent snapshot of the VM. By default, Azure Backup takes full VSS backups. If Azure Backup can't take an app-consistent snapshot, it takes a file-consistent snapshot of the underlying storage (because no application writes occur while the VM is stopped).

For Linux VMs, the **VM Snapshot Linux** extension is installed, and Azure Backup takes a file-consistent backup. For app-consistent snapshots, you need to manually customize pre/post scripts.

Running the pre-registration script performs outbound network connectivity checks with Azure Backup servers and dependent services like Microsoft Entra ID and Azure Storage. It logs into your HANA system using the user key listed as part of the prerequisites. The user key is used to create a backup user (**AZUREWLBACKUPHANAUSER**) in the HANA system, and the user key can be deleted after the pre-registration script runs successfully.

To find out more about prerequisites and what the pre-registration script does, see the **Prerequisites** section of [SAP HANA databases in Azure VMs](/azure/backup/backup-azure-sap-hana-database).

## 2. Create and configure a Recovery Services vault

A Recovery Services vault is a logical container that stores the backup data for each protected resource, such as Azure VMs or workloads running on Azure VMs (like SQL or HANA databases). When a backup job runs for a protected resource, it creates a recovery point inside the Recovery Services vault. You can then later use one of these recovery points to restore data to a given point in time.

> [!NOTE]
> You can create a Recovery Services vault with the Azure portal or by running `az backup vault create` in Azure CLI. Specify the same resource group and location as the VM you wish to protect.

You can use Recovery Services vaults to hold backup data for various Azure services, such as IaaS VMs (Linux or Windows) and Azure SQL databases. Recovery Services vaults support System Center DPM, Windows Server, Azure Backup Server, and more.

Recovery Services vaults are based on the Azure Resource Manager model of Azure, which provides features such as:

- **Enhanced capabilities to help secure backup data**: The security features ensure you can secure your backups, and safely recover data, even if production and backup servers are compromised.
- **Central monitoring for your hybrid IT environment**: Use a central portal to monitor not only your Azure IaaS VMs but also your on-premises assets.
- **Azure role-based access control (Azure RBAC)**: Azure RBAC restricts backup and restore access to the defined set of user roles. Azure Backup has three built-in roles to manage recovery points.
- **Soft Delete**: Even if a malicious actor deletes a backup (or if backup data is accidentally deleted), the data is retained and can be recovered for 14 days.
- **Cross Region Restore (CRR)**: You can restore Azure VMs in a secondary, Azure-paired region. This is useful for testing data backed up in the secondary location, for audit or compliance purposes, or if Azure declares a disaster in the primary region.

## 3. Discover databases on your VM

From the Azure portal in your vault, you can run the Discovery tool to list unprotected VMs by name and resource group. You can filter the results to show only VMs hosting SAP HANA, by using the **`Where is your workload running?`** filter.

When the pre-registration script run completes on each VM that you want to back up, you can then discover databases. During discovery, Azure Backup registers the VM with the vault and installs an extension on the VM.

## 4. Configure backups and create backup policy

The next step is to select the discovered databases you want to protect. You can use the dashboard to navigate to individual VMs. The Recovery Services vault dashboard provides access to vault information, including:

- The latest backup, which is also the latest restore point.
- The backup policy.
- The total size of all backup snapshots.
- The number of VMs that are enabled for backups.

Backup policy defines when backups are taken and how long they're retained. Policies are created at the vault level, and while multiple vaults can use the same backup policy, you need to apply the backup policy to each vault. Policies can be set for full and differential backups.

Before creating a new policy for SAP HANA backup, clarify your Recovery Point Objective (RPO) and Recovery Time Objective (RTO) requirements and their cost implications.

- **RPO** indicates how much data loss is acceptable for the user/customer. The log backup frequency determines the RPO: more frequent log backups provide lower RPO (to a minimum of 15 minutes).
- **RTO** indicates how fast the data should be restored to the last available point-in-time after a data loss scenario.
  - **Daily Full + logs** backups are more expensive because of high data accumulation.
  - **Weekly Full + daily differential + logs** or **Weekly Full + daily incremental + logs** backups are cheaper and result in less data accumulation, because a full copy is taken only once a week.

There are a few principles you should keep in mind when deciding whether to change an item's backup policy:

- All changes are applied retroactively. The most recent backup policy is also applied to any recovery points taken.
- The scope of change also includes the day of backup and type of backup, and retention. For example: If you change a policy  from **daily full** to **weekly full on Sundays**, all earlier daily full backups that aren't from Sundays are marked for deletion.
- A parent isn't deleted until the child is active/not-expired. Every backup type has an expiration time according to the currently active policy. However, even if a parent is marked for deletion, the deletion isn't performed until the child differentials or logs are expired. So, with our policy that we changed from **daily full** to **weekly full on Sundays**, all earlier daily full backups that aren't on Sundays will be marked for deletion. However, backups aren't deleted until the logs that were taken daily earlier are expired. A full backup type is considered as parent to subsequent differentials, incrementals, and logs.

See more information on Azure backup policy in [FAQ-Backup SAP HANA databases on Azure VMs](/azure/backup/sap-hana-faq-backup-azure-vm).

## 5. Run an on-demand backup job

You can run an on-demand backup of a VM after you set up its backup protection. Keep these details in mind:

- If the initial backup is pending, an on-demand backup creates a full copy of the VM in the Recovery Services vault.
- If the initial backup is complete, an on-demand backup only sends changes from the previous snapshot to the Recovery Services vault. That is, later backups are always incremental.
- If you run an on-demand backup, the retention range for an on-demand backup is the retention value that you specify when you trigger the backup.

For SAP HANA databases on Azure VMs, Azure Backup supports only one full backup per day. You can't have a differential backup and a full backup triggered on the same day.

> [!NOTE]
> You can also access the functionality described in the previous sections via Backup Center. Backup Center is a single unified management experience in Azure. It enables enterprises to govern, monitor, operate, and analyze backups at scale. With this solution, you can perform most of the key backup management operations without being limited to the scope of an individual vault.

When the backup job is triggered, Azure Backup performs the following sequence of tasks:

1. When backup job is triggered, Azure Backup executes a pre-snapshot script that puts SAP HANA in a consistent state.
1. When the consistent state is confirmed, Azure Backup executes the disk snapshots.
1. When the snapshots complete, Azure Backup undoes the activity from the pre-snapshot script.
1. After a successful backup, Azure Backup streams the data into the Backup vault.
