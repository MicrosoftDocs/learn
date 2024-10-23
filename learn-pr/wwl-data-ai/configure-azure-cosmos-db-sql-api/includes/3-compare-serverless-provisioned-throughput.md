How do you choose between serverless and provisioned throughput?

## Compare workloads

Provisioned throughput is ideal for workloads with predictable traffic patterns that require sustained and predictable performance with minimal variance.

On the other hand, serverless can handle workloads that have wildly varying traffic and low average-to-peak traffic ratios.

## Compare request units

Provisioned throughput makes some number of request units available each second to each container. The number of request units can be updated either manually or via autoscale.

Serverless doesn’t require any planning or automatic provisioning and can deliver throughput up to a documented service limit.

## Compare global distribution

Provisioned throughput supports distributing your data to an unlimited number of Azure regions.

Serverless accounts can only run in a single Azure region but can be used with Availability Zones in a single region.

## Compare storage limits

Provisioned throughput allows you to store unlimited data in a container.

Serverless allows up to 1 TB of data in a container.

## Migrating between serverless and provisioned throughput

Serverless accounts are capable of being migrated to autoscale throughput if the container needs more resources than serverless can provide. Accounts can also be migrated from autoscale to serverless if needed.
