

This lesson describes how to restore SAP HANA databases running on Azure Virtual Machines (VMs), which the Azure Backup service backed up to a Recovery Services vault. Restores can be used to create copies of the data for dev/test scenarios or to roll back to an earlier state.

## View restore points

You can view a list of all the available recovery points for a database by using Azure CLI or the Azure portal:

- In Azure CLI, use `az backup recoverypoint list`.
- In the Azure portal, open the vault in which the database is registered, select a database to restore, and review the database menu. This provides information about database backup, including the oldest and newest restore points and the database's log backup status for the last 24 and 72 hours.

## Prerequisites

Before restoring a database:

- You can restore the database only to an SAP HANA instance that's in the same region.
- The target instance must be registered with the same vault as the source.
- Azure Backup can't identify two different SAP HANA instances on the same VM, so you can't restore data from one instance to another on the same VM.
- To ensure that the target SAP HANA instance is ready for restore, check its [**Backup readiness** status](/azure/backup/sap-hana-database-restore#prerequisites).

## Restore a database

Azure Backup can restore SAP HANA databases that are running on Azure VMs as follows:

- Restore to a specific date or time. Azure Backup automatically determines the appropriate full, differential backups and the chain of log backups that are required to restore to the selected time.

- Restore to a specific full or differential backup for restoring to a specific recovery point.

To restore a database, you need the following permissions:

- **Backup Operator** permissions in the vault where you're doing the restore.
- **Contributor (write)** access to the source VM for the backup.
- **Contributor (write)** access to the target VM. If you're restoring to the same VM, this is the source VM. If you're restoring to an alternate location, this is the new target VM.

When setting the restore configuration, you can specify where (or how) to restore data:

- **Alternate Location**: Restore the database to an alternate location and keep the original source database.
- **Overwrite DB**: Restore the data to the same SAP HANA instance as the original source. This option overwrites the original database.
- **Restore as files**: Dump the files to a specified path. You can then transfer the files manually to any SAP HANA machine where you want to restore them as a database.

Cross-OS restore is possible using streaming backups (for example, backup of a database running on SLES to restore to an RHEL HANA system). However, you have to ensure that the HANA system you want to restore to and the HANA system you're restoring from are both compatible for restore. Refer to [SAP HANA Note 1642148](https://me.sap.com/notes/1642148) to see which restore types are compatible.

## Test restores

Independent of your backup method, running a test restore against a different system is an absolute necessity. This approach provides a way to ensure that a backup is correct, and that internal processes for backup and restore work as expected. It's true that there are tools provided with HANA that can check backup files' ability to restore. However, the frequent restore exercises are valuable for testing the process of a database restore and training that process with the operations staff.

Keep in mind that doing a simple restore and checking if HANA is up and running isn't sufficient. You should run a table consistency check to be sure that the restored database is fine. SAP HANA offers several kinds of consistency checks, described in [SAP Note 1977584](https://me.sap.com/notes/1977584).

You can find more information about the table consistency check on the SAP website at [Table and Catalog Consistency Checks](https://help.sap.com/saphelp_hanaplatform/helpdata/en/25/84ec2e324d44529edc8221956359ea/content.htm).

## Cross Region Restore

As one of the restore options, Cross Region Restore (CRR) allows you to restore SAP HANA databases hosted on Azure VMs to Azure VMs in a secondary, Azure-paired region. Cross Region Restore supports the following data sources:

- Azure VMs
- SQL databases hosted on Azure VMs
- SAP HANA databases hosted on Azure VMs

Using Cross Region Restore allows you to:

- Conduct drills when there's an audit or compliance requirement.
- Restore the data if there's a disaster in the primary region.

When you restore a VM, you can restore the VM or its disk. When restoring from SQL/SAP HANA databases hosted on Azure VMs, you can restore databases or their files.

You can configure Cross Region Restore by opening any vault that you created with Geo-Redundant storage (GRS). This includes the option to configure the Cross Region Restore feature. To configure CRR for the vault, go to the **Backup Configuration** pane. To begin using the CRR feature, see [Set Cross Region Restore](/azure/backup/backup-create-recovery-services-vault#set-cross-region-restore).

> [!NOTE]
> Every GRS vault has a banner which links to the CRR documentation.

When Cross Region Restore is enabled, you can view the backup items from the secondary region. The secondary region restore user experience is similar to the primary region restore user experience. When you're entering details in the **Restore Configuration** pane, you're prompted to provide only secondary region parameters.
