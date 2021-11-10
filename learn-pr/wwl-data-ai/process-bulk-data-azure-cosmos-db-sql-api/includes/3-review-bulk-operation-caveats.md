There are some caveats to consider when developing for bulk operations that you are different than designing for typical Azure Cosmos DB SQL API applications.

## Throughput consumption

The provisioned throughput in request units per second (RU/s) is higher than if the operations were executed individually. This increase should be considered and measured based on the volume of operations you would like to push in bulk to your container\[s\].

## Document size

The SDK automatically creates batches for optimization with a maximum of 2 Mb (or 100 operations). Smaller items can take advantage of this optimization, with oversized items having an inverse effect.

## Operation quantity

When the SDK is attempting to fill a batch and doesn’t quite have enough items, it will wait 100 milliseconds for more items. This wait can effect overall latency.
