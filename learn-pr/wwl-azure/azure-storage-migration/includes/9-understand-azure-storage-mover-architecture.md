Azure Storage Mover is a fully managed migration service that enables you to move files and folders from on-premises storage or other clouds into Azure Storage while minimizing downtime for your workload. Unlike scripting-based approaches such as AzCopy or RoboCopy, Storage Mover provides a managed control plane in Azure that orchestrates migration jobs, tracks progress, and handles retries — freeing you from building and maintaining custom migration infrastructure.

The service is purpose-built for large-scale, one-time migrations. It operates in iterative waves: an initial pass copies the bulk of the data, and subsequent passes capture any changes that occurred on the source since the last run. This approach lets you continue operating your source storage during the migration and schedule a brief final cutover window once convergence is reached.

## Supported migration scenarios

Storage Mover supports several source-to-target combinations. The following table summarizes the currently supported migration paths:

| Source | Target | Notes |
|--------|--------|-------|
| NFS v3 / v4 mount | Azure Blob container (FNS or HNS) | HNS-enabled containers use the ADLS Gen2 REST API for migration. |
| NFS v3 / v4 mount | Azure File Share | |
| SMB 2.x / 3.x mount | Azure File Share (SMB) | SMB 1.x sources aren't supported. NFS-enabled Azure File Shares aren't supported as targets. |
| SMB 2.x / 3.x mount | Azure Blob container (FNS or HNS) | HNS-enabled containers use the ADLS Gen2 REST API for migration. |
| AWS S3 | Azure Blob container | Objects in Glacier or Glacier Deep Archive storage classes can't be migrated directly. |
| Azure Blob container | Azure Blob container | Cloud-to-cloud migration path for consolidation or cross-region moves. |

### Cloud-to-cloud migrations

In addition to on-premises sources, Storage Mover supports cloud-to-cloud migrations. The most common scenario is migrating data from Amazon S3 buckets to Azure Blob Storage. Storage Mover uses Azure Arc multicloud connectors for AWS to simplify authentication and access management — you connect your AWS account through Arc and Storage Mover handles credential brokering without requiring you to embed long-lived AWS access keys in your configuration.

The Azure-to-Azure path enables migrations between Azure Blob containers across different storage accounts, subscriptions, or regions. This is useful when consolidating multiple storage accounts, restructuring after an acquisition, or moving data closer to compute resources in a different region. Cloud-to-cloud job definitions use the same project and endpoint model as on-premises migrations. The only difference is that both source and target endpoints reference Azure or AWS resources rather than local shares.

The breadth of supported scenarios makes Storage Mover the first tool to evaluate for most file and object migrations into Azure. If your source is a Windows file server and you need to preserve the server's name and IP identity during cutover, Storage Migration Service remains the better fit. If you need ongoing hybrid synchronization rather than a one-time move, Azure File Sync is the appropriate choice.

Learn more: [Cloud-to-cloud migration with Storage Mover](/azure/storage-mover/cloud-to-cloud-migration)

## Architecture and key concepts

A Storage Mover deployment is organized into a hierarchy of resources. At the top sits the **Storage Mover resource** itself, which you deploy into an Azure resource group in the region of your choice. This resource acts as the management and control plane — it stores migration metadata and coordinates agents. Your data never flows through this resource or through the Storage Mover service. Data always travels directly from the agent to the target storage account.

**Agents** are virtual machine appliances that you deploy on a Hyper-V or VMware host as close to the source storage as possible. Each agent registers to a single Storage Mover resource via Azure Arc. You can register multiple agents to the same Storage Mover resource to parallelize work across different sources or locations.

Within a Storage Mover resource you create **projects** to logically group related migration work. Inside each project you define **endpoints** — these describe the source (for example, the IP address and export path of an NFS share) and the target (for example, an Azure Blob container in a specific storage account). A **job definition** ties a source endpoint to a target endpoint and specifies a copy mode: *Additive* merges the source into the target without removing extra files on the target side, while *Mirror* makes the target an exact replica of the source, deleting files that no longer exist at the source. When you start a job definition, Storage Mover creates a **job run** that the assigned agent executes.
