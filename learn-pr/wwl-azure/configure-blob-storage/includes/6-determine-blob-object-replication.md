[Object replication](/azure/storage/blobs/object-replication-overview) copies blobs in a container asynchronously according to policy rules that you configure. 

> [!VIDEO https://learn-video.azurefd.net/vod/player?id=b7e01208-33ae-4488-83a1-6a29ca6624d4]

Replication includes the blob content, metadata properties, and versions. The following illustration shows an example of asynchronous replication of blob containers between regions.

:::image type="content" source="../media/blob-object-replication-21fd3c07.png" alt-text="Diagram that shows asynchronous replication of blob containers between regions." border="false":::

### Things to know about blob object replication

There are several considerations to keep in mind when planning your configuration for blob object replication.

- Object replication requires that blob versioning is enabled on both the source and destination accounts. When blob versioning is enabled, you can access earlier versions of a blob. This access lets you recover your modified or deleted data.

- Object replication doesn't support blob snapshots. Any snapshots on a blob in the source account aren't replicated to the destination account.

- Object replication is supported when the source and destination accounts are in the Hot, Cool, or Cold tier. The source and destination accounts can be in different tiers.

- When you configure object replication, you create a replication policy that specifies the source Azure storage account and the destination storage account.

- A replication policy includes one or more rules that specify a source container and a destination container. The policy identifies the blobs in the source container to replicate.

### Things to consider when configuring blob object replication

There are many benefits to using blob object replication. Consider the following scenarios and think about how replication can be a part of your Blob Storage strategy.

- **Consider latency reductions**. Minimize latency with blob object replication. You can reduce latency for read requests by enabling clients to consume data from a region that's in closer physical proximity.

- **Consider efficiency for compute workloads**. Improve efficiency for compute workloads by using blob object replication. With object replication, compute workloads can process the same sets of blobs in different regions.

- **Consider data distribution**. Optimize your configuration for data distribution. You can process or analyze data in a single location and then replicate only the results to other regions.

- **Consider costs benefits**. Manage your configuration and optimize your storage policies. After your data is replicated, you can reduce costs by moving the data to the Archive tier by using lifecycle management policies.

### Consider versioning when using object replication

You can enable [Blob versioning](/azure/storage/blobs/versioning-overview) to automatically maintain previous versions of an object. When blob versioning is enabled, you can access earlier versions of a blob. This access lets you recover your modified or deleted data.

