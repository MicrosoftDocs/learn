

Azure Cosmos DB approaches data consistency as a spectrum of choices instead of two extremes. Strong consistency and eventual consistency are at the ends of the spectrum, but there are many consistency choices along the spectrum. Developers can use these options to make precise choices and granular tradeoffs with respect to high availability and performance.

Azure Cosmos DB offers five well-defined levels. From strongest to weakest, the levels are:

* Strong
* Bounded staleness
* Session
* Consistent prefix
* Eventual

Each level provides availability and performance tradeoffs. The following image shows the different consistency levels as a spectrum.

:::image type="content" source="../media/five-consistency-levels.png" alt-text="Image showing data consistency as a spectrum.":::

The consistency levels are region-agnostic and are guaranteed for all operations regardless of the region from which the reads and writes are served, the number of regions associated with your Azure Cosmos DB account, or whether your account is configured with a single or multiple write regions.

Read consistency applies to a single read operation scoped within a partition-key range or a logical partition. The read operation can be issued by a remote client or a stored procedure.

