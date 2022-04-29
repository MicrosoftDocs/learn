How do you choose between serverless and provisioned throughput?

## Compare workloads

Provisioned throughput is ideal for workloads with predictable traffic patterns that require sustained and predictable performance with minimal variance.

On the other hand, serverless can handle workloads that have wildly varying traffic and low average-to-peak traffic ratios.

## Compare request units

Provisioned throughput makes some number of request units available each second to each container for database operations. The number of request units can be updated either manually or via autoscale.

Serverless doesn’t require any planning or automatic provisioning and can deliver throughput up to a documented service limit.

## Compare global distribution

Provisioned throughput supports distributing your data to an unlimited number of Azure regions.

Serverless accounts can only run in a single Azure region.

## Compare storage limits

Provisioned throughput allows you to store unlimited data in a container.

Serverless only allows up to 50 GB of data in a container.
