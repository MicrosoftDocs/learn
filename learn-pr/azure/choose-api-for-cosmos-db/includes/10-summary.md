In this module, you have explored the different APIs that Azure Cosmos DB supports, and you have seen that each API has benefits in different scenarios.

Your default choice for new Azure Cosmos DB accounts should be Core (SQL). However, you should also consider the following situations:

If your data is better represented in a graph, then the Gremlin (graph) API might be a good choice.

If you already have an existing application or database that is using one of the other APIs, then the current API might be a better choice for your specific scenario. Using the current API might make it easier to:

   - Migrate your application or database to Azure Cosmos DB
   - Reuse your existing code with minimal changes
   - Leverage the existing knowledge and experience of your development team.

You should only use the Azure Table API if you are migrating from Azure Table Storage, as Core (SQL) offers far more features and flexibility.

## Learn more

Here are some resources where you can learn more about each of the APIs:

- [Azure Cosmos DB](https://docs.microsoft.com/azure/cosmos-db)
- [Modeling data](https://docs.microsoft.com/azure/cosmos-db/modeling-data)
- [MongoDB](https://docs.microsoft.com/azure/cosmos-db/mongodb-introduction)
- [Cassandra](https://docs.microsoft.com/azure/cosmos-db/cassandra-introduction)
- [Table API](https://docs.microsoft.com/azure/cosmos-db/table-introduction)
