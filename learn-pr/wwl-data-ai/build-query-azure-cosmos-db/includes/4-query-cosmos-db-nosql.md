Azure Cosmos DB for NoSQL supports a SQL-like query language optimized for JSON documents. While point reads provide the most efficient access to individual items, queries enable flexible data retrieval based on filter criteria, projections, and sorting. AI applications use queries to fetch batches of training data, retrieve items matching specific attributes, and aggregate statistics from document collections. Understanding query syntax and optimization techniques helps you balance retrieval flexibility with cost efficiency.

## Write basic SELECT queries

The query language uses familiar SQL syntax extended for JSON document structures. Queries operate on a single container, using the `FROM` clause to reference the container and aliases to access item properties. The `SELECT` clause specifies which properties to return, while `WHERE` filters results based on conditions.

A basic query that retrieves all items returns the complete JSON structure for each document. Use an alias (commonly `c` for container) after the `FROM` clause to reference item properties throughout the query. The asterisk (`*`) in the `SELECT` clause returns all properties.

```sql
SELECT * FROM products p
```

Projecting specific properties reduces response size and can lower RU consumption by returning only the data your application needs. List the properties you want in the `SELECT` clause, using the alias to reference nested paths. Projection is valuable for AI applications that need only a subset of fields for inference.

```sql
SELECT p.id, p.name, p.price, p.categoryId
FROM products p
```

The query iterator handles executing queries and processing results. You can iterate through results directly or use pagination for large result sets. Each iteration fetches items from Azure Cosmos DB and might make multiple round trips for queries that return many results.

```python
# Code fragment - focus on basic query execution
query = "SELECT p.id, p.name, p.price FROM products p"

items = container.query_items(query=query, enable_cross_partition_query=True)

for item in items:
    print(f"{item['name']}: ${item['price']}")
```

## Filter results with WHERE clauses

The `WHERE` clause filters items based on conditions involving their properties. You can use comparison operators (`=`, `!=`, `<`, `>`, `<=`, `>=`), logical operators (`AND`, `OR`, `NOT`), and various built-in functions. Filters evaluate against each item, returning only those items where the condition evaluates to true.

Comparison operators work with numbers, strings, booleans, and null values. String comparisons are case-sensitive by default. You can combine multiple conditions with `AND` and `OR` to create complex filters.

```sql
SELECT * FROM products p
WHERE p.categoryId = "electronics" AND p.price < 500
```

String functions enable pattern matching and text manipulation within filters. `CONTAINS` checks if a string contains a substring, `STARTSWITH` and `ENDSWITH` check prefixes and suffixes, and `UPPER`/`LOWER` enable case-insensitive comparisons.

```sql
SELECT * FROM products p
WHERE CONTAINS(p.name, "Speaker") AND p.price BETWEEN 50 AND 200
```

The `IN` operator checks if a value matches any item in a list, useful for filtering by multiple categories or statuses. Negating with `NOT IN` excludes specific values.

```sql
SELECT * FROM products p
WHERE p.categoryId IN ("electronics", "appliances", "computers")
```

## Use parameterized queries

Parameterized queries separate the query structure from the values, preventing injection attacks and enabling query plan caching. Parameters use the `@parameterName` syntax in the query text, with values provided separately through a parameters array. The SDK substitutes parameter values safely at execution time.

Always use parameters for values that come from user input or external sources. Beyond security benefits, parameterized queries allow Azure Cosmos DB to cache and reuse query plans, improving performance for repeated queries with different values.

```python
# Code fragment - focus on parameterized query for security
query = """
    SELECT * FROM products p
    WHERE p.categoryId = @category AND p.price < @maxPrice
"""

parameters = [
    {"name": "@category", "value": "electronics"},
    {"name": "@maxPrice", "value": 500.00}
]

items = container.query_items(
    query=query,
    parameters=parameters,
    enable_cross_partition_query=True
)
```

## Optimize with single-partition queries

Query performance depends significantly on whether the query targets a single partition or requires scanning multiple partitions. Single-partition queries include the partition key in the `WHERE` clause or explicitly specify the `partition_key` parameter. Cross-partition queries fan out to all partitions, consuming more RUs and increasing latency.

When you include the partition key in your query, Azure Cosmos DB routes the request directly to the correct partition. This routing eliminates the overhead of querying multiple partitions and aggregating results. For AI applications with partition-aligned data, always design queries to include the partition key when possible.

```python
# Code fragment - focus on single-partition routing
query = """
    SELECT * FROM products p
    WHERE p.categoryId = @category AND p.price < @maxPrice
"""

parameters = [
    {"name": "@category", "value": "electronics"},
    {"name": "@maxPrice", "value": 500.00}
]

# Method 1: Specify partition key explicitly
items = container.query_items(
    query=query,
    parameters=parameters,
    partition_key="electronics"  # Routes to single partition
)

# Method 2: Include partition key in WHERE clause
# The query above includes categoryId (our partition key)
# If enable_cross_partition_query is False, it routes to that partition
```

Cross-partition queries become necessary when you need to query across all data or when filter criteria don't include the partition key. Set `enable_cross_partition_query=True` to allow these queries. Monitor RU consumption for cross-partition queries, as they typically cost more than single-partition equivalents.

## Sort and paginate results

The `ORDER BY` clause sorts results by one or more properties. You can specify ascending (`ASC`, the default) or descending (`DESC`) order. Sorting adds overhead to query execution, particularly for cross-partition queries that must merge sorted results from multiple partitions.

```sql
SELECT * FROM products p
WHERE p.categoryId = "electronics"
ORDER BY p.price DESC
```

For large result sets, implement pagination to retrieve results in manageable chunks. The SDK's query iterator handles pagination automatically through continuation tokens. Set `max_item_count` to control the page size, balancing between fewer round trips (larger pages) and lower memory consumption (smaller pages).

```python
# Code fragment - focus on pagination handling
query = "SELECT * FROM products p WHERE p.categoryId = @category ORDER BY p.price"

query_iterable = container.query_items(
    query=query,
    parameters=[{"name": "@category", "value": "electronics"}],
    partition_key="electronics",
    max_item_count=50  # Items per page
)

# Iterate through pages
for page in query_iterable.by_page():
    for item in page:
        process_item(item)

    # If you build a web API, return the SDK's continuation token
    # (when available) so clients can request the next page.
```

For web APIs that expose pagination to clients, extract and return continuation tokens, allowing clients to request subsequent pages. Store the continuation token securely, as it encodes internal query state.

## Shape results with projections

Projections transform query results into custom JSON structures. Beyond selecting specific properties, you can rename properties, compute derived values, and create nested objects. The `VALUE` keyword returns scalar values or arrays instead of wrapping results in objects.

Create custom result shapes by defining the structure in the `SELECT` clause. This approach reduces post-processing in your application code and can reduce data transfer when the transformed shape is smaller than the original documents.

```python
# Code fragment - focus on projection and shaping
query = """
    SELECT VALUE {
        "productId": p.id,
        "productName": p.name,
        "currentPrice": p.price,
        "isAvailable": p.quantity > 0,
        "category": p.categoryId
    }
    FROM products p
    WHERE p.categoryId = @category
"""

items = container.query_items(
    query=query,
    parameters=[{"name": "@category", "value": "electronics"}],
    partition_key="electronics"
)

# Results come as flat objects with renamed properties
for item in items:
    print(f"{item['productName']}: ${item['currentPrice']}")
```

The `VALUE` keyword extracts values without the surrounding object structure. Use it to return arrays of scalar values or to unwrap nested results.

```sql
-- Returns: ["Smart Speaker", "Wireless Headphones", "Laptop"]
SELECT VALUE p.name
FROM products p
WHERE p.categoryId = "electronics"
```

## Calculate aggregates

Aggregate functions compute summary statistics across matching items. Azure Cosmos DB supports `COUNT`, `SUM`, `AVG`, `MIN`, and `MAX`. Aggregates scan all matching items, so they can be expensive on large datasets. Use filters to limit the scope of aggregation when possible.

```sql
SELECT VALUE COUNT(1)
FROM products p
WHERE p.categoryId = "electronics"
```

Combine multiple aggregates in a single query to gather statistics efficiently. Each aggregate function operates independently across the filtered result set.

```python
# Code fragment - focus on aggregate queries
query = """
    SELECT
        COUNT(1) as totalProducts,
        AVG(p.price) as averagePrice,
        MIN(p.price) as minPrice,
        MAX(p.price) as maxPrice
    FROM products p
    WHERE p.categoryId = @category
"""

items = list(container.query_items(
    query=query,
    parameters=[{"name": "@category", "value": "electronics"}],
    partition_key="electronics"
))

stats = items[0]
print(f"Products: {stats['totalProducts']}, Avg Price: ${stats['averagePrice']:.2f}")
```

## Query arrays within documents

Azure Cosmos DB documents often contain arrays representing one-to-many relationships, such as product tags, user roles, or feature lists. The `ARRAY_CONTAINS` function filters items based on array membership, checking if an array property contains a specific value.

```sql
SELECT * FROM products p
WHERE ARRAY_CONTAINS(p.features, "wifi")
```

For more complex array queries, use `JOIN` with the `IN` operator to flatten arrays and query individual elements. The join creates a cross product between the item and its array elements, allowing you to filter based on array contents.

```sql
SELECT p.name, f AS feature
FROM products p
JOIN f IN p.features
WHERE f IN ("wifi", "bluetooth")
```

## Monitor query costs

Every query returns RU consumption in the response headers. Monitor these values to understand which queries consume the most resources and identify optimization opportunities. High RU queries might benefit from adding indexes, restricting filters, or redesigning data models.

```python
# Code fragment - focus on monitoring query costs
query = "SELECT * FROM products p WHERE p.categoryId = @category"

query_iterable = container.query_items(
    query=query,
    parameters=[{"name": "@category", "value": "electronics"}],
    partition_key="electronics"
)

total_rus = 0
item_count = 0

for page in query_iterable.by_page():
    headers = container.client_connection.last_response_headers or {}
    page_rus = float(headers.get('x-ms-request-charge', 0))
    total_rus += page_rus

    for item in page:
        item_count += 1
        process_item(item)

print(f"Query returned {item_count} items, consuming {total_rus:.2f} RUs")
```

Query cost optimization strategies include:

- **Filter early:** Apply filters that reduce the result set as much as possible
- **Project needed fields:** Return only properties your application uses
- **Use partition keys:** Route queries to single partitions when possible
- **Limit results:** Use `TOP` to restrict result count when you don't need all matches
- **Optimize indexes:** Ensure your indexing policy supports your query patterns

## Additional resources

- [Getting started with SQL queries in Azure Cosmos DB](/azure/cosmos-db/nosql/query/getting-started)
- [Parameterized queries in Azure Cosmos DB](/azure/cosmos-db/nosql/query/parameterized-queries)
- [Pagination in Azure Cosmos DB](/azure/cosmos-db/nosql/query/pagination)
