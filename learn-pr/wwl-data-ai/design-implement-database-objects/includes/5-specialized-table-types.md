SQL Server support specialized table types designed for specific scenarios and workloads beyond standard disk-based tables. These table types, including [in-memory](/sql/relational-databases/in-memory-oltp/overview-and-usage-scenarios?azure-portal=true), [temporal](/sql/relational-databases/tables/temporal-tables?azure-portal=true), [external](/sql/t-sql/statements/create-external-table-transact-sql?azure-portal=true), [LEDGER](/sql/relational-databases/security/ledger/ledger-overview?azure-portal=true), and [GRAPH](/sql/relational-databases/graphs/sql-graph-overview?azure-portal=true), solve particular performance, compliance, or architectural challenges that standard tables can't address efficiently.

Understanding when and how to use these specialized table types is crucial for designing effective database solutions that meet your application's requirements.

## Use in-memory optimized tables

Traditional disk-based tables incur latency from disk I/O, even with caching. For scenarios requiring high speed, such as thousands of transactions per second with millisecond response times, disk latency becomes the bottleneck. In-memory tables eliminate this by keeping data entirely in RAM with lock-free, optimistic concurrency.

### Understand when to use in-memory tables

[In-memory optimized tables](/sql/relational-databases/in-memory-oltp/introduction-to-memory-optimized-tables?azure-portal=true) provide significant performance benefits for specific workloads:

- **Session state storage** - Web applications with millions of concurrent sessions
- **Real-time analytics** - Financial trading systems requiring microsecond latency
- **High-frequency OLTP** - Order processing systems handling 10,000+ transactions/second
- **Caching layer** - Frequently accessed reference data (product catalogs, configurations)
- **Staging tables** - ETL processes with intensive insert/update operations

For example, an e-commerce site used in-memory tables for shopping cart data, handling 50,000 concurrent carts with submillisecond response times, reducing checkout latency by 80%.

### Consider trade-offs

In-memory tables store the actual table data in RAM for faster access, while traditional tables store data on disk. However, data size is limited by available RAM, and these tables don't support large object types like `VARCHAR(MAX)`, `NVARCHAR(MAX)`, or `VARBINARY(MAX)`.

Even though the table data lives in memory, SQL Server still writes transaction logs to disk to ensure durability. This means you won't lose committed transactions if the server restarts—the data is recovered from the transaction log back into memory.

You can create an in-memory optimized table by using the `MEMORY_OPTIMIZED = ON` option. Here's an example:

```sql
-- Create in-memory optimized table
CREATE TABLE dbo.OrderCache (
    OrderID INT PRIMARY KEY NONCLUSTERED,
    CustomerID INT,
    OrderDate DATETIME2,
    Amount DECIMAL(10,2),
    INDEX IX_CustomerID NONCLUSTERED (CustomerID)
) WITH (MEMORY_OPTIMIZED = ON, DURABILITY = SCHEMA_AND_DATA);
```

## Use temporal tables

[Temporal tables](/sql/relational-databases/tables/temporal-tables?azure-portal=true) automatically track the complete history of data changes. When you update or delete a row, SQL Server automatically stores the previous version in a linked history table with timestamps showing when that version was valid. This happens transparently—you modify data using normal `INSERT`, `UPDATE`, and `DELETE` statements, and the database engine handles versioning.

The key benefit is querying data as it existed at any point in time. You can ask "what was this employee's salary on January 1, 2025?" or "show me all products that were in stock last quarter" without maintaining complex audit tables or writing custom versioning logic.

Temporal tables serve compliance, troubleshooting, and analytical needs:

- **Compliance and auditing** - Financial records requiring complete change history
- **Troubleshooting** - Investigating account balances at the time disputed transactions occurred
- **Trend analysis** - Analyzing how product prices changed over quarters
- **Data recovery** - Reverting accidental updates without restoring backups
- **Slowly changing dimensions** - [Data warehouse Type 2 dimensions](/fabric/data-factory/slowly-changing-dimension-type-two?azure-portal=true) automated

Common business scenarios include applications tracking salary changes and promotions, inventory management analyzing stock trends, healthcare maintaining patient record history for compliance, and insurance tracking policy coverage changes for dispute resolution.

### Consider temporal table benefits

Temporal tables require zero application code changes and offer transparent history tracking. Point-in-time queries use simple syntax, and automatic cleanup manages old history data. However, temporal tables roughly double storage requirements.

[Temporal tables](/sql/relational-databases/tables/creating-a-system-versioned-temporal-table?azure-portal=true) automatically maintain a complete history of data changes for auditing and point-in-time analysis.

You can create a temporal table by using the `SYSTEM_VERSIONING = ON` option. Temporal tables require two extra `DATETIME2` columns to track the validity period of each row version and a `PERIOD FOR SYSTEM_TIME` clause to define which columns track these timestamps. Here's an example:

```sql
-- Create temporal table with automatic history tracking
CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY,
    EmployeeName NVARCHAR(100),
    Department NVARCHAR(50),
    SysStartTime DATETIME2 GENERATED ALWAYS AS ROW START,
    SysEndTime DATETIME2 GENERATED ALWAYS AS ROW END,
    PERIOD FOR SYSTEM_TIME (SysStartTime, SysEndTime)
) WITH (SYSTEM_VERSIONING = ON);

-- Query historical data
SELECT * FROM Employee
FOR SYSTEM_TIME AS OF '2026-01-01' 
WHERE EmployeeID = 1;
```

When you create a temporal table, SQL Server automatically creates a history table to store previous row versions and manages both tables transparently.

## Use external tables

Modern data architectures often have data scattered across data lakes, blob storage, and multiple systems. Traditionally, you'd have to ETL (extract, transform, load) all data into your database before querying it. External tables enable [data virtualization](/sql/relational-databases/polybase/polybase-guide?azure-portal=true) to query data where it lives without moving it, saving storage costs and ETL complexity.

### Understand when to use external tables

External tables excel at querying data across distributed storage systems:

- **Data lake integration** - Query Parquet/CSV files in [Azure Data Lake Storage](/azure/storage/blobs/data-lake-storage-introduction?azure-portal=true) without importing
- **Data exploration** - Analyze raw data before deciding what to import
- **Cost optimization** - Avoid duplicating data that's already stored elsewhere
- **Federated queries** - Join database tables with files in external systems
- **Archival storage** - Access historical data stored in cheaper blob storage

Common scenarios include querying years of log files in data lakes alongside transactional data, combining live database records with archived blob storage data, accessing legacy data without full migration, and querying millions of IoT sensor JSON files without importing.

### Consider performance constraints

External tables provide unified querying across sources but have limitations:

- No data movement or storage duplication
- Often slower than native tables due to network latency, and file parsing
- Read-only (can't update/delete in most scenarios)
- Limited indexing and optimization

You can create an external table by using the `CREATE EXTERNAL TABLE` statement with a data source and file format. Here's an example:

```sql
-- Create external table pointing to data lake
CREATE EXTERNAL TABLE dbo.ExternalSalesData (
    OrderID INT,
    CustomerID INT,
    OrderAmount DECIMAL(10,2),
    OrderDate DATE
) WITH (
    LOCATION = '/raw/sales/',
    DATA_SOURCE = DataLakeSource,
    FILE_FORMAT = ParquetFormat
);
```

## Use ledger tables

In regulated industries, proving data hasn't been tampered with is important. Traditional databases can have data modified by administrators, backdated changes made, or audit logs deleted. Ledger tables use *cryptographic verification* inspired by blockchain technology to create tamper-evident records that can be independently verified, providing cryptographic proof of data integrity.

### Understand when to use ledger tables

Ledger tables serve regulatory compliance and forensic auditing needs:

- **Financial transactions** - Banking, payment processing, cryptocurrency exchanges
- **Supply chain** - Tracking product origin, custody, and authenticity
- **Legal records** - Contracts, agreements, legal filings requiring immutability
- **Healthcare** - Prescription records, patient consent forms
- **Government** - Voting records, land registries, permit issuance

For example, a bank can use ledger tables to store transaction records, allowing auditors to verify that no transactions were altered after posting. A supply chain company can track product provenance using ledger tables, providing customers with proof of authenticity.

### Choose between updatable and append-only ledgers

Ledger tables come in two types. **Updatable ledger tables** allow `INSERT`, `UPDATE`, and `DELETE` operations while tracking all changes cryptographically. The system automatically stores previous versions in a history table, similar to temporal tables, but with the added benefit of tamper-proof verification. **Append-only ledger tables** only allow `INSERT` operations, creating truly immutable records for scenarios requiring absolute data integrity.

You can combine both technologies by creating tables that are both updatable ledger tables and temporal tables, gaining cryptographic verification alongside point-in-time query capabilities.

For example, a pharmaceutical company uses append-only ledger tables for clinical trial data, providing independent auditors cryptographic proof that test results weren't altered after submission.

You can create a ledger table by using the `LEDGER = ON` option. Here's an example:

```sql
-- Create ledger table
CREATE TABLE dbo.FinancialTransaction (
    TransactionID INT PRIMARY KEY IDENTITY,
    AccountNumber NVARCHAR(20),
    Amount DECIMAL(15,2),
    TransactionType NVARCHAR(20)
) WITH (LEDGER = ON);

-- Append-only ledger provides immutability
CREATE TABLE dbo.AuditLog (
    LogID INT PRIMARY KEY IDENTITY,
    EventDescription NVARCHAR(500),
    EventTimestamp DATETIME2
) WITH (LEDGER = ON, APPEND_ONLY = ON);
```

When you create a ledger table, SQL Server automatically adds hidden columns and creates supporting database objects to track the cryptographic chain. Every row modification generates a cryptographic hash that links to previous operations, creating a tamper-evident audit trail. You can verify data integrity using built-in system views like [sys.database_ledger_transactions](/sql/relational-databases/system-catalog-views/sys-database-ledger-transactions-transact-sql?azure-portal=true) and procedures such as [sp_verify_database_ledger](/sql/relational-databases/system-stored-procedures/sys-sp-verify-database-ledger-transact-sql?azure-portal=true) to validate the cryptographic chain remains unbroken.

## Use graph tables

Relational databases excel at structured data but struggle with highly connected data requiring many joins. Finding "friends of friends" or "products related through 3 degrees of categories" becomes complex with traditional tables. [SQL Graph](/sql/relational-databases/graphs/sql-graph-architecture?azure-portal=true) capabilities natively model *nodes* (entities) and *edges* (relationships), making complex relationship queries simple and performant.

Graph tables simplify relationship modeling but require learning new syntax. They provide intuitive modeling of connected data, simpler queries for relationship traversal, and better performance for multi-hop queries. The flexible schema accommodates evolving relationships. However, graph tables have a learning curve for `MATCH` syntax and perform best for read-heavy relationship queries.

A database can contain multiple node and edge tables that work together to model your graph data. You define which tables represent nodes and which represent edges based on your data relationships.

>[!NOTE]
> Graph tables aren't optimal for every scenario. Avoid them for simple parent-child relationships where foreign keys work fine, primarily transactional data without complex relationships, or highly structured, stable schemas.

### Understand graph table structure

SQL Graph uses two types of tables to model relationships. **Node tables** store entities and automatically include a hidden `$node_id` column that uniquely identifies each node. **Edge tables** store relationships between nodes and include hidden columns `$edge_id`, `$from_id`, and `$to_id` to maintain connections. These special columns enable the `MATCH` syntax to traverse relationships efficiently.

You can create graph tables by using the `AS NODE` and `AS EDGE` syntax. Here's an example:

```sql
-- Create graph tables
CREATE TABLE Person AS NODE;
CREATE TABLE Manages AS EDGE;
CREATE TABLE Knows AS EDGE;

-- Insert nodes
INSERT INTO Person VALUES (1, 'Alice'), (2, 'Bob'), (3, 'Charlie');

-- Insert edges (relationships)
INSERT INTO Manages VALUES (1, 2), (2, 3);

-- Query relationships
SELECT Person1.name, Person2.name 
FROM Person AS Person1, Manages, Person AS Person2
WHERE MATCH (Person1-(Manages)->Person2)
AND Person1.id = 1;
```

When you create node and edge tables, SQL Server automatically manages the hidden system columns that enable efficient graph traversal queries.

Each specialized table type comes with trade-offs: in-memory tables need RAM, temporal tables double storage, external tables add network latency, ledger tables prevent deletion, and graph tables require new syntax. We recommend choosing the right table type during design as these decisions are hard to change after deployment.
