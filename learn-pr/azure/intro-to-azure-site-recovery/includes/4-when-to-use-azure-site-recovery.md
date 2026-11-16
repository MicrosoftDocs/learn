Azure Site Recovery addresses Adatum's disaster-recovery needs as part of a broader protection strategy:

- Azure Site Recovery can orchestrate the replication of virtual machines in Adatum's Sydney datacenter to the Australia East Azure region. If necessary, Adatum can temporarily fail over these workloads to Australia East Azure region and fail them back at a later point in time.

- Azure Site Recovery can orchestrate the replication of virtual machines in the Australia East Azure region to the Australia Southeast region.

- Adatum can use Site Recovery for outage recovery and an appropriate backup policy for two-week historical recovery across its on-premises and Azure workloads. Azure-to-Azure replication can also retain up to 15 days of recovery history, but that limit shouldn't be applied to every replication scenario or treated as a replacement for backups.

- Adatum can use test failover in an isolated non-production network to validate application recovery, measure recovery objectives, and identify missing dependencies. Each drill should include test-failover cleanup.

## Consider the cost of protection

Estimate protected-instance charges, replica and cache storage, storage transactions, and applicable data-transfer charges. Test failover and production failover also create billable compute and storage resources.

Recovery VMs generally don't run continuously before failover, but provisioned supporting infrastructure and optional capacity reservations can still incur charges. Clean up completed test failovers and include recovery testing in the cost estimate.

## When not to use Azure Site Recovery

Azure Site Recovery and Azure Backup serve different purposes. Site Recovery replicates workloads for disaster recovery and keeps recovery points within the limits of the selected replication scenario. Azure Backup provides independently retained backup recovery points for historical restore requirements.

For Azure VM backup, data is transferred to a Recovery Services vault and retained according to the backup policy. The documented daily recovery-point retention range is 7 to 9,999 days. This isn't the retention period for Instant Restore snapshots, which are kept separately for a shorter period determined by the policy.

Use an appropriate backup policy when you need to restore data from weeks or months earlier. Replication can copy unwanted changes as well as valid ones, so it isn't a substitute for independently protected backups and tested restore procedures. Many organizations use both services as part of their business continuity strategy.

While Azure Site Recovery can replicate entire computer workloads, there might be scenarios where you only want to replicate applications or other types of data. Some organizations use SQL Server Always On availability groups to replicate copies of important databases. The databases are replicated across sites and to Azure IaaS VMs, without replicating the computer or virtual machine that hosts the database.

For file-server data, Azure File Sync synchronizes file content with an Azure file share without requiring replication of the entire server. A prepared standby server endpoint can provide another access location. If the original server is lost and no standby is available, a recovery option is to provision a new server, install the Azure File Sync agent, and create a new server endpoint.

> [!NOTE]
> File Sync doesn't automatically redirect users when a file server fails. Plan how clients will reach the standby or replacement server, for example through DFS Namespaces, and validate the recovery procedure. Changes that hadn't synchronized from the failed server aren't available in the cloud copy. File synchronization also doesn't replace independently retained backups.
