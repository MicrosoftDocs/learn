Vector embeddings transform text, images, and other content into numerical representations that capture semantic meaning. Azure Database for PostgreSQL supports storing and querying these embeddings through the pgvector extension, allowing you to add vector search capabilities to your existing PostgreSQL database without managing a separate vector store.

This unit covers enabling the pgvector extension, designing schemas for vector storage, inserting and updating embeddings, and performing basic similarity queries. These foundational operations form the basis for building semantic search and retrieval features in your AI applications.

## Enable the pgvector extension

The pgvector extension adds vector data types and similarity search operators to PostgreSQL. Before you can store embeddings, you must enable the extension in your database. Azure Database for PostgreSQL includes pgvector as one of the supported extensions, making it available without additional installation.

To enable pgvector, connect to your database and run the `CREATE EXTENSION` command. You need the appropriate permissions to create extensions, typically granted to the server administrator or users with the `azure_pg_admin` role.

```sql
CREATE EXTENSION IF NOT EXISTS vector;
```

After enabling the extension, you can verify it's available by querying the installed extensions:

```sql
SELECT * FROM pg_extension WHERE extname = 'vector';
```

The pgvector extension introduces the `vector` data type, which stores embeddings as arrays of single-precision floating-point numbers. Each vector has a fixed number of dimensions that you specify when creating a column. The extension also provides operators for calculating distances between vectors and index types for fast similarity search.

## Design schemas for vector storage

Effective schema design for vector storage combines embeddings with the metadata your application needs for filtering and display. When you define a vector column, you specify the number of dimensions using the `vector(n)` syntax, where `n` must match the output dimension of your embedding model.

Common embedding dimensions vary by model. Sentence transformer models typically produce 384-dimensional vectors. OpenAI's text-embedding-ada-002 model outputs 1,536 dimensions, while text-embedding-3-large can produce up to 3,072 dimensions. Using the wrong dimension count causes insertion errors, so verify your model's output dimension before creating tables.

The following example creates a table that stores legal documents with embeddings alongside metadata useful for filtering and display:

```sql
CREATE TABLE documents (
    id SERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    content TEXT,
    category TEXT,
    practice_area TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    embedding vector(1536)
);
```

This schema stores the document embedding in the same row as its metadata. This approach simplifies queries because you don't need joins to retrieve both the similar documents and their details. For large content fields, consider storing the full text in a separate table and keeping only summaries or titles in the main table to reduce the data transferred during similarity searches.

When designing for multiple embedding models or embedding different content types (such as titles versus full content), you can add multiple vector columns:

```sql
CREATE TABLE documents (
    id SERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    content TEXT,
    title_embedding vector(384),
    content_embedding vector(1536)
);
```

## Insert and update embeddings

After creating your schema, you insert embeddings using standard SQL `INSERT` statements. Vectors are represented as string literals in array format and cast to the `vector` type. Your application code generates the embedding using an embedding API (such as Azure OpenAI) and passes it to the database as a parameter.

```sql
INSERT INTO documents (title, content, category, practice_area, embedding)
VALUES (
    'Corporate Merger Agreement Template',
    'This agreement outlines the terms and conditions for the merger of...',
    'contracts',
    'corporate',
    '[0.0123, -0.0456, 0.0789, -0.0321, ...]'::vector
);
```

For batch insertions when loading large datasets, use multi-row `INSERT` statements or the `COPY` command for better performance:

```sql
INSERT INTO documents (title, content, category, embedding)
VALUES
    ('Document 1', 'Content...', 'legal', '[...]'::vector),
    ('Document 2', 'Content...', 'legal', '[...]'::vector),
    ('Document 3', 'Content...', 'legal', '[...]'::vector);
```

When document content changes, update the embedding to reflect the new semantic meaning:

```sql
UPDATE documents
SET content = 'Updated document content...',
    embedding = '[0.0234, -0.0567, ...]'::vector,
    updated_at = NOW()
WHERE id = 42;
```

For applications with frequent updates, consider batching embedding regeneration during off-peak hours rather than updating embeddings synchronously with content changes. This approach reduces latency for content updates and consolidates calls to the embedding API.

## Query vectors with distance operators

The pgvector extension provides three distance operators for measuring similarity between vectors. Each operator calculates a different type of distance, and choosing the right one depends on your embedding model and use case.

**L2 distance (Euclidean distance)** measures the straight-line distance between two vectors in the embedding space. Use the `<->` operator for L2 distance. Smaller values indicate more similar vectors. This metric works well when the magnitude of vectors carries meaning.

```sql
SELECT id, title, embedding <-> '[0.0123, -0.0456, ...]'::vector AS distance
FROM documents
ORDER BY distance
LIMIT 10;
```

**Cosine distance** measures the angle between two vectors, ignoring their magnitudes. Use the `<=>` operator for cosine distance. Values range from 0 (identical direction) to 2 (opposite directions). Cosine distance is the most common choice for text embeddings because it focuses on the direction of meaning rather than the length of the vector.

```sql
SELECT id, title, embedding <=> '[0.0123, -0.0456, ...]'::vector AS distance
FROM documents
ORDER BY distance
LIMIT 10;
```

**Negative inner product** calculates the dot product of two vectors and negates it. Use the `<#>` operator. This metric is useful for maximum inner product search, where larger dot products indicate more similar vectors. The negation converts it to a distance where smaller values are better, matching the behavior of the other operators.

```sql
SELECT id, title, embedding <#> '[0.0123, -0.0456, ...]'::vector AS distance
FROM documents
ORDER BY distance
LIMIT 10;
```

Most embedding models, including OpenAI's embeddings, are optimized for cosine similarity. Check your embedding model's documentation to confirm which distance metric it recommends.

## Vector data types and precision

The pgvector extension offers three data types for storing vectors, each with different storage and performance characteristics.

The **vector** type stores elements as single-precision (32-bit) floating-point numbers. This is the standard type for most use cases and provides a good balance of precision and storage efficiency. A 1536-dimensional vector uses approximately 6 KB of storage.

The **halfvec** type stores elements as half-precision (16-bit) floating-point numbers. This type reduces storage by half compared to `vector` while maintaining sufficient precision for most similarity search tasks. Use `halfvec` when storage is a concern and you verified that reduced precision doesn't significantly impact your search quality.

```sql
CREATE TABLE documents_compact (
    id SERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    embedding halfvec(1536)
);
```

The **sparsevec** type stores sparse vectors where most elements are zero. Instead of storing all dimensions, it stores only the nonzero values and their positions. This type is useful for models that produce sparse embeddings, such as certain document representations. Specify the maximum dimension count when creating the column.

```sql
CREATE TABLE sparse_documents (
    id SERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    embedding sparsevec(10000)
);
```

> [!NOTE]
> HNSW indexes on `sparsevec` columns support up to 1,000 non-zero elements. If your sparse vectors exceed this limit, consider dimensionality reduction or alternative indexing strategies.

For most AI applications using dense embeddings from models like OpenAI or sentence transformers, use the standard `vector` type. Consider `halfvec` only after benchmarking confirms that half-precision provides acceptable search quality for your specific use case.
