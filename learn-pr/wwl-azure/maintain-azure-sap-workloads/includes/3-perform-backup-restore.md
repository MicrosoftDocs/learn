

In order to back up Azure VMs, Azure Backup installs an extension on the VM agent running on the machine. If your VM was created from an Azure Marketplace image, the agent will be running. In some cases, for example if you create a custom VM, or you migrate a machine from on-premises. you might need to install the agent manually. If you do need to install the VM agent manually, use the following OS-specific instructions:

* **Windows** [https://docs.microsoft.com/azure/virtual-machines/extensions/agent-windows](https://docs.microsoft.com/azure/virtual-machines/extensions/agent-windows) 

* **Linux** [https://docs.microsoft.com/azure/virtual-machines/extensions/agent-linux](https://docs.microsoft.com/azure/virtual-machines/extensions/agent-linux) 

After the agent is installed, when you enable backup, Azure Backup installs the backup extension. It also updates and patches the extension without user intervention.

You can back up Azure VMs using a couple of methods:

* **Single Azure VM**: directly from the VM settings in the Azure portal. For details, refer to [https://docs.microsoft.com/azure/backup/backup-azure-vms-first-look-arm](https://docs.microsoft.com/azure/backup/backup-azure-vms-first-look-arm) 

* **Multiple Azure VMs**: You can set up a Recovery Services vault and configure backup for multiple Azure VMs. For details, refer to [https://docs.microsoft.com/azure/backup/backup-azure-arm-vms-prepare](https://docs.microsoft.com/azure/backup/backup-azure-arm-vms-prepare) 

## Application-consistent backup of Azure Linux VMs

When performing backup snapshots of your VMs, application consistency means your applications should be able to start when the VMs boot after being restored. In Windows VMs, snapshots rely on VSS to facilitate application consistency. For Linux VMs, you can use the Linux pre-script and post-script framework to perform application-consistent backups. 

The framework provides an option to run custom pre-scripts and post-scripts while you're taking VM snapshots. Pre-scripts run just before you take the VM snapshot, and post-scripts run immediately after you take the VM snapshot. 

Post-scripts use native application APIs to thaw the IOs, which enable the application to resume normal operations after the VM snapshot.

## Steps to configure pre-script and post-script

1. Sign in as the root user to the Linux VM that you want to back up.

2. From GitHub at [https://github.com/MicrosoftAzureBackup/VMSnapshotPluginConfig](https://github.com/MicrosoftAzureBackup/VMSnapshotPluginConfig) , download VMSnapshotScriptPluginConfig.json and copy it to the /etc/azure directory of all VMs you want to back up. If the /etc/azure directory doesn't exist, create it.

3. Copy the pre-script and post-script for your application to all VMs you plan to back up. You can copy the scripts to any location on the VM. Be sure to update the full path of the script files in the VMSnapshotScriptPluginConfig.json file.

4. Ensure the following permissions for these files:
    - **VMSnapshotScriptPluginConfig.json: Permission “600.”** Only “root” user should have “read” and “write” permissions to this file, and no user should have “execute” permissions.
    - **Pre-script file: Permission “700.”** Only “root” user should have “read”, “write”, and “execute” permissions to this file.
    - **Post-script Permission “700.”** Only “root” user should have “read”, “write”, and “execute” permissions to this file.

> [!IMPORTANT]
> The framework gives users a lot of power. Secure the framework, and ensure only “root” user has access to critical JSON and script files. If the requirements aren't met, the script won't run, which results in a file system crash and inconsistent backup.

5. Configure VMSnapshotScriptPluginConfig.json as described here:

    * **pluginName**: Leave this entry as is, or your scripts might not work as expected.
    
    * **preScriptLocation**: Provide the full path of the pre-script on the VM that's going to be backed up.
    
    * **postScriptLocation**: Provide the full path of the post-script on the VM that's going to be backed up.
    
    * **preScriptParams**: Provide the optional parameters that need to be passed to the pre-script. 
    
    * **postScriptParams**: Provide the optional parameters that need to be passed to the post-script.
    
    * **preScriptNoOfRetries**: Set the number of times the pre-script should be retried if there is any error before terminating. Zero means only one try and no retry if there is a failure.
    
    * **postScriptNoOfRetries**: Set the number of times the post-script should be retried if there is any error before terminating. Zero means only one try and no retry if there is a failure.
    
    * **timeoutInSeconds**: Specify individual timeouts for the pre-script and the post-script (maximum value can be 1800).
    
    * **continueBackupOnFailure**: Set this value to true if you want Azure Backup to fall back to a file system consistent/crash consistent backup if pre-script or post-script fails. Setting this to false fails the backup in case of script failure (except when you have single-disk VM, in which case, script failure results always in crash-consistent backup).
    
    * **fsFreezeEnabled**: Specify whether Linux fsfreeze should be called while you're taking the VM snapshot to ensure file system consistency. We recommend keeping this setting set to true unless your application has a dependency on disabling fsfreeze.

6. The script framework is now configured. If the VM backup is already configured, the next backup invokes the scripts and triggers application-consistent backup.

## SQL Server backup to URL (Azure Storage)

Creating a Windows Azure Storage account within your Azure subscription is the first step in this process. As explained earlier in this course, SQL Server can either use the Windows Azure storage account name and its access key value to authenticate and write and read blobs to the Microsoft Azure Blob storage service or use a Shared Access Signature token granting read and write permissions to individual containers. The SQL Server Credential stores this authentication information and uses it during the backup or restore operations.

To implement SQL Server Backup to URL, you can use of the following methods:

* **Back Up Task in SQL Server Management Studio**: You can back up a database to URL through the Back Up task in SQL Server Management Studio using a SQL Server Credential.

* **SQL Server Backup to URL Using Maintenance Plan Wizard**: the Maintenance Plan Wizard in SQL Server Management Studio includes URL as one of the destination options, and other supporting objects required to backup to Windows Azure storage like the SQL Credential.

* **Transact-SQL, PowerShell or C#**: these options must be used to create a striped backup set, a SQL Server file-snapshot backup, or a SQL credential using Shared Access token

**SQL Server Automated Backup v2 for Azure VMs**

Automated Backup v2 automatically configures Managed Backup to Microsoft Azure for all existing and new databases on an Azure VM running SQL Server 2016/2017 Standard, Enterprise, or Developer editions. This enables you to configure regular database backups that utilize Azure blob storage. Automated Backup v2 depends on the SQL Server IaaS Agent Extension.

Automated Backup v2 works with SQL Server 2016 or higher. If you are using SQL Server 2014, you can use Automated Backup v1 to back up your databases.

*Database configuration:*

* Target databases must use the full recovery model. For more information about the impact of the full recovery model on backups, see Backup Under the Full Recovery Model.

* System databases do not have to use full recovery model. However, if you require log backups to be taken for Model or MSDB, you must use full recovery model.

* Target databases must be on the either the default SQL Server instance, or a named instance installed by following the procedure described at [https://docs.microsoft.com/azure/virtual-machines/windows/sql/virtual-machines-windows-sql-server-iaas-faq#administration](https://docs.microsoft.com/azure/virtual-machines/windows/sql/virtual-machines-windows-sql-server-iaas-faq#administration)

You can use the Azure portal or Az PowerShell to configure Automated Backup v2 during provisioning or for existing SQL Server 2016/2017 VMs.

## SQL Server Backup in Azure VMs (to Recovery Services Vault)

SQL Server Backup in Azure VMs can be configured in the Azure portal or PowerShell (there is no support for Azure CLI). The process involves running discovery of SQL Server instances and their databases from an Azure Recovery Services vault, selecting the databases to be backed up in the discovery results, and assigning a backup policy that determines backup settings, such as frequency and retention. You also have the option of enabling Auto-Protection, which automatically backs up all existing and future databases on a SQL Server instance or Always On Availability Group.

When you run discovery on a SQL Server, Azure Backup does the following:

* Adds the AzureBackupWindowsWorkload extension.

* Creates an NT SERVICE\AzureWLBackupPluginSvc account to discover databases on the virtual machine. This account is used for a backup and restore and requires SQL sysadmin permissions.

* Discovers databases that are running on a VM, Azure Backup uses the NT AUTHORITY\SYSTEM account. This account must be a public sign-in on SQL.

If you didn't create the SQL Server VM by using an Azure Marketplace image, you need to assign to the NT SERVICE\AzureWLBackupPluginSvc account the sysadmin role. 



## SQL Server file snapshot-based backups to Azure Storage

SQL Server File-snapshot backup uses Azure snapshots to provide nearly instantaneous backups and quicker restores for database files stored using the Azure Blob storage service. This capability enables you to simplify your backup and restore policies.

You can use Azure PowerShell scripts and SQL queries to implement SQL Server data files as Azure Blobs. Using scripts, you can easily create a database in SQL Server running on premises or in a virtual machine on Azure and set up a dedicated storage location for your data in Azure Blob Storage. You can also use the Azure portal instead of PowerShell scripts.

Regardless of the choice of the implementation method, the process involves setting up a storage account, creating SQL Server credentials, and creating a database with files stored in blobs. SQL Server needs the credentials to store the security information it uses to write to and read from the Azure blob container.
