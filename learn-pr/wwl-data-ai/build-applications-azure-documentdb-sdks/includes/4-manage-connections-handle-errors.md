Writing queries is only part of building a production application. You also need to manage how your application opens and closes database connections, handle errors when operations fail, and protect sensitive credentials like your connection string. These operational concerns are what separate a prototype from production-ready code.

In this unit, you learn how MongoDB drivers manage connection pools, how to handle common error types in each language, and how to secure your connection string using environment variables.

## Connection lifecycle and pooling

MongoDB drivers maintain a pool of connections to the database. Instead of opening and closing a connection for every operation, the driver reuses connections from the pool. This approach reduces latency and avoids the overhead of Transport Layer Security (TLS) handshakes on every request.

The key principle is: **create one client instance and reuse it throughout your application's lifetime**. Don't create a new client for each request.

::: zone pivot="python"

PyMongo's `MongoClient` manages a connection pool internally. The pool size is configurable via the `maxPoolSize` parameter. The default works well for most applications; see the [PyMongo documentation](https://pymongo.readthedocs.io/en/stable/faq.html) for tuning guidance.

```python
# Create once at application startup
client = MongoClient(connection_string)

# Reuse across your application
db = client["cosmicworks"]

# Close when the application shuts down
client.close()
```

::: zone-end

::: zone pivot="csharp"

In .NET applications, register the `MongoClient` as a singleton in your dependency injection container. The driver handles connection pooling internally. `MongoClient` implements `IDisposable`, so you can call `Dispose()` when your application shuts down.

```csharp
// Create once at application startup (register as singleton in DI)
var client = new MongoClient(settings);

// Reuse across your application
var db = client.GetDatabase("cosmicworks");

// Dispose when the application shuts down
client.Dispose();
```

::: zone-end

::: zone pivot="node"

The Node.js driver maintains a connection pool per `MongoClient` instance. Calling `close()` drains the pool and releases all connections.

```javascript
// Create once at application startup
const client = new MongoClient(connectionString);
await client.connect();

// Reuse across your application
const db = client.db('cosmicworks');

// Close when the application shuts down
await client.close();
```

::: zone-end

## Handle errors

Database operations can fail for several reasons: network timeouts, authentication failures, duplicate key violations, or server-side errors. Your application should handle these errors gracefully instead of crashing.

The most common error categories are:

| Error type | Common cause | How to handle |
|---|---|---|
| Connection failure | Wrong connection string, firewall blocking access, cluster unavailable | Check connection string and firewall rules. Retry with exponential backoff. |
| Authentication error | Wrong username or password | Verify credentials. Check that the user exists on the cluster. |
| Duplicate key | Inserting a document with an `_id` or unique indexed field that already exists | Use upsert operations, or catch the error and handle the conflict. |
| Timeout | Operation takes longer than the configured timeout | Optimize the query. Add an index. Increase the timeout if the operation is expected to be slow. |

To handle these errors, wrap your database operations in a `try`/`catch` block (`try`/`except` in Python). The code inside the `try` block runs your operation. If that operation raises an error, execution jumps to the matching `catch` or `except` block, where you can log the problem, retry the operation, or return a meaningful message to the user. This pattern prevents a single failed operation from crashing your entire application. As a best practice, wrap every database call in a `try`/`catch` block so your application can recover gracefully, provide useful feedback to the user, and continue processing other requests without crashing.

::: zone pivot="python"

```python
# Import specific exception types from PyMongo
from pymongo.errors import ConnectionFailure, DuplicateKeyError, OperationFailure

try:
    # Attempt to insert a new product document
    result = products.insert_one({"sku": "HL-U509", "name": "Sport-100 Helmet, Black"})
except DuplicateKeyError:
    # Raised when a document with the same _id or unique index value already exists
    print("A product with this key already exists. Use update_one instead.")
except ConnectionFailure as e:
    # Raised when the driver cannot reach the cluster
    print(f"Could not connect to Azure DocumentDB: {e}")
except OperationFailure as e:
    # Catches other server-side errors such as authentication or permission failures
    print(f"Database operation failed: {e}")
```

::: zone-end

::: zone pivot="csharp"

```csharp
try
{
    // Attempt to insert a new product document
    await products.InsertOneAsync(helmet);
}
// Catch duplicate key errors using a filter on the exception category
catch (MongoWriteException ex) when (ex.WriteError.Category == ServerErrorCategory.DuplicateKey)
{
    Console.WriteLine("A product with this key already exists. Use ReplaceOneAsync instead.");
}
// Catch connection-level failures such as network timeouts or unreachable clusters
catch (MongoConnectionException ex)
{
    Console.WriteLine($"Could not connect to Azure DocumentDB: {ex.Message}");
}
// Catch other server-side command errors such as authentication or permission failures
catch (MongoCommandException ex)
{
    Console.WriteLine($"Database operation failed: {ex.Message}");
}
```

::: zone-end

::: zone pivot="node"

```javascript
try {
    // Attempt to insert a new product document
    await products.insertOne({ sku: 'HL-U509', name: 'Sport-100 Helmet, Black' });
} catch (error) {
    // Error code 11000 indicates a duplicate key violation
    if (error.code === 11000) {
        console.log('A product with this key already exists. Use updateOne instead.');
    // MongoServerSelectionError means the driver could not reach the cluster
    } else if (error.name === 'MongoServerSelectionError') {
        console.log(`Could not connect to Azure DocumentDB: ${error.message}`);
    // Handle any other server-side or operational errors
    } else {
        console.log(`Database operation failed: ${error.message}`);
    }
}
```

::: zone-end

## Resource cleanup

Always close the client when your application shuts down. This releases connections back to the pool and prevents resource leaks.

::: zone pivot="python"

In Python, use a context manager or close the client explicitly:

```python
# Option 1: Context manager (recommended)
with MongoClient(connection_string) as client:
    db = client["cosmicworks"]
    # ... perform operations ...
# Client closes automatically when the block exits
```

```python
# Option 2: Explicit close
client = MongoClient(connection_string)
try:
    db = client["cosmicworks"]
    # ... perform operations ...
finally:
    client.close()
```

::: zone-end

::: zone pivot="csharp"

In .NET, `MongoClient` implements `IDisposable`, so you can use a `using` statement or call `Dispose()` explicitly:

```csharp
// Option 1: using statement (recommended for scoped usage)
using var client = new MongoClient(settings);
var db = client.GetDatabase("cosmicworks");
// ... perform operations ...
// Client disposes automatically when the scope exits
```

```csharp
// Option 2: Explicit dispose
var client = new MongoClient(settings);
try
{
    var db = client.GetDatabase("cosmicworks");
    // ... perform operations ...
}
finally
{
    client.Dispose();
}
```

For long-running applications, register the `MongoClient` as a singleton in your dependency injection container and let the DI container manage the lifetime.

::: zone-end

::: zone pivot="node"

In JavaScript, use a `try/finally` block to ensure the client closes even if an error occurs:

```javascript
const client = new MongoClient(connectionString);
try {
    await client.connect();
    const db = client.db('cosmicworks');
    // ... perform operations ...
} finally {
    await client.close();
}
```

::: zone-end

## Secure your connection string

In a previous unit, you loaded the connection string from an environment variable instead of hardcoding it. That practice is essential because your connection string contains cluster credentials and should never appear in source code or version control.

::: zone pivot="python"

```python
import os
connection_string = os.environ["AZURE_DOCUMENTDB_CONNECTION_STRING"]
```

::: zone-end

::: zone pivot="csharp"

```csharp
var connectionString = Environment.GetEnvironmentVariable("AZURE_DOCUMENTDB_CONNECTION_STRING");
```

::: zone-end

::: zone pivot="node"

```javascript
const connectionString = process.env.AZURE_DOCUMENTDB_CONNECTION_STRING;
```

::: zone-end

For local development, environment variables work well. For production deployments, use a dedicated secret manager such as **Azure Key Vault** or your platform's built-in secret store (for example, App Service application settings or Kubernetes secrets). These services provide encryption at rest, access auditing, and automatic rotation capabilities that environment variables alone don't offer.

You now know how to manage connection pools, handle common database errors with `try`/`catch` blocks, clean up resources when your application shuts down, and secure your connection string. In the next unit, you put all of these skills together by building a product management application.
