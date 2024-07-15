Azure Site Recovery is the appropriate solution for Adatum for the following reasons:

- Azure Site Recovery can orchestrate the replication of virtual machines in Adatum's Sydney datacenter to the Australia East Azure region. If necessary, Adatum can temporarily fail over these workloads to Australia East Azure region and fail them back at a later point in time.

- Azure Site Recovery can orchestrate the replication of virtual machines in the Australia East Azure region to the Australia Southeast region.

- You can configure Azure Site Recovery to store recovery points for two weeks. This configuration meets Adatum's goals for recovering from data corruption problems.

- Azure Site Recovery allows test failovers to be performed without performing an actual failover, allowing you to verify that the existing virtual machine protection configuration meets Adatum's needs.

## When not to use Azure Site Recovery

Azure Site Recovery isn't a backup solution, but you can use it with backup solutions such as Azure backup. You can configure Azure Site Recovery to store recovery points for up to 15 days. If you want to restore a version of a virtual machine from three or four weeks ago, you must take snapshots of that virtual machine using Azure Backup or a non-Microsoft solution. Azure Backup can store a snapshot of an Azure IaaS virtual machine (VM) for up to 9,999 days. Many organizations use both Azure Backup and Azure Site Recovery as a part of their business continuity strategy.

While Azure Site Recovery can replicate entire computer workloads, there might be scenarios where you only want to replicate applications or other types of data. Some organizations use SQL Server Always On availability groups to replicate copies of important databases. The databases are replicated across sites and to Azure IaaS VMs,
without replicating the computer or virtual machine that hosts the database. Also, solutions such as Azure File Sync allow the contents of file servers to be replicated, and to remain available during a site failure without requiring the replication of the host computer.
