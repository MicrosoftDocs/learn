You have been given more details about a large project's technology and functionality. To help your colleagues, and future projects, you have decided to create a matrix that can be used in the decision-making process.

|   | Core (SQL) | MongoDB | Cassandra | Azure Table | Gremlin |
|---|------------|---------|-----------|-------------|---------|
| **New projects being created from scratch** | &#x2714; | | | | |
| **Existing MongoDB, Cassandra, Azure Table, or Gremlin data** | | &#x2714; | &#x2714; | &#x2714; | &#x2714; |
| **Analysis of the relationships between data** | | | | | &#x2714; |
| **All other scenarios** | &#x2714; | | | | |

The above matrix tries to encapsulate the criteria that you can use to help choose between each API, and it is based on asking the following questions about project environment.

Are there existing databases or applications that use any of the supported APIs?

   - If there is, then you might want to consider using the current API with Azure Cosmos DB, as that choice will reduce your migration tasks, and make the best use of previous experience in your team.

   - If there isn't, then there are a few questions that you can ask in order to help you define the scenario where the database is going to be used:

      1. Does the schema change a lot?

         - A traditional document database is a good fit in these scenarios, making Core (SQL) a good choice.

      1. Is there important data about the relationships between items in the database?

         - Relationships that require metadata to be stored for them are best represented in a graph database.

      1. Does the data consist of simple key-value pairs?

         - Before Azure Cosmos DB existed, Redis or the Table API might have been a good fit for this kind of data; however, Core (SQL) API is now the better choice, as it offers a richer query experience, with improved indexing over the Table API.
