Woodgrove Bank's contactless payment application needs to be available all the time, as its users can use it throughout the world, wherever that payment method is accepted. When data needs to be available all the time, standby replicas can be kept on hand in case a live node fails. Azure Cosmos DB for PostgreSQL supports high availability to prevent database downtime.

## Implicit availability

Azure Cosmos DB for PostgreSQL has its own locally redundant storage (LRS) with three synchronous replicas maintained by Azure Storage. If there's a replica failure, Azure Storage recreates the replica. This functionality is a feature of Azure Cosmos DB for PostgreSQL.

## Considerations

Standby replicas are created for each node in the cluster when enabling high availability in the Azure Cosmos DB for PostgreSQL account. The replicas double the number of servers in the group, which also doubles the cost of the service.

It takes a few minutes to fail over. However, when high availability is enabled, Azure Cosmos DB for PostgreSQL automatically initiates the failover and manages it. There's no need to manually manage failovers.

Standby replicas are provisioned for a different availability zone than the primary cluster. The portal displays the availability zone for the cluster in addition to the High Availability status.

To take advantage of the high availability set up on the coordinator node, an application needs to have logic to detect and retry dropped connections and failed transactions. If a coordinator node fails, the standby is promoted to the coordinator node. The switch in coordinator nodes doesn't require a change in connection strings.

As a database administrator, you sometimes have to talk with the developers on problems that can occur with working with a cluster from an application. From an application development perspective, the Woodgrove Bank application would need retry logic to ensure that calls to the database are retried on failure. When a node is in the process of failing over, there may be a little downtime promoting the new node. The Woodgrove Bank app has a chance of encountering this downtime, and it needs to gracefully handle the disconnect with retry logic for a positive user experience. [Learn more about writing retry logic for your app stack.](/azure/postgresql/hyperscale/quickstart-app-stacks-overview)

## High availability recovery stages

There are three stages to recovering in a high availability setup in Azure Cosmos DB for PostgreSQL.

1. **Detection** - Periodic health checks are run on every node, and after the fourth failed check, the node is declared down.
1. **Failover** - Once a node is declared down, Azure Cosmos DB for PostgreSQL promotes the standby to primary status. Once the standby is promoted to primary, a new standby is created.
1. **Full recovery** - Once all data has been replicated between the newly promoted node and the new standby, the node has reached full recovery.

## High availability states

The High Availability state appears in the Overview for each of the nodes in the cluster. The state you observe is one of the following values:

* **No**: High Availability isn't enabled.
* **Healthy**: The node is fully replicated to its standby.
* **Failover in progress**: A failure was detected.
* **Creating standby**: Once a standby is promoted to primary, then a new standby is created.
* **Replication in progress**: The new standby is synchronizing with the primary.
