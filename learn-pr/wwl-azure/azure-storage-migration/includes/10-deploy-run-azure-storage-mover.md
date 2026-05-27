## Deploy and size an agent

The agent VM image is available for download from the Microsoft Download Center. You extract the virtual hard disk and create a new VM on your Hyper-V or VMware host. After the VM boots, an administrative shell guides you through basic network configuration and agent registration.

Sizing the agent depends primarily on the number of files and folders in the source namespace rather than total data volume. For sources with up to 10 million items, 4 virtual cores and 8 GiB of memory are sufficient. Larger namespaces of 30 to 100 million items benefit from 6 to 8 cores and 12 to 16 GiB of memory. Local storage should be at least 100 GiB, with more needed if the source contains many small files that the agent caches during transfer.

The agent requires outbound HTTPS (TCP 443) connectivity to several Azure services including the Storage Mover service endpoint, Azure Arc, Microsoft Entra ID, Event Hubs (for copy logs), and the Microsoft Artifact Registry (for automatic agent updates). If your environment mandates private networking, you can configure a VPN Gateway or ExpressRoute circuit combined with Private Endpoints for the target storage account and Azure Arc services, though some control plane endpoints still require public access.

Learn more: [Deploy an Azure Storage Mover agent](/azure/storage-mover/agent-deploy) and [Storage Mover networking prerequisites](/azure/storage-mover/network-prerequisites)

## Plan your deployment

When selecting a region for your Storage Mover resource, remember that only control messages and metadata travel to that region. Migration performance depends on proximity between agent and target storage, not between agent and Storage Mover resource. A single Storage Mover resource is usually sufficient even when you deploy agents in different physical locations or countries. Deploy separate resources only when distinct administrative boundaries require separate permissions for different teams.

Bandwidth management is built into the service. You can define per-agent schedules that limit upload throughput during business hours and release the full bandwidth overnight or on weekends. This ensures that migration traffic doesn't interfere with production workloads sharing the same network link.

Learn more: [Plan a successful Azure Storage Mover deployment](/azure/storage-mover/deployment-planning) and [Manage network bandwidth of a Storage Mover agent](/azure/storage-mover/bandwidth-management)

## Run a migration

The workflow follows a straightforward sequence. First, you create a project in your Storage Mover resource. Next, you define source and target endpoints with the appropriate connection details. Then you create one or more job definitions that pair a source with a target and assign an agent. Finally, you start the job definition — either on demand or on a schedule.

Each job run reports progress through the Azure portal, and the service streams detailed copy logs to Event Hubs for auditing. If a run encounters transient errors (for example, a brief network interruption), the agent retries automatically. Subsequent runs are incremental: the agent transfers only new or changed items since the previous run. You can run as many passes as needed until the delta between source and target is small enough to proceed with your cutover.

Management is available through the Azure portal, Azure CLI (`az storage-mover`), and Azure PowerShell (`Az.StorageMover` module), so you can integrate migration orchestration into existing automation.

Learn more: [Create a job definition](/azure/storage-mover/job-definition-create) and [Cloud-to-cloud migration with Storage Mover](/azure/storage-mover/cloud-to-cloud-migration)

## When to choose Storage Mover

Storage Mover is the right tool when you need a managed, large-scale, one-time migration of files or objects into Azure and want built-in orchestration, progress tracking, and retry handling. It excels at NFS-to-Blob, SMB-to-Azure Files, and cross-cloud (AWS S3-to-Azure) scenarios. Use other tools when your scenario requires ongoing synchronization (Azure File Sync), server identity preservation (Storage Migration Service), offline data transfer of very large volumes (Azure Data Box), or lightweight ad-hoc copies in a scripted pipeline (AzCopy).

Learn more: [What is Azure Storage Mover?](/azure/storage-mover/service-overview)

## Limitations

While Azure Storage Mover covers a wide range of file and object migration scenarios, if you require additional capabilities beyond what the service provides today, an alternative tool or ISV solution may be the better fit.

**No automated access-tier placement during migration.** Storage Mover writes all migrated blobs into the target container's default access tier. It can't classify objects during transfer and route them to Hot, Cool, Cold, or Archive tiers based on age, size, or access patterns. If your migration plan calls for immediate cost optimization through tiering — for example, placing infrequently accessed historical data directly into the Cool or Cold tier while keeping recent files in Hot — you need a tool that supports per-object tier assignment during the copy. AzCopy supports explicit tier selection via the `--block-blob-tier` parameter, and several ISV solutions such as Data Dynamics, Atempo, and Komprise offer policy-driven tiering as part of their migration workflows.

**Metadata fidelity depends on the source-target combination.** When migrating from NFS to Azure Blob, Storage Mover preserves timestamps and permissions only as custom blob metadata fields — they don't map to native blob properties. Storage Mover doesn't preserve the last-access timestamp for SMB-to-Azure Files migrations. Storage Mover copies hard links from NFS sources as independent full files on the target, losing the link relationship. Storage Mover logs symbolic links that can't be resolved as failures and skips them. Storage Mover doesn't migrate custom metadata larger than 4 KiB per item. If full POSIX or NTFS fidelity is a hard requirement and the target doesn't natively support it, ISV tools like Komprise Elastic Data Migration may offer richer metadata mapping and transformation capabilities.

**Source protocol and platform constraints.** Storage Mover supports SMB 2.0 and later, and NFS v3/v4, but doesn't support SMB 1.x sources. On the cloud side, Storage Mover supports only AWS S3 as a non-Azure source. Migrations from Google Cloud Storage, other S3-compatible object stores, or SFTP servers require a different tool. For these scenarios, ISV solutions such as Rclone, MoveBot.io, or Azure Data Factory with custom connectors fill the gap.

**No in-flight transformation or filtering.** Storage Mover copies data as-is from source to target. It doesn't support file-type filtering, path exclusions, content transformation (such as encoding changes or format conversion), or deduplication during transfer. If your migration requires selective copying based on rules — for example, excluding temporary files or reorganizing the directory structure on the target — use AzCopy scripting or an ISV tool with built-in filter and transformation engines instead.

**Single-hypervisor agent deployment.** The Storage Mover agent runs exclusively on Hyper-V or VMware hosts. If your on-premises infrastructure uses KVM, Xen, or bare-metal servers without virtualization, you can't deploy the agent without introducing a supported hypervisor. In such environments, agent-less ISV tools or AzCopy running directly on the source server may be more practical.

**AWS S3 Glacier objects are excluded.** When migrating from AWS S3, Storage Mover can't migrate objects in Glacier or Glacier Deep Archive storage classes. You must restore these objects to a standard S3 tier before Storage Mover can transfer them, which adds time and cost to the migration plan.

When these limitations apply, the Azure Storage Migration Program can offset ISV license costs for qualifying net-new-to-Azure migrations. Consult the [Azure Storage migration tools comparison](/azure/storage/solution-integration/validated-partners/data-management/migration-tools-comparison) to evaluate which ISV offering best fits your scenario.
