Tailwind Traders, a fictitious home improvement retailer, looking to migrate to cloud had to choose a low latency and high availability database solution for storing relational data. Based on the organization’s needs, they decided to implement Azure SQL Database, which is a fully managed service with an availability SLA of 99.995% in a Business critical service tier using Availability Zones.

The next decision to make for Tailwind Traders is how to handle scalability. Specifically, the scalability of a relational database. You have to help them design a solution that is dynamically scalable to handle the incoming workload. Your solution should be able to handle an expanding number of requests over time without a negative effect on availability or performance. How will you help them in this situation?

Azure SQL Database enables you to easily change resources allocated to your databases with minimal downtime, including:

- CPU power

- Memory

- IO throughput

- Storage

You can easily scale an Azure SQL Database using the Azure portal without the worry of new hardware purchase or changing the existing infrastructure.

Dynamic Scalability for Azure SQL Database enables you to:

- Use either DTU or vCore models to define maximum amount of resources that will be assigned to each database with a single database implementation

- Use Elastic pools that allow you to purchase resources for the group and set minimum and maximum resource limits for the databases within the pool.

**Types of scaling in Azure SQL Database**

There are two types of scaling you can implement in Azure SQL Database. These are:

- **Vertical** - Vertical scaling refers to increasing or decreasing the compute size of an individual database, also known as "scaling up."

- **Horizontal** - Horizontal scaling refers to adding or removing databases in order to adjust capacity or overall performance, also called "scaling out". Horizontal scaling is managed using the [Elastic Database client library](/azure/azure-sql/database/elastic-database-client-library).

## Design Vertical scaling solution

Imagine a scenario where a small business experiences rapid growth globally and needs to maintain and scale separate Azure SQL databases for each location. However, the rates of growth and database load vary significantly, so resource requirements are unpredictable. How would you manage scaling to meet the demands of this organization?

In this case, it is ideal to choose SQL Elastic pools, to scale, manage performance, and manage costs for a set of Azure SQL databases.

:::image type="content" source="../media/elastic-pools.png" alt-text="Image shows SQL elastic pools and the scaling capability for the different service tiers.":::


The above image shows SQL elastic pools and the scaling capability for the different service tiers. The databases within the pool share the allocated resources. In situations where there is a low average utilization, but infrequent, high utilization spikes you can allocate enough capacity in the pool to manage the spikes for the group. To properly configure SQL elastic pools to reduce server costs, the right purchasing model and the service tier (DTU-based model in basic, standard & premium or VCore-based model in general purpose or business critical) must be selected.

Read more about [SQL elastic pools](/azure/azure-sql/database/elastic-pool-overview).

## Design Horizontal Scaling Solution

There are two types of horizontal scaling. These are:

- Read Scale-Out

- Sharding

 

**Read Scale-Out**

Imagine a scenario where an application's database is accessed for OLTP for updating the database as well as an Analytics app for read-only workload to render visualizations. What can you do to offload some of the compute capacity so that performance of the application isn't affected?

An easy choice here is to use the pre-provisioned read scale-out feature for certain service tiers. The read scale-out feature allows you to offload read-only workloads using the compute capacity of one of the read-only replicas, instead of running them on the read-write replica. This way, some read-only workloads can be isolated from the read-write workloads and will not affect their performance.

The following table shows Read Scale-out provisioning for Azure SQL DB and Azure SQL Managed Instance:

| **Azure SQL DB Managed Instance**| **Azure SQL DB** |
| - | - |
| For the basic, standard and general purpose tier, read scale-out feature is unavailable| For the basic, standard and general purpose tier, read scale-out feature is unavailable |
| For the Business Critical tier, read scale-out is auto-provisioned| For the Premium and Business Critical tier, read scale-out is auto-provisioned |
| Hyperscale tier is unavailable in Azure Managed Instance| Read scale-put feature is available in Hyperscale tier if atleast one secondary replica is created |


 

 

The following image shows read scale-out in a business critical service tier:

:::image type="content" source="../media/business-critical-service-tier-read-scale-out.png" alt-text="Image shows read scale-out in a business critical service tier.":::

 

:::image type="content" source="../media/business-critical-architecture.png" alt-text="Diagram of Business Critical scenario, the data and log files are all running on direct-attached SSD, which significantly reduces network latency.":::

  

In the image above, in Business Critical scenario, the data and log files are all running on direct-attached SSD, which significantly reduces network latency. In this architecture group, there are three secondary replicas. If any type of failure occurs, failing over to a secondary replica is fast because the replica already exists and has the data attached to it.

 

The premium/business critical tier of Azure SQL DB or Azure Managed Instance has an Always On Availability Group. This group is for disaster recovery and high-availability of the application. There is a primary read-write replica and several secondary read-only replicas. The secondary replicas are provisioned with the same compute size as the primary replica. You set the connection string option to decide whether the connection is routed to the write replica or to a read-only replica.

You can disable and re-enable read scale-out on single databases and elastic pool databases in the Premium or Business Critical service tiers using the following methods:

- Azure portal

- Azure PowerShell

- REST API

> [!NOTE]
> Data changes made on the primary replica propagate to read-only replicas asynchronously. Within a session connected to a read-only replica, reads are always transactionally consistent. However, because data propagation latency is variable, different replicas can return data at slightly different points in time relative to the primary and each other.

 

**Sharding**

Imagine a scenario where you need to solve a database problem for an application accessing the database that has a huge amount of transaction throughput that exceeds the database capability. How will you provision the database for performance and availability?

A possible solution for the above scenario is Horizontal Scaling or horizontal partitioning by Sharding. This is a technique to distribute large amounts of identically structured data across a number of independent databases. 

Reasons for Sharding include:

- If the total amount of data is too large to fit constraints of a single database

- If the transaction throughput of the overall workload exceeds capacities of an individual database

- When different customers or tenents' data needs physical isolation from each other

- Within an organization, there is a geographical separation of data for compliance reasons

**Adopt suitable database scaling strategy**

The following table identifies key points to remember before choosing Vertical/Horizontal scaling.

| **Requirement**| **Description** |
| - | - |
| Do you have to manage and scale multiple Azure SQL databases that have varying and unpredictable resource requirements?| **SQL elastic pools.** Vertical scale up is a good solution for this scenario. Elastic pools solve this problem by ensuring that databases get the performance resources they need when they need it. They provide a simple resource allocation mechanism within a predictable budget. There is no per-database charge for elastic pools. You are billed for each hour a pool exists at the highest eDTU or vCores, regardless of usage or whether the pool was active for less than an hour. |
| Do you have different sections of the database residing in different parts of the world for compliance concerns?| **Horizontal scaling by Sharding** works best. Sharding enables you to split your data into several databases and scale them independently. The shard map manager is a special database that maintains global mapping information about all shards (databases) in a shard set. The metadata allows an application to connect to the correct database, based upon the value of the sharding key. |
| Are there dependencies such as commercial BI or data integration tools where multiple databases contribute rows into a single overall result for use in Excel, Power BI, or Tableau?| Use **Elastic database tools** and elastic query feature within it to access data spread across multiple databases. Elastic query is available on standard tier, querying can be done in T-SQL that spans multiple databases in Azure SQL Database. Cross-database queries can be executed to access remote tables, and to connect Microsoft and third-party tools (Excel, Power BI, Tableau, etc.) to query across data tiers. Using this feature, you can scale out queries to large data tiers and visualize the results in business intelligence (BI) reports. |