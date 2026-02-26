Production database applications must handle unexpected situations gracefully. Division by zero, constraint violations, connection timeouts, and invalid data can all cause errors. Unhandled errors result in unclear error messages, incomplete transactions, or application crashes. Proper error handling ensures your T-SQL code fails predictably and provides meaningful feedback.

Database operations interact with multiple users, external systems, and unpredictable data inputs simultaneously. Unlike application code that might recover from a failed operation by retrying, database errors can leave data in an inconsistent state, with some rows inserted and others not, or with locks held indefinitely. Error handling transforms these chaotic failure modes into controlled, predictable responses.

Well-designed error handling improves your code in several ways:

- **Data integrity protection**: When an operation fails partway through, proper error handling ensures that either all changes commit together or none of them persist. Without this, a multi-step process might leave your database with orphaned records, mismatched totals, or broken relationships.

- **Debugging efficiency**: Capturing error details like the line number, procedure name, and specific error message makes troubleshooting faster. Instead of searching through logs for vague failures, you can pinpoint exactly where and why an error occurred.

- **User experience**: Applications can display meaningful messages like "The product ID doesn't exist" instead of cryptic database errors. This helps users understand what went wrong and how to fix it.

- **Operational visibility**: Logging errors to a dedicated table creates an audit trail that helps identify patterns, such as recurring constraint violations that indicate a bug or timeout errors that suggest performance problems.

- **Graceful degradation**: When one operation fails, error handling lets the rest of your code continue or take alternative action, rather than crashing the entire batch or stored procedure.

## Implement T-SQL error handling

T-SQL provides structured error handling through `TRY...CATCH` blocks, similar to exception handling in other programming languages. When an error occurs in the `TRY` block, execution transfers to the `CATCH` block where you can handle the error appropriately:

```sql
BEGIN TRY
    -- TRY block contains code that might cause an error
    -- If an error occurs here, execution jumps to the CATCH block
    SELECT 1/0;  -- This causes a division by zero error
END TRY
BEGIN CATCH
    -- CATCH block handles the error
    -- This code runs only if an error occurred in the TRY block
    PRINT 'An error occurred';
END CATCH;
```

Without error handling, the same code would terminate with an error message:

```sql
SELECT 1/0;  -- Msg 8134: Divide by zero error encountered
```

> [!NOTE]
> `TRY...CATCH` can't catch all errors. Compilation errors (syntax errors, missing objects) and errors with severity 20 or higher that close the connection can't be caught within the same session.

## Retrieve error information

Within the `CATCH` block, SQL Server provides the following functions to retrieve details about the error that occurred:

| Function | Description |
|----------|-------------|
| `ERROR_NUMBER()` | Returns the error number |
| `ERROR_MESSAGE()` | Returns the complete error message text |
| `ERROR_SEVERITY()` | Returns the error severity (0-25) |
| `ERROR_STATE()` | Returns the error state number |
| `ERROR_LINE()` | Returns the line number where the error occurred |
| `ERROR_PROCEDURE()` | Returns the name of the stored procedure or trigger |

The following example demonstrates how to capture error details and log them to a table for later analysis:

```sql
BEGIN TRY
    -- Attempt an operation that might fail
    INSERT INTO SalesLT.Customer (CustomerID, FirstName, LastName)
    VALUES (1, 'Test', 'Customer');  -- Duplicate key causes error
END TRY
BEGIN CATCH
    -- Log error details to a table using the ERROR_* functions
    INSERT INTO ErrorLog (
        ErrorTime,
        ErrorNumber,
        ErrorSeverity,
        ErrorState,
        ErrorProcedure,
        ErrorLine,
        ErrorMessage
    )
    VALUES (
        GETDATE(),
        ERROR_NUMBER(),       -- The error number (e.g., 2627 for duplicate key)
        ERROR_SEVERITY(),     -- Severity level (0-25)
        ERROR_STATE(),        -- Error state for debugging
        ISNULL(ERROR_PROCEDURE(), 'Ad hoc query'),  -- NULL if not in a procedure
        ERROR_LINE(),         -- Line number where error occurred
        ERROR_MESSAGE()       -- Full error message text
    );
    
    -- Re-raise the error to the calling application
    THROW;
END CATCH;
```

> [!TIP]
> Always log errors before reraising them. Once you use `THROW` or `RAISERROR`, the error functions return `NULL` if called again.

## Handle transactions with TRY...CATCH

When errors occur within transactions, you must explicitly roll back uncommitted work. The `@@TRANCOUNT` function tells you whether a transaction is active:

```sql
BEGIN TRY
    -- Start a transaction to group multiple operations
    BEGIN TRANSACTION;
    
    -- First operation: update product prices
    UPDATE SalesLT.Product
    SET ListPrice = ListPrice * 1.05
    WHERE ProductCategoryID = 5;
    
    -- Second operation: update order totals
    -- If this fails, we want to undo the first update too
    UPDATE SalesLT.SalesOrderHeader
    SET TotalDue = TotalDue * 1.05
    WHERE CustomerID = 12345;
    
    -- Both operations succeeded, make changes permanent
    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    -- Check if a transaction is still active before rolling back
    -- Some errors auto-rollback, so @@TRANCOUNT might be 0
    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;  -- Undo all changes from this transaction
    
    -- Re-raise the error so the caller knows something failed
    THROW;
END CATCH;
```

The `@@TRANCOUNT` check is important because:

- An error might occur before `BEGIN TRANSACTION`
- Some errors automatically roll back the transaction before reaching `CATCH`
- Attempting to rollback without an active transaction causes another error

> [!IMPORTANT]
> Always check `@@TRANCOUNT` before calling `ROLLBACK TRANSACTION` in a `CATCH` block. This prevents the error *"ROLLBACK TRANSACTION request has no corresponding BEGIN TRANSACTION."*

## Raise custom errors with `THROW`

The `THROW` statement raises an exception with a custom error number and message. Use it to signal application-specific error conditions:

```sql
CREATE PROCEDURE ProcessOrder
    @OrderID INT,
    @Quantity INT
AS
BEGIN
    BEGIN TRY
        -- Validate input and raise custom errors for invalid data
        IF @Quantity <= 0
            THROW 50001, 'Quantity must be greater than zero.', 1;
        
        IF NOT EXISTS (SELECT 1 FROM Orders WHERE OrderID = @OrderID)
            THROW 50002, 'Order not found.', 1;
        
        -- Process the order
        UPDATE Orders
        SET Quantity = @Quantity
        WHERE OrderID = @OrderID;
        
    END TRY
    BEGIN CATCH
        -- Log the error before reraising
        EXEC LogError;
        
        -- THROW without parameters reraises the current error
        THROW;
    END CATCH;
END;
```

Custom error numbers for user-defined errors must be 50000 or higher. The state parameter (1 in the examples) is a user-defined value between 1 and 255 that can help identify where the error was raised.

## Use `RAISERROR` for formatted messages

`RAISERROR` provides more formatting options than `THROW`, including printf-style parameter substitution. Including runtime values in error messages makes debugging easier because you can see exactly which data caused the failure without digging through logs or reproducing the issue:

```sql
DECLARE @ProductName NVARCHAR(100) = 'Widget Pro';
DECLARE @CurrentStock INT = 5;
DECLARE @RequestedQty INT = 10;

IF @CurrentStock < @RequestedQty
BEGIN
    RAISERROR(
        'Insufficient stock for product "%s". Available: %d, Requested: %d',
        16,  -- Severity
        1,   -- State
        @ProductName,
        @CurrentStock,
        @RequestedQty
    );
END;
```

> [!NOTE]
> `THROW` is the recommended approach for new code because it's simpler and always includes a stack trace. Use `RAISERROR` when you need formatted messages or compatibility with existing error handling patterns.

## Implement nested error handling

Stored procedures that call other procedures need coordinated error handling. Each level should handle its own cleanup and propagate errors appropriately:

```sql
CREATE PROCEDURE OuterProcedure
AS
BEGIN
    BEGIN TRY
        -- Outer procedure owns the transaction
        BEGIN TRANSACTION;
        
        -- First operation in the outer procedure
        UPDATE SomeTable SET Column1 = 'Value';
        
        -- Call nested procedure - if it fails, error propagates here
        EXEC InnerProcedure;
        
        -- All operations succeeded, commit the transaction
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        -- Outer procedure handles rollback for all nested calls
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        
        -- Propagate error to the application
        THROW;
    END CATCH;
END;
GO

CREATE PROCEDURE InnerProcedure
AS
BEGIN
    BEGIN TRY
        -- Inner procedure does its work within the outer's transaction
        UPDATE AnotherTable SET Column2 = 'Value';
    END TRY
    BEGIN CATCH
        -- Don't rollback here - let the outer procedure handle it
        -- This keeps transaction management in one place
        THROW;  -- Re-raise error to outer procedure
    END CATCH;
END;
```

## Use `XACT_ABORT` for automatic rollback

You can set `XACT_ABORT ON` to cause SQL Server to automatically roll back the transaction when any error occurs, even without `TRY...CATCH` like this:

```sql
SET XACT_ABORT ON;

BEGIN TRANSACTION;
    UPDATE Table1 SET Col1 = 'A';
    UPDATE Table2 SET Col2 = 'B';  -- If this fails, entire transaction rolls back
    UPDATE Table3 SET Col3 = 'C';
COMMIT TRANSACTION;
```

Combining `XACT_ABORT` with `TRY...CATCH` gives you the benefits of both approaches: `XACT_ABORT` guarantees immediate rollback for any error, while `TRY...CATCH` lets you log error details and perform custom cleanup before the error propagates:

```sql
-- XACT_ABORT ON ensures automatic rollback on any error
SET XACT_ABORT ON;

BEGIN TRY
    BEGIN TRANSACTION;
    
    -- Execute multiple procedures as a single unit of work
    EXEC Procedure1;  -- If any of these fail...
    EXEC Procedure2;  -- ...XACT_ABORT automatically rolls back...
    EXEC Procedure3;  -- ...and jumps to the CATCH block
    
    -- All succeeded, commit the changes
    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    -- With XACT_ABORT ON, the transaction is usually already rolled back
    -- This check handles edge cases where it might still be active
    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;
    
    -- Log the error details before re-raising
    EXEC LogError;
    
    -- Let the caller know an error occurred
    THROW;
END CATCH;
```

> [!TIP]
> Using `SET XACT_ABORT ON` is a best practice for stored procedures, especially those that span multiple operations. It ensures consistent behavior regardless of the specific error that occurs.

For more information about error handling, see [TRY...CATCH (Transact-SQL)](/sql/t-sql/language-elements/try-catch-transact-sql?azure-portal=true) and [THROW (Transact-SQL)](/sql/t-sql/language-elements/throw-transact-sql?azure-portal=true).
