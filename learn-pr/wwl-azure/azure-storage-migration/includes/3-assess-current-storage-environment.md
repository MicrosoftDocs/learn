Before selecting target services or migration tools, perform a thorough assessment of your current storage estate. A well-executed assessment prevents costly mid-migration course corrections and ensures you choose the right target architecture from the start.

## Inventory your data estate

Create a comprehensive inventory of all storage systems, volumes, and shares. For each, capture:

- Total capacity used and allocated
- Number of files or objects, and directory depth
- File type distribution (documents, media, logs, databases, and so on)
- Largest files and directories
- Growth rate (monthly or yearly trends)

## Analyze access patterns

Understanding how data is accessed is critical for selecting the right target service and tier:

- Access frequency: What percentage of data is actively accessed (hot) vs. rarely touched (cold)?
- Access protocols: SMB, NFS (v3 vs v4.1), REST API, SFTP, iSCSI
- Read/write ratio and I/O patterns (sequential vs. random)
- Latency sensitivity per workload
- Concurrent user/application count

Your storage vendor might offer tools to determine these statistics. Partners like Wool Data (wooldata.com) specialize in storage-level assessments providing data on file type distribution, consumption, locality, latency, and I/O performance. Partners like Komprise, Data Dynamics, and Atempo operate at file level and can provide statistics on access frequency. Cirrus Data operates at SAN level and OS level and can provide more insights.

## Use Azure Migrate for file share assessment

Azure Migrate provides a native assessment capability for on-premises file shares hosted on Windows and Linux servers. It evaluates readiness, sizing, and cost for migrating to Azure Files or Azure VMs.

To create a file share assessment:

1. Discover on-premises servers and their file shares using the Azure Migrate appliance.
1. In the Azure Migrate portal, select discovered file shares and create an assessment.
1. Choose between an as-is on-premises assessment or a performance-based assessment that uses collected utilization data.

The assessment produces:

- **Readiness status** for each file share (Ready, Ready with conditions, or Not ready)
- **Target recommendations** — Azure Files SKU or Azure VM sizing
- **Monthly cost estimates** for the recommended target
- **Migration issues and warnings** that must be resolved before migration (for example, shares exceeding the maximum Azure Files size)

Azure Migrate recommends the most cost-effective path. When a file share qualifies for Azure Files, it recommends the PaaS target. If readiness checks fail (such as size or volume estimation issues), it falls back to an Azure VM recommendation for that share and its colocated shares.

Azure Migrate evaluates migration readiness and target cost but does not collect deep I/O performance metrics. For workloads where latency, throughput patterns, or storage locality drive tier selection, complement Azure Migrate with the vendor-level or partner assessments described above.

For more information, see [Create an Azure Files assessment](/azure/migrate/create-file-share-assessment) and [Review an Azure Files assessment](/azure/migrate/review-file-share-assessment).

## Map workloads to requirements

For each identified workload or data bucket, document:

- Required protocols and access method
- Performance requirements (IOPS, throughput, latency)
- Availability and recovery objectives (RTO and RPO)
- Compliance and regulatory requirements (retention, immutability, and data residency)
- Whether the application can be modified to use cloud-native APIs
- Future workloads such as AI training or inference that will consume this data

Treat buckets of data with the same requirements individually. Different workloads on the same source storage system may warrant different target services in Azure.

## Estimate migration scope

Based on the inventory, estimate the migration scope to inform planning:

- Total data volume to migrate per target service
- Daily change rate (to estimate delta sync requirements)
- Number of distinct migration jobs/waves needed
- Dependencies between data sets and application cutovers

For more information about planning your assessment, see the [Azure Storage migration guide](/azure/storage/common/storage-migration-overview).