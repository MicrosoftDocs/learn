Constraints and sequence objects are design choices that prevent data problems before they happen. A missing foreign key constraint means orphaned records might already exist in your database. Adding sequence objects later to replace identity columns requires changes across all applications. Application code can validate data, but users can bypass it through bulk imports, direct queries, or new applications that skip validation.

Database constraints enforce rules at the engine level, so they always apply. The decisions you make during design, such as which rules to enforce in the database and whether to use identity columns or sequences, affect your data quality for the life of your application.

## Understand when to use constraints

Data quality problems are expensive. Poor data quality leads to incorrect business decisions, failed integrations, and compliance violations. Unlike application-level validation that can be inconsistent across different applications accessing the same database, constraints enforce rules at the database engine level where they can't be bypassed by application code, ad-hoc queries, direct SQL scripts, or bulk imports. Every `INSERT`, `UPDATE`, and `DELETE` operation must satisfy all defined constraints before the database engine commits the change.

### Apply database constraints

Constraints prevent data quality problems before they corrupt your database. The following table shows how each constraint type addresses specific data integrity issues:

| Problem | Constraint | Example |
| ------- | ---------- | ------- |
| Orphaned records | FOREIGN KEY | Prevents orders without valid customers |
| Duplicate data | UNIQUE | Stops duplicate email registrations |
| Invalid data | CHECK | Rejects negative prices or future birthdates |
| Missing critical data | NOT NULL | Prevents incomplete records |
| Referential inconsistency | FOREIGN KEY | Maintains data integrity across tables |

Consider a retail company that didn't define a unique constraint on their customer email column. Over time, the same customers were registered multiple times with identical email addresses. When marketing sent promotional campaigns, some customers received three copies of the same email, increasing costs and damaging customer trust. Adding `UNIQUE (EmailAddress)` to the table definition would have prevented these duplicates from ever being inserted.

Constraints enforce rules at the database engine level, ensuring data quality regardless of how data enters the system. Application validation can be bypassed, varies by application, and is harder to maintain. Database constraints are always enforced, centralized, and provide one source of truth.

Constraints ensure data quality and consistency at the database level.

### Use primary key constraints

[*Primary key constraints*](/sql/relational-databases/tables/primary-and-foreign-key-constraints?azure-portal=true#primary-key-constraints) guarantee unique data and enforce entity integrity. When you specify a primary key constraint, the Database Engine automatically creates a unique index for the primary key columns. A table can contain only one primary key constraint, and all columns defined within a primary key constraint must be defined as `NOT NULL`.

You can create a primary key by using the `PRIMARY KEY` constraint. Here's an example:

```sql
CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),
    EmailAddress NVARCHAR(100) NOT NULL
);
```

### Use foreign key constraints

[*Foreign key constraints*](/sql/relational-databases/tables/primary-and-foreign-key-constraints?azure-portal=true#referential-integrity) enforce referential integrity by controlling the data that can be stored in the foreign key table. A foreign key constraint prevents changes to data in the primary key table if those changes invalidate the link to data in the foreign key table.

You can define [cascading referential actions](/sql/relational-databases/tables/primary-and-foreign-key-constraints?azure-portal=true#referential-integrity) such as `CASCADE`, `SET NULL`, or `SET DEFAULT` to specify what happens when a user tries to delete or update a key to which existing foreign keys point. Although manually creating an [index on foreign key columns](/sql/relational-databases/tables/primary-and-foreign-key-constraints?azure-portal=true#indexes-on-foreign-key-constraints) isn't required, it's often useful because foreign key columns are frequently used in join criteria.

You can create a foreign key by using the `FOREIGN KEY` constraint with a `REFERENCES` clause. Here's an example:

```sql
CREATE TABLE Order (
    OrderID INT PRIMARY KEY IDENTITY,
    CustomerID INT NOT NULL,
    OrderDate DATETIME2,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);
```

### Use unique constraints

[*Unique constraints*](/sql/relational-databases/tables/unique-constraints-and-check-constraints?azure-portal=true#unique-constraints) ensure no duplicate values are entered in specific columns that don't participate in a primary key. Unlike `PRIMARY KEY` constraints, `UNIQUE` constraints allow for the value `NULL`. However, as with any value participating in a `UNIQUE` constraint, only one null value is allowed per column. The Database Engine automatically creates a unique nonclustered index to enforce the uniqueness requirement.

You can create a unique constraint by using the `UNIQUE` keyword. Here's an example:

```sql
CREATE TABLE Product (
    ProductID INT PRIMARY KEY,
    SKU NVARCHAR(50) UNIQUE,
    ProductName NVARCHAR(100)
);
```

### Use check constraints

[*Check constraints*](/sql/relational-databases/tables/unique-constraints-and-check-constraints?azure-portal=true#check-constraints) enforce domain integrity by limiting the values accepted by one or more columns. You can create a `CHECK` constraint with any logical expression that returns `TRUE` or `FALSE` based on logical operators. You can apply multiple `CHECK` constraints to a single column or apply a single `CHECK` constraint to multiple columns.

Because null values evaluate to `UNKNOWN`, their presence in expressions might override a constraint. For example, a constraint `MyColumn = 10` on an `INT` column still allows `NULL` to be inserted because `NULL` doesn't evaluate to `FALSE`.

You can create a CHECK constraint by using the `CHECK` keyword with a logical expression. Here's an example:

```sql
CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY,
    HireDate DATE,
    Salary DECIMAL(10,2),
    CHECK (Salary >= 20000),
    CHECK (HireDate <= GETDATE())
);
```

### Use default constraints

[*Default constraints*](/sql/relational-databases/tables/specify-default-values-for-columns?azure-portal=true) provide default values when no value is specified during `INSERT` operations. When working with database projects, it's recommended to create constraints with explicit names rather than allowing system-generated names, which differ across environments.

You can create a DEFAULT constraint by using the `DEFAULT` keyword. Here's an example:

```sql
CREATE TABLE Activity (
    ActivityID INT PRIMARY KEY IDENTITY,
    Description NVARCHAR(200),
    CreatedDate DATETIME2 CONSTRAINT DF_Activity_CreatedDate DEFAULT GETUTCDATE(),
    IsActive BIT CONSTRAINT DF_Activity_IsActive DEFAULT 1
);
```

## Use sequence objects

A [*sequence object*](/sql/relational-databases/sequence-numbers/sequence-numbers?azure-portal=true) is a user-defined schema-bound object that generates a sequence of numeric values according to the specification with which the sequence was created. Unlike identity columns, sequences aren't associated with specific tables. Applications refer to a sequence object to retrieve its next value, and the relationship between sequences and tables is controlled by the application.

Identity columns work well when you need automatic numbering for a single table. However, they're limited to that one table. You can't share the numbers across multiple tables, get the next value before inserting a row, or easily reset the counter. Sequence objects solve these problems by generating numbers independently of any table.

### Understand when to use sequences

Use sequences instead of identity columns in the following scenarios:

- **Shared number series** - The application requires sharing a single series of numbers between multiple tables or multiple columns within a table.
- **Cycling number series** - The application must restart the number series when a specified number is reached. For example, after assigning values 1 through 10, the application starts assigning values 1 through 10 again.
- **Sorted sequence values** - The application requires sequence values to be sorted by another field. The `NEXT VALUE FOR` function can apply the `OVER` clause, which guarantees that the values returned are generated in the order of the `ORDER BY` clause.
- **Reserve multiple numbers** - An application needs to reserve several sequential numbers at once. Requesting identity values could result in gaps if other processes were simultaneously issued numbers. Calling `sp_sequence_get_range` retrieves several numbers in the sequence at once.
- **Changeable specification** - You need to change the specification of the sequence, such as the increment value, after creation.

Sequence objects can offer more flexibility than identity columns:

| Feature | Sequence | Identity |
| ------- | -------- | -------- |
| Tied to table | No | Yes |
| Shared across tables or columns | Yes | No |
| Get next value before the insert operation | Yes | No |
| Custom min/max values | Yes | Limited |
| Retrieve multiple numbers at once | Yes | No |
| Cycle/restart at specified number | Yes | No |
| Sort values by another field | Yes | No |
| Change increment after creation | Yes | No |

Use an identity column when you need a simple autoincrementing primary key for a single table and don't need to share the same number series across multiple tables or retrieve the next value before inserting the row.

Use a sequence when your application requires a number before the insert is made, needs to share a single series between multiple tables, must restart the number series when a specified number is reached, or needs to reserve multiple sequential numbers at once.

### Understand sequence limitations

Unlike identity columns, [sequence values aren't automatically protected](/sql/relational-databases/sequence-numbers/sequence-numbers?azure-portal=true#limitations) after insertion into a table. Also, uniqueness isn't automatically enforced for sequence values. If sequence values in a table must be unique, create a unique constraint on the column.

Sequence numbers are generated outside the scope of the current transaction. They're consumed whether the transaction using the sequence number is committed or rolled back.

You can create a sequence object by using the [`CREATE SEQUENCE`](/sql/t-sql/statements/create-sequence-transact-sql?azure-portal=true) statement with optional parameters for start, increment, and range. Here's an example:

```sql
-- Create sequence
CREATE SEQUENCE OrderNumber 
    START WITH 1000
    INCREMENT BY 1
    MINVALUE 1000
    MAXVALUE 999999
    NO CYCLE;

-- Use sequence in INSERT with NEXT VALUE FOR function
INSERT INTO Order (OrderID, CustomerID, OrderNumber, OrderDate)
VALUES (1, 100, NEXT VALUE FOR OrderNumber, GETDATE());

-- Get next value before INSERT
DECLARE @NextOrderNum INT = NEXT VALUE FOR OrderNumber;
SELECT @NextOrderNum;

-- Get multiple sequence numbers at once for batch processing
DECLARE @FirstSeq INT, @LastSeq INT;
EXEC sp_sequence_get_range 
    @sequence_name = N'OrderNumber',
    @range_size = 100,
    @range_first_value = @FirstSeq OUTPUT,
    @range_last_value = @LastSeq OUTPUT;

-- Reset sequence
ALTER SEQUENCE OrderNumber RESTART WITH 1000;
```

This example creates a sequence named `OrderNumber` that starts at 1000, increments by 1, and stops at 999999 without cycling back. The `NEXT VALUE FOR` function retrieves the next available number, either inline during an `INSERT` statement or assigned to a variable before the insert when the application needs to reference the value first. For batch operations that require multiple sequential numbers at once, `sp_sequence_get_range` reserves a block of 100 numbers, returning the first and last values in the range. The `ALTER SEQUENCE` statement resets the sequence back to 1000 when needed.

Constraints are architectural decisions that prevent problems before they occur. A missing `CHECK` constraint allows invalid data to corrupt your database silently. Choosing identity columns when you need cross-table numbering forces application-level workarounds. Constraints defined at the database level protect data quality regardless of which application, tool, or script accesses your database. These decisions shape your data integrity guarantees for the life of your application.
