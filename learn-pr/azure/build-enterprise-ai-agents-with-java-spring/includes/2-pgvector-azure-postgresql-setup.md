## What is Vector Search Similarity?

Vector Search Similarity is a technique used to find similar items in a dataset by comparing their vector representations. Vector similarity is commonly calculated using distance metrics, such as Euclidean distance or `cosine` similarity. In the context of AI and machine learning, vector representations or embeddings are numerical representations of data points, such as words, images, or user queries. These vectors capture the semantic meaning of the data points, enabling efficient similarity searches.

For example, in a question-answering system, user queries can be converted into vector embeddings. These embeddings can then be compared to a database of precomputed embeddings of previous prompts and answers to find the most similar ones. This process is known as vector similarity search.

## What is the pgvector extension?

The `pgvector` extension is an extension for PostgreSQL that adds support for vector data types and operations. It enables you to store and query vector embeddings directly within a PostgreSQL database. With `pgvector`, you can perform efficient similarity searches using vector operations, making it an ideal choice for applications that require semantic search capabilities.

The `pgvector` extension includes the following key features:

- Support for vector data types.
- Efficient indexing and querying of vector data.
- Integration with PostgreSQL's existing features and extensions.

## The pgvector extension in Azure PostgreSQL

The `pgvector` extension adds an open-source vector similarity search to PostgreSQL.

Before you can enable `pgvector` on your Azure Database for PostgreSQL flexible server instance, you need to add it to your allowlist as described in [Allow extensions](/azure/postgresql/extensions/how-to-allow-extensions). To determine whether you added it correctly, use the following command: `SHOW azure.extensions;`

> [!IMPORTANT]
> The PostgreSQL community often refers to this extension as `pgvector`. However, the name of the binary and the extension itself is `vector`, which is the name you must use in the allowlist and when you create it in PostgreSQL via the `CREATE EXTENSION` command.

After you add the extension to the allowlist, install the extension by using the following SQL command:

```sql
CREATE EXTENSION IF NOT EXISTS vector;
```

### pgvector operations

The `pgvector` extension enables efficient similarity search, as shown in the following example:

```sql
SELECT id, prompt, response
FROM chat_history
ORDER BY embedding <-> '[0.1,0.2,...]'::vector
LIMIT 3;
```

## The Spring AI implementation of pgvector

Spring AI includes an abstraction of `pgvector` named `VectorStore`. This implementation requires two other PostgreSQL extensions: `hstore` and `uuid-ossp`.

On startup, Spring Boot installs the required extensions and creates the required `vector_store` table with an index if it doesn't already exist.

## Unit summary

Vector Search Similarity and the `pgvector` extension provide powerful capabilities for building AI-powered applications that require semantic search functionality. By using these tools in Azure PostgreSQL, you can efficiently store, index, and query vector embeddings, enabling advanced search and retrieval features in your applications.

In the next unit, you perform the steps to create and configure a PostgreSQL database, enable the `pgvector` extension, and create required tables for use with Spring AI.
