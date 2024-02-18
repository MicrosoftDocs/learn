Business and personal storage utilization at your company continues to increase at an exponential rate. One of the more common ways to remediate capacity limitations of on-premises storage infrastructure is to use cloud-based capabilities. As an Azure administrator, you’re responsible for tracking Azure resource costs, and you need to identify suitable cloud-based capabilities. You also need to explore their pricing models and determine the optimal way of utilizing them. However, keep in mind that your decisions should take into consideration not just the cost, but other storage characteristics as well such as resiliency and performance.

In this unit, you’ll determine the pricing considerations associated with Azure Blob Storage. These considerations include the billing model and the methods of estimating cost based on a range of configuration options and anticipated usage patterns.

### Describe the Azure Blob Storage billing model

The Azure Blob Storage billing model is composed of several different components that reflect a variety of available options when you implement and use this service. The most straightforward is the per-gigabyte (GB) charge that’s associated with the storage capacity allocated to accommodate data at rest. However, even in this case, the actual cost depends on criteria such as the storage account type and replication scope and the blob access tier. Storage capacity is billed per average daily amount of data stored in GBs over a monthly period.

You can divide the core charges associated with active blob usage into the following categories:

- Storage operations, which are measured per transaction

- Data transfers, which are measured per GB

There are several other available Azure Blob Storage components that can further affect total storage costs:

- **Blob index tags (with per-tag pricing)**: These tags allow you to categorize data by using key-value attributes.

- **Change feed (with per logged change pricing)**: This option allows you to track changes to blobs and their metadata.

- **Encryption scopes (with per month pricing)**: Scopes allow you to use different encryption keys on a per-container or per-blob level.

- **Query acceleration (with per-gigabyte of data scanned and returned)**: This feature enables you to limit the amount of data retrieved from JSON or CSV-formatted blobs by applying filtering predicates and column projections.

- **Hierarchical namespace (with per-gigabyte and per-month pricing applicable to metadata usage)**: These enable you to create a multilevel folder hierarchy and use additional protocols such as Network File System v3 (NFSv3) and Secure FTP (SFTP).

Data traffic might also incur additional networking costs (per gigabyte). In particular, traffic from an Azure region (egress only) is subject to additional charges. For cross-region data transfers, the rate differs between intra-continental and inter-continental transfers.

As briefly mentioned earlier, Azure Blob Storage cost also depends on the storage account settings, such as the storage account type (which ties to performance) and replication scope:

- The storage account type must be selected at the time of provisioning, and with the exception of general-purpose v1 accounts, isn't mutable. Blobs are supported in standard (general-purpose) storage accounts (v1 and v2) and premium (block blob) storage accounts. In this situation, the terms *standard* and *premium* designate their respective performance characteristics. *Premium* storage delivers performance that's equivalent to solid-state drives (SSDs), whereas *standard* storage offers performance similar to traditional magnetic disks. The pricing for both storage types reflects this distinction. General purpose storage accounts are capable of hosting all types of content, including blobs (block, append, and page), tables, queues, and files. Block blob storage accounts can contain only block and append blobs.

- You must select the storage account's replication scope at the time of provisioning. Unlike the storage account type, though, you can change it later (with some exceptions). Replication scope determines the account content's resiliency and availability. It supports the following options, which are listed in the order of increasing prices:

  - Locally redundant storage (LRS) synchronously replicates the content of a storage account across three replicas within the same physical location. This is the lowest-priced replication option, but isn’t recommended for workloads that require high availability or durability.
  - Zone-redundant storage (ZRS) provides increased resiliency by replicating the content of a storage account across physical locations (availability zones) in the same Azure region.
  - Geo-redundant storage (GRS) allows you to implement region-level resiliency by enabling asynchronous replication of a storage account's content across two regions. The secondary region automatically includes three additional copies of the storage account, replicated synchronously within that region.
  - Geo-zone-redundant storage (GZRS) further increases resiliency and cost by combining ZRS (in the primary region), GRS (for cross-region replication), and LRS (for replication within the secondary region).
  - Read-access geo-redundant storage (RA-GRS) provides read-only access to the GRS replicas in the secondary region.
  - Read-access geo-zone-redundant storage (RA-GZRS) provides read-only access to the GZRS replicas in the secondary region.

> [!NOTE]
> Premium block blob storage accounts only support LRS and ZRS replication options.

Another important factor that affects storage cost is the access tier, which is either inherited or explicitly assigned to individual blobs. Your choices include hot, cool, cold, and archive tiers. Access tiers allow you to choose the pricing model that reflects your current and expected storage usage patterns. The hot tier minimizes the retrieval time and the cost of storage operations, whereas the archive tier minimizes per-gigabyte storage cost but imposes a wait time during data retrieval. The cool tier provides the same retrieval time as the hot tier and offers mid-range per-gigabyte pricing in exchange for higher access charges. The cold tier has lower storage costs and higher access costs than the cool tier.

> [!NOTE]
> Moving blobs between tiers incurs an extra cost.

Lastly, keep in mind that pricing varies between Azure regions. This might be relevant if you have the flexibility to select the region where your data will be hosted.

At the end of each billing cycle, charges for each category along with their summaries are captured in the invoice that’s available on the Azure portal.

### Estimate Azure Blob Storage costs

Understanding your access patterns and correlating them with your durability and availability needs will help you to best manage your Azure Blob Storage costs. The primary tool for estimating these costs is the Azure pricing calculator. However, you might also want to consider using the Microsoft Excel­–based template the Azure Storage team provides. This template offers some initial guidance by providing a predefined set of worksheets that automatically calculate migration, monthly estimates, and future pricing estimates based on the workload-driven input that you specify. That input includes:

- Target region

- Desired durability (the replication scope)

- Access tier (Premium, hot, cool, or archive)

- The current amount of storage

- Average file size

- Expected growth per month (in gigabytes)

- Volume of read operations (in gigabytes)

- Amount of data deleted monthly (in gigabytes)

You can modify the template to match your specific needs. You can use the resulting values generated by the template as an input to the Azure pricing calculator.

> [!NOTE]
> We've included a link to the Excel template in this module's Summary section.

#### Azure pricing calculator

To calculate the estimated storage cost, on the [**Azure pricing calculator**](https://azure.microsoft.com/pricing/calculator/) page, select the **Storage Accounts** tile. Within the same page, scroll down to the **Storage Accounts** section and specify the options that reflect your anticipated usage needs.

> [!NOTE]
> Before you calculate an estimate, consider signing in on the **Azure pricing calculator** page using the same account you use to manage your Azure environment. This allows you to save the resulting quote for future reference.

As you progress through your estimate, keep in mind the following information:

- Data storage, metadata, and encryption scopes are billed per month. If you anticipate that their usage will be shorter, prorate the charges by calculating their daily cost.

- To identify unit pricing, refer to the Azure Block Storage pricing page. If you enable hierarchical namespaces on the account, make sure that the **File Structure** drop-down list is set to **Hierarchical Namespace (NFS v3.0, SFTP Protocol)**. If you enable hierarchical namespaces on the account and intend use the Data Lake Storage endpoint, refer to the Azure Data Lake Storage Gen2 pricing page. Transaction prices differ between these two pages, but the storage cost is nearly identical.

- Use the redundancy, region, and currency filters to determine the extent to which they affect the final cost.
