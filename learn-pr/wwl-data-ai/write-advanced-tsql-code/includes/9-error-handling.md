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
    -- Code that might cause an error
    SELECT 1/0;  -- Division by zero
END TRY
BEGIN CATCH
    -- Error handling code
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

Within the `CATCH` block, SQL Server provides functions to retrieve details about the error that occurred:

| Function | Description |
|----------|-------------|
| `ERROR_NUMBER()` | Returns the error number |
| `ERROR_MESSAGE()` | Returns the complete error message text |
| `ERROR_SEVERITY()` | Returns the error severity (0-25) |
| `ERROR_STATE()` | Returns the error state number |
| `ERROR_LINE()` | Returns the line number where the error occurred |
| `ERROR_PROCEDURE()` | Returns the name of the stored procedure or trigger |

Use these functions to log detailed error information:

```sql
BEGIN TRY
    -- Attempt an operation that will fail
    INSERT INTO SalesLT.Customer (CustomerID, FirstName, LastName)
    VALUES (1, 'Test', 'Customer');  -- Duplicate key
END TRY
BEGIN CATCH
    SELECT 
        ERROR_NUMBER() AS ErrorNumber,
        ERROR_MESSAGE() AS ErrorMessage,
        ERROR_SEVERITY() AS ErrorSeverity,
        ERROR_STATE() AS ErrorState,
        ERROR_LINE() AS ErrorLine,
        ERROR_PROCEDURE() AS ErrorProcedure;
END CATCH;
```

Create a complete error logging pattern:

```sql
BEGIN TRY
    -- Your business logic here
    UPDATE SalesLT.Product
    SET ListPrice = ListPrice * 1.10
    WHERE ProductCategoryID = 999;  -- Non-existent category
END TRY
BEGIN CATCH
    -- Log error to a table
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
        ERROR_NUMBER(),
        ERROR_SEVERITY(),
        ERROR_STATE(),
        ISNULL(ERROR_PROCEDURE(), 'Ad hoc query'),
        ERROR_LINE(),
        ERROR_MESSAGE()
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
    BEGIN TRANSACTION;
    
    -- First operation
    UPDATE SalesLT.Product
    SET ListPrice = ListPrice * 1.05
    WHERE ProductCategoryID = 5;
    
    -- Second operation (might fail)
    UPDATE SalesLT.SalesOrderHeader
    SET TotalDue = TotalDue * 1.05
    WHERE CustomerID = 12345;
    
    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    -- Check if a transaction is active
    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;
    
    -- Handle or re-raise the error
    THROW;
END CATCH;
```

The `@@TRANCOUNT` check is important because:
- An error might occur before `BEGIN TRANSACTION`
- Some errors automatically roll back the transaction before reaching `CATCH`
- Attempting to rollback without an active transaction causes another error

> [!IMPORTANT]
> Always check `@@TRANCOUNT` before calling `ROLLBACK TRANSACTION` in a `CATCH` block. This prevents the error "ROLLBACK TRANSACTION request has no corresponding BEGIN TRANSACTION."

## Raise custom errors with THROW

The `THROW` statement raises an exception with a custom error number and message. Use it to signal application-specific error conditions:

```sql
-- Validate input before processing
CREATE PROCEDURE ProcessOrder
    @OrderID INT,
    @Quantity INT
AS
BEGIN
    BEGIN TRY
        -- Validation
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
        THROW;  -- Re-raise to caller
    END CATCH;
END;
```

`THROW` without parameters reraises the current error:

```sql
BEGIN CATCH
    -- Log the error
    EXEC LogError;
    
    -- Re-raise the original error to the caller
    THROW;
END CATCH;
```

Custom error numbers for user-defined errors must be 50000 or higher. The state parameter (1 in the examples) is a user-defined value between 1 and 255 that can help identify where the error was raised.

## Use RAISERROR for formatted messages

`RAISERROR` provides more formatting options than `THROW`, including printf-style parameter substitution:

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

Create reusable error messages with `sp_addmessage`:

```sql
-- Add a custom message (run once)
EXEC sp_addmessage 
    @msgnum = 50003,
    @severity = 16,
    @msgtext = 'Cannot delete %s because it has %d dependent records.';

-- Use the message
RAISERROR(50003, 16, 1, 'Customer', 5);
-- Output: Cannot delete Customer because it has 5 dependent records.
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
        BEGIN TRANSACTION;
        
        -- Do some work
        UPDATE SomeTable SET Column1 = 'Value';
        
        -- Call nested procedure
        EXEC InnerProcedure;
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
END;
GO

CREATE PROCEDURE InnerProcedure
AS
BEGIN
    BEGIN TRY
        -- Inner procedure work
        UPDATE AnotherTable SET Column2 = 'Value';
    END TRY
    BEGIN CATCH
        -- Inner procedure doesn't rollback - outer will handle it
        THROW;
    END CATCH;
END;
```

## Use XACT_ABORT for automatic rollback

Setting `XACT_ABORT ON` causes SQL Server to automatically roll back the transaction when any error occurs, even without `TRY...CATCH`:

```sql
SET XACT_ABORT ON;

BEGIN TRANSACTION;
    UPDATE Table1 SET Col1 = 'A';
    UPDATE Table2 SET Col2 = 'B';  -- If this fails, entire transaction rolls back
    UPDATE Table3 SET Col3 = 'C';
COMMIT TRANSACTION;
```

Combine `XACT_ABORT` with `TRY...CATCH` for full protection:

```sql
SET XACT_ABORT ON;

BEGIN TRY
    BEGIN TRANSACTION;
    
    -- Multiple operations
    EXEC Procedure1;
    EXEC Procedure2;
    EXEC Procedure3;
    
    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    -- Transaction is already rolled back by XACT_ABORT
    -- but check anyway for safety
    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;
    
    -- Log and re-raise
    EXEC LogError;
    THROW;
END CATCH;
```

> [!TIP]
> Using `SET XACT_ABORT ON` is a best practice for stored procedures, especially those that span multiple operations. It ensures consistent behavior regardless of the specific error that occurs.

For more information about error handling, see [TRY...CATCH (Transact-SQL)](/sql/t-sql/language-elements/try-catch-transact-sql?azure-portal=true) and [THROW (Transact-SQL)](/sql/t-sql/language-elements/throw-transact-sql?azure-portal=true).
