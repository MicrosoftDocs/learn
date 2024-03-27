Now that you’ve reviewed several cost-optimization options, you’re interested in exploring Azure Blob Storage access tiers in more depth. You recognize their potential in lowering the storage usage costs, but you also realize that their improper use might actually result in increased storage charges. In this unit, you’ll learn about some general rules governing access-tier behaviors. You’ll also identify some of the caveats that should help you optimize their benefits.

### Describe Azure Blob Storage access tiers

Azure Blob Storage supports four access tiers:

- **Hot tier**: An online tier that's optimized for storing data that's accessed or modified frequently. This tier has the highest storage costs, but the lowest access costs.

- **Cool tier**: An online tier that's optimized for storing data that's infrequently accessed or modified. This tier has lower storage costs than the hot tier, but its access costs are higher.

- **Cold tier**: An online tier that's optimized for storing data that's infrequently accessed or modified. This tier has lower storage costs than the cool tier, but its access costs are higher.

- **Archive tier**: An offline tier that’s optimized for storing data that’s accessed very infrequently or not at all. This tier has the lowest storage costs, but the highest access costs.

The term *infrequently* isn't particularly objective. As a general guidance, you should consider using the cool tier if you don't anticipate needing to delete or move the blob to a different tier for at least 30 consecutive days. You can consider the cold tier if you don't anticipate needing to delete or move the blob for at least 90 consecutive days. Consider using the archive tier if that period is at least 180 days. These values result from the pricing model, which imposes an early deletion charge. This charge applies if the blob is either deleted or moved from the cool or archive tier before the tier-specific period has passed. That period is 30 days for the cool tier, 90 days for the cold tier, and 180 days for the archive tier.

An early deletion charge is prorated according to the number of days remaining in the tier-specific period. For example, if a blob is assigned to the cool tier and then deleted after 20 days, the early deletion charge represents the cost of storing the blob for 10 days (30 minus 20) in the cool tier. Similarly, if a blob is assigned to the archive tier and then moved to the cool or hot tier after 100 days, the early deletion charge represents the cost of storing the blob for 80 days (180 minus 100) in the archive tier.

> [!NOTE]
> To avoid the early deletion charge for a blob, you can use the Copy Blob operation to copy the blob to another tier. However, keep in mind that this results in increased capacity charges associated with creating an extra blob that’s a duplicate of the original one.

### Describe the access tier management model for blobs

When you're choosing between hot, cool, cold, and archive access tiers, there are additional factors to consider. It’s also helpful to understand the different access tiers' management models.

In addition to pricing differences, blobs in the archive, cold, and cool tiers have a slightly lower availability Service Level Agreement (SLA) when compared with hot access tier. However, all three tiers offer the same durability, throughput, and storage access latency characteristics, with retrieval time in the range of milliseconds. The hot and cool tiers also support all redundancy options.

The hot, cool, cold, or archive access tier can be assigned to a blob directly during its upload. Alternatively, hot or cool access tiers (but not archive or cold) can be inferred based on the access tier specified as the default tier on the storage account level. However, any explicit tier assignment takes precedence over the inferred one.

> [!NOTE]
> Carefully consider the implications of changing the default access tier on the storage account level, because this might have a significant pricing impact if there’s a large number of blobs without an explicitly assigned access tier.

> [!NOTE]
> If a blob's tier is inferred as cool, there’s no early deletion charge for moving it to the archive tier. However, a charge does apply if the blob is explicitly assigned to the cool tier and then moved to the archive tier before a period of 30 days.

While a blob is assigned to the archive tier, you can't directly read or modify its content, although you do have access to its metadata, including index tags. To access the blob's content, you can assign it to the hot, cool, or cold tier, which triggers the process referred to as *rehydration*. Alternatively, you can invoke the Copy Blob operation to create a copy of the blob in the hot, cool, or cold tier.

> [!NOTE]
> There are two priorities for blob rehydration in the archive tier: standard, and high. Standard-priority rehydration could take up to 15 hours. However, high-priority requests are prioritized over standard priority and for blobs less than 10 GB in size, could complete in less than one hour. High-priority rehydration is more expensive, so Microsoft recommends reserving high-priority rehydration for use in emergency data-restoration situations.

Storage accounts using the archive tier must be configured with the LRS, GRS, or RA-GRS redundancy options. The archive tier doesn’t support zone redundancy, precluding setting the redundancy to ZRS, GZRS, or RA-GZRS.

> [!NOTE]
> The archive tier requires an explicit blob-level assignment, rather than relying on inference. An Azure Storage account cannot be configured with the default tier set to archive.
