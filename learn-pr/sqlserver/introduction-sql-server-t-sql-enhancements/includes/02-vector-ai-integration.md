SQL Server 2025 introduces a new set of AI and vector functions that enable database developers to integrate AI-powered capabilities directly into T-SQL. These new capabilities make it possible to generate embeddings, calculate vector similarity, and search across AI-enriched data without leaving SQL Server. This level of integration reduces the need for external services, simplifies application architecture, and supports real-time intelligent workloads.

## AI and Vector Functions Overview

The new AI features in SQL Server 2025 fall into three main categories: AI generation, vector operations, and vector indexing and search.

### AI Generation Functions

- **AI_GENERATE_CHUNKS** – Splits large text or documents into semantically coherent chunks that can later be embedded or stored for retrieval-augmented generation (RAG) scenarios.  
- **AI_GENERATE_EMBEDDINGS** – Generates embeddings from text input using an external model registered in SQL Server. These embeddings can be stored in tables for use in vector search, similarity analysis, or semantic ranking.

### Vector Operations

- **VECTOR_DISTANCE** – Computes the distance between two vector values, supporting distance metrics such as cosine, Euclidean, and dot product.  
- **VECTOR_NORM** – Returns the vector norm (magnitude) for a given vector.  
- **VECTOR_NORMALIZE** – Returns a normalized version of a vector, typically used before comparison or similarity searches.  
- **VECTORPROPERTY** – Returns metadata about a vector, such as its dimensions or element type.

### External Models and Vector Indexes

SQL Server 2025 allows you to register and manage external AI models using T-SQL.  
- **CREATE EXTERNAL MODEL / ALTER EXTERNAL MODEL / DROP EXTERNAL MODEL** – Manage AI models that are hosted locally or through supported model providers.  
- **CREATE VECTOR INDEX** *(Preview — requires `PREVIEW_FEATURES = ON`)* – Creates an index optimized for vector data to accelerate approximate similarity searches.  
- **VECTOR_SEARCH** *(Preview — requires `PREVIEW_FEATURES = ON`)* – Performs approximate similarity search on vector data using a vector index, returning the closest matches based on the selected distance metric.

These capabilities allow SQL Server to serve as a foundation for retrieval-augmented generation, recommendation engines, and semantic search applications entirely within the database engine.

### Half-precision vector storage and binary ingest

Vectors can now use **half-precision floating-point (fp16)** elements *(Preview — requires `PREVIEW_FEATURES = ON`)* to reduce memory usage and improve scan performance in embedding-heavy workloads. The `float16` base type supports up to 3,996 dimensions per vector.  
You can also **bulk-load vectors** in binary format using `BULK INSERT` or `OPENROWSET(BULK ...)`, which simplifies importing large embedding sets created outside SQL Server.

## Example Scenario: Building a Product Recommendation Query

Imagine you work for a retail company that stores product descriptions in a SQL Server 2025 database. The marketing team wants to build a recommendation feature that suggests products semantically similar to a selected item. Using the new AI and vector features, you can generate embeddings for product descriptions, store them in a table, and perform similarity searches without external processing.

### Create and Register the Model

Before generating embeddings, create a database scoped credential for authentication, then register an external model.

```sql
-- Step 1: Create a database master key if one doesn't exist
IF NOT EXISTS (SELECT * FROM sys.symmetric_keys
               WHERE [name] = '##MS_DatabaseMasterKey##')
    CREATE MASTER KEY ENCRYPTION BY PASSWORD = N'<your-strong-password>';
GO

-- Step 2: Store the OpenAI API key as a database scoped credential
CREATE DATABASE SCOPED CREDENTIAL [https://api.openai.com/v1/embeddings]
    WITH IDENTITY = 'HTTPEndpointHeaders',
    SECRET = '{"Authorization":"Bearer <your-openai-api-key>"}';
GO

-- Step 3: Register the external model
CREATE EXTERNAL MODEL embedding_model
WITH (
    LOCATION = 'https://api.openai.com/v1/embeddings',
    API_FORMAT = 'OpenAI',
    MODEL_TYPE = EMBEDDINGS,
    MODEL = 'text-embedding-3-small',
    CREDENTIAL = [https://api.openai.com/v1/embeddings]
);
GO
```

### Generate and Store Embeddings

Once the model is registered, you can generate embeddings for your product descriptions and store them in a new table.

```sql
CREATE TABLE ProductEmbeddings
(
    ProductID INT PRIMARY KEY,
    Description NVARCHAR(MAX),
    Embedding VECTOR(1536)
);

INSERT INTO ProductEmbeddings (ProductID, Description, Embedding)
SELECT ProductID,
       Description,
       AI_GENERATE_EMBEDDINGS(Description USE MODEL embedding_model)
FROM Products;
```

### Create a Vector Index and Run a Search

`CREATE VECTOR INDEX` and `VECTOR_SEARCH` are preview features in SQL Server 2025 RTM. Enable preview features on the database before using them.

```sql
-- Enable preview features (required for CREATE VECTOR INDEX and VECTOR_SEARCH)
ALTER DATABASE SCOPED CONFIGURATION SET PREVIEW_FEATURES = ON;
GO

CREATE VECTOR INDEX idx_ProductEmbedding
ON ProductEmbeddings (Embedding)
WITH (DISTANCE_METRIC = 'cosine');
```

Now you can perform a semantic search for related products:

```sql
DECLARE @query NVARCHAR(MAX) = 'waterproof hiking backpack';
DECLARE @vector VECTOR(1536) = AI_GENERATE_EMBEDDINGS(@query USE MODEL embedding_model);

SELECT TOP 5 ProductID, Description,
       VECTOR_DISTANCE('cosine', @vector, Embedding) AS SimilarityScore
FROM ProductEmbeddings
ORDER BY SimilarityScore ASC;
```

### Results

| ProductID | Description | SimilarityScore |
|------------|--------------|----------------|
| 105 | "Lightweight waterproof travel backpack" | 0.07 |
| 116 | "Hiking pack with rain cover and hydration slot" | 0.10 |
| 117 | "Compact outdoor day pack with water resistance" | 0.12 |
| 101 | "Trail-ready backpack with external straps" | 0.15 |
| 119 | "Travel and camping waterproof duffel" | 0.18 |

This example demonstrates how to integrate an external AI model, generate embeddings directly within T-SQL, and perform a similarity search using built-in vector functions. Everything runs inside SQL Server, which simplifies development and allows intelligent workloads to remain secure and governed under existing database policies.

## Summary

SQL Server 2025 introduces native AI capabilities that allow developers to build intelligent database applications directly in T-SQL. Functions such as `AI_GENERATE_EMBEDDINGS`, `VECTOR_DISTANCE`, and `VECTOR_SEARCH` streamline integration with AI models while maintaining performance and security. Together, these features make SQL Server 2025 a strong platform for semantic search, recommendations, and context-aware analytics without relying on external compute pipelines.
