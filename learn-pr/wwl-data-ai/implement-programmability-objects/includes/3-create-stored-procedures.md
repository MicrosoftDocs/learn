[Stored procedures](/sql/relational-databases/stored-procedures/stored-procedures-database-engine?azure-portal=true) are one of the most powerful tools in SQL Server for encapsulating business logic and improving application performance. When you create stored procedures, you build reusable code blocks that execute on the server, reducing network traffic and centralizing data access logic.

## Understand stored procedures

A stored procedure is a compiled collection of T-SQL statements that SQL Server stores and executes as a single unit. Unlike unplanned queries that you send to the server each time, stored procedures are precompiled and optimized, which means they run faster on subsequent executions.

You use stored procedures to encapsulate complex business logic, enforce data validation rules, and control how applications interact with your database. For example, instead of allowing direct table access, you can create stored procedures that validate input, apply business rules, and log changes before modifying data.

The performance benefits come from query plan caching. With unplanned queries, SQL Server must parse and optimize each query every time. With stored procedures, the execution plan is cached after the first run, reducing overhead for repeated operations.

## Create basic stored procedures

Creating a stored procedure starts with the [`CREATE PROCEDURE`](/sql/t-sql/statements/create-procedure-transact-sql?azure-portal=true) statement followed by your T-SQL logic. You specify the procedure name using a schema-qualified identifier, which improves clarity and performance.

```sql
CREATE PROCEDURE dbo.GetCustomerOrders
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        OrderID,
        CustomerID,
        OrderDate,
        TotalAmount
    FROM dbo.Orders
    ORDER BY OrderDate DESC;
END
```

The `SET NOCOUNT ON` statement prevents the message about the number of rows affected from being sent to the client. This reduces network traffic and improves performance, especially when the procedure executes multiple statements.

When you create procedures, use the `BEGIN` and `END` keywords to clearly define the procedure body. This makes your code more readable and helps prevent errors when adding or modifying logic later.

## Work with parameters

Parameters make stored procedures flexible and reusable. You define input parameters to accept values from the calling application, and output parameters to return values back to the caller.

Input parameters use the @ symbol followed by a parameter name and data type. You can provide default values to make parameters optional:

```sql
CREATE PROCEDURE dbo.GetCustomerOrdersByDate
    @CustomerID int,
    @StartDate datetime = NULL,
    @EndDate datetime = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        OrderID,
        OrderDate,
        TotalAmount
    FROM dbo.Orders
    WHERE CustomerID = @CustomerID
        AND (@StartDate IS NULL OR OrderDate >= @StartDate)
        AND (@EndDate IS NULL OR OrderDate <= @EndDate)
    ORDER BY OrderDate DESC;
END
```

Output parameters let you return values to the calling application. You define them using the `OUTPUT` keyword:

```sql
CREATE PROCEDURE dbo.CalculateOrderTotal
    @OrderID int,
    @TotalAmount decimal(10,2) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT @TotalAmount = SUM(Quantity * UnitPrice)
    FROM dbo.OrderDetails
    WHERE OrderID = @OrderID;
    
    RETURN 0;
END
```

When you call a procedure with output parameters, you must declare a variable to receive the value and use the `OUTPUT` keyword in the `EXECUTE` statement.

## Implement error handling

Robust stored procedures include error handling to manage unexpected conditions and maintain data integrity. You implement error handling using [`TRY...CATCH`](/sql/t-sql/language-elements/try-catch-transact-sql?azure-portal=true) blocks, which work similarly to exception handling in other programming languages.

```sql
CREATE PROCEDURE dbo.InsertCustomerOrder
    @CustomerID int,
    @OrderDate datetime,
    @TotalAmount decimal(10,2)
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Validate customer exists
        IF NOT EXISTS (SELECT 1 FROM dbo.Customers WHERE CustomerID = @CustomerID)
        BEGIN
            RAISERROR('Customer does not exist.', 16, 1);
        END
        
        -- Insert order
        INSERT INTO dbo.Orders (CustomerID, OrderDate, TotalAmount)
        VALUES (@CustomerID, @OrderDate, @TotalAmount);
        
        COMMIT TRANSACTION;
        RETURN 0;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        
        DECLARE @ErrorMessage nvarchar(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity int = ERROR_SEVERITY();
        DECLARE @ErrorState int = ERROR_STATE();
        
        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
        RETURN -1;
    END CATCH
END
```

The `TRY` block contains your main logic, while the `CATCH` block handles any errors that occur. You can use system functions like `ERROR_MESSAGE()`, `ERROR_SEVERITY()`, and `ERROR_STATE()` to capture error details and pass them to the calling application.

Always check `@@TRANCOUNT` before rolling back transactions in the `CATCH` block. This prevents errors if the transaction already completed or was never started.

## Apply best practices

Following established best practices when you create stored procedures ensures they're maintainable, secure, and performant.

### Use schema-qualified names

Use schema-qualified names for all objects. This eliminates ambiguity and improves performance by avoiding schema resolution overhead:

```sql
-- Good
SELECT * FROM dbo.Orders

-- Avoid
SELECT * FROM Orders
```

### Implement parameter validation

Implement parameter validation at the start of your procedure. Fail fast when inputs are invalid rather than processing bad data:

```sql
IF @CustomerID IS NULL OR @CustomerID <= 0
BEGIN
    RAISERROR('CustomerID must be a positive integer.', 16, 1);
    RETURN -1;
END
```

### Avoid `SELECT *`

Avoid `SELECT *` in production code. Explicitly list columns to prevent issues when table structures change and to improve query performance:

```sql
-- Good
SELECT OrderID, CustomerID, OrderDate FROM dbo.Orders

-- Avoid
SELECT * FROM dbo.Orders
```

### Use meaningful names

Use meaningful names that describe what the procedure does. Include a verb that indicates the operation (Get, Insert, Update, Delete, Calculate):

```sql
CREATE PROCEDURE dbo.GetActiveCustomersByRegion
CREATE PROCEDURE dbo.UpdateCustomerAddress
CREATE PROCEDURE dbo.DeleteExpiredOrders
```

### Avoid the `sp_` prefix

Don't use the `sp_` prefix for your stored procedures. SQL Server reserves this prefix for system procedures stored in the `master` database. When you name a procedure with `sp_`, SQL Server first searches `master` before checking the current database, adding unnecessary overhead:

```sql
-- Good
CREATE PROCEDURE dbo.GetCustomerOrders

-- Avoid
CREATE PROCEDURE dbo.sp_GetCustomerOrders
```

Building on these practices helps you create stored procedures that your team can understand, maintain, and trust to perform reliably in production environments.
