After you've chunked your data and converted it into embeddings, you need a way to quickly find the most relevant chunks when users ask the RAG system questions. Vector search makes this possible by finding content based on mathematical similarity between vectors, with similarity search being one of the most powerful applications for RAG systems.

Imagine searching for something and getting results that understand what you mean, not just what you type. Vector search enables you to find relevant content based on vector similarity, and when used with text embeddings, it can match user queries to semantically related content rather than exact word matches, drastically improving the user experience and making your RAG system much more effective.

## What are vectors?

Before diving into how vector search works, it's important to understand what vectors are. A vector is simply a list of numbers that represents information in a way computers can process mathematically. Think of vectors like coordinates on a map - just as (latitude, longitude) can represent any location on Earth using two numbers, a vector can represent the meaning of a piece of text using hundreds or thousands of numbers.

Text embeddings are a specific type of vector - they are vectors that represent the meaning of text. When you convert text chunks like "dog training tips" into embeddings, you create vectors that might look something like [0.2, -0.1, 0.8, 0.3, ...] with hundreds of dimensions. When two pieces of text have similar meanings, their vectors will have similar overall patterns, making them mathematically "close" to each other.

This mathematical representation is what makes vector search possible - instead of comparing words directly, you can compare the numerical patterns that represent meaning.

## How vector search works

Vector search builds on the text embedding process. Here's how it works step-by-step:

1. **Query conversion**: When a user asks a question, your system converts their query into an embedding using the same model you used for your document data chunks.
2. **Similarity calculation**: The system compares the query embedding to all document chunk embeddings using mathematical similarity measures.
3. **Ranking and retrieval**: Document chunks are ranked by similarity score, and the top most relevant chunks are retrieved.
4. **Context assembly**: The retrieved chunks are assembled and sent to the language model along with the user's question.

### Understanding similarity search

Similarity search is the most common application of vector search for RAG systems, using embeddings to match queries semantically. The system compares query embeddings (from user questions) with document chunk embeddings (from your data) to find relevant content. Unlike traditional keyword search that looks for exact word matches, similarity search recognizes relationships between concepts. For example:

- **Keyword search** for "canine care" would miss documents about "dog training" or "pet health".
- **Similarity search** recognizes that "canine," "dog," and "pet" are related concepts and finds relevant content regardless of exact wording.

This semantic understanding comes from the embedding model, which learned these relationships during training on large amounts of text data.

## Choosing your vector search approach

You have two main options for implementing vector search in Azure Databricks: vector databases and vector libraries. Let's explore each of these options, so you can determine which approach best fits your needs.

### Vector databases: For dynamic, large-scale data

**What is a vector database?**

A vector database is a specialized database optimized to store and retrieve embeddings - those vectors with hundreds or thousands of numbers that represent meaning. Like traditional databases, vector databases use indices (organized structures that speed up searches) to quickly find relevant data, but these vector indices are specifically designed to find mathematically similar vectors rather than exact matches. In RAG applications, vector databases primarily store text embeddings - vectors that represent the semantic meaning of your document chunks - along with metadata about each chunk (like source document, page numbers, or categories).

:::image type="content" source="../media/matched-query.png" alt-text="Vector space visualization showing document vectors as blue dots and a query vector as an orange dot, with the relevant document vector positioned close to the query vector.":::

This visualization shows how vectors work in practice. Each dot represents a vector - the blue dots are document chunk embeddings stored in the vector database, and the orange dot is a query vector. The image labels "Relevant document" and "Query" indicate vectors that are close together in the mathematical space, showing similarity. When you search, the database finds document vectors nearest to your query vector.

This image illustrates why vector databases are so powerful for RAG: documents with similar meanings are positioned close together in the vector space, making it easy to find relevant content by measuring mathematical distance between vectors.

**Azure Databricks option: Mosaic AI Vector Search**

In Azure Databricks, you can use Mosaic AI Vector Search as a vector database to store the vector representations of your data and metadata. Mosaic AI Vector Search integrates with your Lakehouse data and provides search capabilities for your embeddings, with support for filtering results based on metadata you've stored with your document chunks.

Vector databases like Mosaic AI Vector Search can be used when you have large amounts of data and need to store your embeddings persistently for long-term use. Vector databases are particularly well-suited for dynamic data because they support real-time operations - you can add new document chunks, update existing ones, or delete outdated content without rebuilding the entire search system. This makes them ideal for scenarios like knowledge bases that grow over time, document repositories with frequent updates, or applications where multiple users are adding content. They typically provide search capabilities and support filtering on metadata, making them applicable for scenarios where multiple applications need to access the same vector data.

### Vector libraries: For smaller, static datasets

**What are vector libraries?**

Vector libraries are tools that create vector indices to enable fast similarity search without requiring a separate database system. Think of these indices like a specialized filing system that organizes your embeddings so they can be searched quickly - similar to how a database index speeds up queries, but specifically designed for mathematical similarity searches.

Vector libraries store these indices in memory and provide algorithms to quickly find the most similar vectors to your query. A popular example is FAISS (Facebook AI Similarity Search), which provides various indexing algorithms optimized for different types of vector search scenarios.

Vector libraries can work well when you have smaller datasets where your embeddings can fit in memory, and when your data doesn't change frequently. Since the data is stored in memory, searches can be very fast, but you typically need to rebuild the index when you restart your application or add new data.
