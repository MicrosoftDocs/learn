Your web analytics team is using a third-party web analytics application that uses a Cassandra database, and the team has experience writing Cassandra Query Language (CQL) queries to produce their own reports.

## Problem analysis

Your web analytics application is based on Cassandra, and your web analytics team has valuable experience with CQL.

## Recommended API: Cassandra

Based on the existing design of your third-party web analytics application, and the subject expertise that your web analytics team already has with CQL, your easiest path for migration would be to continue to use the Cassandra API for the immediate future.

## Why not any of the other APIs?

Using the decision matrix from earlier in this learning module, you can see why the other APIs are not a good solution for this scenario:

| API | Description |
|---|---|
| **Azure Table** | This API should only be used to allow existing apps that are based on the Table API access to Azure Cosmos DB. |
| **Core (SQL)** | All of the requirements for your web analytics application can be satisfied by Core (SQL), which makes your decision difficult when choosing between Core (SQL) and Cassandra. Since the web team is already using their Cassandra-based application, and because of their prior experience using the Cassandra Query Language (CQL) for some of their reporting, Cassandra is the right choice for this scenario, although Core (SQL) is still a close second choice. |
| **Gremlin** | This API isn't a good choice because the data isn't graph based. |
| **MongoDB** | The flexibility of a document-based data store is not enough of a reason to use MongoDB. |
