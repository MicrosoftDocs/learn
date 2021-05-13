The Azure infrastructure is built to provide scalability and availability for all services. It also makes it easy to build a global system that responds well to users regardless of their location.

In your video camera manufacturing company, you're considering a migration to the cloud in order to provide a reliable service to users of your video sharing web app around the world. You've been asked to prepare a report that assesses whether Azure is a good cloud environment to choose for the backend database, which uses Cassandra on-premises.

Here, you'll learn about the advantages of Azure for hosting NoSQL database systems.

## Scalability

By migrating your database to Azure, you benefit from limitless storage and elastic scalability for performance. To specify performance, you specify the Request Units (RUs) for throughput at either the container or database level.

## Specifying container throughput

The most common option is to specify throughput at the container level. This guarantees throughput uniformly across all logical partitions in the container and the throughput is exclusive to that container. Because the throughput is uniform across logical partitions, if one partition exceeds the throughput it will be rate limited even if other partitions have available throughput. Because of this, it is important to configure your partitioning key to avoid hot partitions.

### Specifying database throughput

By specifying throughput at the database level, the throughput is shared between the containers. This can be useful if containers regularly increase or decrease throughput, but the total throughput for the database remains relatively static. Throughput within each container is still uniform across logical partitions and if one partition exceeds the throughput it will be rate limited even if other partitions have available throughput.

You can change throughput at any time and the maximum throughput for either a container or database is unlimited.

For more information on migration benefits, select Rationale at [Move Cassandra data to Azure Cosmos DB](https://aka.ms/AA58ejl)

## Multi-region

Azure Cosmos DB can be globally distributed across all regions. You can locate your database close to your users or, if you have a global distribution of users, you can add and remove regions at any time. By placing data close to users, you decrease latency and improve the user experience.

If your database is in a single region there is a Service Level Agreement (SLA) for the database to be available for 99.99% of the time, but, if you deploy to multiple regions, you benefit from an SLA of 99.999% read and write availability. Even if there is a regional outage Azure Cosmos DB will automatically failover to another region while maintaining the SLAs.

Replication between regions is handled automatically while maintaining the consistency level that you have defined.

Throughput is configured at the database or container level, not at a regional level. Therefore, you will have identical throughput in all regions that you deploy to automatically.

## Server management

Azure Cosmos DB is a managed service, requiring minimal management of setup and continuing operations.

### Global distribution
To replicate data to another region is a turn-key event. All you must do is specify the region and the data is replicated there with all of the data, the throughput settings, and replication automatically configured.

### Schema and index management
Cosmos DB is schema-agnostic and automatically indexes all data. This removes any need to maintain the database schema and indexes with the schema of your application. This removes a considerable workload, especially when your database is globally distributed.

### Operations management
The Azure Cosmos DB Cassandra API removes the need to manage operating system settings, JVM settings and YAML files.

### Cost
The Cosmos DB Cassandra API can significantly reduce costs compared to an on-premises Cassandra implementation, or compared to an Iaas deployment.
