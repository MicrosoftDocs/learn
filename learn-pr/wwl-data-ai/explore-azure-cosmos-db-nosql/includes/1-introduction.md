::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=aff721c2-0a3e-4925-9689-f9ee7a2aa197]

::: zone-end

::: zone pivot="text"

Imagine you're on the development team at Contoso, an online retailer preparing to launch a new shopping experience. The current catalog application runs in a single region on a relational database, and it's showing its age. Every new product attribute means another schema change. Shoppers outside North America wait noticeably longer for pages to load. The infrastructure sized for the holiday rush sits mostly idle the rest of the year.

Before the team picks a database for the rebuild, they write down what the application actually needs:

- Reads and writes that stay fast for shoppers anywhere in the world, not just near the primary datacenter.
- A flexible schema, so adding attributes to a product doesn't require a migration.
- Throughput that scales up for a sale event and back down afterward, without paying peak prices year-round.
- Room to store vector embeddings alongside product data, because a recommendation assistant is planned for the next release.

Azure Cosmos DB for NoSQL answers all four. It's a fully managed NoSQL database that stores JSON documents, so each product can have its own shape. It copies those documents to any Azure region you choose. You pay for the throughput you provision or consume, and you can change that amount at any time. It also stores a vector embedding as a property on the same document as the product data.

Checking boxes on a requirements list isn't the same as making the right call, though. This module gives you what you need to make that judgment. You begin with the document data model and the resources that hold it: accounts, databases, containers, and items. From there, you get into the mechanics behind those four capabilities, namely request units, partitioning, and global distribution. You then weigh the service against a workload's needs, including AI use cases. Finally, you explore Data Explorer and create an account, database, container, and items of your own.

::: zone-end

> [!NOTE]
> We recognize that different people like to learn in different ways. You can choose to complete this module in video-based format or you can read the content as text and images. The text contains greater detail than the videos, so in some cases you might want to refer to it as supplemental material to the video presentation.
