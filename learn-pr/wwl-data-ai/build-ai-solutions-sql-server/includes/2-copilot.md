[Microsoft Copilot](/ssms/copilot/copilot-in-ssms-overview?azure-portal=true) in [SQL Server Management Studio (SSMS)](/sql/ssms/sql-server-management-studio-ssms?azure-portal=true) provides AI-powered assistance for database development tasks. By integrating directly into your workflow, Copilot helps you write, optimize, and troubleshoot [T-SQL](/sql/t-sql/language-reference?azure-portal=true) queries using natural language.

Copilot in SSMS uses large language models combined with your database context—including schema, indexes, and statistics—to provide contextually aware assistance. This allows you to focus on solving business problems rather than remembering exact syntax or navigating documentation.

Copilot in SSMS makes T-SQL development accessible to a broader audience while improving the productivity of experienced developers. Whether you're writing new queries, debugging existing code, or optimizing performance, Copilot provides assistance based on your database environment.

> [!NOTE]
> Microsoft Copilot in SSMS works with multiple SQL Server versions, including earlier versions. When working with SQL Server 2025, Copilot provides enhanced assistance for new AI features like [vector data types](/sql/t-sql/data-types/vector-data-type?azure-portal=true), [embedding generation](/sql/t-sql/functions/ai-generate-embeddings-transact-sql?azure-portal=true), and AI model integration.

## Understand Copilot in SSMS

Copilot in SQL Server Management Studio is available as an optional workload when installing SSMS, which is based on [Visual Studio](/visualstudio/get-started/visual-studio-ide?azure-portal=true) shell and includes 64-bit support, [Git integration](/visualstudio/version-control/git-with-visual-studio?azure-portal=true), and a modernized query editor experience.

:::image type="content" source="../media/ssms.png" alt-text="Screenshot showing Microsoft Copilot in SQL Server Management Studio with AI-powered query assistance." lightbox="../media/ssms.png" border="false":::

### Explore key capabilities

Copilot in SSMS provides several features:

- **Natural language to T-SQL:** Describe what you want in plain English, get working T-SQL code
- **Query generation:** Create complex queries including joins, aggregations, and window functions
- **Code completion:** IntelliSense powered by AI that predicts your next statement
- **Query explanation:** Understand what existing queries do with plain-language explanations
- **Query optimization:** Get suggestions for improving performance with indexes, query hints, and rewriting
- **Error fixing:** Receive context-aware suggestions when queries fail
- **Schema exploration:** Ask questions about your database structure and relationships
- **Database administration:** Get help with maintenance, configuration, and troubleshooting tasks

### Understand how Copilot uses context

Copilot is context-aware, using information about your database to provide relevant suggestions:

- **Schema information:** Tables, columns, data types, and constraints
- **Index details:** Existing indexes and their structure
- **Statistics:** Column distribution statistics for query optimization
- **Connection context:** Current database and user permissions
- **Editor content:** Code you're currently writing or have selected

This contextual awareness means Copilot generates code that actually works with your specific database schema, not generic examples that require modification.

## Enable Copilot in SSMS

Getting started with Copilot requires installing SSMS and configuring the Copilot integration.

### Install SSMS with Copilot

Download and install SQL Server Management Studio 21:

1. Download SSMS from the official Microsoft [download page](https://aka.ms/ssms/21/release/vs_SSMS.exe)
2. Run the installer and select *"Copilot in SQL Server Management Studio"* as an optional workload
3. Complete the installation and launch SSMS

SSMS includes several improvements beyond Copilot:

- 64-bit architecture for better performance with large databases
- Visual Studio shell for modern UI and features
- Git integration for version control
- Enhanced query editor with improved IntelliSense
- Automatic updates through Visual Studio Installer

### Configure Copilot settings

After installation, configure Copilot preferences:

1. Open **Tools > Options** in SSMS
2. Navigate to **Copilot** settings
3. Configure your preferences:
   - Enable/disable inline suggestions
   - Set suggestion display delay
   - Configure context sharing preferences
   - Choose between different AI model options

### Sign in with your Microsoft account

Copilot requires authentication:

1. Select the **Sign In** button in the top-right corner of SSMS
2. Sign in with your Microsoft account (work, school, or personal)
3. Grant necessary permissions for Copilot functionality
4. Verify your Copilot subscription or trial status

> [!NOTE]
> Copilot in SSMS requires authentication with a Microsoft account that has Copilot access. Check with your organization about Copilot availability, or visit the [Microsoft Copilot website](https://www.microsoft.com/microsoft-copilot) for licensing information.

## Write queries with natural language

One of Copilot's most powerful features is generating T-SQL from natural language descriptions.

### Generate simple queries

Start by writing a comment describing what you want:

```sql
-- Find all customers who placed orders in the last 30 days

-- Copilot suggests:
SELECT DISTINCT c.customer_id, c.customer_name, c.email
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_date >= DATEADD(day, -30, GETDATE())
ORDER BY c.customer_name;
```

Copilot understands your intent and generates appropriate T-SQL that joins the right tables, applies the date filter, and removes duplicates.

### Create complex analytical queries

Copilot can generate sophisticated queries with multiple joins and aggregations:

```sql
-- Calculate total revenue by product category for each quarter of 2024, including percentage of total revenue

-- Copilot suggests:
WITH quarterly_revenue AS (
    SELECT 
        p.category,
        DATEPART(QUARTER, o.order_date) AS quarter,
        SUM(oi.quantity * oi.unit_price) AS revenue
    FROM products p
    INNER JOIN order_items oi ON p.product_id = oi.product_id
    INNER JOIN orders o ON oi.order_id = o.order_id
    WHERE YEAR(o.order_date) = 2024
    GROUP BY p.category, DATEPART(QUARTER, o.order_date)
),
total_revenue AS (
    SELECT SUM(revenue) AS total
    FROM quarterly_revenue
)
SELECT 
    qr.category,
    qr.quarter,
    qr.revenue,
    CAST(qr.revenue * 100.0 / tr.total AS DECIMAL(5,2)) AS percentage_of_total
FROM quarterly_revenue qr
CROSS JOIN total_revenue tr
ORDER BY qr.quarter, qr.revenue DESC;
```

This complex query with CTEs, aggregations, and calculations could take significant time to write manually, but Copilot generates it from a simple natural language description.

## Optimize existing queries

Copilot can analyze and improve the performance of existing queries.

### Request optimization suggestions

Select a query and ask Copilot for optimization advice:

```sql
-- Original query (select this in the editor)
SELECT c.customer_name, COUNT(o.order_id) as order_count
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_date >= '2024-01-01'
GROUP BY c.customer_name
HAVING COUNT(o.order_id) > 5;

-- Ask Copilot: "How can I optimize this query?"

-- Copilot suggests:
-- 1. Add index on orders(customer_id, order_date) for better join performance
-- 2. Change LEFT JOIN to INNER JOIN since WHERE clause filters out NULLs
-- 3. Consider adding INCLUDE columns to reduce key lookups

CREATE INDEX IX_Orders_CustomerId_OrderDate 
ON orders(customer_id, order_date)
INCLUDE (order_id);

-- Optimized query:
SELECT c.customer_name, COUNT(o.order_id) as order_count
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_date >= '2024-01-01'
GROUP BY c.customer_name
HAVING COUNT(o.order_id) > 5
OPTION (RECOMPILE);
```

Copilot not only suggests code changes but also explains why each optimization helps and provides the DDL for recommended indexes.

### Identify performance bottlenecks

Ask Copilot to analyze query execution plans:

```sql
-- Select a slow query
-- Ask Copilot: "Why is this query slow? Show me the execution plan analysis"

-- Copilot examines the query plan and explains:
/*
Analysis of execution plan shows:
1. Table Scan on orders (95% of query cost) - Missing index on order_date
2. Sort operation consuming 30% CPU - Consider adding ORDER BY to index
3. Key Lookup operations - Add INCLUDE columns to covering index

Recommendations:
*/

-- Create covering index
CREATE NONCLUSTERED INDEX IX_Orders_Performance
ON orders(order_date, customer_id)
INCLUDE (order_total, status)
WITH (ONLINE = ON, MAXDOP = 4);

-- Update statistics
UPDATE STATISTICS orders WITH FULLSCAN;
```

Copilot provides actionable recommendations based on execution plan analysis.

### Rewrite queries for better performance

Copilot can suggest alternative query structures:

```sql
-- Original correlated subquery (slow)
SELECT 
    c.customer_name,
    (SELECT COUNT(*) FROM orders WHERE customer_id = c.customer_id) as order_count
FROM customers c;

-- Ask Copilot: "Rewrite this to avoid correlated subquery"

-- Copilot suggests using a JOIN:
SELECT 
    c.customer_name,
    ISNULL(o.order_count, 0) as order_count
FROM customers c
LEFT JOIN (
    SELECT customer_id, COUNT(*) as order_count
    FROM orders
    GROUP BY customer_id
) o ON c.customer_id = o.customer_id;

-- Or using window functions for more complex scenarios:
SELECT DISTINCT
    c.customer_name,
    COUNT(o.order_id) OVER (PARTITION BY c.customer_id) as order_count
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id;
```

Multiple optimization approaches help you choose the best solution for your specific scenario.

## Debug and fix errors

When queries fail, Copilot helps identify and resolve issues quickly.

### Understand error messages

Copilot explains cryptic SQL Server errors:

```sql
-- Query with an error
SELECT 
    customer_name,
    SUM(order_total)
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id;

/*
Error: Column 'customers.customer_name' is invalid in the select list 
because it is not contained in either an aggregate function or the GROUP BY clause.

Ask Copilot: "What does this error mean and how do I fix it?"

Copilot explains:
This error occurs because you're using an aggregate function (SUM) without a GROUP BY clause.
When you use aggregate functions, all non-aggregated columns must be in the GROUP BY clause.
*/

-- Copilot suggests the fix:
SELECT 
    c.customer_name,
    SUM(o.order_total) as total_orders
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_name;
```

Copilot not only fixes the error but explains why it occurred, helping you learn and avoid similar mistakes.

### Resolve syntax errors

Get immediate help with syntax issues:

```sql
-- Query with syntax error
SELCT product_name, price
FROM products
WERE category = 'Electronics';

-- Copilot automatically suggests:
SELECT product_name, price
FROM products
WHERE category = 'Electronics';

-- And highlights the corrections:
-- - SELCT → SELECT
-- - WERE → WHERE
```

Real-time error detection and correction prevent common typos and syntax mistakes.

### Fix logical errors

Copilot can identify logical issues in queries:

```sql
-- Query with logical error
SELECT c.customer_name, o.order_total
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_date >= '2024-01-01';

-- Ask Copilot: "This returns fewer customers than expected. What's wrong?"

-- Copilot identifies the issue:
/*
Problem: Using LEFT JOIN but filtering on orders.order_date in WHERE clause.
This converts your LEFT JOIN to an INNER JOIN because NULL values from 
customers without orders fail the WHERE condition.

Solution: Move the date filter to the JOIN condition or use ISNULL/COALESCE.
*/

-- Corrected query:
SELECT c.customer_name, o.order_total
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id 
    AND o.order_date >= '2024-01-01';
```

Copilot catches subtle logical errors that might otherwise take time to debug.

## Explore database schema with Copilot

Copilot helps you navigate and understand your database structure.

### Ask questions about schema

Query your database structure using natural language:

```sql
-- Ask Copilot: "What tables store customer information?"

-- Copilot responds and generates a query:
/*
The following tables contain customer-related data:
- customers: Primary customer information
- customer_addresses: Customer shipping/billing addresses
- customer_preferences: User preferences and settings
*/

SELECT 
    t.name AS table_name,
    s.name AS schema_name,
    COUNT(c.column_id) AS column_count
FROM sys.tables t
INNER JOIN sys.schemas s ON t.schema_id = s.schema_id
INNER JOIN sys.columns c ON t.object_id = c.object_id
WHERE t.name LIKE '%customer%'
GROUP BY t.name, s.name
ORDER BY t.name;
```

Copilot generates queries to explore schema metadata based on your questions.

### Understand table relationships

Discover foreign key relationships:

```sql
-- Ask Copilot: "Show me all tables related to the orders table"

-- Copilot generates:
SELECT 
    OBJECT_NAME(fk.parent_object_id) AS child_table,
    OBJECT_NAME(fk.referenced_object_id) AS parent_table,
    COL_NAME(fkc.parent_object_id, fkc.parent_column_id) AS child_column,
    COL_NAME(fkc.referenced_object_id, fkc.referenced_column_id) AS parent_column,
    fk.name AS foreign_key_name
FROM sys.foreign_keys fk
INNER JOIN sys.foreign_key_columns fkc 
    ON fk.object_id = fkc.constraint_object_id
WHERE OBJECT_NAME(fk.parent_object_id) = 'orders'
   OR OBJECT_NAME(fk.referenced_object_id) = 'orders'
ORDER BY child_table, parent_table;
```

Understanding relationships helps you write correct joins and maintain referential integrity.

### Generate documentation

Create schema documentation automatically:

```sql
-- Ask Copilot: "Generate documentation for the products table"

-- Copilot generates:
/*
Products Table Documentation
============================

Table: dbo.products
Primary Key: product_id
Created: [Date from sys.tables]

Columns:
*/

SELECT 
    c.name AS column_name,
    t.name AS data_type,
    c.max_length,
    c.is_nullable,
    ISNULL(dc.definition, '') AS default_value,
    ISNULL(ep.value, '') AS description
FROM sys.columns c
INNER JOIN sys.types t ON c.user_type_id = t.user_type_id
LEFT JOIN sys.default_constraints dc ON c.default_object_id = dc.object_id
LEFT JOIN sys.extended_properties ep 
    ON ep.major_id = c.object_id 
    AND ep.minor_id = c.column_id 
    AND ep.name = 'MS_Description'
WHERE c.object_id = OBJECT_ID('dbo.products')
ORDER BY c.column_id;

/*
Indexes:
*/

SELECT 
    i.name AS index_name,
    i.type_desc,
    STRING_AGG(c.name, ', ') AS columns
FROM sys.indexes i
INNER JOIN sys.index_columns ic ON i.object_id = ic.object_id AND i.index_id = ic.index_id
INNER JOIN sys.columns c ON ic.object_id = c.object_id AND ic.column_id = c.column_id
WHERE i.object_id = OBJECT_ID('dbo.products')
GROUP BY i.name, i.type_desc
ORDER BY i.index_id;
```

Automated documentation generation saves time and ensures consistency.

## Perform database administration tasks

Copilot assists with database maintenance and configuration.

### Generate maintenance scripts

Create routine maintenance tasks:

```sql
-- Ask Copilot: "Create a script to rebuild fragmented indexes on the orders table"

-- Copilot generates:
DECLARE @table_name NVARCHAR(128) = 'orders';
DECLARE @rebuild_sql NVARCHAR(MAX);

-- Find fragmented indexes
SELECT 
    @rebuild_sql = STRING_AGG(
        'ALTER INDEX ' + i.name + ' ON ' + OBJECT_SCHEMA_NAME(i.object_id) + '.' + OBJECT_NAME(i.object_id) + 
        ' REBUILD WITH (ONLINE = ON, MAXDOP = 4);',
        CHAR(13) + CHAR(10)
    )
FROM sys.indexes i
INNER JOIN sys.dm_db_index_physical_stats(
    DB_ID(), 
    OBJECT_ID(@table_name), 
    NULL, 
    NULL, 
    'LIMITED'
) ps ON i.object_id = ps.object_id AND i.index_id = ps.index_id
WHERE ps.avg_fragmentation_in_percent > 30
  AND i.name IS NOT NULL;

-- Execute rebuild commands
IF @rebuild_sql IS NOT NULL
BEGIN
    PRINT 'Rebuilding fragmented indexes...';
    EXEC sp_executesql @rebuild_sql;
    PRINT 'Index rebuild complete.';
END
ELSE
    PRINT 'No fragmented indexes found.';
```

Copilot generates production-ready maintenance scripts with best practices built in.

### Troubleshoot performance issues

Get help diagnosing database problems:

```sql
-- Ask Copilot: "Show me the top 10 most expensive queries currently running"

-- Copilot generates:
SELECT TOP 10
    r.session_id,
    r.start_time,
    r.status,
    r.command,
    SUBSTRING(qt.text, r.statement_start_offset/2 + 1,
        (CASE WHEN r.statement_end_offset = -1
            THEN LEN(CONVERT(NVARCHAR(MAX), qt.text)) * 2
            ELSE r.statement_end_offset
        END - r.statement_start_offset)/2) AS query_text,
    r.cpu_time,
    r.total_elapsed_time,
    r.reads,
    r.writes,
    r.logical_reads
FROM sys.dm_exec_requests r
CROSS APPLY sys.dm_exec_sql_text(r.sql_handle) qt
WHERE r.session_id > 50  -- Exclude system sessions
ORDER BY r.cpu_time DESC;
```

Quick access to diagnostic queries helps resolve performance issues faster.

### Configure database settings

Get assistance with database configuration:

```sql
-- Ask Copilot: "Configure this database for optimal vector search performance"

-- Copilot suggests:
-- Enable required features (SQL Server 2025)
ALTER DATABASE SCOPED CONFIGURATION SET PREVIEW_FEATURES = ON;

-- Optimize memory for vector operations
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 8;
ALTER DATABASE SCOPED CONFIGURATION SET OPTIMIZE_FOR_AD_HOC_WORKLOADS = ON;

-- Configure parallelism thresholds
EXEC sp_configure 'cost threshold for parallelism', 50;
EXEC sp_configure 'max degree of parallelism', 8;
RECONFIGURE;

-- Set appropriate recovery model
ALTER DATABASE CURRENT SET RECOVERY SIMPLE;

-- Configure tempdb for vector operations
ALTER DATABASE tempdb MODIFY FILE (NAME = tempdev, SIZE = 8192MB, FILEGROWTH = 512MB);
```

Copilot provides configuration recommendations tailored to your specific use case. When working with SQL Server 2025, Copilot offers enhanced suggestions for new AI capabilities including vector search optimization, embedding generation configuration, and external AI model setup.

## Apply Copilot best practices

Maximize the value of Copilot with these guidelines.

| Category | Practice | Description |
|----------|----------|-------------|
| **Write clear, descriptive prompts** | Be specific | Instead of "get data," write "get customer names and their total order value for 2024" |
| | Include context | Mention table names, column names, and business rules |
| | Specify format | Indicate if you want specific output formats or sorting |
| | Set constraints | Mention performance requirements or filtering criteria |
| **Review and validate generated code** | Check table and column names | Verify Copilot used the correct schema |
| | Test with sample data | Run queries on a small dataset first |
| | Validate business logic | Ensure calculations and filters match requirements |
| | Review performance | Check execution plans for expensive operations |
| | Consider security | Verify generated code doesn't expose sensitive data |
| **Learn from Copilot suggestions** | Read explanations | Understand why Copilot suggests certain approaches |
| | Try alternatives | Ask for different solutions to the same problem |
| | Build knowledge | Use Copilot as a learning tool to improve T-SQL skills |
| | Save patterns | Document useful query patterns for future reference |
| **Balance AI assistance with expertise** | Use judgment | Copilot suggests code, but you make final decisions |
| | Maintain standards | Ensure generated code follows your team's conventions |
| | Consider context | Copilot may not know all business rules or constraints |
| | Verify security | Always review code for SQL injection risks and permission issues |

## Compare Copilot tools for SQL development

While working with SQL Server, you may encounter different AI-powered coding assistants. Understanding the differences helps you choose the right tool for your workflow.

### Microsoft Copilot in SSMS vs GitHub Copilot

Microsoft Copilot in SSMS is purpose-built for SQL Server database development:

- **Database-aware:** Has deep understanding of your connected database schema, indexes, statistics, and metadata
- **Context-specific:** Provides suggestions based on your current database connection and objects
- **SQL Server optimized:** Generates T-SQL code that follows SQL Server best practices and conventions
- **Integrated experience:** Works seamlessly within SSMS with database administration features
- **Requires:** Microsoft Copilot subscription and authentication through Microsoft account

[GitHub Copilot](https://github.com/features/copilot?azure-portal=true) is a general-purpose coding assistant that supports multiple languages:

- **Multi-language:** Supports T-SQL along with Python, JavaScript, C#, and many other languages
- **IDE-agnostic:** Works across Visual Studio Code, Visual Studio, JetBrains IDEs, and other editors
- **Code patterns:** Provides suggestions based on common coding patterns and examples from public code
- **No database context:** Doesn't have access to your specific database schema or metadata
- **Requires:** GitHub Copilot subscription (separate from Microsoft Copilot)

For SQL Server-specific tasks like writing T-SQL queries, optimizing database performance, or exploring schema relationships, **Microsoft Copilot in SSMS** provides superior assistance because of its database awareness. For broader development tasks that span multiple languages or when working outside SSMS, **GitHub Copilot** offers valuable general coding support.

Many SQL Server developers use both tools: Microsoft Copilot in SSMS for database work and GitHub Copilot for application development in their preferred IDE.

By following these practices and understanding the available tools, you can use AI assistance to dramatically improve your productivity while maintaining code quality and security standards. Copilot transforms database development from a tedious, error-prone task into an efficient, collaborative process where AI augments your expertise rather than replacing it.
