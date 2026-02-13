Integrating Azure Database for PostgreSQL into your applications requires choosing appropriate client libraries, managing connections effectively, and handling errors gracefully. This unit covers SDK integration patterns for Python, along with best practices that apply across programming languages.

> [!NOTE]
> Code examples in this unit demonstrate patterns for integrating PostgreSQL with your applications. The `psycopg` library is updated frequently. Visit the [psycopg documentation](https://www.psycopg.org/psycopg3/docs/) for the most current API details and best practices.

## Python integration with psycopg

The `psycopg` library (version 3) is the recommended PostgreSQL adapter for Python. It provides both synchronous and asynchronous interfaces, connection pooling, and full support for PostgreSQL features.

Install psycopg using pip with the binary extra for the simplest setup: `pip install "psycopg[binary]"`. The binary distribution includes pre-compiled dependencies, which avoids the need to install PostgreSQL client libraries on your development machine. For production deployments where you need to compile against specific PostgreSQL client libraries, install without the binary extra and ensure `libpq` development headers are available.

Create connections using `psycopg.connect()` with either a connection string or individual parameters. Connection strings are convenient for configuration files, while individual parameters offer flexibility for computing values programmatically, such as retrieving passwords from Key Vault:

```python
import psycopg

# Connection string format
conn = psycopg.connect("postgresql://user:password@myserver.postgres.database.azure.com/mydb?sslmode=require")

# Individual parameters
conn = psycopg.connect(host="myserver.postgres.database.azure.com", dbname="mydb",
                       user="myuser", password="mypassword", sslmode="require")
```

Context managers ensure connections are properly closed, even when exceptions occur. The outer `with` block manages the connection, and the inner `with` block manages the cursor:

```python
with psycopg.connect(connection_string) as conn:
    with conn.cursor() as cur:
        cur.execute("SELECT * FROM conversations WHERE id = %s", (conversation_id,))
        row = cur.fetchone()
```

Always use parameterized queries to prevent SQL injection attacks. Parameterized queries separate the SQL structure from the data values, letting the database driver handle proper escaping. Use `%s` placeholders for positional parameters or `%(name)s` for named parameters. Never use string formatting or concatenation to build queries with user input.

Retrieve query results using cursor methods that match your needs. Use `fetchone()` when you expect a single row, `fetchall()` for small result sets, and iterate directly over the cursor for large results to avoid loading everything into memory at once.

## Connection management best practices

Effective connection management improves application reliability and performance regardless of the programming language you use.

Set appropriate timeouts to prevent your application from hanging when the database is unreachable or queries run longer than expected. Connection timeouts control how long the client waits to establish a connection, while statement timeouts limit query execution time. Choose timeout values based on your application's tolerance for latency—web applications typically use shorter timeouts (five to 30 seconds) than batch processing jobs.

```python
conn = psycopg.connect(
    connection_string,
    connect_timeout=10,
    options="-c statement_timeout=30000"  # milliseconds
)
```

Implement retry logic with exponential backoff to handle transient failures from network issues, server restarts, or resource contention. Catch `OperationalError` for connection and timeout failures. Don't retry on constraint violations or syntax errors—those require code changes, not retries.

Always close connections when you're done with them. Leaked connections exhaust the connection pool and can prevent new connections. Context managers provide automatic cleanup that works even when exceptions occur.

## Error handling strategies

Database operations can fail for various reasons. Handling errors appropriately improves user experience and simplifies debugging.

Connection failures occur when the server is unreachable or rejects the connection—network problems, incorrect credentials, firewall rules, or server maintenance can all be causes. Handle connection failures by logging details for troubleshooting while presenting user-friendly messages to end users.

Unique constraints, foreign keys, and check constraints raise specific errors when violated. Catch `UniqueViolation`, `ForeignKeyViolation`, and `CheckViolation` to provide meaningful feedback. Always roll back the transaction after a constraint violation.

Deadlocks occur when two transactions wait for each other's locks, creating a circular dependency. PostgreSQL automatically detects deadlocks and terminates one transaction. Your application should catch `DeadlockDetected`, roll back, and retry. To minimize deadlock risk, design transactions to acquire locks in a consistent order. Handle `LockNotAvailable` similarly when queries time out waiting for locks.

## Performance considerations

Application-level patterns can significantly affect database performance.

Insert multiple rows in a single statement instead of executing individual inserts in a loop. Batch operations reduce network round trips, significantly improving throughput for bulk data operations. Use `executemany` for inserting hundreds to a few thousand rows. For larger datasets (10,000+ rows), the `COPY` command provides the highest performance, often two to 10 times faster than individual inserts:

```python
with cur.copy("COPY messages (conversation_id, role, content) FROM STDIN") as copy:
    for record in records:
        copy.write_row(record)
```

Prepared statements can improve performance for queries executed repeatedly with different parameters. The database parses and plans the query once, then reuses that plan. Most PostgreSQL drivers automatically use prepared statements for parameterized queries.

Creating new database connections is expensive—each requires network handshakes, authentication, and server-side resource allocation. Use connection pools to maintain reusable connections that your application can borrow and return:

```python
from psycopg_pool import ConnectionPool

pool = ConnectionPool(connection_string, min_size=1, max_size=10)

with pool.connection() as conn:
    with conn.cursor() as cur:
        cur.execute("SELECT * FROM messages WHERE conversation_id = %s", (id,))
```

## Additional resources

- [psycopg 3 documentation](https://www.psycopg.org/psycopg3/docs/)
- [Azure Identity client library for Python](/python/api/overview/azure/identity-readme)
