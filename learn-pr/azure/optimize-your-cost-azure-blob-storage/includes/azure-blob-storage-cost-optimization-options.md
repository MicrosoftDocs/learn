A general understanding of the Azure Blob Storage pricing model should help you identify the opportunities for cost optimization. Some of the decisions you need to make might be more appropriate at the design stage, such as selecting the target Azure region or the storage account replication scope. Other decisions will be driven by usage patterns that change with time. However, it’s important to note that cost optimization is an ongoing activity that should be closely followed and continuously evaluated. In this unit, you'll find out about different cost optimization options. You’ll also determine which of these options might help you address storage-related charges in your environment.

### Describe the Azure Blob Storage cost optimization options

The primary cost optimization options you’ll consider in this unit include:

- Organizing data into access tiers

- Writing directly to cool and archive tiers

- Automatically moving data between access tiers

- Reserving storage capacity

#### Organize data into access tiers

The purpose of access tiers is to allow companies to choose the pricing model and data retrieval speed that reflect their blob usage patterns. Your choice of the access tier should be based on the frequency with which individual blobs within the storage account will be accessed. For example, to optimize your storage usage and minimize its cost, frequently used blobs should reside in a blob storage account that’s configured with the hot access tier. Conversely, blobs that you intend to use only occasionally should reside in a blob storage account that’s configured with cool access tier. Finally, blobs that are retained for archival purposes, without any near-term plans for accessing their content, should be assigned to the archive tier.

This recommendation is based on the access tier-specific pricing model that determines two types of charges:

- The charges associated with the maintaining data at rest (per gigabyte)

- The charges associated with accessing data to perform read, update, and delete operations.

Assigning the hot access tier to a blob will minimize the second of these charges but increase the first one, whereas selecting the archive access tier will have the opposite effect. Therefore, if you plan to access data frequently, the hot tier represents the most cost-efficient choice. If you plan to access data less frequently, the Cold tier or archive tier makes more sense to reduce the cost of storing data.

For example, your database administration team should consider using archive storage for long-term backups of on-premises data stores. As a result of regulatory requirements, these backups need to be preserved for several years, even though there is rarely a need to restore them. Conversely, the hot tier would be more suitable for log files used to troubleshoot customer issues and for short-term analytics and reporting.

#### Write directly to cool and archive tiers

If you have a clear indication that a new blob won’t be accessed in the near term, you should consider assigning it directly to the cool or archive tier. This will eliminate charges associated with moving it across tiers.

:::image type="content" source="../media/3-upload-blob-archive-tier.png" alt-text="Screenshot of the Azure portal pane has the option of assigning a newly uploaded blob to the archive tier." border="false" lightbox="../media/3-upload-blob-archive-tier.png":::

#### Automatically move data between access tiers

The access tier you assign at the beginning might not reflect longer term storage trends. A log used for troubleshooting a current issue will likely not have the same significance a few weeks later. Similarly, while it might be important to swiftly restore a recent backup, that degree of urgency will probably not apply a few months from now for the same backup copy. While you could modify the access tier manually, such an approach would introduce a significant maintenance overhead, especially when modifying a large number of blobs, which is common in enterprise scenarios.

Fortunately, this isn’t necessary. Azure Blob Storage supports lifecycle management policies that move data between tiers based on the criteria you define. For example, you can define a policy rule that transitions blobs to the archive tier if they haven’t been modified in the last 90 days. Similarly, you can create a policy rule to delete blobs in the archive tier if they haven't been accessed in the last 360 days.

> [!NOTE]
> The policies can be based on the last modified date or the last accessed date. The latter requires enabling last access time tracking.

#### Reserve storage capacity

If you expect to use Azure Blob Storage for an extended amount of time, you can further reduce your costs by purchasing a reserved capacity in 100 terabyte (TB) and 1 petabyte (PB) units per month for the period of either one year or three years. This arrangement offers a discounted price for storage (per gigabyte) charges of data residing in Azure Blob Storage. A reservation can be purchased for any access tier and type of redundancy but is applicable to a specific combination of the Azure region, access tier, and redundancy option.
