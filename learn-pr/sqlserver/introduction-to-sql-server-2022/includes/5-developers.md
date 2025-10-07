
[SQL Server 2025](/sql/sql-server/what-s-new-in-sql-server-2025) provides features and tools for developers to work with data, events, and APIs. This unit covers the development capabilities in SQL Server 2025.

## Implement data enrichment features

SQL Server 2025 significantly improves data enrichment capabilities with several key features:

### Work with native JSON

SQL Server 2025 offers improved native JSON support, letting you store, query, and manipulate JSON directly in T-SQL. New functions like `JSON_OBJECT` and `JSON_VALUE` simplify working with semi-structured data, while enhanced indexing boosts performance for JSON queries. This makes blending relational and hierarchical data easier for modern applications.

[JSON](/sql/relational-databases/json/json-data-sql-server) support in SQL Server lets you store and work with JSON data natively. 

- Process JSON documents directly in SQL Server
- Query and update JSON using T-SQL
- Index JSON properties for faster performance
- Validate JSON at the database level
- Use the JSON data type for strict type enforcement

The following example shows how SQL Server 2025 uses the new JSON data type with automatic validation and dot notation, allowing you to store JSON in a column and query properties like name and price directly in T-SQL without extra functions.

```sql
-- Create a table with a JSON column
CREATE TABLE Products (
    ProductId int PRIMARY KEY,
    ProductData JSON
);

-- Insert valid JSON data with automatic validation
INSERT INTO Products (ProductId, ProductData)
VALUES (1, '{"name": "Widget", "price": 19.99, "features": ["durable", "lightweight"]}');

-- Query JSON properties using dot notation
SELECT 
    ProductId,
    ProductData.name,
    ProductData.price
FROM Products;
```

> [!TIP]
> Use the `ISJSON()` function to validate JSON data before storing it in the database.

### Integrate REST APIs

SQL Server 2025 introduces built-in REST API support, enabling direct interaction with database objects over HTTP without extra middleware. Developers can expose tables, views, and stored procedures as RESTful endpoints, making it easier to integrate SQL Server with modern web and mobile applications. The feature supports secure authentication, JSON payloads for input and output, and fine-grained control over which operations are exposed. This simplifies building lightweight services and microservices that use SQL Server as a backend while reducing development overhead.

The [REST API](/sql/relational-databases/system-stored-procedures/sp-invoke-external-rest-endpoint-transact-sql) operations are executed in-database, improving security and reducing external dependencies.

| Feature | Description | Example Use Case |
|---------|-------------|----------------|
| API integration | Call external APIs from T-SQL | Enrich data with non-Microsoft services |
| API authentication | Secure API calls with managed identities | Connect to Azure services securely |
| Response handling | Process JSON/XML responses natively | Transform external data automatically |
| Request management | Configure timeouts and retries | Ensure reliable API communication |

### Use RegEx operations

SQL Server 2025 adds native support for regular expressions (RegEx) in T-SQL, enabling powerful pattern matching and text manipulation directly within queries. With new functions like [`REGEXP_MATCHES`](/sql/t-sql/functions/regexp-matches-transact-sql), [`REGEXP_REPLACE`](/sql/t-sql/functions/regexp-replace-transact-sql), and [`REGEXP_LIKE`](/sql/t-sql/functions/regexp-like-transact-sql), developers can validate input, extract complex patterns, and perform advanced string transformations without relying on CLR (Common Language Runtime) or external scripts. This feature simplifies tasks such as data cleansing, format validation, and searching for dynamic patterns, making SQL Server more versatile for modern data processing scenarios.

[Regular expression support](/sql/t-sql/functions/regular-expressions-functions-transact-sql) adds pattern matching capabilities:

| Function | Purpose | Example |
|----------|---------|----------|
| REGEXP_MATCHES | Test if a string matches a pattern | Validate email formats |
| REGEXP_REPLACE | Replace text using patterns | Clean and standardize data |
| REGEXP_EXTRACT | Extract matching substrings | Parse structured text |
| REGEXP_LIKE | Pattern-based string comparison | Filter data using patterns |

The following example shows how SQL Server 2025 can call external APIs directly using `sp_invoke_external_service`, sending a POST request with dynamic data and secure headers, and capturing the JSON response for immediate use in T-SQL.

```sql
-- Call an external API to enrich customer data
DECLARE @apiResponse JSON;
EXEC sp_invoke_external_service 
    @service_name = 'CustomerEnrichment',
    @url = 'https://api.example.com/enrich',
    @method = 'POST',
    @headers = '{"Authorization": "Bearer {{azure_token}}"}',
    @request_body = '{"customerId": @customerId}',
    @response = @apiResponse OUTPUT;
```

The following example shows how SQL Server 2025 uses RegEx functions like `REGEXP_MATCHES` to validate email formats and `REGEXP_REPLACE` to standardize phone numbers, enabling powerful text validation and transformation directly in T-SQL.

```sql
-- Validate email addresses using RegEx
SELECT 
    CustomerID,
    Email,
    CASE 
        WHEN Email REGEXP_MATCHES '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
        THEN 'Valid'
        ELSE 'Invalid'
    END AS EmailStatus
FROM Customers;

-- Standardize phone numbers using RegEx
SELECT 
    PhoneNumber,
    REGEXP_REPLACE(
        PhoneNumber,
        '^\+?1?[-. ]?(\d{3})[-. ]?(\d{3})[-. ]?(\d{4})$',
        '($1) $2-$3'
    ) AS FormattedPhone
FROM Contacts;
```

## Configure event streaming

SQL Server 2025 introduces native event streaming capabilities, allowing real-time data to flow directly from the database to external consumers without complex ETL pipelines. Using built-in support for streaming protocols, you can publish changes from tables, views, or queries as continuous streams to platforms like Azure Event Hubs.

### Set up change event streaming

Ensure your [Azure Event Hubs](/azure/event-hubs/event-hubs-about) namespace is properly configured before setting up change event streaming.

Change event streaming provides:

- Stream transaction log changes directly to Azure Event Hubs
- Reduce I/O overhead compared to traditional CDC
- Enable real-time data replication
- Support event-driven architectures

Some of the key benefits of change event streaming include:

1. **Reduced latency**: Direct streaming from transaction logs eliminates the need for intermediate storage
2. **Lower resource usage**: Optimized I/O operations compared to CDC
3. **Real-time AI integration**: Enable AI agents to process and react to data changes instantly
4. **Scalable architecture**: Built to handle high-volume transaction environments

## Use developer tools and languages

SQL Server 2025 expands developer productivity with broad language and tool support. Developers can work with T-SQL alongside modern languages like Python, R, and JavaScript through integrated runtime environments, enabling advanced analytics and AI workflows directly in the database. 

Enhanced Visual Studio extensions provide richer debugging, IntelliSense, and deployment features, while new CLI tools simplify automation and Azure Pipelines. Combined with REST API endpoints and native JSON, RegEx, and event streaming capabilities, SQL Server 2025 offers a unified platform for building modern, data-driven applications efficiently.

### Install Python driver

The new Python driver for SQL Server 2025 offers:

- Simple installation via pip: `pip install mssql-python`
- Async/await support for better performance
- Built-in connection pooling
- Type hints for better IDE integration
- Comprehensive error handling

The following Python snippet shows how to perform an asynchronous query against a SQL Server database using Python. It uses the `mssql.async` library to establish a nonblocking connection with `connect('connection_string')`, ensuring efficient resource management with async with. Inside the connection, it creates a cursor, executes a SQL query using `SELECT TOP 10 * FROM Customers` asynchronously with `await cursor.execute()`, and retrieves all results using `await cursor.fetchall()`.

```python
from mssql.async import connect

async with connect('connection_string') as conn:
    async with conn.cursor() as cursor:
        await cursor.execute('SELECT TOP 10 * FROM Customers')
        results = await cursor.fetchall()
```

### Enhance VS Code experience with GitHub Copilot

The [MSSQL extension for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=ms-mssql.mssql) now includes AI-powered features through GitHub Copilot integration:

1. **Intelligent SQL generation**:
   - Complete SQL queries based on natural language descriptions
   - Suggest optimized query patterns
   - Generate database schema modifications

2. **Smart schema exploration**:
   - AI-powered schema recommendations
   - Automatic relationship detection
   - Impact analysis for schema changes

3. **Query optimization**:
   - Performance improvement suggestions
   - Index recommendations
   - Execution plan analysis

4. **ORM support**:
   - Generate Entity Framework migrations
   - Suggest model changes based on database schema
   - Create data access layer code

Use the MSSQL extension to set up your connection profile and open a new query editor. When you start typing comments like:

```sql
-- Find all customers who made purchases in the last 30 days
-- and calculate their total spending
```

Copilot reads the intent and suggests a full SQL query automatically. 

```sql
SELECT 
    c.CustomerID,
    c.Name,
    COUNT(o.OrderID) as OrderCount,
    SUM(o.TotalAmount) as TotalSpending
FROM 
    Customers c
    JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE 
    o.OrderDate >= DATEADD(day, -30, GETDATE())
GROUP BY 
    c.CustomerID,
    c.Name
HAVING 
    COUNT(o.OrderID) > 0
ORDER BY 
    TotalSpending DESC;
```

Press **Tab** or **Enter** to accept Copilot’s suggestion, or edit it for accuracy.

These features enable developers to build more sophisticated, efficient, and maintainable database applications while improving productivity through AI assistance and modern tooling.
