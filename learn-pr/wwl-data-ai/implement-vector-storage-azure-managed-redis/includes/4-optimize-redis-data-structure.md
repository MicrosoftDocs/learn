Choosing between Redis Hash and JSON data structures affects memory usage, performance, and how you work with your vector data. Understanding the tradeoffs helps you optimize for your application's needs.

Imagine you're building a product catalog with vector embeddings for similarity search. Each product has a name, price, category, and a 1536-dimensional embedding. If your data is simple and flat, Redis Hash stores it compactly with minimal overhead—just the fields you need. But if products have nested attributes (like multiple images, variant SKUs, or hierarchical categories), JSON lets you store complex structures naturally while still supporting vector search. Choosing the right structure ensures your system is both performant and maintainable.

## Using Redis Hash for vectors

Redis Hash is a data structure that stores information as field-value pairs within a single key, similar to a dictionary or map in programming languages. When you use Hash for vector storage, your embedding becomes one field (stored as binary bytes) alongside other fields like product name, price, or category—all under one Redis key like `product:12345`. This flat structure means Hash excels at performance and memory efficiency because it stores only the exact fields you define, with minimal formatting overhead. For vector search applications with straightforward metadata, Hash provides the fastest queries and smallest memory footprint. Use Hash when you have flat data models with no nested objects, need maximum query performance, or prioritize memory efficiency.

### Storing vectors in Hash

Store your vector as bytes in a hash field alongside other metadata:

```python
# Code fragment - focus on Hash storage
import numpy as np

embedding = np.array([0.1, 0.2, 0.3, ...], dtype=np.float32)

redis_client.hset(
    "product:12345",
    mapping={
        "name": "Wireless Mouse",
        "price": "29.99",
        "category": "electronics",
        "embedding": embedding.tobytes()  # Store vector as bytes
    }
)
```

The vector is stored as a binary blob in the `embedding` field. This approach minimizes memory overhead—you only store what you need.

### Creating an index for Hash-based vectors

Define your index to search Hash keys with a vector field:

```python
# Code fragment - focus on Hash index
from redis.commands.search.field import TextField, NumericField, VectorField
from redis.commands.search.indexDefinition import IndexDefinition, IndexType

schema = (
    TextField("name"),
    NumericField("price"),
    TextField("category"),
    VectorField("embedding", "HNSW", {
        "TYPE": "FLOAT32",
        "DIM": 1536,
        "DISTANCE_METRIC": "COSINE"
    })
)

redis_client.ft("idx:products").create_index(
    fields=schema,
    definition=IndexDefinition(
        prefix=["product:"],
        index_type=IndexType.HASH
    )
)
```

## Using Redis JSON for vectors

Redis JSON stores data as JSON documents, allowing you to organize information hierarchically with nested objects and arrays. Unlike Hash's flat field-value pairs, JSON lets you structure complex data naturally—for example, a product can have an array of images, nested specifications, or variant details, all in one document. When you use JSON for vector storage, your embedding is stored as a numeric array `[0.1, 0.2, 0.3, ...]` alongside other fields that can be as complex as your application needs. This flexibility comes with slightly higher memory overhead and query time compared to Hash.

### Storing vectors in JSON

When storing vectors in JSON, you convert your NumPy array to a Python list using `tolist()`, which creates a JSON-compatible numeric array. This array format allows Redis to parse and index the vector while keeping your document flexible enough to include nested objects and complex metadata structures:

```python
# Code fragment - focus on JSON storage
import redis.commands.json as json_commands

document = {
    "name": "Wireless Mouse",
    "price": 29.99,
    "category": "electronics",
    "embedding": embedding.tolist(),  # Convert to list for JSON
    "specs": {
        "color": "black",
        "wireless": True,
        "battery": "AA"
    }
}

redis_client.json().set("product:12345", "$", document)
```

The vector is stored as a JSON array `[0.1, 0.2, 0.3, ...]`. This format supports nested objects like `specs` naturally.

### Creating an index for JSON-based vectors

Define your index to search JSON documents with a vector field. Use JSON when your data has nested structures, you need multiple vectors per document, your application already uses JSON format, or you need JSON query capabilities:

```python
# Code fragment - focus on JSON index
from redis.commands.search.field import TextField, NumericField, VectorField
from redis.commands.search.indexDefinition import IndexDefinition, IndexType

schema = (
    TextField("$.name", as_name="name"),
    NumericField("$.price", as_name="price"),
    TextField("$.category", as_name="category"),
    VectorField("$.embedding", "HNSW", {
        "TYPE": "FLOAT32",
        "DIM": 1536,
        "DISTANCE_METRIC": "COSINE"
    }, as_name="embedding")
)

redis_client.ft("idx:products").create_index(
    fields=schema,
    definition=IndexDefinition(
        prefix=["product:"],
        index_type=IndexType.JSON
    )
)
```

Note the `$.` JSONPath syntax for field names and the `as_name` parameter for query references.

## Comparing Hash and JSON

Choose based on your data complexity and performance requirements:

| Factor | Hash | JSON |
|--------|------|------|
| Memory usage | Lower (binary vector storage) | Higher (JSON array format) |
| Query performance | Faster | Slightly slower |
| Data complexity | Flat fields only | Nested objects supported |
| Vector storage | Binary bytes | Numeric array |
| Best for | Simple records, max performance | Complex documents, flexibility |

### Performance considerations

Hash storage is faster and uses less memory because vectors are stored as compact binary blobs. JSON storage adds overhead for the array structure but offers more flexibility:

```python
# Code fragment - focus on storage comparison

# Hash: 1536 floats × 4 bytes = 6,144 bytes for vector
hash_vector = embedding.tobytes()  # 6,144 bytes

# JSON: Similar data size but with JSON formatting overhead
json_vector = embedding.tolist()  # 6,144 bytes + JSON structure
```

For 1 million products with 1536-dimensional vectors, Hash saves significant memory and improves query latency.

### Switching between Hash and JSON

You can change your data structure by re-ingesting data with a new index:

```python
# Code fragment - focus on migration approach

# Read from Hash
hash_data = redis_client.hgetall("product:12345")

# Convert to JSON
document = {
    "name": hash_data["name"],
    "price": float(hash_data["price"]),
    "category": hash_data["category"],
    "embedding": np.frombuffer(hash_data["embedding"], dtype=np.float32).tolist()
}

# Store as JSON
redis_client.json().set("product:12345", "$", document)
```

Delete the old index and create a new one with the appropriate `IndexType` for your new structure.

## Quick decision guide

Use this guide to choose your data structure:

**Choose Hash when:**
- Each item has simple, flat fields
- You prioritize memory efficiency
- You need maximum query speed
- Your data model won't need nested objects

**Choose JSON when:**
- Your data has nested structures
- You need to store multiple vectors per item
- Your application already uses JSON
- Flexibility is more important than raw performance

For most vector search applications with simple metadata, Hash provides the best balance of performance and simplicity. Use JSON when your data complexity requires it.

## Additional resources

- [Redis Hash Commands](https://redis.io/docs/latest/develop/data-types/hashes/) - Working with Redis Hash data type
- [Redis JSON Documentation](https://redis.io/docs/latest/develop/data-types/json/) - Using JSON in Redis
- [Indexing JSON Documents](https://redis.io/docs/latest/develop/interact/search-and-query/indexing/#index-json-documents) - Creating indexes for JSON data
