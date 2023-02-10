An Azure Recovery Services vault is a storage entity in Azure that houses data. The data is typically copies of data, or configuration information for virtual machines, workloads, servers, or workstations. You can use Recovery Services vaults to organize your backup data and minimize your management overhead.

### Things to know about Recovery Services vaults

Here are some characteristics of Azure Recovery Services vaults.

- A Recovery Services vault stores backup data for various Azure services, such as IaaS virtual machines (Linux or Windows) and Azure SQL databases.

- Azure Recovery Services vaults support System Center Data Protection Manager (DPM), Windows Server, Microsoft Azure Backup Server (MABS), and other services.

- You can use an Azure Recovery Services vault to back up your Azure virtual machines:

   :::image type="content" source="../media/virtual-machine-backup-1e49089a.png" alt-text="Screenshot that shows how to back up an Azure virtual machine to an Azure Recovery Services vault.":::
    
- A Recovery Services vault can be used to back up your on-premises virtual machines, such as Hyper-V, VMware, System State, and Bare Metal Recovery:

   :::image type="content" source="../media/virtual-machine-system-backup-b249b753.png" alt-text="Screenshot that shows how to back up an on-premises Azure virtual machine to an Azure Recovery Services vault":::

For details about creating an Azure Recovery Services vault, see [Configure Azure Recovery Services vault backup options](/training/modules/configure-file-folder-backups/4-setup-recovery-service-vault-backup-options).