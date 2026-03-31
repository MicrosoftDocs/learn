[SQL Server Management Studio (SSMS)](/sql/ssms/sql-server-management-studio-ssms?azure-portal=true) includes [GitHub Copilot](/ssms/github-copilot/overview?azure-portal=true), an AI-powered assistant that helps you write, optimize, and troubleshoot [T-SQL](/sql/t-sql/language-reference?azure-portal=true) code. GitHub Copilot provides code completions in the query editor when writing T-SQL, and also provides a chat where you can use natural language to get help writing queries, ask questions about your database or environment, and get help with SQL issues. You should always use the latest release of SSMS (currently SSMS 22) as that is the GA release.

GitHub Copilot allows you to select a model, and available models vary based on your subscription. GitHub Copilot offers code completion and leverages your connection and database schema to provide context to the model and improve responses.

GitHub Copilot makes database development more accessible and improves productivity for both new and experienced developers. Whether you're writing queries, troubleshooting issues with your code, or optimizing performance, GitHub Copilot helps you focus on solving business problems rather than remembering syntax.

## Understand GitHub Copilot in SQL Server Management Studio

[GitHub Copilot in SSMS](/ssms/github-copilot/overview?azure-portal=true) brings AI-powered code completion, generation, and chat to your database development workflow. GitHub Copilot helps you write T-SQL faster by suggesting code as you type, generating entire queries from natural language comments, and providing a chat experience where you can ask questions about your database and get help with SQL issues.

### Explore GitHub Copilot capabilities

GitHub Copilot provides several features for SQL Server development:

- **Inline code completion:** Real-time suggestions as you write T-SQL code
- **Natural language to code:** Write comments describing your intent, get working queries
- **Multi-line suggestions:** Generate entire query blocks, procedures, or functions
- **Context aware:** Understands the schema of the database to which you're connected

GitHub Copilot also offers these features via its chat:

- **Schema-aware suggestions:** Knows your exact table structures, columns, and data types
- **Query optimization:** Analyzes queries and suggests performance improvements
- **Natural language queries:** Converts questions into T-SQL based on the database to which you're connected
- **Explain queries:** Describes what existing queries do in plain language
- **Fix errors:** Provides context-aware suggestions when queries fail
- **Index recommendations:** Suggests indexes based on the missing index suggestions in the DMVs or in a query plan

GitHub Copilot also provides assistance troubleshooting query and database performance, along with answering questions about database maintenance, best practices, database and server configuration, and more.

### Enable GitHub Copilot in SSMS

To use GitHub Copilot in SQL Server Management Studio:

1. Ensure you have [SSMS 22](/ssms/download-sql-server-management-studio-ssms?azure-portal=true) installed
2. Install GitHub Copilot by selecting the **AI Assistance** workload in the [Visual Studio Installer](/ssms/github-copilot/installation-state?azure-portal=true)
3. Sign in with your GitHub account that has an active [GitHub Copilot subscription](https://github.com/features/copilot/plans?azure-portal=true)
4. Configure your preferences in **Tools > Options > GitHub > Copilot** and **Tools > Options > Text Editor > Inline Suggestions**

> [!NOTE]
> GitHub Copilot requires a subscription (Individual, Business, or Enterprise). Some organizations provide GitHub Copilot for their developers as part of their development tools license. A GitHub Copilot subscription can also be used with Visual Studio and VS Code.

### Write code with inline suggestions

GitHub Copilot provides suggestions as you type:

```sql
-- Start typing a query
SELECT c.CustomerName, 
-- GitHub Copilot suggests: c.Email, c.Phone, c.City
-- Press Tab to accept

-- Or write a comment describing what you need:
-- Get total sales by product category for last quarter

-- GitHub Copilot generates:
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

The gray ghost text shows GitHub Copilot's suggestions. Press **Tab** to accept or **Esc** to dismiss.

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

-- GitHub Copilot suggests:
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

### Apply coding patterns of the current editor

GitHub Copilot follows the coding patterns in your current editor. If you use specific naming conventions, formatting, or patterns, GitHub Copilot incorporates them into suggestions:

```sql
-- If you typically write your queries like this:
SELECT 
    c.CustomerID
    ,c.CustomerName
    ,c.Email
FROM Customers AS c
WHERE c.IsActive = 1;

-- GitHub Copilot follows your style and suggests:
SELECT 
    o.OrderID
    ,o.OrderDate
    ,o.TotalAmount
FROM Orders AS o
WHERE o.Status = 'Completed';
```

This consistency makes suggestions feel more natural and reduces the need for manual formatting.

### Apply GitHub Copilot best practices

Maximize GitHub Copilot's effectiveness:

| Practice | Description |
|----------|-------------|
| **Write descriptive comments** | Clear, specific comments produce better code suggestions |
| **Use meaningful names** | Descriptive table and column names help GitHub Copilot understand context |
| **Break down complex tasks** | Write multiple comments for complex procedures rather than one large block |
| **Review all suggestions** | Always validate generated code for correctness and security |
| **Provide examples** | Include sample data or expected output in comments |
| **Iterate on suggestions** | If the first suggestion isn't right, try rephrasing your comment |

### Query with natural language

Ask questions about your data using plain English:

```sql
-- Ask GitHub Copilot: "Show customers who placed more than 5 orders last month"

-- GitHub Copilot generates (using your actual schema):
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

Because GitHub Copilot connects to your database, it generates code that works with your specific schema.

### Optimize query performance

GitHub Copilot analyzes queries and suggests improvements:

```sql
-- Select a slow query and ask: "How can I make this faster?"

-- Original query:
SELECT c.CustomerName, SUM(od.Quantity * od.UnitPrice) AS Total
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
LEFT JOIN OrderDetails od ON o.OrderID = od.OrderID
WHERE o.OrderDate >= '2024-01-01'
GROUP BY c.CustomerName;

-- GitHub Copilot suggests:
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

When queries fail, GitHub Copilot explains the issue and provides fixes:

```sql
-- Query with error:
SELECT CustomerName, SUM(TotalAmount)
FROM Orders;

-- Error: Column 'Orders.CustomerName' is invalid in the select list

-- Ask GitHub Copilot: "What's wrong with this query?"

-- GitHub Copilot explains and fixes:
/*
The error occurs because CustomerName is not in an aggregate function or GROUP BY clause.
When using aggregate functions like SUM(), all non-aggregated columns must be grouped.
*/

-- Corrected query:
SELECT CustomerName, SUM(TotalAmount) AS Total
FROM Orders
GROUP BY CustomerName;
```

### Get the most from GitHub Copilot

The GitHub Copilot chat window works without a database connection, but it's much more valuable when you have a query editor open and connected to a database. Use GitHub Copilot for general T-SQL development, code completion in the editor, understanding your database and server, query optimization, and more.

Developers can use GitHub Copilot for day-to-day coding and to answer specific database questions, helping accelerate database development while maintaining code quality and leveraging best practices.
