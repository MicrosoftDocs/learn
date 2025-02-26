Imagine searching for something and getting results that understand what you mean, not just what you type. **Vector search** allow you to match user queries to semantically correlated content, rather than exact word matches, drastically improving the user experience.

Vector search can be used in applications like **chatbots**, where you want to deliver relevant documents to help answer user's questions. You can also use vector databases to improve the search capabilities of **recommendation engines** that provide personalized, context-aware recommendations to users.

## Use similarity search to find relevant data

The main advantage of using vector search is the ability to use **similarity search**, which matches search queries *semantically*.

Unlike keyword matching, semantic matching enables plain language search queries to deliver relevant results across various types of data, including text, images, and audio. This approach allows for a deeper understanding of the similarities and differences between data, providing more accurate and meaningful search outcomes.

You can achieve vector search with a **vector database** or a **vector library**. Let's explore each of these options, so you can understand which approach best fits your needs.

## What is a vector database?

A vector database is a database that is optimized to store and retrieve high-dimensional vectors such as **embeddings**.

In a Retrieval Augmented Generation (RAG) architecture, contextual information is stored in vectors. Vector databases are designed for efficient storage of vectors used in generative AI applications, which rely on identifying documents or images with similarities.

:::image type="content" source="../media/matched-query.png" alt-text="Screenshot of the model catalog in the Azure AI Studio.":::

Vector databases provide a query interface that retrieves vectors that represent documents most similar to a specified query vector.

Vector databases are optimized for the high-dimensionality of vectors and are specialized, full-fledged databases for unstructured data.

When you work with Azure Databricks, you can use **Mosaic AI Vector Search** as a vector database to store the vector representations of your data and the metadata. Mosaic AI Vector Search is tightly integrated with your Lakehouse. You can use the API for real-time similarity search, and include filters on the metadata in the query.

> [!Tip]
> Learn more about the [Mosaic AI Vector Search](/azure/databricks/generative-ai/vector-search?azure-portal=true)

A vector database like Mosaic AI Vector Search is ideal when you have a large amount of data and you need to persist the vector indices computed in storage. You can take advantage of inherit database properties, like **Create-Read-Update-Delete** (**CRUD**).

When your data is mostly static, and you don't expect to update your data that often, a vector library can be a better approach.

## Use a library to create vector indices

If you don’t want to integrate with a new database system, you can choose to use a vector library that creates these **vector indices** for you. A vector index is a data structure that holds all necessary information that facilitates the vector search process.

Typically, a vector index can contain three components:

- **Preprocessing**: Optionally, you can choose to normalize your embeddings to reduce the embedding dimensions.
- **Indexing**: Use an indexing algorithm from a vector library like **Faiss** (**Facebook AI Similarity Search**) to index your embeddings.
- **Postprocessing**: Quantize or hash your vectors to optimize for search speeds.

The advantage of using a vector library like FAISS is that it's sufficient for small and static data, more light-weight, and cost-efficient.

However, the data is stored in-memory (RAM), meaning there's no data replication. There's also no CRUD support, which results in a need to rebuild at every session. You also need to wait for full import to finish before you can query your data.

> [!Tip]
> Explore the [Faiss library documentation](https://faiss.ai/?azure-portal=true).
