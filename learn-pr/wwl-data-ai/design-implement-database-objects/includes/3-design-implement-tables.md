Effective table design forms the foundation of any database. Tables structure your data and determine how efficiently your queries access and modify information.

## Design and create tables

Tables are the fundamental building blocks of relational databases, organizing data into rows and columns that represent entities and their attributes. In relational systems, tables define the structure for storing transactional data, enforce relationships through foreign keys, and provide the foundation for queries and reporting.

For multidimensional analytics, tables serve as *fact tables* storing measurable events and *dimension tables* providing context for analysis. The design decisions you make when creating tables—data types, column sizing, constraints, and relationships—directly impact storage efficiency, query performance, data integrity, and scalability across both operational and analytical workloads.

### Choose appropriate data types

Data types are fundamental decisions that affect your database. The wrong choice can lead to wasted storage, poor performance, data loss, or application errors. Unlike application code that you can refactor easily, changing column data types in production databases often requires table rebuilds, which can mean hours of downtime for large tables.

Select proper data types when you design the initial schema, as this is the easiest time to get it right. Also, consider data types carefully when:

- You're storing data where precision matters
- You're working with high-volume tables where storage costs multiply
- You're defining frequently queried columns that perform faster with smaller types

#### Explore common data types

Appropriate data types affect storage, performance, and operations:

| Type Category | Data Types | Storage Size | Usage Guidelines | Example |
|---------------|------------|--------------|------------------|---------|
| **Numeric** | `INT`, `BIGINT`, `DECIMAL`, `FLOAT` | 4 bytes, 8 bytes, varies | Choose based on range and precision needs | `Quantity INT`, `Revenue DECIMAL(10,2)`, `Population BIGINT` |
| **String** | `VARCHAR`, `CHAR`, `NVARCHAR` | 1 byte/char, fixed, 2 bytes/char | Use `VARCHAR` for variable-length data, `CHAR` for fixed-length, `NVARCHAR` for Unicode | `Email VARCHAR(100)`, `CountryCode CHAR(2)`, `ProductName NVARCHAR(100)` |
| **Date/Time** | `DATE`, `DATETIME2`, `DATETIMEOFFSET` | 3 bytes, 6-8 bytes, 10 bytes | `DATETIME2` provides better precision than `DATETIME` | `BirthDate DATE`, `OrderTimestamp DATETIME2`, `EventTime DATETIMEOFFSET` |
| **Binary** | `VARBINARY`, `IMAGE` | varies | For storing binary data like images or documents | `ProfilePhoto VARBINARY(MAX)`, `DocumentContent VARBINARY(MAX)` |
| **Special** | `UNIQUEIDENTIFIER`, `XML`, `JSON` | 16 bytes, varies, native binary | `UNIQUEIDENTIFIER` for GUIDs, `XML` for XML documents, `JSON` (SQL 2025+) for JSON documents in native binary format | `RowGUID UNIQUEIDENTIFIER`, `Config XML`, `Settings JSON` |

Data type nuances require careful attention. For example, using `FLOAT` for financial data instead of `DECIMAL` can introduce rounding errors that can't be fixed without recalculating every dependent value. A `UNIQUEIDENTIFIER` primary key when `INT` suffices triples your index size and slows every `JOIN` operation. Most of these decisions affect the performance of the database and can determine whether queries run in milliseconds or minutes.

### Estimate table size requirements

Table size isn't just about storage costs; it directly impacts your database operations. Table size affects backup and restore times, index rebuild durations, and query performance.

>[!IMPORTANT]
> A poorly designed table that stores 200 bytes per row instead of 100 bytes doubles your storage needs, backup times, and I/O requirements.

Another scenario to plan for table sizing is when you're calculating storage costs for cloud databases, designing for limited disk space, or planning archive strategies. These scenarios all require accurate size estimates to make informed decisions about resources and operations.

For example, a retail company storing 100 million transactions daily with an extra 50 bytes per row wastes 5 GB per day—that's 1.8TB annually of unnecessary storage, plus proportional increases in backup time and costs.

The following example shows how to estimate the size for the `Employee` table:

```sql
-- Estimate row size for a table
-- Fixed-length columns: sum of column sizes
-- Variable-length: estimate average size
-- Example row calculation:
CREATE TABLE Employee (
    EmployeeID INT,              -- 4 bytes
    FirstName NVARCHAR(50),      -- ~2-100 bytes (avg 40)
    LastName NVARCHAR(50),       -- ~2-100 bytes (avg 40)
    HireDate DATE,               -- 3 bytes
    Salary DECIMAL(10,2)         -- 5 bytes
);  
-- Estimated row size: 4 + 40 + 40 + 3 + 5 = ~92 bytes
-- Plus row overhead (~7 bytes) = ~99 bytes per row
-- 1 million rows ≈ 94 MB
```

>[!TIP]
> You can use Copilot to help you generate the table size estimation.

## Design effective columns

The following example demonstrates a well-designed `Product` table that applies the principles covered in this unit:

```sql
CREATE TABLE Product (
    ProductID INT PRIMARY KEY IDENTITY(1,1),       -- Auto-incrementing surrogate key (4 bytes)
    ProductName NVARCHAR(100) NOT NULL,             -- Unicode support, appropriate length, enforced
    Category NVARCHAR(50) NOT NULL,                 -- Smaller than ProductName (categorization needs less space)
    Price DECIMAL(10,2) NOT NULL,                   -- Exact precision for financial data
    StockQuantity INT NOT NULL DEFAULT 0,           -- Integer sufficient for inventory, default prevents nulls
    LastRestocked DATETIME2 DEFAULT GETUTCDATE()    -- Modern date type with automatic timestamp
);
```

This table demonstrates several best practices:

- **Appropriate data types**: `INT` for the primary key (smaller than `BIGINT` or `UNIQUEIDENTIFIER`), `DECIMAL(10,2)` for precise financial calculations instead of `FLOAT`, `DATETIME2` for better precision than legacy `DATETIME`
- **Right-sized columns**: `NVARCHAR(100)` for product names and `NVARCHAR(50)` for categories based on expected data length
- **Constraints**: `NOT NULL` ensures data quality by preventing missing critical values
- **Default values**: Automatic values for `StockQuantity` (0) and `LastRestocked` (current UTC time) reduce application code complexity
- **Efficient primary key**: `IDENTITY` generates sequential keys that cluster efficiently and use minimal storage (4-bytes vs 16 bytes for GUID)

> [!NOTE]
> This example uses `NVARCHAR` (2 bytes per character) for Unicode support. If your data is ASCII-only, `VARCHAR` (1 byte per character) cuts string storage in half. A `ProductName VARCHAR(100)` uses ~30 bytes vs ~60 bytes for `NVARCHAR(100)` on a 30-character name. On 10 million rows, this saves approximately 300 MB. Use `NVARCHAR` for international data; use `VARCHAR` when storage efficiency matters and data will remain ASCII-only.

## Design best practices

Apply these key principles when designing and implementing tables to ensure performance and maintainability:

- **Use appropriate data types** - Smaller data types reduce storage and improve performance
- **Consider table size early** - Estimate row size and total table size to plan storage and indexing
- **Implement meaningful constraints** - Ensure data quality at the database level
- **Plan for growth** - Design tables to handle future data volume
- **Index strategically** - Index columns used in `WHERE`, `JOIN`, and `ORDER BY` clauses
- **Choose columnstore for analytics** - Use columnstore indexes for large tables with analytical queries
- **Normalize when appropriate** - Balance normalization with query performance needs
- **Monitor row and page compression** - Enable compression for large tables to save storage

Most database performance issues stem from poor design decisions made early in development. Oversized data types waste storage and slow queries. Missing or wrong index types create bottlenecks that resource upgrades can't resolve. Prevent these problems by investing time in proper object design before you create or modify tables. The decisions you make during design—choosing appropriate data types, estimating table sizes, selecting the right index types—have far greater effect on long-term performance and cost than any optimization you can apply later.
