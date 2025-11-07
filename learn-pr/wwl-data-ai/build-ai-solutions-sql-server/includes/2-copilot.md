[SQL Server Management Studio (SSMS)](/sql/ssms/sql-server-management-studio-ssms?azure-portal=true) supports two AI-powered coding assistants that help you write, optimize, and troubleshoot [T-SQL](/sql/t-sql/language-reference?azure-portal=true) code. [GitHub Copilot](/ssms/github-copilot/overview?azure-portal=true) provides general coding assistance across multiple languages, while [Copilot](/ssms/copilot/copilot-in-ssms-overview?azure-portal=true) offers database-aware suggestions specific to your connected SQL Server instance.

Both tools use large language models to accelerate database development. GitHub Copilot excels at code completion and pattern recognition across your entire codebase, while Copilot leverages your database schema, indexes, and statistics to provide contextually aware T-SQL assistance.

These AI assistants make database development more accessible and improve productivity for both new and experienced developers. Whether you're writing queries, debugging code, or optimizing performance, AI-powered assistance helps you focus on solving business problems rather than remembering syntax.

## Use GitHub Copilot in SSMS

[GitHub Copilot in SSMS](/ssms/github-copilot/overview?azure-portal=true) brings AI-powered code completion and generation to your database development workflow. As a general-purpose coding assistant, GitHub Copilot helps you write T-SQL faster by suggesting code as you type and generating entire queries from natural language comments.

### Understand GitHub Copilot capabilities

GitHub Copilot provides several features for SQL Server development:

- **Inline code completion:** Real-time suggestions as you write T-SQL code
- **Natural language to code:** Write comments describing your intent, get working queries
- **Multi-line suggestions:** Generate entire query blocks, procedures, or functions
- **Pattern recognition:** Learn from your coding style and common patterns in your workspace
- **Context-aware:** Considers the code you've already written in the current file
- **Multi-language support:** Works with T-SQL, PowerShell, Python, and other languages used in database projects

GitHub Copilot analyzes your current file, open tabs, and workspace to provide relevant suggestions. While it doesn't connect directly to your database, it recognizes T-SQL syntax patterns and common database development practices.

### Enable GitHub Copilot in SSMS

To use GitHub Copilot in SQL Server Management Studio:

1. Ensure you have [SSMS 19.3](/ssms/download-sql-server-management-studio-ssms?azure-portal=true) or later installed
2. Install the [GitHub Copilot extension](/ssms/github-copilot/install-remove-enable-disable?azure-portal=true) from the Extensions menu
3. Sign in with your GitHub account that has an active [GitHub Copilot subscription](https://github.com/features/copilot/plans?azure-portal=true)
4. Configure your preferences in **Tools > Options > GitHub Copilot**

> [!NOTE]
> GitHub Copilot requires a paid subscription (Individual, Business, or Enterprise). Some organizations provide GitHub Copilot for their developers as part of their development tools license.

### Write code with inline suggestions

GitHub Copilot provides suggestions as you type:

```sql
-- Start typing a query
SELECT c.CustomerName, 
-- Copilot suggests: c.Email, c.Phone, c.City
-- Press Tab to accept

-- Or write a comment describing what you need:
-- Get total sales by product category for last quarter

-- Copilot generates:
SELECT 
    p.Category,
    SUM(od.Quantity * od.UnitPrice) AS TotalSales
FROM Products p
INNER JOIN OrderDetails od ON p.ProductID = od.ProductID
INNER JOIN Orders o ON od.OrderID = o.OrderID
WHERE o.OrderDate >= DATEADD(QUARTER, -1, GETDATE())
GROUP BY p.Category
ORDER BY TotalSales DESC;
```

The gray ghost text shows Copilot's suggestions. Press **Tab** to accept or **Esc** to dismiss.

### Generate stored procedures and functions

Describe complex database objects in comments:

```sql
-- Create a stored procedure to calculate customer lifetime value
-- Parameters: @CustomerID int
-- Returns: @TotalValue money, @OrderCount int, @FirstOrderDate date, @LastOrderDate date

-- GitHub Copilot generates:
CREATE PROCEDURE sp_GetCustomerLifetimeValue
    @CustomerID INT
AS
BEGIN
    SELECT 
        @CustomerID AS CustomerID,
        SUM(od.Quantity * od.UnitPrice) AS TotalValue,
        COUNT(DISTINCT o.OrderID) AS OrderCount,
        MIN(o.OrderDate) AS FirstOrderDate,
        MAX(o.OrderDate) AS LastOrderDate
    FROM Orders o
    INNER JOIN OrderDetails od ON o.OrderID = od.OrderID
    WHERE o.CustomerID = @CustomerID
    GROUP BY o.CustomerID;
END;
```

GitHub Copilot understands procedural patterns and generates complete, executable code.

### Explore database schema

GitHub Copilot helps write queries to explore your database structure:

```sql
-- Show all foreign key relationships for Orders table

-- Copilot suggests:
SELECT 
    fk.name AS ForeignKeyName,
    OBJECT_NAME(fk.parent_object_id) AS TableName,
    COL_NAME(fkc.parent_object_id, fkc.parent_column_id) AS ColumnName,
    OBJECT_NAME(fk.referenced_object_id) AS ReferencedTable,
    COL_NAME(fkc.referenced_object_id, fkc.referenced_column_id) AS ReferencedColumn
FROM sys.foreign_keys fk
INNER JOIN sys.foreign_key_columns fkc ON fk.object_id = fkc.constraint_object_id
WHERE OBJECT_NAME(fk.parent_object_id) = 'Orders'
   OR OBJECT_NAME(fk.referenced_object_id) = 'Orders';
```

### Learn from your coding patterns

GitHub Copilot adapts to your style over time. If you consistently use specific naming conventions, formatting, or patterns, Copilot incorporates them into suggestions:

```sql
-- If you typically write your queries like this:
SELECT 
    c.CustomerID
    ,c.CustomerName
    ,c.Email
FROM Customers AS c
WHERE c.IsActive = 1;

-- Copilot learns your style and suggests:
SELECT 
    o.OrderID
    ,o.OrderDate
    ,o.TotalAmount
FROM Orders AS o
WHERE o.Status = 'Completed';
```

This personalization makes suggestions feel more natural and reduces the need for manual formatting.

### Apply GitHub Copilot best practices

Maximize GitHub Copilot's effectiveness:

| Practice | Description |
|----------|-------------|
| **Write descriptive comments** | Clear, specific comments produce better code suggestions |
| **Use meaningful names** | Descriptive table and column names help Copilot understand context |
| **Break down complex tasks** | Write multiple comments for complex procedures rather than one large block |
| **Review all suggestions** | Always validate generated code for correctness and security |
| **Provide examples** | Include sample data or expected output in comments |
| **Keep context nearby** | Open related files or schemas to give Copilot more context |
| **Iterate on suggestions** | If the first suggestion isn't quite right, try rephrasing your comment |

## Use Copilot in SSMS

[Copilot in SSMS](/ssms/copilot/copilot-in-ssms-overview?azure-portal=true) provides database-aware AI assistance that connects directly to your SQL Server instance. Unlike GitHub Copilot, Copilot has access to your database schema, indexes, statistics, and metadata, enabling more contextually accurate T-SQL suggestions.

:::image type="content" source="../media/ssms.png" alt-text="Screenshot showing GitHub Copilot in SQL Server Management Studio with AI-powered code completion." lightbox="../media/ssms.png" border="false":::

### Understand Copilot capabilities

Copilot offers database-specific features:

- **Schema-aware suggestions:** Knows your exact table structures, columns, and data types
- **Query optimization:** Analyzes execution plans and suggests performance improvements
- **Natural language queries:** Converts questions into T-SQL based on your actual database
- **Explain queries:** Describes what existing queries do in plain language
- **Fix errors:** Provides context-aware suggestions when queries fail
- **Index recommendations:** Suggests indexes based on your database statistics

Because Copilot connects to your database, it generates code that works with your specific schema without modification.

### Query with natural language

Ask questions about your data using plain English:

```sql
-- Ask Copilot: "Show customers who placed more than 5 orders last month"

-- Copilot generates (using your actual schema):
SELECT 
    c.CustomerID,
    c.CustomerName,
    c.Email,
    COUNT(o.OrderID) AS OrderCount
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.OrderDate >= DATEADD(MONTH, -1, GETDATE())
    AND o.OrderDate < DATEADD(DAY, 1, EOMONTH(DATEADD(MONTH, -1, GETDATE())))
GROUP BY c.CustomerID, c.CustomerName, c.Email
HAVING COUNT(o.OrderID) > 5
ORDER BY OrderCount DESC;
```

Copilot knows your exact table and column names, ensuring the query works immediately.

### Optimize query performance

Copilot analyzes queries and suggests improvements:

```sql
-- Select a slow query and ask: "How can I make this faster?"

-- Original query:
SELECT c.CustomerName, SUM(od.Quantity * od.UnitPrice) AS Total
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
LEFT JOIN OrderDetails od ON o.OrderID = od.OrderID
WHERE o.OrderDate >= '2024-01-01'
GROUP BY c.CustomerName;

-- Copilot suggests:
-- 1. Change LEFT JOIN to INNER JOIN (WHERE filters out NULLs anyway)
-- 2. Add covering index: CREATE INDEX IX_Orders_Date ON Orders(OrderDate, CustomerID, OrderID)
-- 3. Consider indexed view for frequent aggregations

-- Optimized query:
SELECT c.CustomerName, SUM(od.Quantity * od.UnitPrice) AS Total
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID
INNER JOIN OrderDetails od ON o.OrderID = od.OrderID
WHERE o.OrderDate >= '2024-01-01'
GROUP BY c.CustomerName
OPTION (RECOMPILE);
```

### Understand and fix errors

When queries fail, Copilot explains the issue and provides fixes:

```sql
-- Query with error:
SELECT CustomerName, SUM(TotalAmount)
FROM Orders;

-- Error: Column 'Orders.CustomerName' is invalid in the select list

-- Ask Copilot: "What's wrong with this query?"

-- Copilot explains and fixes:
/*
The error occurs because CustomerName is not in an aggregate function or GROUP BY clause.
When using aggregate functions like SUM(), all non-aggregated columns must be grouped.
*/

-- Corrected query:
SELECT CustomerName, SUM(TotalAmount) AS Total
FROM Orders
GROUP BY CustomerName;
```

### Choose the right tool

Both tools offer value for SQL Server development:

| Feature | GitHub Copilot | Copilot |
|---------|----------------|-------------------|
| **Database schema awareness** | No | Yes |
| **Multi-language support** | Yes | T-SQL focus |
| **Query optimization** | Pattern-based | Database-specific |
| **Works outside SSMS** | Yes | No |
| **Requires database connection** | No | Yes |
| **Subscription** | GitHub Copilot | Copilot |

Use **GitHub Copilot** for general T-SQL development, multi-language projects, and code completion across your entire codebase. Use **Copilot** for database-specific tasks where schema awareness, query optimization, and direct database interaction provide better results.

Many developers use both: GitHub Copilot for day-to-day coding and Copilot when working with specific database instances. Together, these AI assistants accelerate database development while maintaining code quality and security standards.
