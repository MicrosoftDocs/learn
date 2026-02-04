Dynamic Data Masking provides a way to limit exposure of sensitive data without changing your application code or the underlying data. When users query masked columns, SQL Server returns obfuscated values based on masking rules you define. The actual data remains unchanged in the database, but unauthorized users see masked values in query results.

This approach works well when you need to protect sensitive information from certain users while allowing others to see the complete data. Database administrators, developers, and support staff can work with production data without exposing actual customer information, credit card numbers, or other sensitive values.

## Understand masking functions

Dynamic Data Masking supports four masking functions, each designed for different data types and scenarios. Understanding these functions helps you choose the right masking approach for your sensitive columns.

:::image type="content" source="../media/masking.png" alt-text="Table showing the four Dynamic Data Masking functions with before and after comparisons: Default shows XXXX, Email shows jXXX@XXXX.com, Random shows random numbers, and Partial shows 206-XXX-XX89.":::

The default masking function replaces the entire value with a fixed string. For string data types, it shows "XXXX" (or fewer X characters for shorter columns). Numeric values display as zero, and date values show 01-01-1900. This function works for any data type and provides complete obfuscation.

The email masking function reveals the first character of an email address, replaces the rest with "XXX", and preserves the domain suffix. For example, "john.smith@contoso.com" appears as "jXXX@XXXX.com". This format maintains the appearance of valid email data while protecting the actual address.

With the random masking function, numeric values display as a random number within a specified range. You define minimum and maximum values, and each query returns a different random value. This approach works well for financial or statistical data where maintaining realistic-looking numbers matters.

The partial masking function (also called custom string masking) gives you precise control over which characters to reveal. You specify a prefix length to show, padding characters to use, and a suffix length to display. For example, masking a phone number might show "206-XXX-XX89".

## Configure column masks

You apply masks when creating tables or by altering existing columns. The `MASKED WITH` clause specifies the masking function and any required parameters.

You can create a table with masked columns like this:

```sql
CREATE TABLE Customers (
    CustomerID int PRIMARY KEY,
    FirstName varchar(50),
    LastName varchar(50),
    Email varchar(100) MASKED WITH (FUNCTION = 'email()'),
    Phone varchar(20) MASKED WITH (FUNCTION = 'partial(3, "XXX-XXX-", 2)'),
    CreditCardNumber varchar(19) MASKED WITH (FUNCTION = 'partial(0, "XXXX-XXXX-XXXX-", 4)'),
    Income decimal(18,2) MASKED WITH (FUNCTION = 'random(10000, 100000)'),
    SSN char(11) MASKED WITH (FUNCTION = 'default()')
);
```

Each column uses a masking function appropriate for its data:

- `Email` uses email masking to preserve the email format
- `Phone` shows the first 3 digits and last 2 digits
- `CreditCardNumber` reveals only the last 4 digits
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

By default, users see masked data unless they have elevated permissions. The `UNMASK` permission controls who can view the actual values behind masks. You can grant this permission at different scopes to implement granular access control.

To allow a user to see all unmasked data in the database:

```sql
GRANT UNMASK TO DataAnalyst;
```

This database-level permission reveals all masked columns to the specified user. However, you might want more granular control, allowing users to unmask only specific tables or columns.

Starting with SQL Server 2022 and Azure SQL Database, you can grant `UNMASK` at the schema, table, or column level:

```sql
-- Grant unmask on a specific schema
GRANT UNMASK ON SCHEMA::Sales TO SalesManager;

-- Grant unmask on a specific table
GRANT UNMASK ON Customers TO CustomerService;

-- Grant unmask on a specific column
GRANT UNMASK ON Customers(Phone) TO TelemarketingTeam;
```

This granular approach lets you implement the principle of least privilege. Users see only the sensitive data they need for their specific job functions.

> [!IMPORTANT]
> Users with `SELECT` permission on a table combined with `ALTER` permission can potentially bypass masking by modifying the column definition. Carefully manage permissions to prevent users from removing masks.

## Implement masking strategies

When designing your masking strategy, consider how different user roles interact with your data. Start by identifying which columns contain sensitive information and who legitimately needs to see the actual values.

Create database roles for different access levels:

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

Dynamic Data Masking works at the presentation layer, meaning the actual data can still be inferred through certain query patterns. For highly sensitive data requiring complete protection, combine masking with other security measures like encryption or Row-Level Security.

Consider these scenarios where masking excels:

- Development and testing environments where teams need realistic data structures without actual customer information
- Customer service applications where support staff need to verify partial account details
- Reporting scenarios where aggregate data matters but individual records should remain private
- Audit compliance where specific users require full access while others see limited information

> [!NOTE]
> Dynamic Data Masking in SQL databases in Microsoft Fabric follows the same syntax and behavior as Azure SQL Database. Configure masks using T-SQL statements through the SQL analytics endpoint.

Masking provides an additional layer of defense but shouldn't be your only protection for sensitive data. Use it alongside encryption, Row-Level Security, and proper permission management for comprehensive data protection.
