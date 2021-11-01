:::image type="content" source="../media/blob-object-replication-21fd3c07.png" alt-text="Asynchronous replication of blob containers between regions.":::


Object replication asynchronously copies block blobs in a container according to rules that you configure. The contents of the blob, any versions associated with the blob, and the blob's metadata and properties are all copied from the source container to the destination container.

## Scenarios

 -  **Minimizing latency**. Object replication can reduce latency for read requests by enabling clients to consume data from a region that is in closer physical proximity.
 -  **Increase efficiency for compute workloads**. With object replication, compute workloads can process the same sets of block blobs in different regions.
 -  **Optimizing data distribution**. You can process or analyze data in a single location and then replicate just the results to other regions.
 -  **Optimizing costs**. After your data has been replicated, you can reduce costs by moving it to the archive tier using life-cycle management policies.

## Considerations

 -  Object replication requires that blob versioning is enabled on both the source and destination accounts.
 -  Object replication doesn't support blob snapshots. Any snapshots on a blob in the source account are not replicated to the destination account.
 -  Object replication is supported when the source and destination accounts are in the hot or cool tier. The source and destination accounts may be in different tiers.
 -  When you configure object replication, you create a replication policy that specifies the source storage account and the destination account. A replication policy includes one or more rules that specify a source container and a destination container and indicate which block blobs in the source container will be replicated.
