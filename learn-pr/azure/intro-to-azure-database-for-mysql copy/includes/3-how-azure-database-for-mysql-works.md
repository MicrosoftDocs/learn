In this unit, you explore how Azure Database for MySQL works, beginning with its architecture. You also learn how it provides high availability, backup functionality, and scaling to meet your workload's needs.

## Azure Database for MySQL architecture

The following diagram shows an instance of Azure Database for MySQL—Flexible Server configured with Azure Premium Storage (for data and logs) and access to locally redundant storage (for backup).

While the MySQL flexible server is hosted in Availability zone 1, the instance can also use the other availability zones that are present. In addition, various client apps are connected to the MySQL flexible server.

:::image type="content" source="../media/flexible-server.png" alt-text="A detailed architecture diagram of Azure Database for MySQL in a typical organization as previously described.":::

### How high availability works

For Azure Database for MySQL flexible server, within the single availability zone, the following process occurs after a hosting server failure:

1. Azure provisions a new virtual machine (VM).
2. Azure maps the storage and data files to the newly provisioned VM.
3. The MySQL database engine is brought online.
4. Client applications reconnect to the new MySQL instance.

> [!NOTE]
> If you have provisioned high availability across zones, a hot standby server is maintained in another availability zone in the same Azure region. This server is a fully synchronized replica of the primary server. In the event of a primary server failure, the hot standby server can quickly take over with minimal disruption, thereby maintaining service availability.

### How backups work

You can use backups to restore your server to any point in time within the retention period (35 days or up to 10 years with long-term retention, in preview).

### How scaling works

Scaling in Azure Database for MySQL involves adjusting the computing resources according to the application's needs, which can fluctuate based on user demand, the complexity of the operations processed, or other factors like business growth. This flexibility is crucial for maintaining optimal performance and cost efficiency. 

#### Types of scaling

1. **Vertical scaling (Scaling Up/Down)**
    1. **Compute scaling**: This refers to changing the compute tier of your MySQL Flexible Server instance. Azure offers several compute tiers, each designed to cater to different types of workloads:
        1. *Burstable*: Suitable for environments with intermittent bursts of CPU usage that don't require continuous full CPU performance.
        1. *General Purpose*: Designed for a wide range of applications, providing a balance of compute, memory, and I/O resources.
        1. *Business Critical*: Offers the highest performance for databases, with more powerful CPUs and faster I/O, suitable for high-transaction, low-latency workloads.
    1. **Memory and CPU allocation**: Depending on your selected tier, you can scale the number of vCores and the amount of RAM available to your database, which directly impacts the ability to handle larger or more complex queries and higher numbers of concurrent connections.
1. **Horizontal scaling**
    1. Azure Database for MySQL can scale horizontally by adding read replicas to distribute read traffic across multiple servers, improving read performance while keeping the primary server available for writes. Horizontal scaling allows your database to handle more query load, increasing application responsiveness.
1. **Storage scaling**
    1. **Dynamic storage scaling**: Azure Database for MySQL allows you to increase storage capacity without downtime. You can start with a smaller allocation and scale up as your data grows.
    1. **Autogrow feature**: This feature automatically increases storage size before reaching the capacity limit, thus preventing any disruptions due to storage constraints.

#### Autoscale IOPS

Autoscale IOPS (Input/Output Operations Per Second) is a feature that dynamically adjusts the I/O throughput based on the current workload. This is particularly useful for unpredictable or spike-prone workload patterns, as it ensures that the database can handle sudden increases in load without manual intervention.

- **IOPS scaling based on load**: When the workload increases and more I/O throughput is required, the Autoscale feature automatically increases the IOPS limit up to the maximum allowed in the chosen compute tier. Conversely, IOPS can be reduced during periods of low activity to minimize costs. 
- **Cost-effectiveness**: By automatically adjusting IOPS based on actual usage, you only pay for the IOPS you use rather than over-provision resources to handle peak loads, which may only occur sporadically.

#### Best practices for scaling

To effectively scale Azure Database for MySQL, monitor performance metrics using Azure Monitor, set up critical alerts, plan for future growth by reviewing usage patterns, and test scalability during off-peak hours to ensure smooth performance under increased load.

By understanding and utilizing these scaling mechanisms, you can ensure that your Azure Database for MySQL is always running efficiently, adapting to both the current and future needs of your business.

### Configure and tune engine behavior

To easily configure and customize server variables and parameters in Azure Database for MySQL, you can use the Azure portal, Azure CLI, or the REST API to adjust settings such as query cache size, connection timeouts, and storage engine preferences, ensuring optimal performance and behavior for your specific workload.

Replication in Azure Database for MySQL is managed using asynchronous replication, where data from the primary server is replicated to a read-only replica server, allowing for load balancing and enhanced data availability. You can also use read replicas to offload read-only queries from the primary server, improving performance and reducing the load on the primary instance.

Next, consider whether Azure Database for MySQL meets the needs of your organization, its apps, and database workloads.
