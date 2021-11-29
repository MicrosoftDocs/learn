Protection and recovery are the third and final discipline in a cloud-management baseline. For an enterprise environment, this table outlines the suggested minimum for any management baseline:

| Tool | Description | Link to more information |
| -----|-------------|--------------------------|
| Azure Backup | Backup of data and virtual machines in Azure | [Azure Backup overview](/azure/backup/backup-overview) |
| Microsoft Defender for Cloud | Strengthened security and advanced threat protection |  [Microsoft Defender for Cloud product page](https://azure.microsoft.com/services/security-center/) |

Another essential tool is Azure Site Recovery. Azure Site Recovery replicates virtual machines and workloads between clouds, Azure regions, or local datacenters. When an outage occurs in your primary Azure region, your workload (for example, virtual machines) fails over to the copy running in the secondary Azure region. The workload will then be online in the secondary site or region. 

This approach to recovery can significantly reduce recovery times. Most likely, the default management baseline includes Azure Site Recovery. For your most critical workloads, it can be suitable protection.

An older IT environment often has one backup solution with one configuration. Azure makes it easy to deploy a backup vault for each workload if needed. With separate backup vaults, you can handle both permissions to backup data and showback for the backup cost.
