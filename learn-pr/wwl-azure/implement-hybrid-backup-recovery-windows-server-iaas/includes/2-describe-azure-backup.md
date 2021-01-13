
Contoso depends on computing resources for their operations and needs to maintain business continuity. To develop a business continuity plan, the IT team must identify the necessary steps to recover from a disaster that impacts computing resources availability. The two most common means of facilitating business continuity are implementing a comprehensive backup, and developing a disaster recovery strategy. Azure offers dedicated services that not only considerably simplify these tasks.

## What is Azure Backup?

The Azure Backup service uses Azure resources for short-term and long-term storage to minimize or even eliminate the need for maintaining physical backup media such as tapes, hard drives, and DVDs. Since its introduction, the Azure Backup service has evolved from its original form that relied exclusively on a backup agent that you could download on the Azure portal, into a much more diverse offering.

Azure Backup’s most basic functionality helps you to protect folders and files on Windows Server and client operating systems, both on-premises and in Azure. This functionality relies on the Azure Recovery Services Agent, which is available for download on the Azure Recovery Services vault interface in the Azure portal. You must install the agent on every system that you want to protect.

The Azure Backup service includes:

- 64-bit Windows Server and client file, folder, and system state backups by using the Azure Recovery Services agent, and the Online Backup integration module for Windows Server Essentials.
- Long-term storage for backups with Microsoft System Center Data Protection Manager and Recovery Services Agent.
- Long-term storage for backups with Azure Backup Server and Recovery Services Agent.
- Azure VM-level backups with the Azure VM extensions for Linux and Windows operating systems. 

Azure Backup offers several optional features that provide additional data protection, including:

- Retention of backups for 14 days following their deletion.
- A custom personal identification number (PIN), which is required to modify an existing passphrase, or to stop protection and delete backup data.
- Administrative email alerts triggered by events such as disabling or deleting backups.

## Why use Azure Backup?

Azure Backup offers multiple components that you can download and deploy on the appropriate computer,
server, or in the cloud. The component (or *agent*) that you deploy depends on what you want to protect.
All Azure Backup components (regardless of whether you're protecting data on-premises or in the cloud) can be used to back up data to a Recovery Services vault in Azure. Azure Backup delivers the benefits described in the following table.

|Benefit|Description|
|----|----|
| Automatic storage management|Azure Backup automatically allocates and manages backup storage, using a pay-as-you-use model.|
|Unlimited scaling|There is no need to worry about high availability for your data in the cloud.|
|Two storage options|Azure Backup offers two types of replication: locally redundant storage (LRS), and geo-redundant storage (GRS).|
|Unlimited data transfer|Azure Backup doesn't limit the amount of inbound or outbound data you transfer.|
|Data encryption|Data encryption enables more secure transmission and storage of your data in the public cloud.|
|Application-consistent backup|With an application-consistent backup, a recovery point has all required data to restore the backup copy.|
|Long-term retention|You can use Recovery Services vaults for both short-term and long-term data retention.|

## How can you use Azure Backup?

You can use Azure Backup to perform the following backup types:

- On-premises. Azure Backup can back up files, folders, and system state using the Microsoft Azure Recovery Services (MARS) agent. Alternatively, you can use Data Protection Manager (DPM) or the Microsoft Azure Backup Server (MABS) agent to protect on-premises VMs (both Hyper-V and VMware), and other on-premises workloads.
- Azure VMs. Back up entire Windows or Linux VMs (using backup extensions), or back up files, folders, and system state using the MARS agent.
- Azure Files shares. Back up Azure File shares to a storage account.
- Microsoft SQL Server in Azure VMs. Back up SQL Server databases running on Azure VMs.
- SAP HANA databases in Azure VMs. Back up SAP HANA databases running on Azure VMs.
- Microsoft cloud. Azure Backup replaces your existing on-premises or off-site backup solution with a cloud-based solution that's reliable, secure, and cost-competitive.

## Security features for hybrid backups

Concerns about security issues such as malware, ransomware, and intrusion, are increasing. These security issues can be costly, in terms of both money and data. To help guard against such attacks, Azure Backup now provides security features to help protect hybrid backups. These features are described in the following table.

|Feature|Description|
|----|----|
|Prevention|An additional layer of authentication is added whenever a critical operation such as changing a passphrase is performed. This validation helps to ensure that only users who have valid Azure credentials can perform such operations.|
|Alerting|An email notification is sent to the subscription admin whenever a critical operation such as deleting backup data is performed. This email ensures that the user is notified quickly about such actions.|
|Recovery|Deleted backup data is retained for an additional 14 days from the date of the deletion. This ensures the data is recoverable within a given period, so there is no data loss even if an attack occurs. Also, a greater number of minimum recovery points are maintained to guard against corrupt data.|

## Additional reading

For more information, review the following documents:

- [An overview of Azure VM backup](https://aka.ms/backup-azure-vms-introduction?azure-portal=true)
- [About the Microsoft Azure Recovery Services (MARS) agent](https://aka.ms/backup-azure-about-mars?azure-portal=true)
- [MABS (Azure Backup Server) V3 UR1 protection matrix](https://aka.ms/mabs-protection-matrix?azure-portal=true)
- [Prepare to back up workloads to Azure with System Center DPM](https://aka.ms/backup-azure-dpm-introduction?azure-portal=true)
- [Security features to help protect hybrid backups that use Azure Backup](https://aka.ms/backup-azure-security-feature?azure-portal=true)
