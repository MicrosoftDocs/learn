[Dynamic Data Masking](/sql/relational-databases/security/dynamic-data-masking?azure-portal=true) provides a way to limit exposure of sensitive data without changing your application code or the underlying data. When users query masked columns, SQL Server returns obfuscated values based on masking rules you define. The actual data remains unchanged in the database, but unauthorized users see masked values in query results.

This approach works well when you need to protect sensitive information from certain users while allowing others to see the complete data. Database administrators, developers, and support staff can work with production data without exposing actual customer information, credit card numbers, or other sensitive values.

## Understand masking functions

Dynamic Data Masking supports four masking functions, each designed for different data types and scenarios. Understanding these functions helps you choose the right masking approach for your sensitive columns.

:::image type="content" source="../media/masking.png" alt-text="Table showing the four Dynamic Data Masking functions with before and after comparisons: Default shows XXXX, Email shows jXXX@XXXX.com, Random shows random numbers, and Partial shows 206-XXX-XX89.":::

The **default** function replaces the entire value with a fixed string. For strings, you see *"XXXX"* (or fewer X characters for shorter columns). Numbers display as zero, and dates show *"01-01-1900"*. Use this when you want complete obfuscation.

The **email** function reveals just the first character of an email address, replaces the middle with "XXX", and preserves the domain suffix. So *"john.smith@contoso.com"* appears as *"jXXX@XXXX.com"*. The data still looks like a valid email, but the actual address stays hidden.

The **random** function displays numeric values as a random number within a range you specify. Each query returns a different value. This works great for financial or statistical data where you need data that looks genuine.

The **partial** function gives you precise control. You specify how many characters to show at the start, what padding characters to use in the middle, and how many to show at the end. For example, a phone number might appear as *"206-XXX-XX89"*.

## Configure column masks

You apply masks when creating tables or by altering existing columns. The `MASKED WITH` clause specifies which function to use.

Here's a table with several masked columns:

```sql
CREATE TABLE Customers (
    CustomerID int PRIMARY KEY,
    FirstName varchar(50),
    LastName varchar(50),
    Email varchar(100) MASKED WITH (FUNCTION = 'email()'),
    Phone varchar(20) MASKED WITH (FUNCTION = 'partial(3, "-XXX-XX", 2)'),
    CreditCardNumber varchar(19) MASKED WITH (FUNCTION = 'partial(0, "XXXX-XXXX-XXXX-", 4)'),
    Income decimal(18,2) MASKED WITH (FUNCTION = 'random(10000, 100000)'),
    SSN char(11) MASKED WITH (FUNCTION = 'default()')
);
```

Notice how each column uses a different masking function based on what makes sense for that data:

- `Email` uses email masking to preserve the email format
- `Phone` shows the first three digits and last two digits
- `CreditCardNumber` reveals only the last four digits
- `Income` displays a random value between 10,000 and 100,000
- `SSN` uses default masking for complete obfuscation

To add masking to an existing column, use `ALTER COLUMN`:

```sql
ALTER TABLE Customers
ALTER COLUMN DateOfBirth ADD MASKED WITH (FUNCTION = 'default()');
```

You can remove masking from a column when it's no longer needed:

```sql
ALTER TABLE Customers
ALTER COLUMN DateOfBirth DROP MASKED;
```

## Control mask visibility with permissions

By default, users see masked data unless they have elevated permissions. The [`UNMASK` permission](/sql/relational-databases/security/dynamic-data-masking?azure-portal=true#permissions) controls who sees the real values behind the masks.

To allow a user to see all unmasked data in the database:

```sql
GRANT UNMASK TO DataAnalyst;
```

This database-level permission reveals all masked columns to the specified user. However, you might want more granular control, allowing users to unmask only specific tables or columns.

Starting with SQL Server 2022, you can grant `UNMASK` at the schema, table, or even column level:

```sql
-- Grant unmask on a specific schema
GRANT UNMASK ON SCHEMA::Sales TO SalesManager;

-- Grant unmask on a specific table
GRANT UNMASK ON Customers TO CustomerService;

-- Grant unmask on a specific column
GRANT UNMASK ON Customers(Phone) TO TelemarketingTeam;
```

This granular approach helps you follow the principle of least privilege—users see only the sensitive data they actually need for their job.

> [!IMPORTANT]
> Users with `SELECT` permission on a table combined with `ALTER` permission can potentially bypass masking by modifying the column definition. Carefully manage permissions to prevent users from removing masks.

## Implement masking strategies

When planning your masking strategy, think about how different user roles interact with your data. Which columns contain sensitive information? Who legitimately needs to see the actual values?

A common pattern is to create database roles for different access levels:

```sql
-- Role for users who see masked data
CREATE ROLE MaskedDataViewers;
GRANT SELECT ON Customers TO MaskedDataViewers;

-- Role for users who see unmasked data
CREATE ROLE UnmaskedDataViewers;
GRANT SELECT ON Customers TO UnmaskedDataViewers;
GRANT UNMASK ON Customers TO UnmaskedDataViewers;

-- Add users to appropriate roles
ALTER ROLE MaskedDataViewers ADD MEMBER SupportStaff;
ALTER ROLE UnmaskedDataViewers ADD MEMBER ComplianceOfficer;
```

One thing to keep in mind: Dynamic Data Masking works at the presentation layer, meaning the actual data can still be inferred through certain query patterns. For highly sensitive data requiring complete protection, combine masking with other security measures like encryption or Row-Level Security.

Consider these scenarios where masking is useful:

- Development and testing environments where teams need realistic data structures without actual customer information
- Customer service applications where support staff need to verify partial account details
- Reporting scenarios where aggregate data matters but individual records should remain private
- Audit compliance where specific users require full access while others see limited information

> [!NOTE]
> Dynamic Data Masking in SQL databases in Microsoft Fabric works the same way as Azure SQL Database. You configure masks using T-SQL through the SQL analytics endpoint.

Masking adds an important layer of defense, but don't rely on it alone for your most sensitive data. Use it alongside encryption, Row-Level Security, and proper permission management for comprehensive protection.
