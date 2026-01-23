**SQL Server programmability objects** provide different ways to encapsulate and reuse logic in your database. Each object type—[views](/sql/relational-databases/views/views?azure-portal=true), [stored procedures](/sql/relational-databases/stored-procedures/stored-procedures-database-engine?azure-portal=true), [functions](/sql/relational-databases/user-defined-functions/user-defined-functions?azure-portal=true), and [triggers](/sql/relational-databases/triggers/dml-triggers?azure-portal=true)—serves distinct purposes and offers unique capabilities. Understanding when to use each object helps you build more maintainable, performant, and secure database solutions.

In this unit, you learn the key characteristics of each programmability object and explore decision criteria to help you choose the right tool for your specific scenario.

## Use views to simplify data access

**Views** act as virtual tables that encapsulate SELECT queries. They don't store data themselves but instead provide a saved query definition that executes when you reference the view.

Views excel at simplifying complex queries and providing consistent data access patterns. When you frequently use `JOIN` across multiple tables or apply the same filters across different queries, a view consolidates that logic in one place. For example, if your application regularly needs customer orders with product details, a view can combine those tables once rather than repeating the `JOIN` logic everywhere:

```sql
CREATE VIEW sales.CustomerOrderDetails AS
SELECT 
    o.OrderID,
    c.CustomerName,
    p.ProductName,
    o.OrderDate,
    o.Quantity
FROM sales.Orders o
INNER JOIN sales.Customers c ON o.CustomerID = c.CustomerID
INNER JOIN sales.Products p ON o.ProductID = p.ProductID;
```

Views also provide a **security layer** by controlling column and row visibility. You can grant users access to a view that exposes only specific columns from a table, hiding sensitive data like salary information or personal identifiers. This becomes especially important when different teams need varying levels of access to the same underlying data.

However, views have limitations. They can't accept parameters, perform data modifications (except for simple single-table views), or execute procedural logic. When you need these capabilities, consider other programmability objects instead.

## Use stored procedures for complex operations

**Stored procedures** contain precompiled T-SQL code that can include multiple statements, control flow logic, and transaction management. Unlike views, stored procedures can modify data and accept input parameters.

Stored procedures work best for **complex business operations** that involve multiple steps or data modifications. When you need to insert data into several related tables, validate business rules, and handle errors as part of a single transaction, a stored procedure provides the structure you need:

```sql
CREATE PROCEDURE sales.ProcessOrder
    @CustomerID INT,
    @ProductID INT,
    @Quantity INT
AS
BEGIN
    BEGIN TRANSACTION;
    
    -- Check product availability
    DECLARE @AvailableStock INT;
    SELECT @AvailableStock = StockQuantity 
    FROM sales.Products 
    WHERE ProductID = @ProductID;
    
    IF @AvailableStock >= @Quantity
    BEGIN
        -- Insert order
        INSERT INTO sales.Orders (CustomerID, ProductID, Quantity, OrderDate)
        VALUES (@CustomerID, @ProductID, @Quantity, GETDATE());
        
        -- Update inventory
        UPDATE sales.Products 
        SET StockQuantity = StockQuantity - @Quantity 
        WHERE ProductID = @ProductID;
        
        COMMIT TRANSACTION;
    END
    ELSE
    BEGIN
        ROLLBACK TRANSACTION;
        RAISERROR('Insufficient stock available', 16, 1);
    END
END;
```

Stored procedures also improve **performance** for frequently executed operations. SQL Server compiles and caches the execution plan, reducing overhead for subsequent executions. Additionally, they reduce network traffic by executing multiple operations on the server side rather than sending individual SQL statements from the client.

Use stored procedures when you need to encapsulate business logic, perform data modifications, or execute operations that require transaction control and error handling.

## Use functions to return computed values

**Functions** differ from stored procedures in a fundamental way: they must return a value and can be used directly in SQL expressions. SQL Server supports two main types—**scalar functions** that return a single value and **table-valued functions** that return a result set.

Functions work best for **reusable calculations and transformations**. When you frequently need to apply the same formula or conversion across different queries, a scalar function centralizes that logic. For instance, calculating tax on order amounts becomes consistent when you use a function:

```sql
CREATE FUNCTION sales.CalculateTax
    (@Amount DECIMAL(10,2),
     @TaxRate DECIMAL(5,4))
RETURNS DECIMAL(10,2)
AS
BEGIN
    RETURN @Amount * @TaxRate;
END;

-- Use the function in a query
SELECT 
    OrderID,
    OrderAmount,
    dbo.CalculateTax(OrderAmount, 0.0825) AS TaxAmount
FROM sales.Orders;
```

**Table-valued functions** provide parameterized, reusable query logic. Unlike views, they accept parameters, making them more flexible for scenarios where you need to filter or transform data based on input values:

```sql
CREATE FUNCTION sales.GetCustomerOrders
    (@CustomerID INT,
     @StartDate DATE)
RETURNS TABLE
AS
RETURN
(
    SELECT OrderID, OrderDate, TotalAmount
    FROM sales.Orders
    WHERE CustomerID = @CustomerID 
      AND OrderDate >= @StartDate
);

-- Use the function like a table
SELECT * FROM sales.GetCustomerOrders(101, '2024-01-01');
```

However, functions have strict limitations. They can't modify data, can't use non-deterministic functions like `GETDATE()` in scalar functions, and can impact performance when used in large queries. Use functions when you need to embed calculations in queries or return parameterized result sets, but avoid them for operations that modify data or require complex procedural logic.

## Use triggers for automatic event responses

**Triggers** are special stored procedures that execute automatically when specific data modification events occur. They fire in response to INSERT, UPDATE, or DELETE operations on a table.

Triggers excel at **enforcing business rules** and **maintaining data integrity** across related tables. When you need to automatically log changes, validate complex constraints, or synchronize data between tables, triggers provide an event-driven solution:

```sql
CREATE TRIGGER sales.AuditOrderChanges
ON sales.Orders
AFTER UPDATE
AS
BEGIN
    INSERT INTO sales.OrderAuditLog (OrderID, ModifiedDate, ModifiedBy, OldAmount, NewAmount)
    SELECT 
        i.OrderID,
        GETDATE(),
        SYSTEM_USER,
        d.TotalAmount,
        i.TotalAmount
    FROM inserted i
    INNER JOIN deleted d ON i.OrderID = d.OrderID
    WHERE i.TotalAmount <> d.TotalAmount;
END;
```

Triggers also help **maintain referential integrity** in scenarios where declarative constraints aren't sufficient. For example, you might use a trigger to prevent deleting a customer who has pending orders, or to automatically archive records before deletion.

However, triggers execute implicitly, which can make debugging difficult and impact performance when they contain complex logic. They also add hidden dependencies that developers might overlook when modifying tables. Use triggers sparingly, primarily for audit logging, enforcing business rules that can't be expressed as constraints, or maintaining denormalized data that must stay synchronized.

## Choose based on your requirements

The right programmability object depends on what you need to accomplish. Use this decision framework to guide your selection:

**Choose views when you need to:**
- Simplify access to complex joins or commonly filtered data
- Provide a security layer by controlling column and row visibility
- Create a stable interface to underlying tables that might change
- Present data without accepting parameters or modifying values

**Choose stored procedures when you need to:**
- Execute complex business logic with multiple statements
- Modify data across multiple tables in a single transaction
- Accept input parameters and return output parameters or result sets
- Implement error handling and transaction control

**Choose functions when you need to:**
- Perform reusable calculations that return values for use in queries
- Return parameterized result sets (table-valued functions)
- Embed logic directly in `SELECT`, `WHERE`, or `JOIN` clauses
- Ensure deterministic results for indexing (for specific function types)

**Choose triggers when you need to:**
- Automatically respond to data modification events
- Enforce complex business rules that extend beyond constraints
- Maintain audit logs of data changes
- Synchronize related data across tables automatically

With this understanding of each programmability object's strengths and use cases, you can select the appropriate tool for your database design and implementation tasks.
