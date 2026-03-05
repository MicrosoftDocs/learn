Azure Managed Redis supports standard Redis commands for data operations. This unit covers how to use the **redis** Python library to store and retrieve data, set expiration times, and manage cache invalidation. 

Redis supports multiple data types beyond simple strings, each optimized for different use cases. Understanding these data structures helps you choose the right approach for storing and retrieving your application data.

| Data type | Operations |
|--|--|
| String operations | String operations (`SET`, `GET`, `MSET`, `MGET`) work with text or serialized data. When you use `decode_responses=True` in your connection, Redis automatically converts byte responses to strings, making it easier to work with text data. For binary data like images or pickled Python objects, set `decode_responses=False` to work with raw bytes. |
| Hash operations | Redis Hashes store objects as field-value pairs within a single key, ideal for representing structured data like user profiles or product details. Use `HSET` to store fields, `HGET` to retrieve individual fields, and `HGETALL` to get all fields at once. Hashes are more memory-efficient than storing each field as a separate key. |
| List operations | Redis Lists are ordered collections of strings, perfect for queues, activity feeds, or recent items. Use `LPUSH`/`RPUSH` to add items to either end, `LPOP`/`RPOP` to remove and return items, and `LRANGE` to retrieve ranges. Lists support both stack (LIFO) and queue (FIFO) patterns. |
| Numeric operations | Redis provides atomic increment and decrement operations (`INCR`, `DECR`, `INCRBY`, `DECRBY`) that work on numeric string values. These operations are atomic, making them ideal for counters, rate limiting, and distributed counting scenarios without race conditions. Even though the values are stored as strings, Redis treats them as integers for these operations. |

## Connect to Azure Managed Redis with the redis-py library

Before performing data operations, establish a connection to your Azure Managed Redis instance. The `redis-py` library supports both synchronous and asynchronous operations. 

Azure Cache for Redis and Azure Managed Redis both use the same libraries for application development. However, they have different default connection ports:

- Ports for Azure Managed Redis and Enterprise caches: 10000
- Ports for Azure Cache for Redis instances: 6380

> [!NOTE]
> The clustering policy chosen for an Azure Managed Redis instance impacts the connection method. The following examples work with Enterprise clustering and non-clustered configurations. If you're working with an instance using OSS clustering policy, you need to use `redis.cluster.RedisCluster` instead of `redis.Redis` for your connection.

```python
import redis

# Create a Redis client
r = redis.Redis(
    host='your-redis-instance',
    port=10000,
    ssl=True,
    decode_responses=True,  # Convert byte responses to strings automatically
    password='your-access-key'
)
```

For production environments, consider using Microsoft Entra ID authentication with the `redis-entraid` package for enhanced security.

```python
import redis
from azure.identity import DefaultAzureCredential
from redis_entraid.cred_provider import create_from_default_azure_credential

# Create credential provider using DefaultAzureCredential
credential_provider = create_from_default_azure_credential(
    ("https://redis.azure.com/.default",),
)

# Create a Redis client with Azure Entra ID authentication
r = redis.Redis(
    host='your-redis-instance',
    port=10000,
    ssl=True,
    decode_responses=True,  # Convert byte responses to strings automatically
    credential_provider=credential_provider
)
```

> [!NOTE]
> All of the remaining code examples in this unit assume a Redis connection is in place. For example, in `r.set('user:1001:name', 'Alice Smith')` the "r" represents the connection. 

## Basic data operations

Redis provides simple yet powerful commands for storing, retrieving, and managing key-value data. 

### Set and Get operations

The most fundamental operations in Redis are storing and retrieving string values using `SET` and `GET` commands.

```python
# Store a value
result = r.set('user:1001:name', 'Alice Smith')
print(f"SET operation successful: {result}")  # Returns True

# Retrieve the value
name = r.get('user:1001:name')
print(f"Retrieved name: {name}")  # Output: Alice Smith
```

Hashes store multiple field-value pairs within a single key, making them ideal for structured data like user profiles or cached model results.

```python
# Store multiple fields in a hash
r.hset('user:1001', mapping={
    'name': 'Alice Smith',
    'email': 'alice@example.com',
    'age': '28'
})

# Retrieve a single field
name = r.hget('user:1001', 'name')
print(f"Name: {name}")  # Output: Alice Smith

# Retrieve all fields
user_data = r.hgetall('user:1001')
print(f"User data: {user_data}")  # Returns dict with all fields
```

### Multiple key operations

When you need to work with multiple string keys simultaneously, use `MSET` and `MGET` for better performance.

```python
# Set multiple keys at once
r.mset({
    'user:1001:name': 'Alice Smith',
    'user:1001:email': 'alice@example.com',
    'user:1001:age': '28'
})

# Get multiple values at once
values = r.mget('user:1001:name', 'user:1001:email', 'user:1001:age')
print(f"User data: {values}")  # Returns list of values
```

For Hash operations, multiple key operations would involve working with multiple Hash keys (not multiple fields within one Hash).

```python
# Using pipeline for multiple hash operations (efficient)
pipe = r.pipeline()
pipe.hgetall('user:1001')
pipe.hgetall('user:1002')
results = pipe.execute()
# Returns list of dicts, one for each hash

# Or retrieve specific fields from multiple hashes
pipe = r.pipeline()
pipe.hget('user:1001', 'name')
pipe.hget('user:1002', 'name')
names = pipe.execute()
# Returns list of names: ['Alice Smith', 'Bob Jones', 'Carol White']
```

### Check key existence

Before attempting to retrieve or update data, verify whether a key exists. The `EXISTS` command works with all Redis data types because it checks for the presence of a key, not the type of data it contains.

```python
# Check if a key exists
if r.exists('user:1001:name'):
    print("Key exists")
    
# Check multiple keys
count = r.exists('user:1001:name', 'user:1001:email', 'user:9999:name')
print(f"Number of existing keys: {count}")  # Returns 2
```

### Delete operations

Remove keys from the cache when data is no longer needed or becomes stale. The `DELETE` command works with all Redis data types, removing the entire key and its associated data.

```python
# Delete a single key
result = r.delete('user:1001:name')
print(f"Keys deleted: {result}")  # Returns count of deleted keys

# Delete multiple keys
result = r.delete('user:1001:email', 'user:1001:age')
print(f"Keys deleted: {result}")
```

## Working with expiration

Setting expiration times on keys is crucial for automatic cache invalidation and memory management. Expiration commands (`EXPIRE`, `SETEX`, `TTL`, etc.) work with all Redis data types because they operate on keys, not values.

### Set value with expiration

Use `SETEX` to set a string value and expiration time in a single atomic operation. For other data types like Hashes or Lists, set the data first, then use `EXPIRE` to add expiration.

```python
# Set a key with 60-second expiration
r.setex('session:abc123', 60, 'user_data')

# Alternative: Set value with expiration in milliseconds
r.psetex('temp:data', 5000, 'temporary_value')  # Expires in 5000ms
```

### Add expiration to existing keys

Apply expiration to keys that already exist in the cache. These commands (`EXPIRE`, `PEXPIRE`, `EXPIREAT`) work with all Redis data types.

```python
# Set a key without expiration
r.set('user:1002:preferences', 'dark_mode')

# Add 3600-second (1 hour) expiration
r.expire('user:1002:preferences', 3600)

# Set expiration in milliseconds
r.pexpire('user:1002:preferences', 3600000)

# Set expiration at specific Unix timestamp
import time
expire_at = int(time.time()) + 7200  # 2 hours from now
r.expireat('user:1002:preferences', expire_at)
```

### Check and manage TTL

Monitor the time-to-live (TTL) of keys to understand when they expire. These commands (`TTL`, `PTTL`, `PERSIST`) work with all Redis data types since they query or modify key-level expiration settings.

```python
# Get TTL in seconds
ttl = r.ttl('user:1002:preferences')
if ttl == -1:
    print("Key exists but has no expiration")
elif ttl == -2:
    print("Key does not exist")
else:
    print(f"Key expires in {ttl} seconds")

# Get TTL in milliseconds
ttl_ms = r.pttl('user:1002:preferences')
print(f"Key expires in {ttl_ms} milliseconds")

# Remove expiration (persist the key)
r.persist('user:1002:preferences')
```

## Cache invalidation patterns

Effective cache invalidation ensures your application serves fresh data while maintaining optimal performance. These patterns work with all Redis data types.

### Time-based invalidation

The simplest approach uses TTL to automatically expire cached data after a set period.

```python
def cache_database_query(query_key, query_function, ttl=300):
    """
    Cache database query results with automatic expiration.
    
    Args:
        query_key: Cache key for the query
        query_function: Function that executes the database query
        ttl: Time to live in seconds (default: 5 minutes)
    """
    # Check if result is cached
    cached_result = r.get(query_key)
    if cached_result:
        print("Cache hit")
        return cached_result
    
    # Execute query and cache result
    print("Cache miss - executing query")
    result = query_function()
    r.setex(query_key, ttl, result)
    return result

# Usage example
def get_product_details():
    # Simulate database query
    return "Product: Laptop, Price: $999"

product_data = cache_database_query('product:12345', get_product_details, ttl=600)
```

### Manual invalidation on update

When data changes, explicitly remove or update the cached version to maintain consistency.

```python
def update_user_profile(user_id, new_data):
    """
    Update user profile and invalidate related cache entries.
    """
    # Update database (simulated)
    save_to_database(user_id, new_data)
    
    # Invalidate all related cache keys
    cache_keys = [
        f'user:{user_id}:profile',
        f'user:{user_id}:summary',
        f'dashboard:user:{user_id}'
    ]
    deleted = r.delete(*cache_keys)
    print(f"Invalidated {deleted} cache entries")

def save_to_database(user_id, data):
    # Placeholder for database operation
    pass
```

### Cache-aside pattern with expiration

Implement the cache-aside (lazy loading) pattern with automatic expiration for optimal cache usage.

```python
def get_user_data(user_id, ttl=3600):
    """
    Retrieve user data using cache-aside pattern.
    
    Args:
        user_id: User identifier
        ttl: Cache expiration in seconds (default: 1 hour)
    """
    cache_key = f'user:{user_id}:data'
    
    # Try to get from cache
    cached_data = r.get(cache_key)
    if cached_data:
        return cached_data
    
    # Cache miss - fetch from database
    user_data = fetch_from_database(user_id)
    
    # Store in cache with expiration
    if user_data:
        r.setex(cache_key, ttl, user_data)
    
    return user_data

def fetch_from_database(user_id):
    # Placeholder for database query
    return f"User data for {user_id}"
```

### Pattern-based invalidation

Delete multiple related keys using pattern matching with the `SCAN` command (not `KEYS`, which blocks the server).

```python
def invalidate_user_cache(user_id):
    """
    Invalidate all cache entries for a specific user.
    Uses SCAN for non-blocking pattern matching.
    """
    pattern = f'user:{user_id}:*'
    cursor = 0
    deleted_count = 0
    
    while True:
        cursor, keys = r.scan(cursor, match=pattern, count=100)
        if keys:
            deleted_count += r.delete(*keys)
        if cursor == 0:
            break
    
    print(f"Invalidated {deleted_count} keys for user {user_id}")

# Usage
invalidate_user_cache(1001)
```

## Best practices for data operations

Following these practices ensures your Redis implementation is robust, performant, and maintainable.

- **Use connection pooling:** The `redis` library automatically uses connection pooling, but you can configure it for optimal performance. For more information, visit [Connection pools and multiplexing](https://redis.io/docs/latest/develop/clients/pools-and-muxing/).
- **Handle errors gracefully:** Always implement error handling for Redis operations to ensure application resilience.
- **Choose appropriate TTL values:** Select expiration times based on your data's characteristics and freshness requirements:
    - Frequently changing data: 1-5 minutes
    - Moderate change rate: 15-60 minutes
    - Relatively stable data: 1-24 hours
    - Static reference data: 24+ hours

Consider your application's requirements for data freshness versus cache hit rates when determining TTL values.
