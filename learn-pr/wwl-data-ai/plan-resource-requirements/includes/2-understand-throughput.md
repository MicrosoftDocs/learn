In our basic hierarchy of resources, an Azure Cosmos DB for NoSQL database is a unit of management for a set of schema-agnostic containers. Each container is a unit of scalability for both **throughput** and **storage**.

Containers are partitioned horizontally across compute within an Azure region. Container are distributed across all partitions within a container and all Azure Regions you configure in your Azure Cosmos DB for NoSQL account.

Even with the throughput distributed across the partitions for a container and regions in an account, with Dynamic Autoscale, only those partitions and regions in which requests are occurring will be scaled up. Dynamic Autoscale ensures that costs reflect only the throughput consumed by an application.

## Container-level throughput provisioning

![Throughput provisioned at container level](../media/2-container.png)

Any throughput provisioned exclusively at the container level is reserved only for this container. This throughput is available only for this container all the time. This throughput is also financially backed by SLAs (Service Level Agreements).

Users creating new accounts should look to start with Serverless as it only bills when requests are made. Serverless makes it cost efficient when developing new applications. It also is suitable for production-grade applications with infrequent requests or otherwise low usage requirements.

> [!NOTE]
> Users can also provision throughput for a database that is shared across all containers. However, this should only be used when all of the containers have roughly the same volume of requests and data as it is not possible to guarantee performance when these vary widely across containers.
