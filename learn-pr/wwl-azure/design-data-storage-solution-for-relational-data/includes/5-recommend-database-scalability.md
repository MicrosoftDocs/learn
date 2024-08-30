
As the CTO for Tailwind Traders, you're interested in a low latency and high availability database solution to store relational data. After reviewing the five deployment options, you decide to implement Azure SQL Database for its fully managed service features. You're hoping to gain the high availability SLA offered in the Business Critical service tier when using availability zones. 

Your next decision is how to support scalability for a relational database. You need a dynamically scalable solution that can handle an expanding number of requests over time without a negative effect on availability or performance. 

## Azure SQL Database and dynamic scalability

Azure SQL Database supports dynamic scalability. You can easily change resources allocated to your databases, such as CPU power, memory, I/O throughput, and storage with minimal downtime. Use the Azure portal to scale an Azure SQL Database without changing the existing infrastructure or purchasing new hardware.

### Things to know about dynamic scalability

Review the following characteristics of dynamic scalability for an Azure SQL database:

- Choose DTU or vCore models, and define the maximum amount of resources to assign to each database with a single database implementation.

- Use elastic database pools, and purchase resources for the group, and set minimum and maximum resource limits for the databases within the pool.

- Implement vertical or horizontal scaling:

   - **Vertical**: Increase or decrease the compute size of an individual database, also called _scaling up_.

   - **Horizontal**: Add or remove databases to adjust capacity or overall performance, also called _scaling out_. 

- Apply horizontal scaling by using sharding to partition data or read scale-out provisioning.

### Things to know about vertical scaling

Implement vertical scaling by using SQL Database elastic database pools. The databases within an elastic database pool share the allocated resources. Vertical scaling allows you to change the compute size for a set of databases. When you have low average utilization, but infrequent, high utilization spikes,
you can allocate enough capacity in the pool to manage the spikes for the group.

To properly configure SQL elastic database pools to reduce server costs, choose the appropriate purchasing model and service tier:

| DTU model | vCore model |
| --- | --- |
| **Basic**, **Standard**, and **Premium** tiers  | **General Purpose** and **Business Critical** tiers |

#### Business scenario

Let's explore a business scenario for using vertical scaling. A small business experiences rapid growth globally. The company needs to maintain and scale separate SQL databases for each location. The rates of growth and database load vary significantly. Resource requirements are unpredictable. The ideal dynamic scaling solution is to use SQL elastic database pools with vertical scaling. You can scale, manage performance, and manage costs for a set of SQL databases. For more information, see [SQL elastic database pools](/azure/azure-sql/database/elastic-pool-overview).

:::image type="content" source="../media/elastic-pools.png" alt-text="Diagram of SQL elastic database pools and the scaling capability for different service tiers." lightbox="../media/elastic-pools.png" border="false":::

### Things to know about horizontal scaling

Horizontal scaling is managed by using the SQL Database [Elastic Database client library](/azure/azure-sql/database/elastic-database-client-library). There are two ways to apply horizontal scaling: read scale-out provisioning and sharding.

- **Sharding**: Partition data across a set of SQL databases that are identically structured. A set consists of a primary read-write replica and secondary read-only replicas. You can split large databases into smaller components to improve performance and make them easier to manage.

- **Read scale-out**: Load-balance read-only workloads for a set of SQL databases. Offload read-only workloads by using the compute capacity of a read-only replica, instead of running workloads on the read-write replica. Isolate some read-only workloads from the read-write workloads and not affect performance. The following table shows support for read scale-out provisioning in Azure SQL Database and Azure SQL Managed Instance:

   | Azure SQL Managed Instance | Azure SQL Database |
   | --- | --- |
   | **Basic**, **Standard**, and **General Purpose** tiers: Read scale-out is unavailable | **Basic**, **Standard**, and **General Purpose** tiers: Read scale-out is unavailable  |
   | **Business Critical** tier: Read scale-out is autoprovisioned | **Business Critical** and **Premium** tiers: Read scale-out is auto-rovisioned | 
   | No applicable tier | **Hyperscale** tier: Read scale-out is available if at least one secondary replica is created |

#### Business scenario: Sharding

Let's explore a business scenario for using sharding horizontal scaling. You need to solve a database problem for an application that accesses a database that has a huge amount of transaction throughput that exceeds the database capability. You're looking for a way to configure the database for performance and availability. A possible solution is horizontal scaling or _horizontal partitioning by sharding_. This technique distributes large amounts of identically structured data across a set of independent databases. 

Sharding is useful in many situations. Here are some examples:

- The total amount of data is too large to fit the constraints of a single database.

- The transaction throughput of the overall workload exceeds the capacities of an individual database.

- Different customer's or tenant's data require physical isolation from each other.

- Within an organization, there's a geographical separation of data for compliance reasons.

#### Business scenario: Read scale-out

Let's explore a business scenario for applying read scale-out provisioning. Your application's database is accessed for online transactional processing (OLTP) to update the database, and by analytics applications for read-only workloads to render visualizations. You need a horizontal scaling solution that can offload some of the compute capacity so application performance isn't affected. An easy choice is to use the pre-provisioned read scale-out feature for certain service tiers. Rather than running the workloads on the read-write replica, you can offload read-only workloads by using the compute capacity of one of the read-only replicas. This approach allows some read-only workloads to be isolated from the read-write workloads and doesn't affect their performance.

The following image shows how horizontal read scale-out provisioning is applied in the Business Critical service tier:

:::image type="content" source="../media/business-critical-read-scale-out-small.png" alt-text="Diagram that shows read scale-out provisioning in a business critical service tier." lightbox="../media/business-critical-service-tier-read-scale-out.png" border="false":::

The data and log files all run on direct-attached SSD, which significantly reduces network latency. In this architecture group, there are three secondary replicas. If any type of failure occurs, failing over to a secondary replica is fast because the replica already exists and has the data attached to it.

The Premium and Business Critical tiers for Azure SQL Database and Azure SQL Managed Instance have an **Always On Availability Group**. This group is for disaster recovery and high-availability of the application. There's a primary read-write replica, and several secondary read-only replicas. The secondary replicas are provisioned with the same compute size as the primary replica. You set the connection string option to decide whether the connection is routed to the write replica or to a read-only replica.

:::image type="content" source="../media/business-critical-architecture.png" alt-text="Diagram that shows the Business Critical tier, where the data and log files all run on direct-attached SSD, which significantly reduces network latency." lightbox="../media/business-critical-architecture-large.png" border="false":::

You can disable and re-enable read scale-out on single databases and elastic pool databases in the Premium or Business Critical service tiers. These functions are available in the Azure portal, PowerShell, and the REST API.

> [!NOTE]
> Data changes made on the primary replica propagate to read-only replicas asynchronously. Within a session connected to a read-only replica, reads are always transactionally consistent. However, because data propagation latency is variable, different replicas can return data at slightly different points in time relative to the primary replica and each other.

### Things to consider when choosing scalability solutions

Review the following scaling scenarios, and think about which database scaling strategy can work for Tailwind Traders.

| Scenario | Scaling solution |
| --- | --- |
| Manage and scale multiple Azure SQL databases that have varying and unpredictable resource requirements | **Elastic database pools and vertical scaling**. Use elastic database pools to ensure databases get the performance resources they need when they need it. Elastic pools provide a simple resource allocation mechanism within a predictable budget. There's no per-database charge for elastic pools. You're billed for each hour a pool exists at the highest eDTU or vCores, regardless of usage or whether the pool was active for less than an hour. |
| Different sections of a database reside in different geographic locations for compliance reasons | **Horizontal scaling and sharding**. Use sharding to split your data into several databases and scale them independently. The shard map manager is a special database that maintains global mapping information about all shards (databases) in a shard set. The metadata allows an application to connect to the correct database based on the value of the sharding key. |
| Dependency support for commercial BI or data integration tools, where multiple databases contribute rows into a single overall result for use in Excel, Power BI, or Tableau | **Elastic database tools and elastic query**. Use the Elastic database tools elastic query feature to access data spread across multiple databases. Elastic query is available on the Standard tier. Querying can be done in T-SQL that spans multiple databases in Azure SQL Database. Run cross-database queries to access remote tables, and to connect Microsoft and third-party tools (Excel, Power BI, Tableau, and so on) and query across data tiers. You can scale out queries to large data tiers and visualize the results in business intelligence reports. |