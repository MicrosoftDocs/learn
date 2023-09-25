

Data sets have unique lifecycles. Early in the lifecycle, people access some data often. But the need for access drops drastically as the data ages. Some data stays idle in the cloud and is rarely accessed once stored. Some data expires days or months after creation, while other data sets are actively read and modified throughout their lifetimes.

## Access tiers

Azure storage offers different access tiers, allowing you to store blob object data in the most cost-effective manner. Available access tiers include:

* **Hot** - Optimized for storing data that is accessed frequently.
* **Cool** - Optimized for storing data that is infrequently accessed and stored for at least 30 days.
* **Archive** - Optimized for storing data that is rarely accessed and stored for at least 180 days with flexible latency requirements, on the order of hours.

The following considerations apply to the different access tiers:

* The access tier can be set on a blob during or after upload.
* Only the hot and cool access tiers can be set at the account level. The archive access tier can only be set at the blob level.
* Data in the cool access tier has slightly lower availability, but still has high durability, retrieval latency, and throughput characteristics similar to hot data. 
* Data in the archive access tier is stored offline. The archive tier offers the lowest storage costs but also the highest access costs and latency.
* The hot and cool tiers support all redundancy options. The archive tier supports only LRS, GRS, and RA-GRS.
* Data storage limits are set at the account level and not per access tier. You can choose to use all of your limit in one tier or across all three tiers.

## Manage the data lifecycle

Azure Blob storage lifecycle management offers a rich, rule-based policy for General Purpose v2 and Blob storage accounts. Use the policy to transition your data to the appropriate access tiers or expire at the end of the data's lifecycle. The lifecycle management policy lets you:

* Transition blobs to a cooler storage tier (hot to cool, hot to archive, or cool to archive) to optimize for performance and cost
* Delete blobs at the end of their lifecycles
* Define rules to be run once per day at the storage account level
* Apply rules to containers or a subset of blobs (using prefixes as filters)

Consider a scenario where data gets frequent access during the early stages of the lifecycle, but only occasionally after two weeks. Beyond the first month, the data set is rarely accessed. In this scenario, hot storage is best during the early stages. Cool storage is most appropriate for occasional access. Archive storage is the best tier option after the data ages over a month. By adjusting storage tiers in respect to the age of data, you can design the least expensive storage options for your needs. To achieve this transition, lifecycle management policy rules are available to move aging data to cooler tiers.

> [!NOTE]
> Data stored in a premium block blob storage account cannot be tiered to Hot, Cool, or Archive using Set Blob Tier or using Azure Blob Storage lifecycle management. To move data, you must synchronously copy blobs from the block blob storage account to the Hot tier in a different account using the Put Block From URL API or a version of AzCopy that supports this API. The Put Block From URL API synchronously copies data on the server, meaning the call completes only once all the data is moved from the original server location to the destination location.
