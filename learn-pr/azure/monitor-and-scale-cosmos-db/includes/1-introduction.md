You can use Azure Cosmos DB to build highly responsive and highly available applications. Use Azure monitoring tools and database design options to help optimize performance and costs.

Imagine that you work for a retail startup that's designing a database to manage online orders. You're working on a proposal for an efficient database design. The operating budget must be kept within tight constraints. You've prototyped several designs for your data architecture. But you need to understand how to monitor and optimize the performance of each design. With this knowledge in hand, you can tune and optimize your solution.

In this module, you'll use a console application to populate the database and simulate a set of queries. Next, you'll use Azure Cosmos DB monitoring tools to observe and understand the following key metrics of Azure Cosmos DB:

- **Total requests** made per second, and the proportion of requests rejected because the provisioned throughput is exceeded.
- **Total throughput**, measured in Request Units per second (RU/s), and the distribution of throughput across partitions.
- **Total storage**, measured in kilobytes (KB), and the distribution of data across partitions.

After you understand these key metrics, we'll assess different partitioning and indexing strategies to maximize the efficiency of your capacity.

## Learning objectives

In this module, you will:

- Use monitoring tools to measure the throughput of your Azure Cosmos DB database.
- Identify a partition strategy for your Azure Cosmos DB data.
- Measure the impact of different indexing strategies.

Prerequisites:

- Familiarity with NoSQL database concepts
- Familiarity with Azure Cosmos DB concepts like databases, collections, and documents
