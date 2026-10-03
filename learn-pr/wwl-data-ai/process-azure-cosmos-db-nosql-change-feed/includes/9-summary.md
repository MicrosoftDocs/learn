You can now treat an Azure Cosmos DB container as an event source and move its data when the container's own design has to change. Contoso's denormalized category names stay in sync automatically, and the catalog can move onto a new partition key without rebuilding the pipeline that feeds it.

## What you learned

- The change feed’s contents depend on its mode. Latest-version mode records creates and updates, while all-versions-and-deletes mode also records intermediate versions, deletes, and time-to-live expirations. Both modes guarantee ordering within a partition-key value, but not across different partition-key values. The change feed processor manages position and distributes work automatically in .NET and Java. The pull model is available in .NET, Java, Python, and Node.js, but applications using it must manage polling, continuation tokens, and work distribution.
- A change feed processor needs a monitored container, a lease container, a compute instance, and a delegate. It provides at-least-once delivery, so a change that always fails can block its lease until your handler routes it aside. Pull-model consumers manage their own checkpoints and retries.
- Latest-version mode returns the latest available version of created and updated items. It can read from the container’s lifetime while those items still exist, but deleted items are removed from the feed. All-versions-and-deletes mode captures every version and deletion only within the continuous-backup retention window. It requires Azure Cosmos DB for NoSQL, continuous backup, and account-level enablement.
- The Azure Functions trigger runs the processor on the platform’s side. A function whose managed identity has only data-plane permissions must have its lease container created in advance with /id as the partition key. The trigger can create the lease container automatically only when CreateLeaseContainerIfNotExists is enabled and the connection is authorized to create containers.
- A container copy job moves data to a new container. The new container can use a different partition key, unique key policy, or throughput model. An offline copy requires you to stop writes. An online copy allows writes during the copy and requires a write pause for cutover. Enabling online copy adds a 50 to 100 percent request unit surcharge to replace and delete operations on the source account; creates aren't affected.

## Learn more

- [Change feed in Azure Cosmos DB](/azure/cosmos-db/change-feed)
- [Change feed modes](/azure/cosmos-db/change-feed-modes)
- [Change feed processor](/azure/cosmos-db/change-feed-processor)
- [Change feed pull model](/azure/cosmos-db/change-feed-pull-model)
- [Azure Cosmos DB trigger for Azure Functions](/azure/azure-functions/functions-bindings-cosmosdb-v2-trigger)
- [Container copy jobs](/azure/cosmos-db/container-copy)
