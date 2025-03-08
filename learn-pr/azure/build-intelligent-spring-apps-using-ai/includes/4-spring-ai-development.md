In this unit, you learn how to implement Retrieval-Augmented Generation (RAG) in a Spring Boot application using vector search similarity provided by the `pgvector` extension in a PostgreSQL database. We introduce relevant RAG concepts such as embeddings, embedding models, and vector stores. By the end of this unit, you should understand how to apply these tools to enhance your applications with advanced search and retrieval capabilities.

## What are embeddings?

*Embeddings* are dense vector representations of data. In simpler terms, embeddings are a way to convert complex data, like words or images, into a set of numbers (vectors) that a computer can easily process. In natural language processing (NLP), embeddings represent words, sentences, or documents as vectors in a high-dimensional space. In these vectors, each word or sentence is represented as a list of numbers. These numbers aren't random; they're designed to capture the meaning and relationships between the words.

These vectors capture semantic relationships, enabling advanced search and analysis. For instance, if you search for "queen" in a database, the system can also find related terms like "king" or "royalty" because their vectors are close to each other. This capability makes embeddings a powerful tool for tasks like search engines, recommendation systems, and language translation.

## Use Azure OpenAI embedding models

Embedding models are essential tools in natural language processing (NLP) and other AI applications. They convert complex data, such as text, into dense vector representations that capture the semantic meaning of the data. These vectors can then be used for various tasks, including search, recommendation, and clustering.

Azure OpenAI provides powerful embedding models that can be easily integrated into your applications. These models can generate embeddings for various types of data, enabling advanced search and retrieval capabilities. One the most commonly used text embedding model from OpenAI is the `text-embedding-ada-002` model. This model can be used for various applications, including search, clustering, and recommendation systems, due to its ability to understand and represent complex text data. When used with ChatGPT models, `text-embedding-ada-002` enhances the chatbot's ability to understand context, retrieve relevant information, and provide more accurate and contextually appropriate responses. By using `text-embedding-ada-002` with ChatGPT, developers can create more intelligent and responsive applications that deliver better user experiences.

## Implement VectorStore in Spring AI

The `VectorStore` is a class provided by the Spring AI `pgvector` Store Spring Boot starter. It simplifies the integration of vector storage and search capabilities into your Spring Boot applications. It uses PostgreSQL's `pgvector` extension to store and query document embeddings efficiently.

You can add the `VectorStore` Spring Boot starter dependency to your project using this dependency:

```xml
<dependency>
    <groupId>org.springframework.ai</groupId>
    <artifactId>spring-ai-pgvector-store-spring-boot-starter</artifactId>
</dependency>
```

On startup, the `pgvector` Spring Boot starter attempts to install the required database extensions and create the required `vector_store` table with an index if not existing. Optionally, you can do this manually using this SQL statements:

```sql
CREATE EXTENSION IF NOT EXISTS vector;
CREATE EXTENSION IF NOT EXISTS hstore;
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE IF NOT EXISTS vector_store (
    id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
    content text,
    metadata json,
    embedding vector(1536) // 1536 is the default embedding dimension
);

CREATE INDEX ON vector_store USING HNSW (embedding vector_cosine_ops);
```

The `VectorStore` also requires an `EmbeddingModel` instance to calculate embeddings for the documents. To use Azure OpenAI Embedding Model, add the following dependency to your project:

```xml
<dependency>
    <groupId>org.springframework.ai</groupId>
    <artifactId>spring-ai-azure-openai-spring-boot-starter</artifactId>
</dependency>
```

At application startup, Spring Boot autoconfigures `VectorStore` using the following Azure OpenAI application properties:

```properties
spring.ai.azure.openai.api-key=${AZURE_OPENAI_API_KEY}
spring.ai.azure.openai.endpoint=${AZURE_OPENAI_ENDPOINT}
spring.ai.azure.openai.chat.model=gpt-4o
spring.ai.azure.openai.embedding.model=text-embedding-ada-002
```

### Add documents to the vector store

To add documents to the vector store, you need to generate embeddings and store them along with the original content. The provided code snippet demonstrates how to use the `VectorStore` class in a Spring Boot application to store and manage documents:

```java
@Autowired
private VectorStore vectorStore;

List<Document> documents = List.of(
    new Document("A vector store is a specialized database designed to store and manage high-dimensional vectors. ", Map.of("prompt", "What is Vector Store")),
    new Document("PGVectorStore is a Spring Boot starter that simplifies the integration of vector storage and search capabilities into your Spring Boot applications.", Map.of("prompt","Why Use PGVectorStore?"))
);
vectorStore.add(documents);
```

Here's a detailed explanation of how this code works:

1. First use the Spring's `@Autowired` annotation to automatically inject an instance of the `VectorStore` class into the current class.
1. Next create a list of `Document` objects. Each `Document` object contains a string representing the content and a map of metadata. In this example, two documents are created:
1. Finally we add the list of documents to the `vectorStore` instance. The add method of the `VectorStore` class is used to store the documents in the vector store database table, and generate embeddings using the specified `EmbeddingModel` in your Spring Boot configuration.

### Query documents

After your documents are stored, you can perform similarity searches to find documents that are semantically similar to a given query. Here's a sample code to perform a similarity search using the `VectorStore` class:

```java
List<Document> results = vectorStore.similaritySearch(
    SearchRequest.builder()
        .query("Spring")
        .topK(5)
        .build()
);
```

Here's a detailed explanation for this code snippet:

1. The `similaritySearch` method of the `VectorStore` class is used to find documents that are similar to a given query.
1. This code uses the builder pattern to create a `SearchRequest` object using the following components:
    1. This `query` method sets the query string for the search. The similarity search looks for documents in the vector store that are similar to this query.
    1. The `topK(5)` portion specifies the number of top results to return. In this case, the search should return the top five most similar documents.

## Unit summary

In this unit, you learned the concepts behind using Spring Boot's `VectorStore` and OpenAI Spring Boot Starter to manage and query document embeddings. You explored the importance of embeddings, how to generate and store them, and how to perform similarity searches. In the next exercise, we build a RAG Spring Boot application using these tools.
