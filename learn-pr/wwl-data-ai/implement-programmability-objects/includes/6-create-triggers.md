[**Triggers**](/sql/relational-databases/triggers/dml-triggers?azure-portal=true) are special stored procedures that automatically execute when specific events occur in your database. You define triggers to maintain data integrity, enforce business rules, and automate database operations without requiring application-level code.

## Understand trigger fundamentals

A trigger responds to data modification or schema changes in your database. When you create a trigger, you specify the event that activates it and the actions it performs.

Triggers execute automatically. Unlike stored procedures that you call explicitly, triggers fire in response to `INSERT`, `UPDATE`, `DELETE`, or DDL statements. This automatic execution makes them powerful for enforcing rules that must apply consistently across all data modifications.

SQL Server supports two main categories of triggers: [**DML (Data Manipulation Language)**](/sql/relational-databases/triggers/dml-triggers?azure-portal=true) triggers and [**DDL (Data Definition Language)**](/sql/relational-databases/triggers/ddl-triggers?azure-portal=true) triggers. DML triggers respond to changes in table data, while DDL triggers respond to schema changes like `CREATE`, `ALTER`, or `DROP` statements.

## Create DML triggers for data modifications

DML triggers monitor and respond to data changes in tables or views. You define them as either [**AFTER**](/sql/t-sql/statements/create-trigger-transact-sql?azure-portal=true) triggers or **INSTEAD OF** triggers.

**AFTER** triggers execute after the triggering statement completes. The database first performs the data modification, then runs the trigger code. You use AFTER triggers to validate changes, update related tables, or log modifications:

```sql
CREATE TRIGGER tr_UpdateInventory
ON Sales.OrderDetails
AFTER INSERT
AS
BEGIN
    UPDATE Inventory.Products
    SET QuantityInStock = QuantityInStock - i.Quantity
    FROM Inventory.Products p
    INNER JOIN inserted i ON p.ProductID = i.ProductID;
END;
```

**INSTEAD OF** triggers replace the original data modification statement. The trigger code executes instead of the `INSERT`, `UPDATE`, or `DELETE` operation. You use INSTEAD OF triggers to modify views that normally wouldn't accept direct modifications or to implement complex business logic:

```sql
CREATE TRIGGER tr_UpdateOrderView
ON Sales.OrderSummaryView
INSTEAD OF UPDATE
AS
BEGIN
    UPDATE Sales.Orders
    SET OrderStatus = i.OrderStatus,
        ModifiedDate = GETDATE()
    FROM Sales.Orders o
    INNER JOIN inserted i ON o.OrderID = i.OrderID;
END;
```

With DML triggers, you access the **inserted** and **deleted** pseudo-tables. These temporary tables store copies of the affected rows. `INSERT` operations populate the **inserted** table, `DELETE` operations populate the **deleted** table, and `UPDATE` operations populate both tables with old values in **deleted** and new values in **inserted**.

## Implement triggers for specific events

You specify which data modification events activate your trigger. A single trigger can respond to multiple events by combining `INSERT`, `UPDATE`, and `DELETE` in the trigger definition.

For precise control, you create separate triggers for each operation. This approach simplifies your code and makes your triggers easier to maintain:

```sql
CREATE TRIGGER tr_LogPriceChanges
ON Products.Catalog
AFTER UPDATE
AS
BEGIN
    IF UPDATE(Price)
    BEGIN
        INSERT INTO Audit.PriceHistory (ProductID, OldPrice, NewPrice, ChangeDate)
        SELECT d.ProductID, d.Price, i.Price, GETDATE()
        FROM deleted d
        INNER JOIN inserted i ON d.ProductID = i.ProductID
        WHERE d.Price <> i.Price;
    END;
END;
```

At the same time, you might combine events when the same logic applies to multiple operations. For example, you could create a single audit trigger that responds to `INSERT`, `UPDATE`, and `DELETE`:

```sql
CREATE TRIGGER tr_AuditEmployeeChanges
ON HR.Employees
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    DECLARE @Operation NVARCHAR(10);
    
    IF EXISTS (SELECT * FROM inserted) AND NOT EXISTS (SELECT * FROM deleted)
        SET @Operation = 'INSERT';
    ELSE IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
        SET @Operation = 'UPDATE';
    ELSE
        SET @Operation = 'DELETE';
    
    INSERT INTO Audit.EmployeeLog (EmployeeID, Operation, ChangeDate)
    SELECT COALESCE(i.EmployeeID, d.EmployeeID), @Operation, GETDATE()
    FROM inserted i
    FULL OUTER JOIN deleted d ON i.EmployeeID = d.EmployeeID;
END;
```

The `UPDATE()` function helps you determine which columns changed. You check specific columns to avoid unnecessary processing when only certain fields matter for your business logic.

## Apply trigger best practices

Triggers affect database performance because they execute with every qualifying operation. You write efficient trigger code to minimize impact on transaction throughput.

Keep your trigger logic focused and minimal. Execute only essential operations within the trigger body. For complex or time-consuming operations, consider logging the event details and processing them asynchronously through a separate job:

```sql
CREATE TRIGGER tr_QueueLargeOrders
ON Sales.Orders
AFTER INSERT
AS
BEGIN
    INSERT INTO Processing.OrderQueue (OrderID, TotalAmount, QueuedDate)
    SELECT OrderID, TotalAmount, GETDATE()
    FROM inserted
    WHERE TotalAmount > 10000;
END;
```

Avoid recursive operations where a trigger modification causes the same trigger to fire again. Set the `RECURSIVE_TRIGGERS` database option appropriately and design your triggers to prevent endless loops.

Handle errors properly within triggers. Transaction behavior depends on your error handling. If a trigger encounters an error and you don't handle it, SQL Server rolls back both the trigger and the original statement:

```sql
CREATE TRIGGER tr_ValidateOrderDate
ON Sales.Orders
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (SELECT * FROM inserted WHERE OrderDate > GETDATE())
    BEGIN
        THROW 50001, 'Order date cannot be in the future', 1;
    END;
END;
```

Document your triggers thoroughly. Other developers need to understand why triggers exist and what they do, since they execute invisibly during normal database operations.

Now that you understand how to create and implement triggers, you're ready to explore how they integrate with other programmability objects to build comprehensive database solutions.
