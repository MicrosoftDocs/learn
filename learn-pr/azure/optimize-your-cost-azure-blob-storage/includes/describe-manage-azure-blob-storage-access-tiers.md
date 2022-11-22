Now that you’ve reviewed several cost optimization options, you’re interested in exploring Azure Blob Storage access tiers in more depth. You recognize their potential in lowering the storage usage costs, but you also realize that their improper use might actually result in increased storage charges. In this unit, you’ll learn about some general rules governing access tier behaviors. You’ll also identify some of the caveats that should help you optimize their benefits.

### Describe Azure Blob Storage access tiers

Azure Blob Storage supports three access tiers:

- Hot tier. An online tier that’s optimized for storing data that’s accessed or modified frequently. This tier has the highest storage costs, but the lowest access costs.

- Cool tier. An online tier that’s optimized for storing data that’s infrequently accessed or modified. This tier has lower storage costs than the Hot tier, but its access costs are higher.

- Archive tier. An offline tier that’s optimized for storing data that’s accessed very infrequently or not at all. This tier has the lowest storage costs, but the highest access costs.

The term *infrequently* is not particularly objective. As a general guidance, you should consider using the Cool tier if you don't anticipate the need to delete or move the blob to a different tier for at least 30 consecutive days. Consider using the Archive tier if that period is at least 180 days. These values result from the pricing model, which imposes an early deletion charge. This charge applies if the blob is either deleted or moved from the Cool or Archive tier before the tier-specific period has passed. That period is 30 days for the Cool tier and 180 days for the Archive tier.

An early deletion charge is prorated according to the number of days remaining in the tier-specific period. For example, if a blob is assigned to the Cool tier and then deleted after 20 days, the early deletion charge represents the cost of storing the blob for 10 days (30 minus 20) in the Cool tier. Similarly, if a blob is assigned to the Archive tier and then moved to the Cool or Hot tier after 100 days, the early deletion charge represents the cost of storing the blob for 80 days (180 minus 100) in the Archive tier.

> [!NOTE]
> To avoid the early deletion charge for a blob, you can use the Copy Blob operation to copy the blob to another tier. However, keep in mind that this results in increased capacity charges associated with creating an extra blob that’s a duplicate of the original one.

### Describe the access tier management model for blobs

When choosing between Hot, Cool and Archive access tiers, there are additional factors to consider. It’s also helpful to understand the different access tiers’ management models.

In addition to pricing differences, blobs in both the Archive and Cool tiers have a slightly lower availability Service Level Agreement (SLA) when compared with Hot access tier. However, both tiers offer the same durability, throughput, and storage access latency characteristics, with retrieval time in the range of milliseconds. The Hot and Cool tiers also support all redundancy options.

The Hot, Cool, or Archive access tier can be assigned to a blob directly during its upload. Alternatively, Hot or Cool access tiers (but not Archive) can be inferred based on the access tier specified as the default tier on the storage account level. However, any explicit tier assignment takes precedence over the inferred one.

> [!NOTE]
> Carefully consider the implications of changing the default access tier on the storage account level, because this might have a significant pricing impact if there’s a large number of blobs without an explicitly assigned access tier.

> [!NOTE]
> If a blob's tier is inferred as Cool, there’s no early deletion charge for moving it to the Archive tier. However, a charge does apply if the blob is explicitly assigned to the Cool tier and then moved to the Archive tier before a period of 30 days.

While a blob is assigned to the Archive tier, its content cannot be directly read or modified, although you do have access to its metadata, including index tags. To access the blob's content, you can assign it to the Hot or Cool tier, which triggers the process referred to as *rehydration*. Alternatively, you can invoke the Copy Blob operation to create a copy of the blob in the Hot or Cool tier. 

> [!NOTE]
> There are two priorities for blob rehydration in the Archive tier: standard, and high. Standard priority rehydration could take up to 15 hours. However, high priority requests are prioritized over standard priority and for blobs less than 10 GB in size, could complete in less than one hour.

Storage accounts using the Archive tier must be configured with the LRS, GRS, or RA-GRS redundancy options. The Archive tier doesn’t support zone redundancy, precluding setting the redundancy to ZRS, GZRS, or RA-GZRS.

> [!NOTE]
> The Archive tier requires an explicit blob-level assignment, rather than relying on inference. An Azure Storage account cannot be configured with the default tier set to Archive.
