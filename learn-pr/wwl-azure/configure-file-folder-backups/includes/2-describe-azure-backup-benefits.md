Azure Backup is the Azure-based service you can use to back up (or protect) and restore your data in the Microsoft cloud. Azure Backup replaces your existing on-premises or off-site backup solution with a cloud-based solution that's reliable, secure, and cost-competitive.

Azure Backup offers multiple components that you download and deploy on the appropriate computer, server, or in the cloud. The component, or agent, that you deploy depends on what you want to protect. All Azure Backup components (no matter whether you're protecting data on-premises or in the cloud) can be used to back up data to a Recovery Services vault in Azure.

#### Overview of Azure Backup

> [!Video https://www.youtube.com/embed/elODShatt-c]

### Things to know about Azure Backup

Let's take a look at some of the many benefits you gain from implementing Azure Backup.

| Benefit | Description |
| --- | --- |
| **Offload on-premises backup** | Azure Backup offers a simple solution for backing up your on-premises resources to the cloud. Get short and long-term backup without the need to deploy complex on-premises backup solutions. |
| **Back up Azure IaaS VMs** | Azure Backup provides independent and isolated backups to guard against accidental destruction of original data. Backups are stored in an Azure Recovery Services vault with built-in management of recovery points. Configuration and scalability are simple, backups are optimized, and you can easily restore as needed. |
| **Get unlimited data transfer** | Azure Backup doesn't limit the amount of inbound or outbound data you transfer, or charge for the data that's transferred. Outbound data refers to data transferred from a Recovery Services vault during a restore operation. If you perform an offline initial backup by using the Azure Import/Export service to import large amounts of data, there's a cost associated with inbound data. |
| **Keep data secure** | Data encryption allows for secure transmission and storage of your data in the public cloud. You store the encryption passphrase locally, and it's never transmitted or stored in Azure. If it's necessary to restore any of the data, only you have encryption passphrase, or key. |
| **Get app-consistent backups** | An application-consistent backup means a recovery point has all required data to restore the backup copy. Azure Backup provides application-consistent backups, which ensure extra fixes aren't required to restore the data. Restoring application-consistent data reduces the restoration time, allowing you to quickly return to a running state. |
| **Retain short and long-term data** | You can use Azure Recovery Services vaults for short-term and long-term data retention. Azure doesn't limit the length of time data can remain in a Recovery Services vault. You can keep it for as long as you like. Azure Backup has a limit of 9,999 recovery points per protected instance. |
| **Automatic storage management** | Hybrid environments often require heterogeneous storage with some on-premises instances and some instances in the cloud. With Azure Backup, there's no cost for implementing on-premises storage devices. Azure Backup automatically allocates and manages backup storage. The service uses a pay-as-you-use model, so you only pay for the storage you consume. |
| **Multiple storage options** | Azure Backup offers two types of replication to keep your storage and data highly available. <br><br>**Locally redundant storage (LRS)** replicates your data three times (it creates three copies of your data) in a storage scale unit in a datacenter. All copies of the data exist within the same region. LRS is a low-cost option for protecting your data from local hardware failures. <br><br>**Geo-redundant storage (GRS)** is the default and recommended replication option. GRS replicates your data to a secondary region (hundreds of miles away from the primary location of the source data). GRS costs more than LRS, but GRS provides a higher level of durability for your data, even if there's a regional outage. |