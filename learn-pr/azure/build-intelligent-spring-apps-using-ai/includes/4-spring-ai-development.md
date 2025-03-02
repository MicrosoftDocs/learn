In this unit, you will explore the concepts behind using the `PGVectorStore` Spring Boot Starter and OpenAI Spring Boot Starter to manage and query document embeddings in a PostgreSQL database. By the end of this unit, you will understand how to leverage these tools to enhance your applications with advanced search capabilities.

Prerequisites
Before diving into the concepts, ensure you have a basic understanding of:

Spring Boot framework
PostgreSQL database
Embeddings and vector representations
Understanding Vector Stores

## What is a Vector Store?

A vector store is a specialized database designed to store and manage high-dimensional vectors. These vectors often represent complex data such as text, images, or other multimedia content. Vector stores enable efficient similarity searches, making them ideal for applications like recommendation systems, semantic search, and more.

## Why Use PGVectorStore?

PGVectorStore is a Spring Boot starter that simplifies the integration of vector storage and search capabilities into your Spring Boot applications. It leverages PostgreSQL's vector extension to store and query document embeddings efficiently.

## What are Embeddings?

Embeddings are dense vector representations of data. For example, in natural language processing (NLP), embeddings represent words, sentences, or documents as vectors in a high-dimensional space. These vectors capture semantic relationships, enabling advanced search and analysis.

## Using Azure OpenAI EmbeddingModel

Azure OpenAI provides powerful models to generate embeddings for various types of data. By integrating Azure OpenAI's Embedding Models with `PGVectorStore`, you can create and store embeddings for your documents, enabling sophisticated search capabilities.

## Adding Documents to Vector Store

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
1. Finally we add the list of documents to the `vectorStore` instance. The add method of the `VectorStore` class is used to store the documents in the vector store database table, as well as generate embeddings using the specified `EmbeddingModel` in your Spring Boot configuration.

## Querying Documents

Once your documents are stored, you can perform similarity searches to find documents that are semantically similar to a given query. Here is a sample code to perform a similarity search using the `VectorStore` class:

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
    1. This `query` method sets the query string for the search. The similarity search will look for documents in the vector store that are similar to this query.
    1. The `topK(5)` portion specifies the number of top results to return. In this case, the search should return the top 5 most similar documents.

## Unit Summary

In this unit, you learned the concepts behind using `PGVectorStore` and OpenAI Spring Boot Starter to manage and query document embeddings. You explored the importance of embeddings, how to generate and store them, and how to perform similarity searches. In the next exercise, we will build a RAG Spring Boot application using these tools.
