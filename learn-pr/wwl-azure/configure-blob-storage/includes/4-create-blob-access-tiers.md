Azure Storage provides different options for accessing block blob data (as shown in the screenshot), based on usage patterns. Each access tier in Azure Storage is optimized for a particular pattern of data usage. By selecting the correct access tier for your needs, you can store your block blob data in the most cost-effective manner.

:::image type="content" source="../media/blob-performance-tiers-16ec0068.png" alt-text="Screenshot of creating a storage account with choices for blob performance.":::


 -  **Hot**. The Hot tier is optimized for frequent access of objects in the storage account. New storage accounts are created in the Hot tier by default.
 -  **Cool**. The Cool tier is optimized for storing large amounts of data that is infrequently accessed and stored for at least 30 days. Storing data in the Cool tier is more cost-effective, but accessing that data may be more expensive than accessing data in the Hot tier.
 -  **Archive**. The Archive tier is optimized for data that can tolerate several hours of retrieval latency and will remain in the Archive tier for at least 180 days. The Archive tier is the most cost-effective option for storing data, but accessing that data is more expensive than accessing data in the Hot or Cool tiers.

> [!NOTE]
> When data usage changes, you can switch access tiers at any time.
