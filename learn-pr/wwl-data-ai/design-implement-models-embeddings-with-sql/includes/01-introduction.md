Building intelligent applications with Azure SQL Database involves more than storing and querying relational data. Developers need to integrate AI models, generate embeddings from text, and perform vector searches to enable features like semantic search and Retrieval Augmented Generation (RAG). Azure SQL Database and Fabric SQL database support these capabilities through external models, the vector data type, and built-in AI functions.

Together, external models and embedding workflows allow developers to add AI capabilities directly inside the database. This approach keeps AI processing close to the data and reduces the need to move information between systems for tasks like similarity search or content retrieval.

Imagine a retail development team that builds applications using Azure SQL Database to manage product catalogs, customer reviews, and support documentation. Their work includes generating embeddings from product descriptions, enabling semantic search across support articles, and keeping embeddings current as content changes. By using external models and built-in AI functions in Azure SQL Database, the team can design, generate, and maintain embeddings while working entirely within Transact-SQL.

After completing this module, you'll be able to:

- Evaluate AI models for SQL database workloads based on capabilities and performance requirements.
- Create and manage external models to reference AI endpoints from Transact-SQL.
- Design embeddings with appropriate chunking strategies.
- Generate and store embeddings using built-in SQL AI functions.
- Choose maintenance approaches to keep embeddings aligned with source data.
