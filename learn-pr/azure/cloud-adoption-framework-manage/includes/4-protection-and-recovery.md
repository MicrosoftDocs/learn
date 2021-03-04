Protect and recover is the third and final discipline in any cloud-management baseline. For any enterprise-grade environment, this table outlines the suggested minimum for any management baseline:

| Tool | Description | Link to more information |
| -----|-------------|--------------------------|
| Azure Backup | Backup up data and virtual machines in Azure. | [More information at Microsoft Docs](https://docs.microsoft.com/azure/backup/backup-overview) |
| Azure Security Center | Strengthen security and provides advanced threat protection. |  [More information at Microsoft Docs](https://azure.microsoft.com/services/security-center/) |

Another essential tool is Azure Site Recovery. Azure Site Recovery replicates virtual machines and workloads between clouds, Azure regions, or local datacenters. When an outage occurs in your primary Azure region, your workload, for example Virtual Machines, fails over to the copy running in the secondary Azure region. The workload will then be online in the secondary site or region. This approach to recovery can significantly reduce recovery times. Most likely, the default management baseline includes Azure Site Recovery. Still, for your most critical workloads, it can be suitable protection.

Often in a legacy IT environment, one backup solution with more or less one configuration. Azure makes it easy to deploy a backup vault for each workload if needed. With seprate backup vaults it also becomes easy to handle both permissions to backup data and show back for the backup cost.
