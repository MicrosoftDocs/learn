Database connections are expensive resources. Each connection consumes server memory, requires authentication overhead, and counts against server limits. For AI applications that make frequent vector queries, efficient connection management is essential for achieving high throughput without exhausting resources.

> [!NOTE]
> Code examples in this unit demonstrate connection management patterns for Python (psycopg) and .NET (Npgsql). These libraries are updated frequently. Visit the [psycopg documentation](https://www.psycopg.org/psycopg3/docs/) and [Npgsql documentation](https://www.npgsql.org/doc/) for current API details.

## Connection overhead

Creating a new PostgreSQL connection involves multiple steps, each adding latency:

1. **TCP handshake:** Establishing the network connection (typically 1-3 round trips)
1. **TLS negotiation:** Encrypting the connection (required for Azure Database for PostgreSQL)
1. **Authentication:** Verifying credentials (password or token exchange)
1. **Server process allocation:** PostgreSQL spawns a backend process for each connection
1. **Session initialization:** Setting session parameters and loading configurations

This sequence takes 50-200 milliseconds depending on network latency and server load. For a recommendation engine handling thousands of requests per second, creating new connections per request would consume more time in connection setup than in actual query execution.

Azure Database for PostgreSQL limits concurrent connections based on compute tier. Burstable B1ms allows 50 connections, General Purpose 2 vCores allows 859 connections, General Purpose 4 vCores allows 1,718 connections, Memory Optimized 4 vCores allows 3,437 connections, and Memory Optimized 16 vCores allows 5,000 connections. Exceeding these limits causes connection failures. Applications that create connections per request can quickly hit these limits during traffic spikes.

## Connection pooling with PgBouncer

PgBouncer is a lightweight connection pooler that sits between your application and PostgreSQL. It maintains a pool of database connections and multiplexes client connections across them, dramatically reducing the number of actual database connections needed.

Azure Database for PostgreSQL includes built-in PgBouncer support on General Purpose and Memory Optimized compute tiers. The Burstable tier doesn't support this feature. Enable PgBouncer through the Azure portal or CLI. Once enabled, connect through port 6432 (the PgBouncer port) instead of 5432 (the direct PostgreSQL port). The PgBouncer connection string uses `postgresql://user:password@myserver.postgres.database.azure.com:6432/mydb`.

```azurecli
az postgres flexible-server parameter set \
    --resource-group myResourceGroup \
    --server-name myserver \
    --name pgbouncer.enabled \
    --value true
```

PgBouncer supports three pooling modes, each with different trade-offs. Session mode means a client holds a server connection for the entire session (until disconnect). This mode supports all PostgreSQL features but provides minimal connection reduction. Transaction mode means a client holds a server connection only during a transaction. Between transactions, the connection returns to the pool. This mode works well for most applications and significantly reduces connection requirements. Statement mode means a client gets a connection only for individual statements. This mode provides maximum connection reduction but doesn't support multi-statement transactions. For vector search workloads, transaction mode is typically the best choice.

PgBouncer exposes several parameters that control pool behavior, connection limits, and timeout handling. For vector search workloads with bursty traffic patterns, tuning these parameters helps balance connection availability against resource consumption. Configure `pgbouncer.default_pool_size` (20-50 depending on concurrency needs), `pgbouncer.max_client_conn` (5000+ for high-traffic applications), `pgbouncer.pool_mode` (transaction), and `pgbouncer.query_wait_timeout` (30-120 seconds).

Transaction mode returns connections to the pool after each transaction commits or rolls back. This affects several PostgreSQL features. Session variables reset between transactions, so settings applied with `SET` don't persist across transactions. Use `SET LOCAL` within transactions or configure defaults server-side. Prepared statements might not work because named prepared statements are tied to connections. In transaction mode, a prepared statement created in one transaction might not be available in the next if a different connection is assigned. LISTEN/NOTIFY doesn't work because these features require persistent connections and are incompatible with transaction pooling. For vector search applications, these limitations are rarely problematic since queries are typically simple selects without session-specific state.

## Application-level connection pooling

In addition to (or instead of) PgBouncer, your application can manage connection pools directly. This provides finer control over connection lifecycle and integrates with application frameworks.

The `psycopg_pool` package provides connection pooling for psycopg. Application-level pools give you control over connection lifecycle, idle timeout behavior, and health checking. They also integrate naturally with your application's error handling and logging. When combined with PgBouncer, application pools handle local connection management while PgBouncer handles server-side multiplexing. The `with pool.connection()` context manager automatically returns the connection to the pool when the block exits, even if an exception occurs.

```python
from psycopg_pool import ConnectionPool

# Create a connection pool
pool = ConnectionPool(
    conninfo="postgresql://user:password@myserver.postgres.database.azure.com:6432/mydb",
    min_size=5,      # Minimum connections to maintain
    max_size=20,     # Maximum connections allowed
    max_idle=300,    # Close idle connections after 5 minutes
    max_lifetime=3600  # Recycle connections after 1 hour
)

# Use connections from the pool
def search_similar_products(query_embedding, limit=10):
    with pool.connection() as conn:
        with conn.cursor() as cur:
            cur.execute("""
                SELECT id, name, embedding <=> %s AS distance
                FROM products
                ORDER BY embedding <=> %s
                LIMIT %s
            """, (query_embedding, query_embedding, limit))
            return cur.fetchall()
```

Npgsql includes built-in connection pooling enabled by default, so you don't need a separate package. The pool automatically manages connection creation, reuse, and disposal based on parameters you specify in the connection string. Each unique connection string maintains its own pool, so consistent connection strings across your application ensure efficient pool utilization. When you call `conn.Close()` or the connection is disposed, it returns to the pool rather than being destroyed. Configure pooling through connection string parameters like `Minimum Pool Size=5;Maximum Pool Size=20;Connection Idle Lifetime=300;Connection Lifetime=3600`.

Pool size affects both performance and resource consumption. Setting the pool too small causes requests to wait for available connections, increasing latency. Setting it too large wastes memory and can overwhelm the database server. The right size depends on your traffic patterns, query duration, and the number of application instances sharing the database. Keep minimum size large enough to handle baseline traffic without waiting. Cap maximum size at what the database can handle divided by the number of application instances. If you have 10 application instances and your database supports 1,000 connections, set maximum to 100 per instance (leaving headroom). Recycle connections periodically (every 30-60 minutes) to maintain health because long-lived connections might accumulate memory leaks or hold stale cached plans.

## Session management for AI workloads

Some vector queries benefit from session-level settings that allocate more resources to the query than the server-wide defaults allow.

Vector similarity queries that sort large result sets benefit from increased `work_mem`. Set it for specific sessions or transactions using `SET LOCAL work_mem = '256MB'`. `SET LOCAL` applies only within the current transaction. When the transaction ends, the setting reverts to the default, which is safe for pooled connections.

Adjust `hnsw.ef_search` or `ivfflat.probes` for queries with different accuracy requirements. Use `SET LOCAL hnsw.ef_search = 200` for higher recall in queries where accuracy is critical, or `SET LOCAL hnsw.ef_search = 20` for faster queries where approximate results are acceptable. This pattern lets you balance accuracy and speed based on the specific use case without affecting other queries.

## Efficient SDK usage patterns

Beyond connection management, how you structure database interactions affects performance.

Network round trips add latency to every database operation. When you need multiple pieces of data, fetching them in a single query eliminates the per-query overhead of network transmission, query parsing, and result serialization. For AI applications that retrieve embeddings for multiple items, batching can reduce total latency from hundreds of milliseconds to single digits. Instead of making multiple round trips with individual queries, use a single query with `WHERE id = ANY(%s)` and pass a list of IDs.

For loading large numbers of vectors, the PostgreSQL `COPY` command is dramatically faster than individual `INSERT` statements. `COPY` streams data directly into the table in a binary or text format, bypassing the overhead of parsing individual SQL statements. When loading embedding data from batch processing pipelines or initial data migrations, `COPY` can reduce load times from hours to minutes. `COPY` can load hundreds of thousands of rows per second, while individual inserts are limited to thousands per second.

When your application can parallelize work, async database operations improve throughput by executing multiple queries concurrently without blocking threads. This pattern is valuable for AI workloads that need to search multiple vector collections simultaneously or combine vector search with other data retrieval. Async pools manage connections efficiently across concurrent operations while respecting pool size limits. Use `AsyncConnectionPool` from psycopg_pool and `asyncio.gather` to execute multiple searches concurrently.

## Connection resilience

Network issues, server restarts, and failovers can interrupt database connections. Robust applications handle these gracefully.

Transient failures such as network blips, connection resets, and brief server unavailability during maintenance are inevitable in cloud environments. Implementing retry logic with exponential backoff helps your application recover gracefully from these temporary issues without overwhelming the server with immediate retry attempts. Add random jitter to prevent multiple application instances from retrying simultaneously. Catch `OperationalError` exceptions, calculate wait time as `(2 ** attempt) + random.uniform(0, 1)`, and retry up to a maximum number of attempts.

Timeouts prevent your application from waiting indefinitely when the database is slow or unreachable. Connection timeouts limit how long to wait when establishing new connections, while statement timeouts limit query execution time. For vector search applications, choose timeouts that accommodate your slowest legitimate queries while failing fast on queries that exceed acceptable latency. Configure timeouts in your connection string using parameters like `connect_timeout=10` and `options=-c statement_timeout=30000`. For vector queries, set statement timeouts that accommodate your slowest acceptable queries. A 30-second timeout is reasonable for complex vector searches; interactive applications might use lower values.

When all pool connections are in use and new requests arrive, the pool must either queue requests (adding latency) or reject them immediately. Neither option is ideal, so monitoring pool utilization helps you scale before exhaustion becomes frequent. When exhaustion does occur, returning a clear error message helps clients implement their own retry logic rather than timing out unpredictably. Handle `PoolTimeout` exceptions by returning a graceful error like `{"error": "Service temporarily busy, please retry"}`. Monitor pool utilization and scale if exhaustion happens frequently.

## Additional resources

- [PgBouncer in Azure Database for PostgreSQL](/azure/postgresql/flexible-server/concepts-pgbouncer)
- [psycopg connection pool documentation](https://www.psycopg.org/psycopg3/docs/api/pool.html)
- [Npgsql connection pooling](https://www.npgsql.org/doc/connection-string-parameters.html#pooling)
