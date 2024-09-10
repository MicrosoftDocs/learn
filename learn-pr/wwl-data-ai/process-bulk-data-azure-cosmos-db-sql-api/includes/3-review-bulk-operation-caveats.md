There are some caveats to consider when developing for bulk operations that are different than designing for typical Azure Cosmos DB for NoSQL applications.

## Throughput consumption

The provisioned throughput in request units per second (RU/s) is higher than if the operations were executed individually. This increase should be considered as you evaluate total throughput requirements when measured against other operations that will happen concurrently.

## Latency impact

When the SDK is attempting to fill a batch and doesn’t quite have enough items, it will wait 100 milliseconds for more items. This wait can affect overall latency.

## Document size

The SDK automatically creates batches for optimization with a maximum of 2 Mb (or 100 operations). Smaller items can take advantage of this optimization, with oversized items having an inverse effect.
